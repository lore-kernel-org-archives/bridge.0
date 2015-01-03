Return-Path: <fabf@skynet.be>
From: Fabian Frederick <fabf@skynet.be>
Date: Sat,  3 Jan 2015 12:42:08 +0100
Message-Id: <1420285328-7901-1-git-send-email-fabf@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 1/2 net-next] netfilter: remove err1 label only
	used with CONFIG_SYSCTL
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org

This patch fixes the following warning:
net/bridge/br_netfilter.c:995:1: warning: label ‘err1’ defined but not used [-Wunused-label]

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 net/bridge/br_netfilter.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
index c190d22..37e7d9a 100644
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
2.1.0

