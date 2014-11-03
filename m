Return-Path: <linux@roeck-us.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net;
	s=default; h=Message-Id:Date:Subject:Cc:To:From;
	bh=g8LQ1qe+BA/QfVyQnqwJ6yKn5rVJ11F+cthfAYqWhlw=; 
	b=MfXCVDAhBz+d1uAnLgMcy01I/WbWY95uAP4caujdJDZ6f1aV3ueRc3p+bYMNnQrGXRsj3biPIKw3/NvCyq1I4D0Vn0dw89AYoM9nOU3ckuLSyyrCSKqofzZULYBuk3qR/WzxCnQ54XyVee+oj3baJWiEB260NQ1JsVw1tcVhc9I=;
From: Guenter Roeck <linux@roeck-us.net>
Message-Id: <1414981155-27155-1-git-send-email-linux@roeck-us.net>
Subject: [Bridge] [PATCH] netfilter: nft_reject_bridge: Fix powerpc build
	error
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 03 Nov 2014 02:50:11 -0000
To: Patrick McHardy <kaber@trash.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>

Fix:
net/bridge/netfilter/nft_reject_bridge.c:
In function 'nft_reject_br_send_v6_unreach':
net/bridge/netfilter/nft_reject_bridge.c:240:3:
	error: implicit declaration of function 'csum_ipv6_magic'
   csum_ipv6_magic(&nip6h->saddr, &nip6h->daddr,
   ^
make[3]: *** [net/bridge/netfilter/nft_reject_bridge.o] Error 1

Seen with powerpc:allmodconfig.

Fixes: 523b929d5446 ("netfilter: nft_reject_bridge: don't use IP stack to reject traffic")
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 net/bridge/netfilter/nft_reject_bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/netfilter/nft_reject_bridge.c b/net/bridge/netfilter/nft_reject_bridge.c
index 654c901..48da2c5 100644
--- a/net/bridge/netfilter/nft_reject_bridge.c
+++ b/net/bridge/netfilter/nft_reject_bridge.c
@@ -18,6 +18,7 @@
 #include <net/netfilter/ipv6/nf_reject.h>
 #include <linux/ip.h>
 #include <net/ip.h>
+#include <net/ip6_checksum.h>
 #include <linux/netfilter_bridge.h>
 #include "../br_private.h"
 
-- 
1.9.1

