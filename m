Message-ID: <46BD8D93.1060200@pp.inet.fi>
Date: Sat, 11 Aug 2007 13:21:07 +0300
From: Jussi Kivilinna <jussi.kivilinna@pp.inet.fi>
MIME-Version: 1.0
References: <46BB63B0.9060509@pp.inet.fi>
	<20070810094347.24c70480@oldman.hamilton.local>
In-Reply-To: <20070810094347.24c70480@oldman.hamilton.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] Fix typo in net/bridge/br_stp_if.c
Reply-To: jussi.kivilinna@mbnet.fi
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

Stephen Hemminger kirjoitti:
> 
> Okay, but I can't forward patch through directly without Signed-off-by:
> 

Oh, sorry, didn't know about DCO/Signed-off-by, but I do now.

Fixes a typo in net/bridge/br_stp_if.c

Signed-off-by: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>

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
