Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382C212D66
	for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823980; cv=none; b=BWoKW5KjQU+/83f7MVen8WVzPUZIEEImE/u1qZVvhKGQHBOwl5YgL917IowQ3FET4MrpjLiNf16oYR7ZARnBf1RwAqkr7Z4rKBUdcT1cwztYntH3eN6t2CLEQc/Uw7ST1sdAsNX3ZKrbIcvC0iYCVroNnKMHUHAXP3QefRzQUzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823980; c=relaxed/simple;
	bh=PpWhu6geevy6hVriSMI3jM+oaAQ6lslz7ZRk1SJTcoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNtM8FIkmGO1lhAQMZ1+DoCRByPmElJPg9uKAejcbGYl3W4xQL4XjQuHlUlOiUr9wVUoccsKxhC/j638nhTzkvDYqECmLdB6tb+JpykfVpvNV0+WjDMvJ3X8oCi2VwDtHTLJBUISXxQhlydp94C4hZpDHqVvijkRBcZUnAwqi/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/E5+pTj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/E5+pTj"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so8353366a12.3
        for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 01:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733823977; x=1734428777; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKIHos904u/55jjyV61JBBioSUFkR0jZBzN6/oqpIaY=;
        b=e/E5+pTjN4qmV277nFz9hcUkFH9cUQqZ+irQoo5sTN3fr8/zIi+oHvfH6UH5v6x6RM
         eePvMXwQ57IQ/I6CqCLB+GQ1TbFBt1ILYTLMxhulz00o+iLKYrz8MoE/xR5zOOULsLTE
         Mow7AjLWhaOiQGM2zeBGcep0AcbHs/XyBeQXgO+RekCLwkrSzS53nSY/vwcMXKsdJkal
         H7h5aQwmi53mxKXSDC4TzbPZRgUVwRE2Y7fZQ3WvTtB2XOKk97DuULNUe6xIBgg4FuQH
         80/DisFuAgaNcvP9dWWVgYhafbsvvMn4iiwQG+tdfCw5TawQRkesIg3OLqk5Bbd7AUYZ
         WSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823977; x=1734428777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKIHos904u/55jjyV61JBBioSUFkR0jZBzN6/oqpIaY=;
        b=P4dcnQyjeXqMSzvqf2nVTDtEwDRUHpUfQZprpdHwj67j/FL3p6VDM2myPbnqOckgQE
         c1Xh++44M9n5SoUaTIFVVVekKIoXmvTNYAVdz95CqdLML4vnFgCsKbolZ6l+gQi0SGA3
         DlJToI0MeoD7CsOBKY1VCsb2mcHD4dttM4Q9SiNHJrufgaWU+JUtIS9M8uO1+elSoHBH
         hLqiJpogeLsnq1obO7qFbZmopUUaLnYn0aqBQm8THY2Dhglm1pwFeUH+9m45RhYWLgHP
         CbO3VIsJHiXtOJ8vePagmx+KH34UOlw07k0ORKS2WYPoBbMweMUbtDOcvln+4/MI0MB/
         yLCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMjI1NcPjAkZ4wwSlziCQtMmzU+b61e8uC8azmDSO3SUBbAuBAMhBlRWG+Ff3e2rSjMolEsfg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzixTh+ZlJxA2eKmV0fMTqhtjO13F8lm0uWeI+ci0fzgtLpLIup
	uXDQEmD52W6UdjK4NtGaSb9KA8Ammmv5XWjdXG04RQquugoXDU4S
X-Gm-Gg: ASbGncsoq4g+SVjzcZCpqtkro6LsztUOajH20zlnIDfo24JH0TOFPBr82sOozvNSyJC
	qBND3gpgolBS3SovZCxE5wVHL5yqD9CCLe6mU0bQF96ZSMSvRhDojirZaWbHU7yB76uveAoTIVD
	zPtiaYset6jjmrFc3r/HH+mszsHwuVVHsEANyStwO5imGkLvwv5eFAixVOY5cqTWnMWDZhlq8dv
	Nv7mrqtzNWqubHTpIdj9a21N9n57XVFuKWoihGDYCT9yGM6WmeEUu5QuMYoYgUqQxZViR5I3ydc
	k5Rwx7Rpwum2LmIdjlQbSzUWNsZamJMmCZG1cb/fFupQv7TEQTo+uapMV459ZGxBCaIgh4A=
X-Google-Smtp-Source: AGHT+IEEUrkGtJfTGOQCwFkl/sxLKxNiujiQKGJAvLJ8Ua0u8uaifo2lDidZZxTSL8EGmSiw468ajg==
X-Received: by 2002:a05:6402:13d1:b0:5d3:cd5b:64da with SMTP id 4fb4d7f45d1cf-5d4185f81d8mr3897445a12.23.1733823976507;
        Tue, 10 Dec 2024 01:46:16 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b609e56sm7313936a12.40.2024.12.10.01.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:46:16 -0800 (PST)
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
Subject: [PATCH RFC v3 net-next 03/13] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Tue, 10 Dec 2024 10:44:51 +0100
Message-ID: <20241210094501.3069-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210094501.3069-1-ericwouds@gmail.com>
References: <20241210094501.3069-1-ericwouds@gmail.com>
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

