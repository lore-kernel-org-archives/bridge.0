Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3904B1E9B32
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240777; cv=none; b=aaExfBx0DsNmAbb/dG33+G2LG/XqJhJLfaSyI+jEPEyyHA0u54mgRFkA5eatUV7LWIsuYIEHTeLlATwMLCkilG4ELIcqcDXhd0xI0by7r9YgOkGUNpE59QqOZMRwTbcXQf54Ml+NI1DsDjt/EL/s2kww5dTSSMrjfWIFRsAVme4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240777; c=relaxed/simple;
	bh=dxwgF+fYRk3V5G96b0Vv6EygsfQSyTWaswg0nQK3KaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnjtH3UH8XW6zS7mcACLXhXHaM2tUO2VanyPyqBvp9qEPajS2jxWhoPPRzy6zz3ozH3m8j0sVwVCgqaP2h1gEtlY6YW05TuX8x/JqE1VToTt24kDl40KqycUe+a691DQAkAfkZoL6Nx673ptITzoSVH7eYG34jbJR+fE/8KBdo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqTAEQyE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqTAEQyE"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so28917225a12.1
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 01:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736240773; x=1736845573; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dC3jhTj5HQrnKJfxc0SY/ZIZuFArZD9eLZZ+JbLbIJI=;
        b=ZqTAEQyEmDy3h2ghNzxvVtrOiYNMaCcioYHKuflpsYvVcvCoJQCeEbtO56KASHoPht
         WufDzSHBcXfyKhGkkv/LphrQsCx0P+TUTEVxm2PGorcLl7QeF2yUdZaI4fARcyQ2NV52
         nRT9s7hCRZmnP7PZFuJuFNb9RyauhRDgR7nCJtm3rgrQ1N0pOvzbCfPNiMrOjw1UBohE
         x9cn8qNhfJNKOb+1oSLdl1GrLnoa6UvhCM5msKfQB3fppjbRo7EgYfOlrdDusGDJYgvY
         yyZTm4eE0JGfpF5A6TX4tQXvN/+Gpmc5xkbnalXBCM8LUFCFLGK41sNRi9+fCILMOQQw
         B8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240773; x=1736845573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dC3jhTj5HQrnKJfxc0SY/ZIZuFArZD9eLZZ+JbLbIJI=;
        b=biig0V+xuU85Hdnf3ltwqsr8WcoDV1eIv+6H6aWlASBEsPYNENv5T5aLbdm07E1333
         im8/kefrzSo2nWlJAGqch3NDNLxbxOtDpaYv2Sj3+LaLygk+H99yolCt5Te1T9BcFQNb
         yFf+VjcFuua0NoRFP+VZCY4WOuWF7ohm84x9cstM9TcROVIEFE+pz3fK8vmtjfARZa8v
         dMpSjv0i/b72YfjXHedSmz9jq0AfP6PkhkvTvi0LRLjQjRQSdWk3kAXLANCu2SOUwcll
         348qEPKx6Izm0A+fSh2GrZkXEMqW/b7DJiqal/3jqHPkHgd6bwgejGZG/IzB0H25gPlg
         b5rg==
X-Forwarded-Encrypted: i=1; AJvYcCU4UE2nV4VDBb1SKASYNtp4zSVFutpk+06dhnwOlY0juhe4swaG7QiXG4RaeCkN0O0ghUAL87Y=@lists.linux.dev
X-Gm-Message-State: AOJu0YxyRkxq1GN8vH92KpED8oZZsNfYRNiWpVk3/8QtCNmB47H7S9xb
	DLP9X/ecKCJttV/b5YBtjQknfB2J/FoL2W6HFf6hWqlbUReDQPR6
X-Gm-Gg: ASbGncvmxrNp4a6HoHs8OfHkn23u6z6Zq2+IJmI6jJgoM55zWQNfiTNN8FgPnBsPuR8
	Rv7D2WCJIACCqNCncb1/W9voFST0K1y2nMx8jlTeP4YLNqqYKrAHDJt5psK2yKlKgfVdWiRd/Qn
	wCPuIpAe/B3Agh2HTf0wWebPQ/x/u7egmYBiKi8QpAiFSubXqAhInDFUnR1QFvmuxBugxkz/L5t
	IqO0aNO54UULDRcO5nW6qGp+rAh4gtk6V3oic4UzKt45oqB4gSZBFmCiqRHWupxAlW/Y3tEXs3p
	Zzh9eO4Cex72F2FL02N4pn3W/ffgK6sTFdh0lXpor0caWk98Bkp3oLBefgH0e1wiF5McGtjRpg=
	=
X-Google-Smtp-Source: AGHT+IGPm33fBqlSag/h/JxGM9QbnBBO/F6XspmD/3+zFhonYQ/Vf8Fd540DJY6vH70es8P0d2HC8A==
X-Received: by 2002:a05:6402:1f4f:b0:5d8:8292:5674 with SMTP id 4fb4d7f45d1cf-5d95e8d541dmr2197749a12.7.1736240773221;
        Tue, 07 Jan 2025 01:06:13 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f3f9sm24005333a12.23.2025.01.07.01.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:06:12 -0800 (PST)
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
Subject: [PATCH v4 net-next 08/13] netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
Date: Tue,  7 Jan 2025 10:05:25 +0100
Message-ID: <20250107090530.5035-9-ericwouds@gmail.com>
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

Need to add NFPROTO_BRIDGE to nft_flow_offload_validate() to support
the bridge-fastpath.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index cdf1771906b8..cce4c5980ed5 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -421,7 +421,8 @@ static int nft_flow_offload_validate(const struct nft_ctx *ctx,
 
 	if (ctx->family != NFPROTO_IPV4 &&
 	    ctx->family != NFPROTO_IPV6 &&
-	    ctx->family != NFPROTO_INET)
+	    ctx->family != NFPROTO_INET &&
+	    ctx->family != NFPROTO_BRIDGE)
 		return -EOPNOTSUPP;
 
 	return nft_chain_validate_hooks(ctx->chain, hook_mask);
-- 
2.47.1

