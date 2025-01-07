Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A31E3771
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240769; cv=none; b=QMxtr+Xzk6FZD/NqpqhEZ8KrcQUnaMizHLjkqAHt51KYqk1AOeGS5KzPMlHqp+rpJSvtl+J1/A35oDr+hFrBdfeaLxtML11gILyeAzz4VrkKd3FXvCsMYAsBcgyw6SIwZ+MTYpnuoVoWGqetcQAy7Nlb3++SrOVtmwPvhRBRaoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240769; c=relaxed/simple;
	bh=PpWhu6geevy6hVriSMI3jM+oaAQ6lslz7ZRk1SJTcoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddzneO4vh0m2VEmJXvOy3576gUcqRhMw4S1gKgU/Mhy3IpGr5dMY9Hmo9a5jxMzr/D+TcTQogavlrRZZEpHlqw4SETG8KRy20it/LcrZobffzUJPWnsTDnzA6Avh1aistwwjcwVEGYhrjasTInzPH6k9rPM7Z/rjRsJLTVuzEaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChNm+27Z; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChNm+27Z"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso26775148a12.2
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 01:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736240765; x=1736845565; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKIHos904u/55jjyV61JBBioSUFkR0jZBzN6/oqpIaY=;
        b=ChNm+27ZzyoKGzIxRDvtbmCmUxD3XvqVvrKnbfxJadvsG6ENcVcclnE5fQ4lFodWQc
         /+QeqBIH7Sl4zvAGhLSvU0xBJbETfNYFThUi9l055N38ULbsKKtjEPnt5Nzlj95MZKDp
         0p9DVB6Qd7iqmyIOWC5/4FZn9SWa2g6/OU+0BIIhLlQiBuf8ShY1Y2NN/IKw75WyrSs3
         cuABOE1jMn+XBz4H9YDk//XZrnU7zYfXsFHIh7ImsuignZ9TB7iXKxzWq8m/OjCJIBmy
         I1Uhj9pLUl2AryQvVPfCGKtxDA/W0+nFFmnOWl4GsiWftHoV1FRtXZt+4Jhf0J7cBple
         JpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240765; x=1736845565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKIHos904u/55jjyV61JBBioSUFkR0jZBzN6/oqpIaY=;
        b=kpZDTv2GA2AjAExU8N4dCI8Gj+1Jlhl0WXc9Uy1klARFtyTeFuZvOHbpKHweWS2ZxT
         qyuhgUkVk2PNfQ3Y33h8zCSj5Dbelua/GowRbPF1M1NHEjo1dxBhR/DHfevdPpjn7zL0
         uPMO57d6xW60mdhXqVevd3SYorPNNblXxePpkrfDag295yybwpYTHRgr8OeeGmA6S4UV
         GC/McFxYg5qQ2x+YM1ezGDEfUk7H3n2myJsDMOSTbAi4jhp5np26VFgJXYcoVMRBggi0
         1Z/W7OZ18loMeZQASbkxN8040eqxtTEaBKm5ffwy5+uv1qJ8qN5HPfe0Qi3bCls1Fage
         DmVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxzMJHs2QKY0qt3t9sVonS7TaWUO24e/8Hmipzc3tUvxBsDT19HlcSGhgKcjgBvuDQqKhLDy0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4LcXlCVMWxNJ6yCnD42WTs7WhqJrFmroHQWqtNQV2zPzgKTLI
	RYw0tdGq16KoBsLfPmSbfB57pH6ohvTsBa4SMXuM4kEY5w88TjF3
X-Gm-Gg: ASbGncu5W3syW1U2qyMfpqhbnJpDPxTfRVbJGWxIaehYxtUctOQwDzBVKXyHVmpquQP
	C7k+NuhYasx9VsrUty1PJtX1LogZhYas0PLjFQ/ZE2zHPEmBJ4VXR+bvjpZKhF9PRute9X3AOz2
	y4tdWwp7Smeqcgxvu8k9FGYqM/ElCYmatOy45bKpr3F/iYjPlzYKGREW1aOZkBePQvNj8BpFrqG
	gdjpm0LTGFhv9ZnGNWotDsT9uNQNg01TwewXgg0+JCGsSnLTwhhpw/dw0asDWxrca+0mp3bf7dD
	PlTsZKtEPf+e8S4rIl7XKKYWzoqOYHJ5Qq83QMgmYthTYjVwGBlo0yJy2Ys6T124UgeckWPmgw=
	=
X-Google-Smtp-Source: AGHT+IF9Q6hAjeuuV+Dr+SGY25DZC7a14teg1xdkg9BFE9rkMwMad+u2nsuZglYNPKcORNXEsZ1PbA==
X-Received: by 2002:a05:6402:2315:b0:5d4:320:ee66 with SMTP id 4fb4d7f45d1cf-5d81de5d419mr44287641a12.31.1736240765137;
        Tue, 07 Jan 2025 01:06:05 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f3f9sm24005333a12.23.2025.01.07.01.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:06:04 -0800 (PST)
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
Subject: [PATCH v4 net-next 03/13] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Tue,  7 Jan 2025 10:05:20 +0100
Message-ID: <20250107090530.5035-4-ericwouds@gmail.com>
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

This adds the capability to evaluate 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets in the bridge filter chain.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_chain_filter.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 7010541fcca6..91aa3fa43d31 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -232,11 +232,27 @@ nft_do_chain_bridge(void *priv,
 		    struct sk_buff *skb,
 		    const struct nf_hook_state *state)
 {
+	struct ethhdr *ethh = eth_hdr(skb);
 	struct nft_pktinfo pkt;
+	int thoff;
 
 	nft_set_pktinfo(&pkt, skb, state);
 
-	switch (eth_hdr(skb)->h_proto) {
+	switch (ethh->h_proto) {
+	case htons(ETH_P_PPP_SES):
+		thoff = PPPOE_SES_HLEN;
+		ethh += thoff;
+		break;
+	case htons(ETH_P_8021Q):
+		thoff = VLAN_HLEN;
+		ethh += thoff;
+		break;
+	default:
+		thoff = 0;
+		break;
+	}
+
+	switch (ethh->h_proto) {
 	case htons(ETH_P_IP):
 		nft_set_pktinfo_ipv4_validate(&pkt);
 		break;
@@ -248,6 +264,8 @@ nft_do_chain_bridge(void *priv,
 		break;
 	}
 
+	pkt.thoff += thoff;
+
 	return nft_do_chain(&pkt, priv);
 }
 
-- 
2.47.1

