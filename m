Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7CF19F41C
	for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742068861; cv=none; b=BS4ILgNIYD+1kxI51AkY+LH2V4toZX5uVSQ8BalzHls6OrCN33eA/+KtlYHkTqomStP3DQntOqktINOjjolINqG1sd1t8Au8ULIEkk5FMo5fNyLX9UigFIjznhlUz1STj8pYQ7PLARHUKv5mqSxdwDZtD9koEYP0ZAC0xInxd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742068861; c=relaxed/simple;
	bh=WOvVk2IW6QUSaxpGvpwW6W6ywpdv9Y60/i896yobQ+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgvcZt8Vi3uuJ3KmSLZf4fzQyUwB08Uqoy1PDeVYVdXaf8XSLyXsrHW51UMxoNhmI4ewQ2CeNRZEzbpUEHKhr8TITl5CTT5NgnUIkbQxRL2/KTHLmdurKZhk0lTqFa7m73rCSAMW0TplGzr2bQqS1xFR5nKvUX1thYa+kSV78/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KumIDVTa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KumIDVTa"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac34257295dso68596666b.2
        for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 13:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742068858; x=1742673658; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukwtTV0ExXBJKM7v4LhbJXSMG6hQJqW8GgzzDxNF23M=;
        b=KumIDVTadDHsY6Cnfjek9xyupwCAA7HSg35idHkvdxwurHIPleLVEnSnbJLb6rilMD
         Vf49ooHBJ75Q+WaU2XMH0wDkA/Ukhv7axdSF2AOQdmOXLeqvUekmmU4zwOPvtdbalY6z
         l6DPXp8p5gGYRhM4FoyDtAXe1xNWu733Fe7ZbqYkRL7U9bnwLlUZNtyCPgJLDMAFx1RD
         a1+G7+Ntqvf34EW4fOhsm/OlXfFlSK8yH0VExEzc4hdMUbIcGeEBKZrPnZLAfVvNhTZh
         8diL4yO9iK8Qny0RLgU/SpO6sI1XSvZyRMeYcN9DcgHAjwv1sGhFfdLdarvbLlKV4abu
         WHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742068858; x=1742673658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukwtTV0ExXBJKM7v4LhbJXSMG6hQJqW8GgzzDxNF23M=;
        b=Vf/cNS7LlgpII3kqjkuS7KW1YM5sSWBs0HnDfwGjLZq1c8W7iV78VdBzMETp8MFhEv
         04jqwJnUpEJdY7uzD8UHhpehT81X65YHau21q7AE+qdRPnlm2oWcVyfjFyoeNCy0/nd5
         8l28SvIdw19qY7kgQjXW/R67gkx/birSmutX60UK85Ju/v0SRqeI7u9+YLeWttxKWihS
         9ovn9sHrrrkroMnA/65+6gDqdrZK8Z2BR0yfhfapIRrK1P+XqtyVBt5h+zyf1eejsQUf
         zRmipUWHQsAQOCdlPC+eJgyQ5up4aMQRuVoualjCr/ysdLMS/WgUBIfSA5+X7J87GIIZ
         UGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcyPnk8uTZ9m8bIdNYQtbAJxT9APQaz0IccMBPrHyYdKrZ86Msv7OeAA2M2dg50BoXh/oOBjY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwNnvq8DUMTb0H2DoJ9RMghLaSu4bg5FKlG4fWkdkTKZuVpsSEs
	WHxXCjcUZ5ZN4TaYBRY0QthNRhq1JVJAE1D8PhQtVhaR8ruRFF3m
X-Gm-Gg: ASbGncv+hmWxoxbYc4j4wH0w04kNYIVh8nB5nx0FPx+A9LaDarw5YMWfpW0GyhOqZog
	2CD4HWewOM20m4eQL4leuObtb2KxAI6QryeNbvi2bHJeV8ZiYqZ5ZXHxwqmLCvh3sVngtG30y4d
	2orrkY1hpouN2Z5+/e4gtf4zuPSYxiKaOGy9kl9utTw4qgnU8sBjSUfOFvhAQ27w2IsqeHk7G/7
	SY799p88Kl9wKkvOAtbyt9KS8Lcci8sPiWzDwJu5dEMfS9jwHDB0FouG2Pbv7Sl7dG9NDLkR+iu
	vN95XaJx9P2du+Fknpo/W1gIu0pT/e6bKniJ6yZPvetKpLbfYGW1oJiqfdswVvNHFUMTXs28tIm
	YLZ2Sf6rhXsdKWGLG5jMIfmoFIh1wVH0WBnceQLehioH43clXcPZMBF8QHIWdO/A=
X-Google-Smtp-Source: AGHT+IHUG1k/HafScItz7647c4vgB0uWfWGe/KDk6+6POY+YOWwiV4SdbYmPp+R4rwe/RASZYCq8Yw==
X-Received: by 2002:a17:907:7290:b0:ab6:362b:a83a with SMTP id a640c23a62f3a-ac3301dd62cmr796461766b.8.1742068858019;
        Sat, 15 Mar 2025 13:00:58 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9bc6sm405908066b.49.2025.03.15.13.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 13:00:57 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v10 nf-next 2/3] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Sat, 15 Mar 2025 21:00:32 +0100
Message-ID: <20250315200033.17820-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250315200033.17820-1-ericwouds@gmail.com>
References: <20250315200033.17820-1-ericwouds@gmail.com>
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

