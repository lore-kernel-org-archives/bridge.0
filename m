Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E327D79D
	for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773794; cv=none; b=Mqq3+WaTb0Nl8IOF8mJ3gWOyCu+HDsmIGzCdwP6mTQkLPR9YmzKT5GaAjf0fvD31ELmD5GGLswz8NRwV/BRqMWD0xk4Q19GfcisTUvNfPzmZ2RTo21yrY6Hp9+RCbKTGTIzSs129vUl8uoIflTclaKVmIIsJJJFKMZDLFwi+5NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773794; c=relaxed/simple;
	bh=Vja1w1A/Wnz062ttT6Bt+MXuQBy3cdFVFTFu9bvZ8Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7zBOKVVHLdGEkfMEdA9lWgGlpb5Clvk/Cvk3ijok2xURL13Xw3xxdQ4MLYKbPtRmVguNJD2TWcivUOflBc606Hu2VBsSgURmiIgZoxottejCQZcMVHXvHqXKbLHctrQcGcU1HQOOoST9UggxEalTvyhbUrVot2gcj5UOdRdg2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev72bU/I; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev72bU/I"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf4802b242so82398466b.1
        for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 12:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740773791; x=1741378591; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr1wMzwLJ3r114jkr+fSh/N13xzOYrfc9OnXbfM4Z7I=;
        b=ev72bU/Ih+yEUnaMLo4CR0yHyAR5jrQt8GTJhrXI/QCAw+d1+GzEyNGADVXBt32MBb
         NjqXLzFbvB8SygXO1jcZDSyHe+GJVXMxWNo3ax1QL1N0G6QSYQnH1Ofq2QkTVRgNigKY
         XNDJBlxSBgtts1oVtuikIGAshMCERhHr8XMpzcs0/o0ao+WlYQzi152F4tNqTJ8Gbsyk
         wCjd9g53jWJi8y1EBwQE1v4Vd4AzXA5pJwokSJMQ/Q6k5p1DEs2mcMTsN2gthbVP2hUr
         rAPZVR1mkWXl7+O+Eji9Jg1dKOVPVeUs4zHR3BaxLx2yOG6+nD/v1NN4WqRavfx7rcoE
         1wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740773791; x=1741378591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gr1wMzwLJ3r114jkr+fSh/N13xzOYrfc9OnXbfM4Z7I=;
        b=CiKKLetKUksMMnjOfwL9g+xNpF9ZsCes+6wHlbhLroK47rKM7fEFpr94pYt6ALiAHk
         tUlWvapyMuA0+qRTiLNaAtEITxMRw7JRnHq4BhVyUDIUf4zRSMNxhdLrPfNxx1jx+9u/
         Jm7hgVGeDgJ5rxQ7fV9t4YOn+GtxovknfJfiXsJP+rv53FkZKX9NMnbbdIJ1rZMKp7XP
         AyKe/Kx8wIXksGjwQDTFfFOYOSNLn/UYBfTsqTmpHUAxYviBgH/VMcRPTlNuJhan/5lP
         5If7vCgKfdvxSrLp7X/Dx5DPZm+6sKx/DshofqTf1DAK5c9CpBMY2bMNbueMeHdjtFY8
         f1/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkfVU4O+q+lvwDZDgaorYh9VSGU++COeSjEhn6VY/BdOUKBA73ry3FTDPBuwQc3y4ZsXl77Tc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwBcEHqvSblM1cV6liF7Z1fvIKr+OqfNRLWOvFdwOJVem+0SfI/
	adlGf7W+3+WIv/M3VmnqEmxqBRAqRQKD4Ouguh2pKTEhBMNQ5zSF
X-Gm-Gg: ASbGncsMZ9I+/lfyrYzKOknDEPwrPf7w9ZxLgo4lGbuSRdlvxF1NdtAtmG7K5t19Ikb
	ibCajFwu9RYG4rOAG2dJZMdAguhBEEfDPfrL2i5rpo8cmdZfhxaBKJzcOn2ZD8lqJpUQVu2OBhT
	lou/4AdXsvNeOoz2yXasOQ/9ONMu/Gh38/C5qFdl6f592VAkaXezRwfhIGl5Yf3sdJDdcGis1Tq
	uVbr6/HN2900NzrSSQQ02jz6utxWHdtHVxA8nrD3GJ+XPHROY2z016S6xAOmBEhzWm93jYUpZ58
	p5ziqjoSMaZWdyRYlrgFTF9avnWEYPtM5oegW5eslyuBZFw8IgUFOhcgaHFtEJx92LzNmzkCQoa
	mmDLbUBM/CJsO6LGsM/5a62LyIyqc2Wl7vFb7ohm4LzU=
X-Google-Smtp-Source: AGHT+IGIlmp0gTErSS4DfDNJ2k0q+U7DXk7nnE8hCWt5GhbV6qmR8RoCNHygavxB4lOMiFfar//Acg==
X-Received: by 2002:a17:907:3fa4:b0:ab6:d7c5:124 with SMTP id a640c23a62f3a-abf265e8ed2mr386410966b.43.1740773790747;
        Fri, 28 Feb 2025 12:16:30 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c66sm340812666b.136.2025.02.28.12.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:16:30 -0800 (PST)
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
Subject: [PATCH v8 net-next 10/15] netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
Date: Fri, 28 Feb 2025 21:15:28 +0100
Message-ID: <20250228201533.23836-11-ericwouds@gmail.com>
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

Need to add NFPROTO_BRIDGE to nft_flow_offload_validate() to support
the bridge-fastpath.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 5ef2f4ba7ab8..323c531c7046 100644
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

