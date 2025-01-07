Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64661E2317
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240771; cv=none; b=uht4FpNWgwduj9bCi+tN6Ss5fHMbL7Pq7Cc483/Yd4UCtjPV9jFyV4hnApuR+k7f9PMqU3CGmLLsP88JgGbDEJOC04S3qZWsJ4W8ipvDg/Wro1DENIIuFHBhShhD8BpEWZDvoWFde28WRWyj+SCgiqT0avbpIMc2mOA33H2kfq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240771; c=relaxed/simple;
	bh=EiUlqjqcyycmVQh/cReUaNfMFD5MK6JvPeuoOO/UWjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIKC9xoNZ6SrQsI4vyg6WO8QecJbJHvHnP403f65uDQWbyHOGwstrxU3/DURATGVG4iY3a1rxZWKpIVORAsbuOKuW/mZ2olGdrgkqq1IV3Xry6D2xlOdEH3dH9N7QsyeBaw35idTFCFEOAhf9ED9K9H55Ft+FYohKNgOdsrAbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1xsnWee; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1xsnWee"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so20732700a12.1
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 01:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736240764; x=1736845564; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+WwlYEDG0HLvBd8VAnV5F5MIiHlMD5bJhzWof6nBUU=;
        b=d1xsnWeeTG9KehLvmE/x7gng46ByzvVFzvObiIErwJTlp9eb/qItJcbdFOcApB4HGr
         FRhYlWHIwEPJ3lnFtfag7EfjU2c0O3+dkSNu6MRFUW7aKWXQLzclSIg2R1UFwFZDlHV2
         NmisvE4TkutBoZv15XzZtITrNmygsciYsvOoR0BgGP0aM1+nCilbpJ1Q4ep8Wd6qKlIn
         QkN13GuSLKJWFf4Ql9h4kNdPFkHong3Ua+bp8o9MdpAnbzY3v5CzRfjVUs8yTsOLyjcN
         oRrB/93V61fzIJkViPRNpk6kA5/tn6AxbwrVncNLYXAUZNhOFRn0KYl+BoScHJ41klCw
         fDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240764; x=1736845564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+WwlYEDG0HLvBd8VAnV5F5MIiHlMD5bJhzWof6nBUU=;
        b=E3Fk3MB2XKOO/05tHapo/YqfNsZgDbyufXGfM1IL69lP7oBnxFZeuPXBfKKWz26W/p
         4jbAPUsNCJ5HGJ9rH74LZDw2N/GZ2k1rBbfQ3F9mAzMD4FwcuYVJ0Pc6hXhZTe6QJqsc
         QVZ/iZKOZCFnq4dwQZqvTUe7Flcu2C63oohnhdH7TwUWK6xFS6U1fK1W0CCHZ8kDQyNT
         mAkGm8zl5UMpHJmUx/gdW/Ay+YC168OkWoqy2ttJ/uP+PypwdfsrM9U1vxuTeP/ni+Ke
         XFwKs42x/IeI9D5qMGxS7DHHeO9jjNIqirm9OI81y3CRE1PRNgPCTudxhxn4ienPwwxR
         AVRA==
X-Forwarded-Encrypted: i=1; AJvYcCXEJYYlhEAdK24sDfJK5tTk0UUdZC1rsGHuCPcNXNxOVLn5Elb5fjp99El/qyvtCYmER08naB0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxlhi7IyRPvsv9ICEELeypmY3BLvc1zSOEVitPasdsUi3Wuxhwj
	E0m4sAmZxP0dcHqW/EmcR12mZWbt5Xa9nUFyV39U2UudnNnVyNml
X-Gm-Gg: ASbGnct+71W7pKVi5xEXElWyCJloIfoDf2N++BXLAZVg7jcJaE61gtxPyWrxewXfAi9
	4g4y1mCRAZFDT81lvN10skmPElYxVCHmH8sJVMPzW27L5AtdhbG2ljtUBjgPwWwlL0xjpU57MsB
	sKNAh/S9n95LLXrwzqvNwdsSQTbz+CeqvplWkjS7M0IIs+s1ZpAjrtVv9b8XWH4GTNnG6GRwWD3
	MYuAJtjHi9GeavapC7EZrLEc62DvGhGVwaG9ibAg94s5jc/pXk4NeEZY7mbPC+nGTJKRDspXLMe
	r6a5KQaonYXjZdVFLjuI+OYNJLJ9ir5TzG/DVpNgwJm5gfiA49UFpveVIxnGwG4RhCuc4rwtyA=
	=
