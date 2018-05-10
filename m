Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=wdB1WZXoEIcrv9fnZn1m+AwwCO8gkERB1JiwmsVWOeQ=;
	b=twhqxNWhJsB7QNc19INQYf17GL8444lA1/tpYFRFZtq/UhL/QXLX6YvGaLSJEhSl2PaIM/187aI3eqbsfQYtSjCG2zRAEsI6EET7mrVbMXDmtsmw423IXxfUWllv8thh2A3liIMCMZDJsTEcpXHiNt9rMoZa3/oeTbJxgLZ7FCY=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 10 May 2018 13:13:02 +0300
Message-Id: <20180510101306.4891-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 0/4] mlxsw: Support VLAN devices in
	mirroring offloads
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Ido Schimmel <idosch@mellanox.com>, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, jiri@mellanox.com, petrm@mellanox.com, davem@davemloft.net

Petr says:

When offloading "tc action mirred mirror", there are several scenarios
where VLAN devices can show up, that mlxsw can offload on Spectrum
machines.

I) A direct mirror to a VLAN device on top of a front-panel port device
   (commonly referred to as "RSPAN")

II) VLAN device in egress path of a packet when resolving a mirror to
    gretap or ip6gretap netdevice.

Specifically in the latter case, the following are the cases that can be
offloaded:

IIa) VLAN device directly above a physical device.
IIb) A VLAN-unaware bridge where the egress device is as in IIa.
IIc) VLAN device on top of a VLAN-aware bridge where the egress device
     is a physical device.

This patch set implements all the above cases.

First, in patch #1, br_vlan_get_info() is extended to allow bridge
master argument.

Case I is then implemented in patches #2 and #3, case II in patch #4.

Note that handling of VLAN protocol is not included. In case I, mirrored
packets may end up being double-tagged, and it might be reasonable for
the outer tag to be an 802.1ad. However, the protocol type configuration
would have to be put on the same VLAN netdevice that represents normal
VLAN traffic, and mlxsw currently ignores this setting in that case. Thus
this support was left out and the encapsulation always uses 802.1q
protocol.

Petr Machata (4):
  net: bridge: Allow bridge master in br_vlan_get_info()
  mlxsw: reg: Add MLXSW_REG_MPAT_SPAN_TYPE_REMOTE_ETH
  mlxsw: spectrum_span: Support mirror-to-VLAN
  mlxsw: spectrum_span: Support VLAN under mirror-to-gretap

 drivers/net/ethernet/mellanox/mlxsw/reg.h          |  6 ++
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    | 91 ++++++++++++++++++++--
 net/bridge/br_vlan.c                               |  2 +
 3 files changed, 91 insertions(+), 8 deletions(-)

-- 
2.14.3

