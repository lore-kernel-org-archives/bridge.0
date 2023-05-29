Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E1CA4060B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16C5140199
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsH9Fql3+aFCOAK3ry7SSk9NvxGxNwdm36kEQWltJ1I=;
 b=M35m+4rQaLu4U6kvllmzG3OpacqyxU3ZfrVAqeq5JWRjP0Ad1NPr9Vgzd7Xf4q6ivXZKV4beTLF5bE7qF3olF1VNnwwVS5V9tbonndavXZV0H3UqZb3F5LxLMHGCPo2BlbkrLqS7LNujTSGpq+LzJVIUkIkuTJiROQGR3CaKoYaUSv4yXpZJuWGcrnwXX2Ep8aYqHrNJAS4zoMPxnWs2bQ8sYUUjq4YdID5k6TXxwv97qlTAlGeDtmF0blRsHPGO8NA20D0vDi9ZSLh3Oc49wwPsS7N+itkJZ2G1QNP54HWmNSLYrAwnIZw/V2SBWm/EZWPOpJ2BY0HsDpd4kXjnlw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 29 May 2023 14:48:27 +0300
Message-ID: <20230529114835.372140-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 0/8] Add layer 2 miss indication and
	filtering
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, leon@kernel.org, vladimir.oltean@nxp.com, razor@blackwall.org, roopa@nvidia.com, claudiu.manoil@nxp.com, Ido Schimmel <idosch@nvidia.com>, UNGLinuxDriver@microchip.com, edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, simon.horman@corigine.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

tl;dr
=====

This patchset adds a single bit to the tc skb extension to indicate that
a packet encountered a layer 2 miss in the bridge and extends flower to
match on this metadata. This is required for non-DF (Designated
Forwarder) filtering in EVPN multi-homing which prevents decapsulated
BUM packets from being forwarded multiple times to the same multi-homed
host.

Background
==========

In a typical EVPN multi-homing setup each host is multi-homed using a
set of links called ES (Ethernet Segment, i.e., LAG) to multiple leaf
switches in a rack. These switches act as VTEPs and are not directly
connected (as opposed to MLAG), but can communicate with each other (as
well as with VTEPs in remote racks) via spine switches over L3.

When a host sends a BUM packet over ES1 to VTEP1, the VTEP will flood it
to other VTEPs in the network, including those connected to the host
over ES1. The receiving VTEPs must drop the packet and not forward it
back to the host. This is called "split-horizon filtering" (SPH) [1].

FRR configures SPH filtering using two tc filters. The first, an ingress
filter that matches on packets received from VTEP1 and marks them using
a fwmark (firewall mark). The second, an egress filter configured on the
LAG interface connected to the host that matches on the fwmark and drops
the packets. Example:

 # tc filter add dev vxlan0 ingress pref 1 proto all flower enc_src_ip $VTEP1_IP action skbedit mark 101
 # tc filter add dev bond0 egress pref 1 handle 101 fw action drop

Motivation
==========

For each ES, only one VTEP is elected by the control plane as the DF.
The DF is responsible for forwarding decapsulated BUM traffic to the
host over the ES. The non-DF VTEPs must drop such traffic as otherwise
the host will receive multiple copies of BUM traffic. This is called
"non-DF filtering" [2].

Filtering of multicast and broadcast traffic can be achieved using the
following flower filter:

 # tc filter add dev bond0 egress pref 1 proto all flower indev vxlan0 dst_mac 01:00:00:00:00:00/01:00:00:00:00:00 action drop

Unlike broadcast and multicast traffic, it is not currently possible to
filter unknown unicast traffic. The classification into unknown unicast
is performed by the bridge driver, but is not visible to other layers.

Implementation
==============

The proposed solution is to add a single bit to the tc skb extension
that is set by the bridge for packets that encountered an FDB or MDB
miss. The flower classifier is extended to be able to match on this new
metadata bit in a similar fashion to existing metadata options such as
'indev'.

A bit that is set for every flooded packet would also work, but it does
not allow us to differentiate between registered and unregistered
multicast traffic which might be useful in the future.

A relatively generic name is chosen for this bit - 'l2_miss' - to allow
its use to be extended to other layer 2 devices such as VXLAN, should a
use case arise.

