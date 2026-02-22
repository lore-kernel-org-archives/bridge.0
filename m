Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F4835C1B4
	for <bridge@lists.linux.dev>; Sun, 22 Feb 2026 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771790347; cv=none; b=hHigGnd287rX8ceHkksKMX6IQ5bQeeRa7ZxU1lHGE+fqFa7ZOA48MZMuaRNAx7kxdd/h22JZi/khVWAQV3Lh+4W96so9B5EMcmuki3jWXTjYHdue8tUyDEVZ1yEbtZar2CNZD9N9W9/ujOK66QfhY6+SCjM8vXMMiuKjK14XLfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771790347; c=relaxed/simple;
	bh=MgqFP+kEIYkaJNFbJG3TL6RfVtetCetfNmpFyY7dGco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q819vprmj3SKnbZCjz5zWrdzmif9VbOBb5O1bOgH2MzfZ80/IUPclSOehlJz9YQl7ddN4uUcfIOmNZipSy03G6xZnhkKMF4WcfNKo4wRcFYcMwXrT9LCBT2Mu1x+UVNRcw+KlshRczCuBJ7M45BhvwuKAUl+4pgZxcd3W8vreh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bz6NO1Wb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz6NO1Wb"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8fd976e90cso493590366b.0
        for <bridge@lists.linux.dev>; Sun, 22 Feb 2026 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771790344; x=1772395144; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+3Us/40ma9gw7n/u08hiyPrq5670jVo0kM4Qwre1Os=;
        b=Bz6NO1Wb/hFQw8M5z4URr8fYjInRUA3xh5XprlwXu+vO2N+eGANk+GOkNRICi7qTND
         O950gkYFp13V+T4WsquVr2rFGLRTj3IA3jZtPOplcS4dki/063Z8Oo754H3Yt14Q5cmM
         d6L1xmyEYXj6DoLsLeWKiWdhfmtkQ2q7tQVXmzoFzKF8/eXc9reTZFDrL21NzD0gE4WP
         HoXekwmOUYkAMCOOzw/yp+2UVlvAuQG0diSAyCNv+2mrXkTDjvhy45WA6/UpR5NwynWD
         t5czM0ONJOfzHXVyxgNnmwoTbzowgUyyCAPsV9eE8f2ynRlfTkB4s+/EepN45QXTy9Ke
         71VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771790344; x=1772395144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+3Us/40ma9gw7n/u08hiyPrq5670jVo0kM4Qwre1Os=;
        b=GLPueOG/5hftlaQ+NYcFspfvLF7MDUAp41zdeH1E1Dz3CnDlnWhpFVp71kqls+vjyR
         BF/2SqOCJu3VVZl2kxv5rhXZ2I0Z0ruj+akTh5X6paw99XlI0hWCgFf6vD1IjoiKSHvs
         1tDxjJdeWpLsoH9RQFjJAi0AHxqfXdfSpJDN7XEp1Ag5s+onZIvVuZ/1W7CQfofc+NV2
         jsAv9QF5YN7xfXgPtmyj9YzQ+Bry/59LkivWudZg1tpx8RRvOw3KOYx9OTSjyO7JQ31n
         elPdImgUUVOA+/JQmIVD4XIuLW/2PlmYOn3DRTO+dJyg4NGzS5KqSZloC8sU41KODylR
         m9+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIoZwD9cDKrQNzyVhom3ot/p9WEmhdMei7HWRN+qpl4vpUIxfi3XsSYprwypxbmmXyIMvraUU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/jFnAPdTYg4NImUyYWd1NA3xtuEV2suO8+1QP/WfQzy3HS39M
	16QhcOUIUGKHqTIw94+n7YPO/AhHFdj7TC22vvnJ7fC9MYVwsvjSeeAW
X-Gm-Gg: AZuq6aLbu9+DcgnqT52m334C7E7rr2jKFEYcTEioSV6+QpGRVcYRj69Y2JrRRzmjA0A
	kpzRurw8W3JRDVAS9SQj5Thu9KyYqCavEunRo4HXkt7XxRaM29OW6uDuBCFXn5xsPKN2NplOgfp
	AgTHvdfijlheTcQqyrJFrleJOUAUlzhhJjb5OwZnLFXne8PFx448+vt/i11BoHhWJRGVPdEygiR
	kZMj/pyr2RsIOWUDWhFlp6wLcih91elC9T0g4TcaGB/IxVYqLnb3fAdQ18xS8/sp7P9g6Okqlsm
	SBmcADkBu+e9n2D3iEL2InejoeKrlZVROIobN9PyirbaXsSEpDv/thnBpYu9h/gLuV+Phi63D26
	2oJ4H2SKv1AVEJ6NptnWaPp0xVm72buZFl0Yu3yyOkV+fBjo2I2v1ZOKPRv0QZ1/5LlkgX1wDfP
	CuzpbU68VuBiNX4uacBiUS+7AlAsf0jijNfa5P3NELGXJGDMoR2y+GHTjqngHE7l4YdlJWGLGOQ
	n5Y53hbrtxmVa8b30cnYWtET4h2W4H2OJEZhLjn5KZdLQAzQsZ4cR8=
X-Received: by 2002:a17:906:2699:b0:b88:4b1f:5aff with SMTP id a640c23a62f3a-b9081b89670mr286298566b.44.1771790344085;
        Sun, 22 Feb 2026 11:59:04 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084c5c514sm246125466b.5.2026.02.22.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 11:59:02 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v18 nf-next 2/4] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Sun, 22 Feb 2026 20:58:41 +0100
