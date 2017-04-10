Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-me-sender:x-me-sender:x-sasl-enc
	:x-sasl-enc; s=fm1; bh=+WsaXr5/waZbTlmfYvGX+lFBl1xqLSg/sDFdlqDX1
	Ks=; b=lE9AfIOk6M+GhTDEEEbZ+HPrZcrZpWe+8tZNFTzkRBiUtqReh3MOhdzot
	KUUAbigyDs2nAC3lPFialFEA0RxyRbidTxETcJCtCif7cUHS/FH1yn65fY3gTkJP
	RuhPo5BwKJyhD2n9q4hBPdS0Ff0N3QPUGPt6f4nWSgO++scXZ6mQNxKO99GJO1Qz
	58kzqAEHEkSoD3iRTfgElyD+r813IXApfstNuDIlLwix/3/cPD8OA8GOEb1TOee3
	2jbldNjH2N15CAzoMFL8HW88B9jposcbmYud/pU9+SyKEg7LYByxXDAspEUBgVsb
	7f3gqmNfV7prd2EHFOwB9AdNpNcHw==
From: idosch@idosch.org
Date: Mon, 10 Apr 2017 14:59:28 +0300
Message-Id: <20170410115928.9344-3-idosch@idosch.org>
In-Reply-To: <20170410115928.9344-1-idosch@idosch.org>
References: <20170410115928.9344-1-idosch@idosch.org>
Subject: [Bridge] [PATCH net v3 2/2] bridge: netlink: register netdevice
	before executing changelink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@mellanox.com>, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, peter@svinota.eu, bridge@lists.linux-foundation.org, davem@davemloft.net

From: Ido Schimmel <idosch@mellanox.com>

Peter reported a kernel oops when executing the following command:

$ ip link add name test type bridge vlan_default_pvid 1

[13634.939408] BUG: unable to handle kernel NULL pointer dereference at
0000000000000190
[13634.939436] IP: __vlan_add+0x73/0x5f0
[...]
[13634.939783] Call Trace:
[13634.939791]  ? pcpu_next_unpop+0x3b/0x50
[13634.939801]  ? pcpu_alloc+0x3d2/0x680
[13634.939810]  ? br_vlan_add+0x135/0x1b0
[13634.939820]  ? __br_vlan_set_default_pvid.part.28+0x204/0x2b0
[13634.939834]  ? br_changelink+0x120/0x4e0
[13634.939844]  ? br_dev_newlink+0x50/0x70
[13634.939854]  ? rtnl_newlink+0x5f5/0x8a0
[13634.939864]  ? rtnl_newlink+0x176/0x8a0
[13634.939874]  ? mem_cgroup_commit_charge+0x7c/0x4e0
[13634.939886]  ? rtnetlink_rcv_msg+0xe1/0x220
[13634.939896]  ? lookup_fast+0x52/0x370
[13634.939905]  ? rtnl_newlink+0x8a0/0x8a0
[13634.939915]  ? netlink_rcv_skb+0xa1/0xc0
[13634.939925]  ? rtnetlink_rcv+0x24/0x30
[13634.939934]  ? netlink_unicast+0x177/0x220
[13634.939944]  ? netlink_sendmsg+0x2fe/0x3b0
[13634.939954]  ? _copy_from_user+0x39/0x40
[13634.939964]  ? sock_sendmsg+0x30/0x40
[13634.940159]  ? ___sys_sendmsg+0x29d/0x2b0
[13634.940326]  ? __alloc_pages_nodemask+0xdf/0x230
[13634.940478]  ? mem_cgroup_commit_charge+0x7c/0x4e0
[13634.940592]  ? mem_cgroup_try_charge+0x76/0x1a0
[13634.940701]  ? __handle_mm_fault+0xdb9/0x10b0
[13634.940809]  ? __sys_sendmsg+0x51/0x90
[13634.940917]  ? entry_SYSCALL_64_fastpath+0x1e/0xad

The problem is that the bridge's VLAN group is created after setting the
default PVID, when registering the netdevice and executing its
ndo_init().

Fix this by changing the order of both operations, so that
br_changelink() is only processed after the netdevice is registered,
when the VLAN group is already initialized.

Fixes: b6677449dff6 ("bridge: netlink: call br_changelink() during br_dev_newlink()")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Peter V. Saveliev <peter@svinota.eu>
Tested-by: Peter V. Saveliev <peter@svinota.eu>
---
v2->v3:
* Drop goto
v1->v2:
* Error-out on changelink() failure

 net/bridge/br_netlink.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index a8f6acd..225ef7d 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1165,11 +1165,14 @@ static int br_dev_newlink(struct net *src_net, struct net_device *dev,
 		spin_unlock_bh(&br->lock);
 	}
 
-	err = br_changelink(dev, tb, data);
+	err = register_netdevice(dev);
 	if (err)
 		return err;
 
-	return register_netdevice(dev);
+	err = br_changelink(dev, tb, data);
+	if (err)
+		unregister_netdevice(dev);
+	return err;
 }
 
 static size_t br_get_size(const struct net_device *brdev)
-- 
2.9.3

