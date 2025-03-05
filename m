Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11102080D3
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170614; cv=none; b=NEx72fN7faIQ7oJvecZadDT8/5hZZEk6fpgRqvvyygfSOFiAxjNtYZVaRF55hbNcxVPRd5+D1GjNAB841sZ1BJ/99uilx4f8NqZlgUGSJ5OdKVADF6R3WbXNpfcMq2YyZSWZonM9oP1J21psCHo1eQ3wE3hytwNF5plSF3lfJ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170614; c=relaxed/simple;
	bh=WOvVk2IW6QUSaxpGvpwW6W6ywpdv9Y60/i896yobQ+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHK//LA72xYEOKMxL3l88OKYuAfG9sHHKdXfH3ijk3uprE1kVTbjSiuWFPxPSFei5ZMbkdcLMTqJ1KMudtNiHALJZPjawkC6a58skKSQNL3pu/bvmvzQnUEH/29QACpHOgliXiOd83T5JB3pQ0FlVwKeT2cmwwpnuIMFecZoPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esLAlV1W; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esLAlV1W"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf6f3b836aso553309166b.3
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 02:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170610; x=1741775410; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukwtTV0ExXBJKM7v4LhbJXSMG6hQJqW8GgzzDxNF23M=;
        b=esLAlV1WtDnrvHHKpCldCMD0s0WG+KIZAPWkKNMftSYUZWP8svbQ1PiDsgw5b2XgNo
         14sLMUI5tSl1S6Ujfq5zxm7U5W5UL/uy7j6ybEPx3Lipcr2vG6mr602cT/4qHBiusgyX
         jpVVxINg9nVAgwv82I2L2oM90Cyv8Y5furwAlr0rNNZ7wcAtl/hWzivcqDOKgnSZ88uV
         uDAUb8loCM6CSsTmBR3eWjbDJWSeIPgYEer/kVc23MjvsyAmb/PbB14rCXJutMBh9SSu
         YVcx4vNysgknTagBiswp6j1hf1rthkhG+B3KKwGllRyyZdrbjTHoGLJRSUMyNv4zGo3E
         0V9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170610; x=1741775410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukwtTV0ExXBJKM7v4LhbJXSMG6hQJqW8GgzzDxNF23M=;
        b=bnAyFfVnmEjD1qpiuMaRYiRQEbnotEkkC7I0+cTqHEydb5xf7NIrhTe/OrkYB87HmO
         38zzs3RqSnm5ot3L6eIgzfxKd5Y1aJqRZ1Pm7CovN7S7ie908MhJiS5yKSGzktJueBKC
         vseRBwDZ2rdD9DD0q4gkx5bHH74BM5/uLczKN4rVEjAeLZsqMpNBphiZ48+DNTf5S7p9
         B5ut9WU2/wsWXRstIMEIxomsERe8jorNpnCqKXU47fKUrAnlIkFn6idZ17Ukx2MX+rXz
         YekeMNoKqWSe5TBdnf6x2pUsabzhEODXhJn5HbOTlpS7QKc1zVMnlNqSkhrMqk2R7OoR
         iruw==
X-Forwarded-Encrypted: i=1; AJvYcCUey1ctzJbsumKaNt+POaLZthXDTP8KzKDbOAUpWKrldi5Hmcsdx7icIHv7Ny0aRz7Q+xm3lMg=@lists.linux.dev
X-Gm-Message-State: AOJu0YwbxiwPYqv4wRSqxt+R72nVn3OHVyxhyqSNo3sob1VS0+QUNjn+
	7zaMzCd0qspmFHf5oHzwhlLekVX9MqkMSZv+LRoRTq8kdiI0AD00
X-Gm-Gg: ASbGncvb9urVbYk7TzE2EnLuH1m3cSipz2TO20OmQLF3Ft61kRT1fste1I4FCKHvgu8
	hu6ytF96CpBOz/pc+Hzr9WbBCwtTd+KedrhMPX5jpzpZt4NQXxj0VrYwd70fZKYeiyJIR5rR1xr
	fEO7YBq1XX6/4mjlXixFwMioZkdhSW1BUwVxgEf2Mpvf4yTOWKryoxNd5HCjqjhlo4j6ubsHkl/
	xTDpFoy7xqwM7FNuVzc/lliwEMblIbXvN9fS2q9Ji8ygITVvHO7FORc/z52AX3qIgRcu7BNf7o7
	bxSdSA4AfCxgHhHs3AjFA/eFc/ycMvBc5mrQgJsB6jP2qLLt4bJfl+pHyMP7bdseAfkzYwgFLLB
	mSw84ssi+mKzZrmHT4ZcD0aItYwYArcq6d5WSj5l2hp0l7CMGIOr24FpNk8mn5Q==
X-Google-Smtp-Source: AGHT+IHxPPtoLfRPnCkh6koJ/eG/1JnXDYqS7eXulrdGgVMhsQC/yU7G5LKQ+8CrzPKHzBnta10/cQ==
X-Received: by 2002:a17:906:d54c:b0:abf:6f37:57df with SMTP id a640c23a62f3a-ac20e03ab40mr291110966b.51.1741170609587;
        Wed, 05 Mar 2025 02:30:09 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1f7161a4esm247154266b.161.2025.03.05.02.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:30:09 -0800 (PST)
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
Subject: [PATCH v9 nf 05/15] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Wed,  5 Mar 2025 11:29:39 +0100
Message-ID: <20250305102949.16370-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305102949.16370-1-ericwouds@gmail.com>
References: <20250305102949.16370-1-ericwouds@gmail.com>
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

