Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 22 May 2015 02:56:01 +0200
Message-Id: <1432256161-4425-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] bridge: allow setting hash_max +
 multicast_router if interface is down
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>

Network managers like netifd (used in OpenWRT for instance) try to
configure interface options after creation but before setting the
interface up.

Unfortunately the sysfs / bridge currently only allows to configure the
hash_max and multicast_router options when the bridge interface is up.
But since br_multicast_init() doesn't start any timers and only sets
default values and initializes timers it should be save to reconfigure
the default values after that, before things actually get active after
the bridge is set up.

With this patch hash_max and multicast_router attributes can be
changed even if the according bridge (port) is down, just like other
other bridge (port) attributes allow too.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
Changelog:
* [RFC PATCH net-next] -> [PATCH net-next]


 net/bridge/br_multicast.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 2d69d5c..066199e 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1775,8 +1775,6 @@ int br_multicast_set_router(struct net_bridge *br, unsigned long val)
 	int err = -ENOENT;
 
 	spin_lock_bh(&br->multicast_lock);
-	if (!netif_running(br->dev))
-		goto unlock;
 
 	switch (val) {
 	case 0:
@@ -1793,7 +1791,6 @@ int br_multicast_set_router(struct net_bridge *br, unsigned long val)
 		break;
 	}
 
-unlock:
 	spin_unlock_bh(&br->multicast_lock);
 
 	return err;
@@ -1802,18 +1799,15 @@ unlock:
 int br_multicast_set_port_router(struct net_bridge_port *p, unsigned long val)
 {
 	struct net_bridge *br = p->br;
-	int err = -ENOENT;
+	int err = 0;
 
 	spin_lock(&br->multicast_lock);
-	if (!netif_running(br->dev) || p->state == BR_STATE_DISABLED)
-		goto unlock;
 
 	switch (val) {
 	case 0:
 	case 1:
 	case 2:
 		p->multicast_router = val;
-		err = 0;
 
 		if (val < 2 && !hlist_unhashed(&p->rlist))
 			hlist_del_init_rcu(&p->rlist);
@@ -1834,7 +1828,6 @@ int br_multicast_set_port_router(struct net_bridge_port *p, unsigned long val)
 		break;
 	}
 
-unlock:
 	spin_unlock(&br->multicast_lock);
 
 	return err;
@@ -1939,15 +1932,11 @@ unlock:
 
 int br_multicast_set_hash_max(struct net_bridge *br, unsigned long val)
 {
-	int err = -ENOENT;
+	int err = -EINVAL;
 	u32 old;
 	struct net_bridge_mdb_htable *mdb;
 
 	spin_lock_bh(&br->multicast_lock);
-	if (!netif_running(br->dev))
-		goto unlock;
-
-	err = -EINVAL;
 	if (!is_power_of_2(val))
 		goto unlock;
 
-- 
1.7.10.4

