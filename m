Return-Path: <stefan@agner.ch>
From: Stefan Agner <stefan@agner.ch>
Date: Wed, 28 Sep 2016 15:05:28 -0700
Message-Id: <20160928220528.17478-1-stefan@agner.ch>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1475099992; bh=YZsl0yELJmq1e8WWzUkqci2BaHaZyIMwdaGo9RBCUQY=;
	h=From:To:Cc:Subject:Date:Message-Id;
	b=o2LsJBTi6LFBKTKhgEOEkAm79GqcOPhsgn2IcrbiyHJ1BTOqL3x1Q/dCfzwnXdRXwuThYFM+z97IY58CIMVKqaAi30A5McjASd0lBXZbm4AF/Uz/nAUA0K1cTa4vVbgEXEURvyK2qC5GXkLkLstvKfJz2HhosGqLrSwKdJziQzA=
Subject: [Bridge] [PATCH] netfilter: bridge: clarify bridge/netfilter message
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, Stefan Agner <stefan@agner.ch>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, pablo@netfilter.org

When using bridge without bridge netfilter enabled the message
displayed is rather confusing and leads to belive that a deprecated
feature is in use. Use IS_MODULE to be explicit that the message only
affects users which use bridge netfilter as module and reword the
message.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 net/bridge/br.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 3addc05..889e564 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -227,9 +227,11 @@ static int __init br_init(void)
 	br_fdb_test_addr_hook = br_fdb_test_addr;
 #endif
 
-	pr_info("bridge: automatic filtering via arp/ip/ip6tables has been "
-		"deprecated. Update your scripts to load br_netfilter if you "
+#if IS_MODULE(CONFIG_BRIDGE_NETFILTER)
+	pr_info("bridge: filtering via arp/ip/ip6tables is no longer available "
+		"by default. Update your scripts to load br_netfilter if you "
 		"need this.\n");
+#endif
 
 	return 0;
 
-- 
2.10.0