Message-ID: <20260222195845.77880-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222195845.77880-1-ericwouds@gmail.com>
References: <20260222195845.77880-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a bridge, until now, it is possible to track connections of plain
ip(v6) and ip(v6) encapsulated in single 802.1q or 802.1ad.

This patch adds the capability to track connections when the connection
is (also) encapsulated in PPPoE. It also adds the capability to track
connections that are encapsulated in an inner 802.1q, combined with an
outer 802.1ad or 802.1q encapsulation.

To prevent mixing connections that are tagged differently in the L2
encapsulations, one should separate them using conntrack zones.
Using a conntrack zone is a hard requirement for the newly added
encapsulations of the tracking capability inside a bridge.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 93 ++++++++++++++++++----
 1 file changed, 76 insertions(+), 17 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 58a33d0380b0..49e01083278c 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -16,6 +16,7 @@
 #include <net/netfilter/nf_conntrack_helper.h>
 #include <net/netfilter/nf_conntrack_bridge.h>
 
+#include <linux/ppp_defs.h>
 #include <linux/netfilter_ipv4.h>
 
 #include "../br_private.h"
@@ -236,58 +237,116 @@ static int nf_ct_br_ipv6_check(const struct sk_buff *skb)
 	return 0;
 }
 
+static int nf_ct_bridge_pre_inner(struct sk_buff *skb, __be16 *proto, u32 *len)
+{
+	switch (*proto) {
+	case htons(ETH_P_PPP_SES): {
+		struct ppp_hdr {
+			struct pppoe_hdr hdr;
+			__be16 proto;
+		} *ph;
+
+		if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
+			return -1;
+		ph = (struct ppp_hdr *)(skb->data);
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			*proto = htons(ETH_P_IP);
+			*len = ntohs(ph->hdr.length) - 2;
+			skb_set_network_header(skb, PPPOE_SES_HLEN);
+			return PPPOE_SES_HLEN;
+		case htons(PPP_IPV6):
+			*proto = htons(ETH_P_IPV6);
+			*len = ntohs(ph->hdr.length) - 2;
+			skb_set_network_header(skb, PPPOE_SES_HLEN);
+			return PPPOE_SES_HLEN;
+		}
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr;
+
+		if (!pskb_may_pull(skb, VLAN_HLEN))
+			return -1;
+		vhdr = (struct vlan_hdr *)(skb->data);
+		*proto = vhdr->h_vlan_encapsulated_proto;
+		skb_set_network_header(skb, VLAN_HLEN);
+		return VLAN_HLEN;
+	}
+	}
+	return 0;
+}
+
 static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 				     const struct nf_hook_state *state)
 {
 	struct nf_hook_state bridge_state = *state;
+	int ret = NF_ACCEPT, offset = 0;
 	enum ip_conntrack_info ctinfo;
+	u32 len, pppoe_len = 0;
 	struct nf_conn *ct;
-	u32 len;
-	int ret;
+	__be16 proto;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if ((ct && !nf_ct_is_template(ct)) ||
 	    ctinfo == IP_CT_UNTRACKED)
 		return NF_ACCEPT;
 
-	switch (skb->protocol) {
-	case htons(ETH_P_IP):
-		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+	proto = skb->protocol;
+
+	if (ct && nf_ct_zone_id(nf_ct_zone(ct), CTINFO2DIR(ctinfo)) !=
+			NF_CT_DEFAULT_ZONE_ID) {
+		offset = nf_ct_bridge_pre_inner(skb, &proto, &pppoe_len);
+		if (offset < 0)
 			return NF_ACCEPT;
+	}
+
+	switch (proto) {
+	case htons(ETH_P_IP):
+		if (!pskb_may_pull(skb, offset + sizeof(struct iphdr)))
+			goto do_not_track;
 
 		len = skb_ip_totlen(skb);
-		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+		if (pppoe_len && pppoe_len != len)
+			goto do_not_track;
+		if (pskb_trim_rcsum(skb, offset + len))
+			goto do_not_track;
 
 		if (nf_ct_br_ip_check(skb))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		bridge_state.pf = NFPROTO_IPV4;
 		ret = nf_ct_br_defrag4(skb, &bridge_state);
 		break;
 	case htons(ETH_P_IPV6):
-		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
-			return NF_ACCEPT;
+		if (!pskb_may_pull(skb, offset + sizeof(struct ipv6hdr)))
+			goto do_not_track;
 
 		len = sizeof(struct ipv6hdr) + skb_ipv6_payload_len(skb);
-		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+		if (pppoe_len && pppoe_len != len)
+			goto do_not_track;
+		if (pskb_trim_rcsum(skb, offset + len))
+			goto do_not_track;
 
 		if (nf_ct_br_ipv6_check(skb))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		bridge_state.pf = NFPROTO_IPV6;
 		ret = nf_ct_br_defrag6(skb, &bridge_state);
 		break;
 	default:
 		nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
-		return NF_ACCEPT;
+		goto do_not_track;
 	}
 
-	if (ret != NF_ACCEPT)
-		return ret;
+	if (ret == NF_ACCEPT)
+		ret = nf_conntrack_in(skb, &bridge_state);
+
+do_not_track:
+	if (offset && ret == NF_ACCEPT)
+		skb_reset_network_header(skb);
 
-	return nf_conntrack_in(skb, &bridge_state);
+	return ret;
 }
 
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
-- 
2.53.0

