Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=OohND7DHdYrfe52ooEBexDXN3fzi4+KvImlSFpKFJQs=;
	b=ugxJ4yLsFST5PIPYvqfdnnmnsjmD9WjTi5dwnp6v/XQBbQgLVHDef9vyaLidGDGD4pAIZYgTMmrY9D96PlMXRMqZLoV2URmzr/cfDQIyrzknyxQ5xW4bIi76pYmHOAaDYz7pZ0U3TTRVHS57wEGEBymkSS6fLfQK9yrwwRjYDuA=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sun, 25 Feb 2018 21:59:06 +0200
Message-Id: <20180225195906.26399-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net] bridge: Fix VLAN reference count problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Ido Schimmel <idosch@mellanox.com>, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, davem@davemloft.net, elena.reshetova@intel.com

When a VLAN is added on a port, a reference is taken on the
corresponding master VLAN entry. If it does not already exist, then it
is created and a reference taken.

However, in the second case a reference is not really taken when
CONFIG_REFCOUNT_FULL is enabled as refcount_inc() is replaced by
refcount_inc_not_zero().

Fix this by using refcount_set() on a newly created master VLAN entry.

Fixes: 251277598596 ("net, bridge: convert net_bridge_vlan.refcnt from atomic_t to refcount_t")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 net/bridge/br_vlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 51935270c651..9896f4975353 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -168,6 +168,8 @@ static struct net_bridge_vlan *br_vlan_get_master(struct net_bridge *br, u16 vid
 		masterv = br_vlan_find(vg, vid);
 		if (WARN_ON(!masterv))
 			return NULL;
+		refcount_set(&masterv->refcnt, 1);
+		return masterv;
 	}
 	refcount_inc(&masterv->refcnt);
 
-- 
2.14.3

