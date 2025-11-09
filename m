Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6070423D28B
	for <bridge@lists.linux.dev>; Sun,  9 Nov 2025 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716287; cv=none; b=azm5LgGBAtrE3I76iml0JqeopOMt3pn+9qOEgjMi+9OezSjHR96zNZO+fEj62qgrGjQl/Y19zVFZi+40tGN4XJWD8JX9Ttj+xu/B4K0pLaML8fcv2CqqGIvTWJPtBdrjXHt5tEesal7+BwltzeEs5vwZzpQ/+XqdIU8cSfQOk8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716287; c=relaxed/simple;
	bh=NfMwE8dlBybLdyHrMU5tp+2O3dmiRVolCqKrdaLCBmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBM9qqRpByLqpiiz2LuTDOJLJ/iI9QT7jnk1fQtUNH9A9Ohk6zDWanKKyMlj/uwag/19P4lUDsnXS8M0n2Tx9/CD+f4xfgMBwNZ7HCBjINlKyrVZIh/R6yQs2i1GZ+f/mgUDOFceI1LklL3u7rnSdu8X+GWfmiafb6bqOYWYiEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTa1bXYZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTa1bXYZ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso1255398a12.3
        for <bridge@lists.linux.dev>; Sun, 09 Nov 2025 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762716283; x=1763321083; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hS4vmMYkkCMh57/80KWcAsjRY0+LD1ZQh8tlkeNEwTE=;
        b=mTa1bXYZJkWQHcfdsABukHAaJ3W9U/v6J++SxINNzS45YNLftw0cr0OhAFArsdg8qV
         nKxjrV89F8H+yyc4jHvFIClZI27hTAFu5mgeh/wmF8EbXtBB2BYMS6Xyv8SBSAjHrVQ3
         aXIw9sQ2E5FpWNLfjaT0c0ieAfvVr+5Lb/4JdpQJ09ZjyJ1ftwg/7E1CvbYPb4zDzV4a
         tw64lrl0iiBG9XPc/51UCcLDP7SUFxMgTm2JX7mDHDYY9b+iCirPNNa1ZIPF2xiiyOKJ
         IyZnObPYQncQOAsE+g4yhvV42nQztTfDVjk0SAMVN6at+7Iu0yfcYS+zBFNQGtb77lGt
         2DoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762716283; x=1763321083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hS4vmMYkkCMh57/80KWcAsjRY0+LD1ZQh8tlkeNEwTE=;
        b=vr8keYumTPyTX5DeYAjavtNACbw8wVXIoeKx+86HH/5UnbnEB6tjROuu/+G+35WUBM
         8OhS3wu0izTt+HFx1kpJYGDGx4rKSVCrjgzrTp8GElu/tHxlcK7VWqSomSuQf/5k/zga
         jB6/XK03yIxPpiU+C1swY85uOEUArrNuzzYXKFTzAqDyZbUvSWiAARl/OLx5OlKZs6Hf
         r+NsX1/9cDkfc3FYZebdW2ncMXzYVzuVoyxV1cXXLp2mXu8MTAfWp3BCEnnH9EAF5zcY
         3lKh/DvhF8CwpR2GM2IaY/jc5I/oTHktgYc9hgM8/gFirQqVua50YGYXYh8KWutgXzWx
         X2Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXJQwmaEiEMvkdBW/ZSW5itC0pbgrw7lrStx283sXwKdza3Hco1bi/DOeIVAKLCF7uXzZ+Jc8M=@lists.linux.dev
X-Gm-Message-State: AOJu0YwDVf5eD+7s8qXpYGgZCcfLQTQoyUo3t7h2CumQ23AYsW/BKRMt
	hfD2+JzOxTmICjjx4scSvLvvsyf2KOeYmLE7GJiDgF1ktzclC+iWXONZ
X-Gm-Gg: ASbGnctSIawObLV+V3oWNIO2MSP+tKw7RCWechQmtvyu2uEejhB0LTVjycqrUkvLzsz
	7aqHjMjF2uQDmq1EGeXRuBoMBHio+pRZbJh1fX4UDd41TNEwMmfLpVLRwFWyNWFMs03HuwO1Fxe
	aRWSNGTVNCUp2gRdhInn0OI7t0HndBIsKmx5UBN9DBNzfWqXE99Wma8nICMKyXWqWhfUrhW9faS
	iN68of1SsyGXwiDyHP6qQJFuW+iqcIksuI0BWT/V1c8SAumP4KFtxw4aik3Wk4pEV2CeyX/uFbS
	EVNzLJodbXLEZdFxAxa62liCpPW4PlOexTb4Pi0j3t6U8KeOYWmvT53po5qi5CPp0jKMip+pFZv
	T+W9vdBnt0L4zLzO/udoQuiKQ5q0P8zWaRtyORfZEy6PvOyL8Iq86GIQp538/QKscyBjok1l2Zo
	funQLFB43kUZFNVThJIS67apMUN/pxZeqUUTb7ebAaxS6oZ6NYgDuYLGMpIYtRca0unxg/rE/hr
	EK7h78iPA==
X-Google-Smtp-Source: AGHT+IH97I/DBz8O1O1cNdMC5n7mLspwOnl2jq3tWIZKwko84qxwSv/wHhaodHGaDoHLoE9ZfnxFIw==
X-Received: by 2002:a17:907:7ea4:b0:b70:b5ce:e66e with SMTP id a640c23a62f3a-b72e02db993mr614713566b.21.1762716283159;
        Sun, 09 Nov 2025 11:24:43 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e447sm919652466b.42.2025.11.09.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 11:24:42 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
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
Subject: [PATCH v17 nf-next 2/4] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Sun,  9 Nov 2025 20:24:25 +0100
Message-ID: <20251109192427.617142-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251109192427.617142-1-ericwouds@gmail.com>
References: <20251109192427.617142-1-ericwouds@gmail.com>
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
 net/bridge/netfilter/nf_conntrack_bridge.c | 92 ++++++++++++++++++----
 1 file changed, 75 insertions(+), 17 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 6482de4d8750..39e844b3d3c4 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -237,58 +237,116 @@ static int nf_ct_br_ipv6_check(const struct sk_buff *skb)
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
 
 		len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len);
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
2.50.0