With the above, the control plane can implement a non-DF filter using
the following tc filters:

 # tc filter add dev bond0 egress pref 1 proto all flower indev vxlan0 dst_mac 01:00:00:00:00:00/01:00:00:00:00:00 action drop
 # tc filter add dev bond0 egress pref 2 proto all flower indev vxlan0 l2_miss true action drop

The first drops broadcast and multicast traffic and the second drops
unknown unicast traffic.

Testing
=======

A test exercising the different permutations of the 'l2_miss' bit is
added in patch #8.

Patchset overview
=================

Patch #1 adds the new bit to the tc skb extension and sets it in the
bridge driver for packets that encountered a miss. The marking of the
packets and the use of this extension is protected by the
'tc_skb_ext_tc' static key in order to keep performance impact to a
minimum when the feature is not in use.

Patch #2 extends the flow dissector to dissect this information from the
tc skb extension into the 'FLOW_DISSECTOR_KEY_META' key.

Patch #3 extends the flower classifier to be able to match on the new
layer 2 miss metadata. The classifier enables the 'tc_skb_ext_tc' static
key upon the installation of the first filter that matches on 'l2_miss'
and disables the key upon the removal of the last filter that matches on
it.

Patch #4 rejects matching on the new metadata in drivers that already
support the 'FLOW_DISSECTOR_KEY_META' key.

Patches #5-#6 are small preparations in mlxsw.

Patch #7 extends mlxsw to be able to match on layer 2 miss.

Patch #8 adds a selftest.

iproute2 patches can be found here [3].

Changelog
=========

Since v1 [4]:

* Patch #1: Use tc skb extension instead of adding a bit to the skb. Do
  not mark broadcast packets as they never perform a lookup
  and therefore never incur a miss.

* Patch #2: Split from flower patch. Use tc skb extension instead of
  'skb->l2_miss'.

* Patch #3: Split flow_dissector changes to a previous patch. Use tc skb
  extension instead of 'skb->l2_miss'.

* Patch #4: Expand commit message to explain why some users were not
  patched.

* Patch #5: New patch.

* Patch #6: New patch.

* Patch #7: Use 'fdb_miss' key element instead of 'dmac_type'.

* Patch #8: Test that broadcast does not hit miss filter.

Since RFC [5]:

No changes.

[1] https://datatracker.ietf.org/doc/html/rfc7432#section-8.3
[2] https://datatracker.ietf.org/doc/html/rfc7432#section-8.5
[3] https://github.com/idosch/iproute2/tree/submit/non_df_filter_v1
[4] https://lore.kernel.org/netdev/20230518113328.1952135-1-idosch@nvidia.com/
[5] https://lore.kernel.org/netdev/20230509070446.246088-1-idosch@nvidia.com/

Ido Schimmel (8):
  skbuff: bridge: Add layer 2 miss indication
  flow_dissector: Dissect layer 2 miss from tc skb extension
  net/sched: flower: Allow matching on layer 2 miss
  flow_offload: Reject matching on layer 2 miss
  mlxsw: spectrum_flower: Split iif parsing to a separate function
  mlxsw: spectrum_flower: Do not force matching on iif
  mlxsw: spectrum_flower: Add ability to match on layer 2 miss
  selftests: forwarding: Add layer 2 miss test cases

 .../marvell/prestera/prestera_flower.c        |   6 +
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   6 +
 .../mellanox/mlxsw/core_acl_flex_keys.c       |   1 +
 .../mellanox/mlxsw/core_acl_flex_keys.h       |   3 +-
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c   |   2 +
 .../ethernet/mellanox/mlxsw/spectrum_flower.c |  45 ++-
 drivers/net/ethernet/mscc/ocelot_flower.c     |  10 +
 include/linux/skbuff.h                        |   1 +
 include/net/flow_dissector.h                  |   2 +
 include/uapi/linux/pkt_cls.h                  |   2 +
 net/bridge/br_device.c                        |   1 +
 net/bridge/br_forward.c                       |   3 +
 net/bridge/br_input.c                         |   1 +
 net/bridge/br_private.h                       |  27 ++
 net/core/flow_dissector.c                     |  10 +
 net/sched/cls_flower.c                        |  30 +-
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/tc_flower_l2_miss.sh       | 350 ++++++++++++++++++
 18 files changed, 485 insertions(+), 16 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh

-- 
2.40.1

