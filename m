Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFB121A437
	for <bridge@lists.linux.dev>; Tue,  4 Feb 2025 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698600; cv=none; b=JYGsE80NMVFAYjvVkQvW5lmkRwBpjQieerrBYPb0jnvsrt/7b6TkSSt9yWEZao8ENHmeMGehBhpK1zDeJrfW47zKBDahV3BkHcq1TFml24GGXqUQ6RnKEdv+0k32tWBmANrhNR6NPYYfSRp+1q6EZAuw6t+lyKsmiQ/QNSnRqQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698600; c=relaxed/simple;
	bh=jB4CLuNpjbTGQnMeQ4Tsv0ptAlvhyNfXsNUxXknTJVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubJv03kOf3dps8X2WpBs/lNYTHuN/2CrFLQaCpnuioEAU6DeTP/kKwaP0ptQw/I0grnrq8vGSsUkKIjbAnyjVBNnHD77H7xxoXj+z+Walca/1VcQhsNIIHL/2Pd0/cTRJ0T/b/7ijuRQCashn6px8ABzhd52XX5f4OEVn7rzpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2+rSbDh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2+rSbDh"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso1227369266b.3
        for <bridge@lists.linux.dev>; Tue, 04 Feb 2025 11:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698596; x=1739303396; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkGaA4c7zu7TuRSY1s83dH0+lqC3nn6Z4nZphc3xrDs=;
        b=N2+rSbDhFSTN6ugg6uMCOpCAV9Is/+FPv2dXml1arxfY44UTgeamdcvsqFekuOS4Qa
         YWWGpmhErNEy49I/hcFUefmrU2dFbtDKjvVOzQ4E6r6MeB8beHemiQQvH9SqL1jTWA0T
         W6BJK0/pSixwoU27c+Hk9M9tbsXhohH9+YlxG4vZc424uJ1Q2h1yDboU6slE8jZ3vT4m
         nnucvSm8MxjKm3lwE54Zr7l4AUoYUfaPcB9G9lMZ65ZbJSXuDJono/fnNgt5r+Aq6a9H
         GLVG15KRkUgWBdMbAaAYAg69d6tsyTB6P2zN8aCxcezX2V7leH3Aisjkbbr0G9137Woz
         0iMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698596; x=1739303396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkGaA4c7zu7TuRSY1s83dH0+lqC3nn6Z4nZphc3xrDs=;
        b=LPGs+4kp2VYgBq6OU2FFQU/PWuRU0wcpK0JcIXuoLXzhMT0oqmw4366b0RxgR2RIjy
         TDf55hgy3wXn88hp/uzNF/9DVFO7+6xryjKYYmiDalzdKtSJJcppxFnlvQLPIoF6EEwD
         T1WhIO/bmVl7tPeyBeH7lSR7ZM2hly5LCYSCcEWZlIQQ+n0X7sWIU78HPVGJbPzr0fxK
         ZUymMYciEHRECqroenKe6Adsb00SeGJiJx3SyHb44o4x4GkoAlyPvDx448UJMVruO8Rb
         2LlYWftHCjuOPIEZ5c1a1rj1Qww75E1z2uUKfnGsFx7Zby4LIfGyghtXSq9mCebv0HQg
         R2wg==
X-Forwarded-Encrypted: i=1; AJvYcCUhENqUDD3Vfz2WVHu8KuhQE+ksM2UWPA2Qd6TqDO5XDCwfu9G9dIC8+4zlC1V87+siNf2+ji4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwZV1NMrx5pIi91Ce7WlpcC7sJpi8ukIO1sSiVA6XBBlHv1HPlW
	3A4z45eD940h2cDOX0ZZ0YiIXxRDhhRzXQUen+HXCLVExIR508q9
X-Gm-Gg: ASbGnct4SyXPnrM83l4QofMrs+3JuILmJuEuA45iazE3PgD8wQcSkAu8F28OSIARm0o
	fK1aTjd7nNvWPoRMN7RMVtj0HQmBZsIWDirYrpjnkBC/9EyduqihsMNR8on5BQ0IgtAzfQNOQSq
	rxORyuoszXk1RNZdw1aHJ8B9CsH1Zg8rR2nHYwh3KRaYp4fS6pcpxHIdgbDBnHWAjheH+/S4tqh
	60K/zZl8wiA7EAi4/mKVJO/Mzi7rewpfJZ2Xkw6rSpRxwgMjXa/SWV4Bhydgnejr1eov8NoiIdq
	lK289Jpvodq6OTeLOhGkkUA8meLgIwLVGZoAG3MYOInrqwUZLxono4iVAsB07UGfNHv7hmMcDeT
	uZgafA6WPwFQr6ws+W+N4BAhXRXqah3A6
X-Google-Smtp-Source: AGHT+IGs4CC5gM167ZayoImsZp06NKQRfeGwh8m9DaNw+WB4zUAYvUsoKlU1KSkyxVdKrRT1PS7NMw==
X-Received: by 2002:a17:907:944c:b0:aa6:7220:f12f with SMTP id a640c23a62f3a-ab6cfce5fdfmr2766061766b.18.1738698596201;
        Tue, 04 Feb 2025 11:49:56 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5635bsm964684466b.164.2025.02.04.11.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:49:55 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
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
Subject: [PATCH v5 net-next 04/14] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Tue,  4 Feb 2025 20:49:11 +0100
Message-ID: <20250204194921.46692-5-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204194921.46692-1-ericwouds@gmail.com>
References: <20250204194921.46692-1-ericwouds@gmail.com>
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
index 19a553550c76..7c7080c1a67d 100644
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

