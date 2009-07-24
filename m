From: Xiaotian Feng <dfeng@redhat.com>
Date: Fri, 24 Jul 2009 17:06:32 +0800
Message-Id: <1248426392-30777-1-git-send-email-dfeng@redhat.com>
Subject: [Bridge] [PATCH] net/bridge: use kobject_put to release kobject in
	br_add_if error path
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, shemminger@linux-foundation.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Xiaotian Feng <dfeng@redhat.com>

kobject_init_and_add will alloc memory for kobj->name, so in br_add_if
error path, simply use kobject_del will not free memory for kobj->name.
Fix by using kobject_put instead, kobject_put will internally calls
kobject_del and frees memory for kobj->name.

Signed-off-by: Xiaotian Feng <dfeng@redhat.com>
---
 net/bridge/br_if.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 8a96672..eb404dc 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -424,7 +424,7 @@ int br_add_if(struct net_bridge *br, struct net_device *dev)
 err2:
 	br_fdb_delete_by_port(br, p, 1);
 err1:
-	kobject_del(&p->kobj);
+	kobject_put(&p->kobj);
 err0:
 	dev_set_promiscuity(dev, -1);
 put_back:
-- 
1.6.2.5

