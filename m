Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hom66D7QlF74ZChwS4t+afVi3WhkjTNJBXj7NjSNFVM=;
 b=tzWe0JAh41Gch5AiXUler1lJGHcqpdBUfWCEMcGGoBuvpGARlOm/fBp4GAqpPZr/eg
 /v2jlAxpf4/MDN2h3VP8hyxcd76IvPO8N2VDN+JgQ3qg0xKxraMsW6v0VrIrxEOClZ8a
 nEffjvCvE2bsllavHYmQd1SPwBRHushTPBFjxy3vRyWhv48f8+xx/apSuijmabUtsO1q
 a/1Tt1jyHBRpsXnr5I5bPhh/uYU2JqkQrh8qp0VwurSmfVGPN3tRdTYU39bkgc1El1ip
 RU7F1RPlIBqriUWYGtNhHP0hr49wbmP57GjqDvgCoSdnb84jZ34lWjhMkdaxKlgHwQE3
 ykIA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 16 Aug 2021 13:11:34 +0300
Message-Id: <20210816101134.577413-4-razor@blackwall.org>
In-Reply-To: <20210816101134.577413-1-razor@blackwall.org>
References: <20210816101134.577413-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 3/3] net: bridge: mcast: account for ipv6
	size when dumping querier state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

We need to account for the IPv6 attributes when dumping querier state.

Fixes: 5e924fe6ccfd ("net: bridge: mcast: dump ipv6 querier state")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 76992ddac7e0..e411dd814c58 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2931,7 +2931,13 @@ size_t br_multicast_querier_state_size(void)
 	return nla_total_size(0) +		/* nest attribute */
 	       nla_total_size(sizeof(__be32)) + /* BRIDGE_QUERIER_IP_ADDRESS */
 	       nla_total_size(sizeof(int)) +    /* BRIDGE_QUERIER_IP_PORT */
-	       nla_total_size_64bit(sizeof(u64)); /* BRIDGE_QUERIER_IP_OTHER_TIMER */
+	       nla_total_size_64bit(sizeof(u64)) + /* BRIDGE_QUERIER_IP_OTHER_TIMER */
+#if IS_ENABLED(CONFIG_IPV6)
+	       nla_total_size(sizeof(struct in6_addr)) + /* BRIDGE_QUERIER_IPV6_ADDRESS */
+	       nla_total_size(sizeof(int)) +		 /* BRIDGE_QUERIER_IPV6_PORT */
+	       nla_total_size_64bit(sizeof(u64)) +	 /* BRIDGE_QUERIER_IPV6_OTHER_TIMER */
+#endif
+	       0;
 }
 
 /* protected by rtnl or rcu */
-- 
2.31.1

