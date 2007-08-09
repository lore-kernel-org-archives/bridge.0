Message-ID: <46BB63B0.9060509@pp.inet.fi>
Date: Thu, 09 Aug 2007 21:57:52 +0300
From: Jussi Kivilinna <jussi.kivilinna@pp.inet.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] Fix typo in net/bridge/br_stp_if.c
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Fixes a typo in net/bridge/br_stp_if.c

--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -132,7 +132,7 @@ static void br_stp_start(struct net_bridge *br)
         } else {
                 br->stp_enabled = BR_KERNEL_STP;
                 printk(KERN_INFO "%s: starting userspace STP failed, "
-                               "staring kernel STP\n", br->dev->name);
+                               "starting kernel STP\n", br->dev->name);

                 /* To start timers on any ports left in blocking */
                 spin_lock_bh(&br->lock);
