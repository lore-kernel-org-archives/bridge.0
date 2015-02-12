Return-Path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Feb 2015 15:17:27 +0100
Message-Id: <1423750647-30389-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] bridge: netfilter: Move sysctl-specific error code
	inside #ifdef
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org

If CONFIG_SYSCTL=n:

    net/bridge/br_netfilter.c: In function ‘br_netfilter_init’:
    net/bridge/br_netfilter.c:996: warning: label ‘err1’ defined but not used

Move the label and the code after it inside the existing #ifdef to get
rid of the warning.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 net/bridge/br_netfilter.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
index 65728e0dc4ffd011..0ee453fad3de6521 100644
--- a/net/bridge/br_netfilter.c
+++ b/net/bridge/br_netfilter.c
@@ -987,15 +987,12 @@ static int __init br_netfilter_init(void)
 	if (brnf_sysctl_header == NULL) {
 		printk(KERN_WARNING
 		       "br_netfilter: can't register to sysctl.\n");
-		ret = -ENOMEM;
-		goto err1;
+		nf_unregister_hooks(br_nf_ops, ARRAY_SIZE(br_nf_ops));
+		return -ENOMEM;
 	}
 #endif
 	printk(KERN_NOTICE "Bridge firewalling registered\n");
 	return 0;
-err1:
-	nf_unregister_hooks(br_nf_ops, ARRAY_SIZE(br_nf_ops));
-	return ret;
 }
 
 static void __exit br_netfilter_fini(void)
-- 
1.9.1

