Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9EB14A09C
	for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728845737; cv=none; b=bz7gvWJ+WugllvX3Or6dldC1s0IaVkKDPFXGN31wfYGKU6gaVSEiHWPzpkBnO/Fdgh4HB4ijatlPAR+GlVM9gHWWVMDDp9YozCSuYG9Pora/tEgUrj5Wn9Sw9yiqjMjILR1O2zvMy6w5tpDYuKUmL2vUlOULQ2rzaSWVmVgQoQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728845737; c=relaxed/simple;
	bh=tuoPy7aZ5VeD2cNXsXFZ+jCXqmclfS0mmV8rllHpiAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScTO7ohkSTxh83KyxuwA9oIEj6DsKtuLSPEgR+KyHysG+TnbQKRV7lzj64pjwT+bfnnZqotm4v/DlRFLuKNUmMDtp9XVJZbz2zFRKUiY0Imc14A1+OVEFmWLQBVYX8wVp1CZb/5WN9EnmgK3qRMobT98BRlrkqODI0Cgbb6p9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVFXk2Wy; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVFXk2Wy"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so189143466b.0
        for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728845734; x=1729450534; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfUb9HJ+s1GLLmxcujXBQ1+8qs5ZhQwuVS6uJsoTo/c=;
        b=lVFXk2Wyeuav97pgy4d1l1Ls5DONJTiXK3/qyJUXLDfeK2hpoTM8wwPGys/DcKi515
         XO+8euDDxKj7KUGlZ9UEKuzmQJmldHxKNpzXnoRnHaeGVK9RTkDWeVAiwF50O43PGjwx
         6FCJ7CSdnqZvmB4XULTGVhFbZfR0F2QAISvqLHPjxGcU8EK66wr7yTpkmftn29hucWFR
         VBILNbU4nwATLpscuiwJ4hcL/YBcEUu4cDlQoiy89uomKMURqUOZxuxyp0v+QcrbyQgl
         TkKV4nC0i1V0otlJPqk2nhPQalktr8CR4fL7CODXYu9FATvt7O2QaXRnqiWHhc18zKlr
         mAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728845734; x=1729450534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfUb9HJ+s1GLLmxcujXBQ1+8qs5ZhQwuVS6uJsoTo/c=;
        b=hfMs8F7fO7tcEe3dVYmfDrg4H7DsKapYH15VuRB1p3od1tzCKzll0ts0l5GEpPubkC
         NcDe6mc6sPI5Epymq/Af9c0+YItIhSU2HwHqCiuuMSayHUUvfOEmU5mFwIIgKvOXo6A5
         7yFQZOEeoYOozSKjU2+PCunHhnAlzEhvvOkqRmTkXP/x52T/11hll6gM/bRT5c2DuQ6E
         RYEoPRRwoKzsyH/nnflOIbduPKszzJ4O5gO56hKl185frMxCsw+LwNtPJ52WYxFO2tRz
         i1jYERqOe6lgL+pp8g5u0HqPg4NCado8aApV1HYeGq9Y3VJVgnQ31dSidEfTbPV1S/DU
         xk8w==
X-Forwarded-Encrypted: i=1; AJvYcCUuJvAGtg5jCc2dEP94VBnyzPNeCUABlCzj3rrGlQVQd1RsVCl+IN+VtOYOAM1DGL8uWaC4WJo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk8o0OcsS5rypqxE67utTz4aO3r8xKhGvK00nmsIwVjt3MgEtH
	WZT6KALP0VgJ+khidpr+mAJA98E6KEIDu4JyE/jiWBJWQ4EklpK6
X-Google-Smtp-Source: AGHT+IH+8DzpaIYRj4WDn5wY606h6B8yn6VPFaENvcSZa4TDlxRT2Jmn8BI4I5TivbHspBA60sKu/Q==
X-Received: by 2002:a17:907:6d14:b0:a8d:5472:b591 with SMTP id a640c23a62f3a-a99b93a86b0mr765431566b.5.1728845734027;
        Sun, 13 Oct 2024 11:55:34 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a12d384b9sm13500866b.172.2024.10.13.11.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 11:55:33 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH RFC v1 net-next 02/12] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Sun, 13 Oct 2024 20:54:58 +0200
Message-ID: <20241013185509.4430-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013185509.4430-1-ericwouds@gmail.com>
References: <20241013185509.4430-1-ericwouds@gmail.com>
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
 net/bridge/netfilter/nf_conntrack_bridge.c | 86 ++++++++++++++++++----
 1 file changed, 73 insertions(+), 13 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 816bb0fde718..fb2f79396aa0 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -241,56 +241,116 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
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
+	case htons(ETH_P_PPP_SES):
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
+	case htons(ETH_P_8021Q):
+		struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data);
+
+		data_len = 0xffffffff;
+		offset = VLAN_HLEN;
+		outer_proto = skb->protocol;
+		inner_proto = vhdr->h_vlan_encapsulated_proto;
+		break;
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
2.45.2

