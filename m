Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yXugY6d6T5JQ0E8sNO0/q9WRH/ek0UK4wOazUv+3iLQ=;
 b=InZAbQ1dDJW3JUG3tm2610Sm8jfyPUYpcoztYMjP3QPX6CrHuqXMLzK/lIOG9eHXzj
 XVJx/WMkrNhURHBhIuAgPtMx0M2VTQGFtbGXPMiqHX0LTXPsrXntccWmbh2HPcCdGxFR
 +3fZIMByMt0JmSB5Ui8t7oS+NYmfP361BAjXFmW2akUzQsy8+SkBQ/IeTnqsGkXjkfrJ
 fMoMdlTa0b69VVL4+zS/iXRezG2yKTrMep1xPT4HwmKblqo4G81uta6epcU6LsAOvhPC
 DomqSU+R2nra6h9rRHZrGh1z4C532asQSdb/roM0sUsGGNQu0SYlweJA0C4y7+XSu1dU
 oO9Q==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 16 Aug 2021 13:11:32 +0300
Message-Id: <20210816101134.577413-2-razor@blackwall.org>
In-Reply-To: <20210816101134.577413-1-razor@blackwall.org>
References: <20210816101134.577413-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 1/3] net: bridge: mcast: don't dump
	querier state if snooping is disabled
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

A minor improvement to avoid dumping mcast ctx querier state if snooping
is disabled for that context (either bridge or vlan).

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 0e5d6ba03457..9bdf12635871 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2943,6 +2943,10 @@ int br_multicast_dump_querier_state(struct sk_buff *skb,
 	struct net_bridge_port *p;
 	struct nlattr *nest;
 
+	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED) ||
+	    br_multicast_ctx_vlan_global_disabled(brmctx))
+		return 0;
+
 	nest = nla_nest_start(skb, nest_attr);
 	if (!nest)
 		return -EMSGSIZE;
-- 
2.31.1

