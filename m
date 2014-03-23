Return-Path: <monamagarwal123@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id;
	bh=TBAN1W9rlNjhbb+ZVmjKIpGArXpE5IaIhbp4u7HYRbs=;
	b=XYfWNGzibOZCdh4gLelF8JaWQorgd6jC69Z58pwTttpb8H7U0H24MLSuY3SHJ+npo9
	D5xawNaB8nwlnEamBKeQBr9Fj/3FpiJ+A9xehJ7R4LZPhb+VOFjfy+Ofu7myWViLQm8x
	AuEKMW5meiJlpWYYBT7FZF/QxP+/dWGZ0lY8/gb+GBnCPkcaPw+V33tzQBs/aV633S8d
	oShivTjz2ItQI7+DnW+E3MaPZBwdb4Ymld0NMGTYmcoprzhcLPJM0Ie9+mm1mFtSgXUE
	ky6wjx/OAhzvZyyFc0ukLgIAHmwskUFVgpVQNlh3cTFoULHdYw+KIqzNduK3Ke5Lh2IL
	+NqQ==
From: Monam Agarwal <monamagarwal123@gmail.com>
Date: Mon, 24 Mar 2014 00:41:13 +0530
Message-Id: <1395601873-12447-1-git-send-email-monamagarwal123@gmail.com>
Subject: [Bridge] [PATCH] net/bridge: Use RCU_INIT_POINTER(x,
	NULL) in br_vlan.c
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org, davem@davemloft.net, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

This patch replaces rcu_assign_pointer(x, NULL) with RCU_INIT_POINTER(x, NULL)

The rcu_assign_pointer() ensures that the initialization of a structure       
is carried out before storing a pointer to that structure. 
And in the case of the NULL pointer, there is no structure to initialize. 
So, rcu_assign_pointer(p, NULL) can be safely converted to RCU_INIT_POINTER(p, NULL)

Signed-off-by: Monam Agarwal <monamagarwal123@gmail.com>
---
 net/bridge/br_vlan.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 8249ca7..5d5b101 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -99,9 +99,9 @@ static int __vlan_del(struct net_port_vlans *v, u16 vid)
 	v->num_vlans--;
 	if (bitmap_empty(v->vlan_bitmap, VLAN_N_VID)) {
 		if (v->port_idx)
-			rcu_assign_pointer(v->parent.port->vlan_info, NULL);
+			RCU_INIT_POINTER(v->parent.port->vlan_info, NULL);
 		else
-			rcu_assign_pointer(v->parent.br->vlan_info, NULL);
+			RCU_INIT_POINTER(v->parent.br->vlan_info, NULL);
 		kfree_rcu(v, rcu);
 	}
 	return 0;
@@ -113,9 +113,9 @@ static void __vlan_flush(struct net_port_vlans *v)
 	v->pvid = 0;
 	bitmap_zero(v->vlan_bitmap, VLAN_N_VID);
 	if (v->port_idx)
-		rcu_assign_pointer(v->parent.port->vlan_info, NULL);
+		RCU_INIT_POINTER(v->parent.port->vlan_info, NULL);
 	else
-		rcu_assign_pointer(v->parent.br->vlan_info, NULL);
+		RCU_INIT_POINTER(v->parent.br->vlan_info, NULL);
 	kfree_rcu(v, rcu);
 }
 
-- 
1.7.9.5

