Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8DF20CCD6
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170619; cv=none; b=hPj3e0JyvOx1HBhU+UItISzSnQEbFH0Sw1F8crWk8mwkEn3nGS8kwlIyY3AQPn6YSl8uAZCEZF9YBhjAydG1+s3z7xg/T6C0BFUHLatVo1KrrdRHqAtD5cFRYJ3YjoDoSjm+Gijj/NrEq0riOJEvLy/kCKLHWdxxqywA3Y00wCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170619; c=relaxed/simple;
	bh=Vja1w1A/Wnz062ttT6Bt+MXuQBy3cdFVFTFu9bvZ8Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EB9Q/Z3OdZkkuhHsoWKpd8IvGX7wTvJlXcGMEOkWoXk3qagiu2G5RDc9Z7jB1t1Hq7kApLOPvxtqOq2v3rd8lJ3PJQHt9DiF+75qgiTP2yxVLyhTxkXc8RmyugRmvUzxfEZMadmc3oRPPfXL+YCE3ECZXcsBNX1LQEj6Nug3jVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kajzbepL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kajzbepL"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac21c5d0ea0so34037566b.2
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 02:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170616; x=1741775416; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr1wMzwLJ3r114jkr+fSh/N13xzOYrfc9OnXbfM4Z7I=;
        b=kajzbepLZ44b0EJbq1g22XrbJpmny8iiVYE7+tQV/q+J8rAKbLazt+1N+cAQzDK/SQ
         DkOycYszTp1MyeQYuQXWdDulBhj6Qci+OqVFrGVuvwxIu6VZewbqJOjm39lAuNt2vm2c
         Mqedf2h43R1B2ElpBXUgJPmizVABvs4VmDIt/AsDWfpeYN+bO17eHHGfiu0PjN2nFtl0
         8fJ+mZV1gxu9ZBhBt6xyjWPfl1E0gr7zeypvGM1UqsIQPmTIYI3BKEIB3++lXIAZ5C4U
         xuwOyFBcEdefmjZz2HRvxQ+Q10Vn66nrZmJpKzi6Nrf7ch/eq5dDIA3/DUtVg5w68Sjy
         KPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170616; x=1741775416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gr1wMzwLJ3r114jkr+fSh/N13xzOYrfc9OnXbfM4Z7I=;
        b=H2wrQgNUIp6IohZBQeLjGY+3vh6VoFeNXj7KbsaxO5Fw0gNwMAa1otoo+p38s6DW0M
         /6ORFFE7chYIVA+NHKPPuD+3oH3BMEUpuJg80yD4QFsVgWgxfH2IzsgZNSo7p5fpwwO3
         ysoqMSCXyMUG660zINaxIUKUjazNs0G/94w/MVgEVHu7bc9NZNrVD07qpvqPuwNxBxPx
         Fz2zWbPTGQmm51U33mjmrd6v+2w4XlAgcQMAq/T52bXEaPgC3KFprrMyvdwnKjBcWqhV
         EMEUwOspBSeW7YcLf6Gi61iAhJjSu5j+nGWETVU7jwFm2mVNOtbQL4D6bhySWBI9RwNO
         zWyw==
X-Forwarded-Encrypted: i=1; AJvYcCX5eTDfCx17hKiQpyWeCYlm9hTnVpr61Yo8FoEIC40yn91ESyqKGjlJUBrqWt7hnCIWFM4LgJU=@lists.linux.dev
X-Gm-Message-State: AOJu0YwVV9QPS8YlwM/AidbM+bHWDTGWOLtDyi8TDDd6/MI3oG5lJWb4
	KpmJYTqVVZszAjvAcXZBTXqiB4PoPET8qx/t9qxLgYhAsf0xFI6k
X-Gm-Gg: ASbGncva2BS2ne1hKXbqMl1UIOYnzukfLgBbr7xS583LgqW+Y1beB+200z3SzvF4SP+
	YSjeLkcYzlnAJIzgSwPHRuWTeCZn5h4moHzqr9qPhMAuWJzwg3GiEnoQhlAlM7ccyhquxF3J/Dj
	IvQNncvWs+cWHD1IsRwUtdw+WhOw0Cy/mm3AOpviHtNH0FBB3hBJTzyp3DbuPD5rLimD4s3tBpy
	nf+mtxg54uDolaEwPTElzztA6StExFY6nYXaVxZFzUWUAeVFzRQhTbSj0y1ETJttguLv7TueIr/
	MnMx5LBUzzTttD8Lc0VQgTf5eyeJ2C2quI8TeOmEyGsHncMewkHkq1EfM0AakuO/p9EbLjrh/QP
	2qfVjQ9wp49lJlbRGDg2IakcKd8J2fu3rzTSEQHg/RD+v7AfITTYp8blQ8Rh5Og==
X-Google-Smtp-Source: AGHT+IEs4xR9pD9LIK2nl03zhbpQIh0Gipd81ijJP6mFjuSVofHY5Sl1xp/UlJ1W/hq6f/T3nlJWzg==
X-Received: by 2002:a05:6402:2688:b0:5e4:9348:72e3 with SMTP id 4fb4d7f45d1cf-5e59f47f008mr5076173a12.21.1741170615734;
        Wed, 05 Mar 2025 02:30:15 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1f7161a4esm247154266b.161.2025.03.05.02.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:30:15 -0800 (PST)
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
Subject: [PATCH v9 nf 10/15] netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
Date: Wed,  5 Mar 2025 11:29:44 +0100
Message-ID: <20250305102949.16370-11-ericwouds@gmail.com>
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

