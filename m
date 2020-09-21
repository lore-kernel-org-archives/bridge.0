Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v0VyLBidFMgxaEIbE0qIA152wkMYPe0lHT8kdjtZmtI=;
 b=OSP2THmw1TyZKAGS7yzefO2pKInkY7BvVFxJAj31KwbSw5vuyIHod9PG0W22OsIBBw
 EYaik+sFpNryraAU1anxdSztI+DnuMf7S6ED0uwC84M+Yl1Z+UxA++acN1YBzn/fF9fF
 EQyWODKHqRr9INwFmC3i8ZVtXEMTOTNcjFq3Y1zVOP9yr/ImLjcaxeSy2zXnwu+Ziq09
 QV5C1mRga7XoicYsM5GxQP1dqGwYZrR22RyayOfO7tiLbghz/959wnFw2CY16ypUoZUu
 Me1ZZ9m3Q8No4ivqFaDchAGNV2YAtdZlyN7LZNonGt65yVcAgAhcaLvTRoJC80RHduYu
 4xVw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 21 Sep 2020 13:55:14 +0300
Message-Id: <20200921105526.1056983-5-razor@blackwall.org>
In-Reply-To: <20200921105526.1056983-1-razor@blackwall.org>
References: <20200921105526.1056983-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 04/16] net: bridge: add src field to br_ip
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Add a new src field to struct br_ip which will be used to lookup S, G
entries. When SSM option is added we will enable full br_ip lookups.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 include/linux/if_bridge.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 6479a38e52fa..4fb9c4954f3a 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -18,6 +18,12 @@ struct br_ip {
 		__be32	ip4;
 #if IS_ENABLED(CONFIG_IPV6)
 		struct in6_addr ip6;
+#endif
+	} src;
+	union {
+		__be32	ip4;
+#if IS_ENABLED(CONFIG_IPV6)
+		struct in6_addr ip6;
 #endif
 	} u;
 	__be16		proto;
-- 
2.25.4