X-Google-Smtp-Source: AGHT+IE84iozQuTG7YLPXSHPMUD1Jp0Hd82dBIjkAMjnqzFh19j2OWr5/GOeKdXGrKNPV87nRB5Drg==
X-Received: by 2002:a05:6402:524d:b0:5d2:723c:a57e with SMTP id 4fb4d7f45d1cf-5d81ddacfeemr57802207a12.16.1736240763963;
        Tue, 07 Jan 2025 01:06:03 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f3f9sm24005333a12.23.2025.01.07.01.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:06:03 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v4 net-next 02/13] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Tue,  7 Jan 2025 10:05:19 +0100
Message-ID: <20250107090530.5035-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107090530.5035-1-ericwouds@gmail.com>
References: <20250107090530.5035-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets that are passing a bridge.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 88 ++++++++++++++++++----
 1 file changed, 75 insertions(+), 13 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 816bb0fde718..31e2bcd71735 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -241,56 +241,118 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 				     const struct nf_hook_state *state)
 {
 	struct nf_hook_state bridge_state = *state;
+	__be16 outer_proto, inner_proto;
 	enum ip_conntrack_info ctinfo;
+	int ret, offset = 0;
 	struct nf_conn *ct;
-	u32 len;
-	int ret;
+	u32 len, data_len;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if ((ct && !nf_ct_is_template(ct)) ||
 	    ctinfo == IP_CT_UNTRACKED)
 		return NF_ACCEPT;
 
+	switch (skb->protocol) {
+	case htons(ETH_P_PPP_SES): {
+		struct ppp_hdr {
+			struct pppoe_hdr hdr;
+			__be16 proto;
+		} *ph = (struct ppp_hdr *)(skb->data);
+
+		data_len = ntohs(ph->hdr.length) - 2;
+		offset = PPPOE_SES_HLEN;
+		outer_proto = skb->protocol;
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			inner_proto = htons(ETH_P_IP);
+			break;
+		case htons(PPP_IPV6):
+			inner_proto = htons(ETH_P_IPV6);
+			break;
+		default:
+			return NF_ACCEPT;
+		}
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data);
+
+		data_len = 0xffffffff;
+		offset = VLAN_HLEN;
+		outer_proto = skb->protocol;
+		inner_proto = vhdr->h_vlan_encapsulated_proto;
+		break;
+	}
+	default:
+		data_len = 0xffffffff;
+		break;
+	}
+
+	if (offset) {
+		switch (inner_proto) {
+		case htons(ETH_P_IP):
+		case htons(ETH_P_IPV6):
+			if (!pskb_may_pull(skb, offset))
+				return NF_ACCEPT;
+			skb_pull_rcsum(skb, offset);
+			skb_reset_network_header(skb);
+			skb->protocol = inner_proto;
+			break;
+		default:
+			return NF_ACCEPT;
+		}
+	}
+
+	ret = NF_ACCEPT;
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		len = skb_ip_totlen(skb);
+		if (data_len < len)
+			len = data_len;
 		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		if (nf_ct_br_ip_check(skb))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		bridge_state.pf = NFPROTO_IPV4;
 		ret = nf_ct_br_defrag4(skb, &bridge_state);
 		break;
 	case htons(ETH_P_IPV6):
 		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len);
+		if (data_len < len)
+			len = data_len;
 		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
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
 
-	return nf_conntrack_in(skb, &bridge_state);
+do_not_track:
+	if (offset) {
+		skb_push_rcsum(skb, offset);
+		skb_reset_network_header(skb);
+		skb->protocol = outer_proto;
+	}
+	return ret;
 }
-
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
 				    const struct nf_hook_state *state)
 {
-- 
2.47.1

