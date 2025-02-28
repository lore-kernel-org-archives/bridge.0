Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A06276047
	for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773786; cv=none; b=VW4p7CgNrIWUq/FoNLMh9y38MNxuWd4f8L/fvuDCYQJWdC8qKal0NyBjekgzeIqfSLjEQ+iDkjsWOvCJuW4yGrLBbeqg/SLwsiXNuAjqEuYUQ0vE/LGzNVTgRBm7p1JueVrlYfB7O29NO84NTXu16yiprUidxmgE3oOQglzBliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773786; c=relaxed/simple;
	bh=WOvVk2IW6QUSaxpGvpwW6W6ywpdv9Y60/i896yobQ+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgdGuTqYWflDygh9otcPww5Tas1g0rYnfM9hhI9LGafBBYxeoUxNQvUk1Y5p+lb8cR2v3qo7b15e8r86xtWy6kke1SB26pH8Po0wBcb6JvDjbV40kYx/7LPSSh4cYp1LU+SyUZaq6ovdEQkkd5qh6gd6P2sCvtPzE3NfKOtaowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqGRLeO8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqGRLeO8"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec61d0f65so517566166b.1
        for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 12:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740773783; x=1741378583; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukwtTV0ExXBJKM7v4LhbJXSMG6hQJqW8GgzzDxNF23M=;
        b=EqGRLeO8gIeyMCShQ3/43P5QCSHFajT9cJNsf7tHeftBhscMcJj+KlwbWsrTaKdfZ2
         B09lZbCWaLvkZhJWmpPHhWlaZr4hnM3btELlzZz0E67ir+mzsGoG9jzNX4hn9pO35Da0
         ml/kVvx+qiswjvY2h74j0Sg7FdzEQ5RhLFtMH/GncDEt8DXXjJTn2l06MSkRC8QTFu1e
         Ug6ceKnaWbwFVRmMnweryNyjtpsvfiMEdxbq6kuSKzBNB7I5QIB3c7jZIse4+SQ+P/2D
         slgswNg/Iy+uiZKGj2pF4HXMZbnJt9lNjUdBLXxZQIbGAiWgHse/bd3dhTNDktPacD3e
         YFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740773783; x=1741378583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukwtTV0ExXBJKM7v4LhbJXSMG6hQJqW8GgzzDxNF23M=;
        b=IQULEDmns7NyCFWnI3XImFh8NBB0tjv1V9/cFnMLu21AJx3iTwZtcpr5trjhJtb4Bb
         md3SYBwI3llOIa1ociq3mgZjyvsOEdz8hnaY/axdPrrzvYgZ5jHYJg6olSXjUdNSbEVx
         hCfCMcfzf2CUWUoygofhC/UzzcSLctHmNqvxalSv0sKRBNR/4iICpDQOat1TQrOTNiHD
         sNH1l3HZcsGIwowmMo99CYGCTrOgteTs1cjQu3OqWJnbbeoeP6pvkG8genHVwl/KDep3
         rIkaUhIgFQYQeeKp4u2yUY42MhamPlycDTOUbI5H+huKCg4nSa/AupN/a+E1SCbamfKY
         Sicg==
X-Forwarded-Encrypted: i=1; AJvYcCWljdO1fKhBABPN7Y7R9UyEGuRT/zKzqfsYBEOXuQLJmcOECen5nWSHZB6Whr8n8vSxoWWL1O0=@lists.linux.dev
X-Gm-Message-State: AOJu0YyPX51y6z3ZOurVU0hFdOAE7TQQTrRnxtuKwX7cZLPzpRwubjUY
	sfqJpzW4O6Z10G/qxeT1h1P884hf8kgbHAyAPg4eAmAAl9+ASrF/
X-Gm-Gg: ASbGncsMb8orFd3TNOe7YLbBKWUe0wUG1SF5iQXHHHn0KlKUNdVwYNQXQUeQvGDt7jD
	ZWt1+gdEwfIVromSBW+OMaoU3YuE3yz5EbA8yHNosIghuuKGLLl0NIzkdCktvlUAymy+USal1h6
	2RjBj7Td6HI6hhxsjxuGjyGXc2kWqRM8J2R8WSaoJTLRazc0KABjBvCJpibL4XAtOL+FvI+yzpx
	/+817yL1QpNb2wnqq5QqA1JHVD3/US0y8KZZTyYbEexF0oRUT6fwkG8qd74xHdukkb+RQ5Uowdk
	oZdc2VvIs5PR+OWHlBdYI2LZB4Rw13Hgk6m+4Stot+8lxYNkNwj2E1A6qx87qDzJLvG+sIED6zb
	qSR05Bgt+L0R9dnt0v250uudfrbHZrkUFEAje2lMwcmI=
X-Google-Smtp-Source: AGHT+IFuUzdbgaD/IFSs5QLipx4iHpbTunJtFdHt4pWJCQ/QSyvZEmN8DMfkaEXDfQkozt/2Pfk6qg==
X-Received: by 2002:a17:906:6a05:b0:abf:16f8:5190 with SMTP id a640c23a62f3a-abf26822611mr449155566b.44.1740773782957;
        Fri, 28 Feb 2025 12:16:22 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c66sm340812666b.136.2025.02.28.12.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:16:22 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Ahmed Zaki <ahmed.zaki@intel.com>,
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
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v8 net-next 05/15] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Fri, 28 Feb 2025 21:15:23 +0100
Message-ID: <20250228201533.23836-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228201533.23836-1-ericwouds@gmail.com>
References: <20250228201533.23836-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the capability to evaluate 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets in the bridge filter chain.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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

