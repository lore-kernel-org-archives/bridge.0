Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C291A8F9E
	for <bridge@lists.linux.dev>; Sun,  9 Feb 2025 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099452; cv=none; b=DQlvsuiU3PcgbhlG1NNI4QtDx/RdVZEpai0O60nfCI0EE4zh1aNuqyAM9S8tAu1f18WWfj0aWb/ojRzk/ru7agvNRvXA9Cdd8GF6ETub7H+H6YdFuUq4W9t1b1/mWsjkMcXhX2sFY3dyoBJlamrZUTU/lP+eW8yq1LyCbeyKttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099452; c=relaxed/simple;
	bh=WOvVk2IW6QUSaxpGvpwW6W6ywpdv9Y60/i896yobQ+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4z7MHhLqiwXkBZ+o2j1aacf3S/P+BA3TURl9p4X+EDLzESIE8sZkxR3Hi9bn78UknP9BiqHwsG+rohLTdsrQ/aEtNVe2d8xDX0WGurEO4LcvFNNXnFGtWtIQRDElrCAuDvdOXBnzNsSYvcVc5VyyiaxW3n0/V2xzQfKHnEKJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpcrgeqT; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpcrgeqT"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7917fc0c2so337511566b.0
        for <bridge@lists.linux.dev>; Sun, 09 Feb 2025 03:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739099449; x=1739704249; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukwtTV0ExXBJKM7v4LhbJXSMG6hQJqW8GgzzDxNF23M=;
        b=HpcrgeqTkukBs165r4XEGW/VrK8734wacNQ7vYEaJt9XBnk6Veax3BVT8WoPj7eFs9
         DTDk50eN/vjJLwNHHAnb+lJGWaQ9Nqb7hk7nvWfFt3gkEors4yj9IIeJDRi8YTK3/vmS
         j5cpTkuWCWj5jGUzAAj89jPXSoUj90WzD2C+wb5bhz64Y+Q6DAtB92ZmD+PqJN4Heqgm
         eiFYmG0a9CMSkXGUDeaTuw2eRBN9pmVHMK+S002I3DHaiPyW2m4Co03TtY+G1znYQx88
         i6oU/nsAU0GQCoMKcygAszrBl62lkPO80E1txvJWXm5FjuFJNVpxrZnUBvMH+yblfYit
         udug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739099449; x=1739704249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukwtTV0ExXBJKM7v4LhbJXSMG6hQJqW8GgzzDxNF23M=;
        b=wsfrU2RZTZV2OVZjJhOys8JWkF9AKVhEA2UNRPaQd9beo8pjEZeop6MXAYsQjNp4fh
         H4ZNgMlA37idTKkufybrGAUWauG3J8Hqud7IMfqeWltH12y82vnkz7hiUDyo0dSckBCa
         niouds5xUW9HeICLCovMfoqOLMRIdJs/kUcpN5QZnCjGoovHX+mSBXVgnnoLUbDTjJrD
         vrNYNRV9LHiZAQ4jtNn251reyiS3AC6Y2rg3vQg3aizhHa1WepvTtueJo/dqqWJjCgG9
         tUT8Mp7zPNahwtRTIEDBPfCX4a4piXpoaMYPLrVl63JxEto+UppHQhjbhwHD2d6qH7EC
         wRVA==
X-Forwarded-Encrypted: i=1; AJvYcCUs+W+vXU8qpDwm6Q1q9dFpP90nqrLqnuLIjo4EQT39RD7XmZZhiwR0ztmYMxyPPqHKL5IH3pM=@lists.linux.dev
X-Gm-Message-State: AOJu0YyKfdiYyTpcwx2BiasBASdgdclQv2phPbBaBgMusRyNYxYxbX/0
	O1Cr9sYEg3A6gkUB2ui0UK2pSJTBlyNgdBk0VWMpLqy2mrtuCdx1
X-Gm-Gg: ASbGncv6zpPnpvbZA0ro5jnUAb5a7wGEHFtCJvmasc1xGzcZEM+/ToO/A/ura0TtWvg
	GugORQTLpqZ+IcSt5/aCaBN6l2FXfqp5d99ZoV3Q6bnsuCX4Jr39/fHfruJc9ToqkbPN38FnEkF
	vPwP0G36pL8aXVVHWJV5V9GKvlRmhkSNWS9LMDGZ2GsiBOQfiHma6IoGwHuNGKTAogE0g8G0+nF
	phdlSuTi7T1Rs4M5ftq6ruqe9yLoGTaxt5WVXnmIGxglna+1WEAeIOlHEGExYnACdeymN2I//G1
	JP7uDAUuxnDnPo4EDGX/UtmHUj154DPnBsIu+sFliVGgtIHa69TSuA98IEzhyyi7BORUmtuPHyF
	6TeTOKrFiJ6R4SrLQ7IcdUTjZEuyjh14c
X-Google-Smtp-Source: AGHT+IFQ0RozlZVD0Ur8OeqIX9zHHE/nY2BIcLmW4b68G+IKqL2kYQbbZ+HNgEJWAQaRsfBoOg4giA==
X-Received: by 2002:a17:907:7f08:b0:aae:fd36:f511 with SMTP id a640c23a62f3a-ab789d3431bmr1087121966b.47.1739099448924;
        Sun, 09 Feb 2025 03:10:48 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79afc7452sm357516366b.163.2025.02.09.03.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:10:48 -0800 (PST)
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
Subject: [PATCH v6 net-next 04/14] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Sun,  9 Feb 2025 12:10:24 +0100
Message-ID: <20250209111034.241571-5-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250209111034.241571-1-ericwouds@gmail.com>
References: <20250209111034.241571-1-ericwouds@gmail.com>
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

