From: Tobias Klauser <tklauser@distanz.ch>
Date: Fri, 10 Dec 2010 14:18:04 +0100
Message-Id: <1291987084-27302-1-git-send-email-tklauser@distanz.ch>
In-Reply-To: <20101209082924.6d797871@nehalam>
References: <20101209082924.6d797871@nehalam>,
	<1291903356-30618-1-git-send-email-tklauser@distanz.ch>
Subject: [Bridge] [PATCH v2] bridge: Fix return values of
	br_multicast_add_group/br_multicast_new_group
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org
Cc: netdev@vger.kernel.org

If br_multicast_new_group returns NULL, we would return 0 (no error) to
the caller of br_multicast_add_group, which is not what we want. Instead
br_multicast_new_group should return ERR_PTR(-ENOMEM) in this case.
Also propagate the error number returned by br_mdb_rehash properly.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 net/bridge/br_multicast.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 326e599..85a0398 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -654,11 +654,13 @@ static struct net_bridge_mdb_entry *br_multicast_new_group(
 	struct net_bridge_mdb_htable *mdb;
 	struct net_bridge_mdb_entry *mp;
 	int hash;
+	int err;
 
 	mdb = rcu_dereference_protected(br->mdb, 1);
 	if (!mdb) {
-		if (br_mdb_rehash(&br->mdb, BR_HASH_SIZE, 0))
-			return NULL;
+		err = br_mdb_rehash(&br->mdb, BR_HASH_SIZE, 0);
+		if (err)
+			return ERR_PTR(err);
 		goto rehash;
 	}
 
@@ -680,7 +682,7 @@ rehash:
 
 	mp = kzalloc(sizeof(*mp), GFP_ATOMIC);
 	if (unlikely(!mp))
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	mp->br = br;
 	mp->addr = *group;
@@ -713,7 +715,7 @@ static int br_multicast_add_group(struct net_bridge *br,
 
 	mp = br_multicast_new_group(br, port, group);
 	err = PTR_ERR(mp);
-	if (unlikely(IS_ERR(mp) || !mp))
+	if (IS_ERR(mp))
 		goto err;
 
 	if (!port) {
-- 
1.7.0.4

