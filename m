Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3114AD2E
	for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728845738; cv=none; b=hoLjstj3vBRh6tMWkornWAWTrtehNArGAqYkTklYJP+PNcnT3XND2i6Ni2dH/uggdxbyD/A9E7Qx/r6qg+s1yklft3PjVKGoh768jqSyOvUvstQkMscYz2vpSroIdLjJYcjdwrCmb7jS8VXdcOk9D5HUHLENcwgNyAYO/WIS7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728845738; c=relaxed/simple;
	bh=poTP47yQdf4khdC+9ijtITarQAaptxBJXapnWT/Y6lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gX8xbPvNPntp3uzJcCGXYL08VLPV+pJnK0NJHhZf+5WGsU6kTchz/9WGSMljFKTeMly1zdr0akYnTaH/14epaN0RLfY8iv204OtmKkcH5tzmSK5gxQKQEN5CFytDc+BlMVmMkNoNQlmtFj/eYS1IROGe39B4IyCQ5BV6Fv54RRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8ZMPbwm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8ZMPbwm"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0cee600aso41183466b.1
        for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728845736; x=1729450536; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qi0AlNa47OjnLX+zdNkH8pnYspHiUC9rPn7VlkLtCao=;
        b=j8ZMPbwm3QOW8WJxweAFk8P6XbDJyVZOqjYMn+VgZf4Ald4VNy3085OHZ2AR1+RSB8
         BvAv4IgglHzUDujiwkp2bpw2xvar/+0d3JF3kFovIVpo1w4fhlCmt5zvEnfVfhSElbCZ
         KUsqzpIfZNmnrVP5OOU4Jkvj7lq/V9ACaNl/K60jzckfRaaS1ur/sz0oXm1WZBJK2JSr
         sezH6hFoXbFWQ7pC75JXAoeHeHar2CU+LdHFGwZdYoxoWDW67CF9fDyJidI8BslLUTNK
         dNM0Bp7WxWCCo6gICyYHq+hlZkX3lmiN3zTPz9cYWURJAMsfFD8/lN/OMmcpZvtMJZTR
         8QOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728845736; x=1729450536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi0AlNa47OjnLX+zdNkH8pnYspHiUC9rPn7VlkLtCao=;
        b=AQI7ig8nW3wxeGJncDxnYbCXO2bm/xmT/kznZVqpK2tSpl2V07WCwvhOtXp6QPU2oT
         MAA7GYTafpIfJkgUSwAps5XSiQHO1qwU5Y3QSDSdDUzXosLLGr8txKHtTdVn/+/qy6yT
         8Ry9xl69NCCr6FH16gxKEpe2a2/A3zhvrn5qwqAZIvtrW1hMKsb+DSkCHO24Os28UZBa
         P2up2qwrLqldM+w9Mq94NA6kKdokIVpHmBDfM+5mlJgK2syRICSAq4uvzxIPxQ4TGyOg
         XI9Lr2mgjKBiGIdUq0JZTlZErRwIY3AH6vZoTwpawRf+LOsI6MJHRP3apiJjoGncCc54
         5WXg==
X-Forwarded-Encrypted: i=1; AJvYcCXNyFqM6+S+DLrS7eVsbaUS2+MBSMISuhhxIyInJTKX89OsQooNq/yVRNKT9ro3APevERh+HfY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzbZYh2n7s4o3IXc2vTbcESzv+8TU60ko5YOcrkBS6W9ijI4Ucv
	2nB6dpYnFP0I+v/XDlrJb3IYcRKldHzuHhdyF1BRWhW2Oun298KV
X-Google-Smtp-Source: AGHT+IHVDWLkh2asCKPkqAFL6v1zfW7f+2znEwYnsBE2sJ/tzUwV2TxOCxBYdSzOWLcdLwlQKhvF3w==
X-Received: by 2002:a17:907:2da4:b0:a99:ffb5:1db6 with SMTP id a640c23a62f3a-a99ffb55507mr289530366b.24.1728845735564;
        Sun, 13 Oct 2024 11:55:35 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a12d384b9sm13500866b.172.2024.10.13.11.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 11:55:35 -0700 (PDT)
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
Subject: [PATCH RFC v1 net-next 03/12] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Sun, 13 Oct 2024 20:54:59 +0200
Message-ID: <20241013185509.4430-4-ericwouds@gmail.com>
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
2.45.2

