Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e4rdU00h44ADnRjwhROIBI7M9jhhbUlXeokwBcuNYYk=;
 b=cr+VGPpHAr8l9krM9sHZurZ49IsvLCXFch3eN3kk2yc8W9bBXDK9G2iNiGdXEoEtM8
 gKGupx014qx98PMJpUlbQW6lzGa7UkcyN6NiyEkv3CnOIGuNRRg9wogJc8klCuAPLpY8
 6i8qWfaMIXpq0+ioWLGDnmaNXrkhInMbkZAlk=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 13 Jan 2020 17:52:25 +0200
Message-Id: <20200113155233.20771-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/8] net: bridge: add vlan notifications
	and rtm support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Hi,
This patch-set is a prerequisite for adding per-vlan options support
because we need to be able to send vlan-only notifications and do larger
vlan netlink dumps. Per-vlan options are needed as we move the control
more to vlans and would like to add per-vlan state (needed for per-vlan
STP and EVPN), per-vlan multicast options and control, and I'm sure
there would be many more per-vlan options coming.
Now we create/delete/dump vlans with the device AF_SPEC attribute which is
fine since we support vlan ranges or use a compact bridge_vlan_info
structure, but that cannot really be extended to support per-vlan options
well. The biggest issue is dumping them - we tried using the af_spec with
a new vlan option attribute but that led to insufficient message size
quickly, also another minor problem with that is we have to dump all vlans
always when notifying which, with options present, can be huge if they have
different options set, so we decided to add new rtm message types
specifically for vlans and register handlers for them and a new bridge vlan
notification nl group for vlan-only notifications.
The new RTM NEW/DEL/GETVLAN types introduced match the current af spec
bridge functionality and in fact use the same helpers.
The new nl format is:
 [BRIDGE_VLANDB_ENTRY]
    [BRIDGE_VLANDB_ENTRY_INFO] - bridge_vlan_info (either 1 vlan or
                                                   range start)
    [BRIDGE_VLANDB_ENTRY_RANGE] - range end

This allows to encapsulate a range in a single attribute and also to
create vlans and immediately set options on all of them with a single
attribute. The GETVLAN dump can span multiple messages and dump all the
necessary information. The vlan-only notifications are sent on
NEW/DELVLAN events or when vlan options change (currently only flags),
we try hard to compress the vlans into ranges in the notifications as
well. When the per-vlan options are added we'll add helpers to check for
option equality between neighbor vlans and will keep compressing them
when possible.

Note patch 02 is not really required, it's just a nice addition to have
human-readable error messages from the different vlan checks.

iproute2 changes and selftests will be sent with the next set which adds
the first per-vlan option - per-vlan state similar to the port state.

Thank you,
 Nik


Nikolay Aleksandrov (8):
  net: bridge: vlan: add helpers to check for vlan id/range validity
  net: bridge: netlink: add extack error messages when processing vlans
  net: bridge: vlan: add rtm definitions and dump support
  net: bridge: vlan: add new rtm message support
  net: bridge: vlan: add del rtm message support
  net: bridge: vlan: add rtm range support
  net: bridge: vlan: add rtnetlink group and notify support
  net: bridge: vlan: notify on vlan add/delete/change flags

 include/uapi/linux/if_bridge.h |  29 ++
 include/uapi/linux/rtnetlink.h |   9 +
 net/bridge/br_netlink.c        |  61 +++--
 net/bridge/br_private.h        |  90 +++++++
 net/bridge/br_vlan.c           | 473 +++++++++++++++++++++++++++++++--
 security/selinux/nlmsgtab.c    |   5 +-
 6 files changed, 632 insertions(+), 35 deletions(-)

-- 
2.21.0

