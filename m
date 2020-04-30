Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8Ws9ps3lVg7IhWMNT
 naQ/4aJYXRu9Os3jYNOpTZ6jvA=; b=v99v1/6soCGfESBw9ZMkohNduywqGF+F6
 ckTokBbPqazQ/k3wQjp2vnp1jEZr4m91K3UfXV3S4rR/u+fJNDTiW1iq4KxBvv3X
 bKKZhrZfLxnNq+Sj0S++HH6YrUgfE3l/Zbb8hAPFoIm04R6hNykmMnOp7WNGzlU5
 XXbaW5QCYH0NGuFrBtj6PKS9Pm5gG9czOlgYZ/NTgLEqG7wdtr6ziupTb+VdbDzM
 whemRMhBXLdPmItICFUesqxIldjOhxLzqmbn/aUO2nWBIZChJd1icoVH8hUKe1ME
 HqKevSt3LbWSYLjyHm0twnECLH1y3irIBA3tu0L+zSBoK3O5LOpoQ==
From: Ido Schimmel <idosch@idosch.org>
Date: Thu, 30 Apr 2020 22:38:45 +0300
Message-Id: <20200430193845.4087868-1-idosch@idosch.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: vlan: Add a schedule point during
	VLAN processing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@mellanox.com, s.priebe@profihost.ag, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, Ido Schimmel <idosch@mellanox.com>, kuba@kernel.org, davem@davemloft.net

From: Ido Schimmel <idosch@mellanox.com>

User space can request to delete a range of VLANs from a bridge slave in
one netlink request. For each deleted VLAN the FDB needs to be traversed
in order to flush all the affected entries.

If a large range of VLANs is deleted and the number of FDB entries is
large or the FDB lock is contented, it is possible for the kernel to
loop through the deleted VLANs for a long time. In case preemption is
disabled, this can result in a soft lockup.

Fix this by adding a schedule point after each VLAN is deleted to yield
the CPU, if needed. This is safe because the VLANs are traversed in
process context.

Fixes: bdced7ef7838 ("bridge: support for multiple vlans and vlan ranges in setlink and dellink requests")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Tested-by: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
---
 net/bridge/br_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 43dab4066f91..a0f5dbee8f9c 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -612,6 +612,7 @@ int br_process_vlan_info(struct net_bridge *br,
 					       v - 1, rtm_cmd);
 				v_change_start = 0;
 			}
+			cond_resched();
 		}
 		/* v_change_start is set only if the last/whole range changed */
 		if (v_change_start)
-- 
2.24.1

