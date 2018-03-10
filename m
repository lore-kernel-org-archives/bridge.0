Return-Path: <igor.mitsyanko.os@quantenna.com>
From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Date: Fri,  9 Mar 2018 19:03:05 -0800
Message-Id: <20180310030308.12947-3-igor.mitsyanko.os@quantenna.com>
In-Reply-To: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
Subject: [Bridge] [PATCH net-next 2/5] bridge: propagate BR_ flags updates
	through sysfs to switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: ivecera@redhat.com, igor.mitsyanko.os@quantenna.com, jiri@resnulli.us, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

sysfs interface to configure bridge flags only updates SW copy but does
not notify hardware through switchdev interface. Make sure it is.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 net/bridge/br_sysfs_if.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 126a8ea..9bdd177 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -51,6 +51,7 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
 		      unsigned long mask)
 {
 	unsigned long flags;
+	int err;
 
 	flags = p->flags;
 
@@ -59,10 +60,16 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
 	else
 		flags &= ~mask;
 
-	if (flags != p->flags) {
-		p->flags = flags;
-		br_port_flags_change(p, mask);
-	}
+	if (flags == p->flags)
+		return 0;
+
+	err = br_switchdev_set_port_flag(p, flags, mask);
+	if (err)
+		return err;
+
+	p->flags = flags;
+	br_port_flags_change(p, mask);
+
 	return 0;
 }
 
-- 
2.9.5

