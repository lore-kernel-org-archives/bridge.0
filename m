Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A0A30BB8D
	for <bridge@lists.linux.dev>; Tue, 24 Feb 2026 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916004; cv=none; b=WXmzf0BA7dqMDdBuPKZfM0klbMU6/uD8dhc1NzDb//AGkG5JNwqJsuzCmwcu49F0mEJuPcRQWk9sOebK4dTftyUJ6GW45B2YMLLQL7jvsrlxXnv0YUdRreLa7rAPI7AjHzLCXsndis2zPs1ux1nLvHCnHTlBAobKxrPBV77JBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916004; c=relaxed/simple;
	bh=otw/sidfsrVAXpxIAPSAHcc1JnUEwkQzo3iMewEEbLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNM58rmzrJvPqqLFQdrkNhVfOHVF8MVkkDkr2rdDI7SAXwW+vxAmvtmhhcyzIdaTeZ+ozeVM1HbErntj9iaQDS6/5xvR5Y06NtPBz+S/Q13gTjbXLKMSbfX4Ej3xcPYz0r2OPyaqvHMYkFQdQiDLBfg3bGTCf9vjB7+YqdgJcxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/tFwg24; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/tFwg24"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65c5a778923so7854250a12.2
        for <bridge@lists.linux.dev>; Mon, 23 Feb 2026 22:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771916001; x=1772520801; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coP60IDvUwENZ4G8REzPur6qzEmmqfojoUutShryN4c=;
        b=X/tFwg24/3aKEludoK2dZ1OzhxInZif2W402n9QcJh5HaQg9FYaN8Wdpt8IudB9dvs
         vrAtvHfEwDDwRNpeS7wgPCTWyPsqfpB+pNfvkH5O0ylaUZf76sothdKADcJvgKc67ilV
         I2doGOHMJCqlBGpLE2nEfxNuH3GfFBOhWcae4gMcA98b8tLh0yd7msST81WULcNGFpN5
         GW23juWvrAuzTZhvNBbS5utMZsPybLNcRqROGVnD6Z+KSvFgFWOSsX8VFFEwegUfoQcB
         eajbzO/05zjCtm0wM9vR1bs/0iu10pwj0qPxUEgtixoQLPY8E0+vInEB6fVNGG2+vI2/
         kmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771916001; x=1772520801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=coP60IDvUwENZ4G8REzPur6qzEmmqfojoUutShryN4c=;
        b=pds1y14u91nS3RqwqSENt6hR+/4hHmQnakzpMwQqwIw/PO7nDECvdD+TcBrmqWwsTU
         prxWvBJIUqiXpqtLgRgHFhK3Sy9oBLMmsj2YpSaavnWIp78BOlcHAKIZbu+vyvTzfZVD
         +zW6raPc67zbbfck8s69Rellv+ktBkHmQOp8r0eDuATfsEfElFqPvlMqN5luArE7llV/
         DzlXFR0s2Vv6d8GaIoAVSDtaqfdEfmi6f/fAbGl7+NIvmkgkfe3+IauZ1Kc7rqvT33Bb
         98bRFes4Jn4n+YxDGMTXNic/2/QWvZIzpvW0KEYblKM6L1LG3muaHdcJRzcLm38r5LQA
         zapA==
X-Forwarded-Encrypted: i=1; AJvYcCXCmd4/fFUgEaczoj5THFBtALtRd+3skCw44n0X6UUBRB+v3XcCUukTcF18Cs4cQ8NUsDsnBZk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxsPJ586P48PF1+Po6G4leWSPG6rexAEU5w5ZyTgUiCtoEvjM/M
	bA5IiZ1YtY5VHwj9X74SJjhFvEno9OL5fz2i/OkuXRrGYj2ck6NuPGEy
X-Gm-Gg: ATEYQzyo36MfQ+cHbGCWBS2tQi7WVmruPgV7M6tdcmVJqdhh8K++QVG748Cbo/S5XMU
	azuy0bQQFIUN6jnM+R/s6Ot4L/bQtZY7jnoyFgvpz+LPnM+qeEYzmICyu34Qv65Mk9nMdZtbJUV
	14vE2DgZtCVHQqjkYAc40ViHhsePCSR9/S6hvpzsuB0Upy3DBebofED0eA+/HF0qXWRLsLvXO87
	aV3ZjkvfqkT7Q2yQxw2h0w6uYk0EOMDpOhQDQKL63fwdS9b4OgmJo/J2y1nk7LPkWzhgLBUlozL
	SzoepkSG4DtsBMLN2CQmp7ymeNanaFZn8laZkVKFob2s1dHijW5Qe4lQQ85hsjGRfqtga9JzEV3
	HVXRtT49brcsqdMAcEtBa/EBIWE9RIRPNx2cDYd1TVd70ZBQLrFm4gtIqSt1P4xjLrjJMp3MQnF
	Wt7gbej+tYEvSjdpC6Gqm0WZTMo2DBN96VXdD1l4lxorxW7ZO1zYroswKGSQX+/pC7ktt07kFk9
	jjUMGwCQEzs54wZkIVCzlU3xnq6DaMsoFF4vgXFOW9GKI77zPhdSkE=
