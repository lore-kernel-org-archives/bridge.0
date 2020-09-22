Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v0VyLBidFMgxaEIbE0qIA152wkMYPe0lHT8kdjtZmtI=;
 b=zbAOCZzno3G76ktSrpwFQ832xwc2ICqQyx1yQ4rBV/xmC/IoFF95FWd8yUAdc6Sm5W
 8LJpaWTWg7I8F4ipMdBDQDl4lylyzmJtfEZBLfS1JaGjX/ngr1b05vj/BH+vk/IcrRvu
 Nz0n1CQ30QMkNTsqN8mkeAA3QFPz0a8usehPA70ywRTeaload2kkOH59MCJWXPLjRqeg
 S0Ld7cB4QxTi6J1D0uIXwmtHWsTOz7/H2iKPuFlSDTjDj1AfIYe/ofPv502n+Q5DSWiq
 NE1zuN6KqA6nD8+im5KIKbDqB96O+wAnML3Y2WgIYZ4Equd13+9loI3D815Fdn3ZhCGb
 OOfg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 22 Sep 2020 10:30:15 +0300
Message-Id: <20200922073027.1196992-5-razor@blackwall.org>
In-Reply-To: <20200922073027.1196992-1-razor@blackwall.org>
References: <20200922073027.1196992-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 04/16] net: bridge: add src field to
	br_ip
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