X-Received: by 2002:a05:6402:50d2:b0:64b:58c0:a393 with SMTP id 4fb4d7f45d1cf-65ea4f07f63mr7024950a12.30.1771916001174;
        Mon, 23 Feb 2026 22:53:21 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eaba13866sm3096698a12.18.2026.02.23.22.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:53:20 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v19 nf-next 5/5] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Tue, 24 Feb 2026 07:53:06 +0100
Message-ID: <20260224065307.120768-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224065307.120768-1-ericwouds@gmail.com>
References: <20260224065307.120768-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nft_do_chain_bridge() pktinfo is only fully populated for plain packets
and packets encapsulated in single 802.1q or 802.1ad.

When implementing the software bridge-fastpath and testing all possible
encapulations, there can be more encapsulations:

The packet could (also) be encapsulated in PPPoE, or the packet could be
encapsulated in an inner 802.1q, combined with an outer 802.1ad or 802.1q
encapsulation.

nft_flow_offload_eval() also examines the L4 header, with the L4 protocol
known from the conntrack-tuplehash. To access the header it uses
nft_thoff(), but for these packets it returns zero.

Introduce nft_set_bridge_pktinfo() to help populate pktinfo with the
offsets.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_chain_filter.c | 55 +++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index d4d5eadaba9c..66ef30c60e56 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -227,21 +227,68 @@ static inline void nft_chain_filter_inet_fini(void) {}
 #endif /* CONFIG_NF_TABLES_IPV6 */
 
 #if IS_ENABLED(CONFIG_NF_TABLES_BRIDGE)
+static int nft_set_bridge_pktinfo(struct nft_pktinfo *pkt, struct sk_buff *skb,
+				  const struct nf_hook_state *state,
+				  __be16 *proto)
+{
+	nft_set_pktinfo(pkt, skb, state);
+
+	switch (*proto) {
+	case htons(ETH_P_PPP_SES): {
+		struct ppp_hdr {
+			struct pppoe_hdr hdr;
+			__be16 proto;
+		} *ph, _ph;
+
+		ph = skb_header_pointer(skb, 0, sizeof(_ph), &_ph);
+		if (!ph) {
+			*proto = 0;
+			return -1;
+		}
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			*proto = htons(ETH_P_IP);
+			return PPPOE_SES_HLEN;
+		case htons(PPP_IPV6):
+			*proto = htons(ETH_P_IPV6);
+			return PPPOE_SES_HLEN;
+		}
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr, _vhdr;
+
+		vhdr = skb_header_pointer(skb, 0, sizeof(_vhdr), &_vhdr);
+		if (!vhdr) {
+			*proto = 0;
+			return -1;
+		}
+		*proto = vhdr->h_vlan_encapsulated_proto;
+		return VLAN_HLEN;
+	}
+	}
+	return 0;
+}
+
 static unsigned int
 nft_do_chain_bridge(void *priv,
 		    struct sk_buff *skb,
 		    const struct nf_hook_state *state)
 {
 	struct nft_pktinfo pkt;
+	__be16 proto;
+	int offset;
 
-	nft_set_pktinfo(&pkt, skb, state);
+	proto = eth_hdr(skb)->h_proto;
+
+	offset = nft_set_bridge_pktinfo(&pkt, skb, state, &proto);
 
-	switch (eth_hdr(skb)->h_proto) {
+	switch (proto) {
 	case htons(ETH_P_IP):
-		nft_set_pktinfo_ipv4_validate(&pkt, 0);
+		nft_set_pktinfo_ipv4_validate(&pkt, offset);
 		break;
 	case htons(ETH_P_IPV6):
-		nft_set_pktinfo_ipv6_validate(&pkt, 0);
+		nft_set_pktinfo_ipv6_validate(&pkt, offset);
 		break;
 	default:
 		nft_set_pktinfo_unspec(&pkt);
-- 
2.53.0

