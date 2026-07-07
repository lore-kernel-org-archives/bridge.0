Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53303396B6F
	for <bridge@lists.linux.dev>; Tue,  7 Jul 2026 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415486; cv=none; b=erAcf2HQj6dXoG+Gi/4xtctGxCEnGBld/3piun1hNYzfmvgLFxWRvP/K+uZJ4dQXSeCC5goiCOd+YphjIOo6X7h2W1Jz08qIaRMRJiPnpO7HOShKbc477V567ja7Bxuf0eb1TNWGHL/i2C/N8p2UC3g1u1fxtzEBXa3PhYzuW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415486; c=relaxed/simple;
	bh=c4d0Gn8acxX3dds/zr06bS5e3i/O+AWIqoHlkIL0KS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YO3ggbL5+tYuMy+BJUTTaQf4qTrQ/XnQO/W7py7dSf2MiT8GS2U+5JdLTkqHNXB15VtsnxslhPG5cnLuWg7o5DA0dxUO0ts5wHLwcV6l8nSwTtwsn4YhH6JCcPvtFzklFfOb2XfwBWnAJZOq4b3y1Izg7acA9IJUdfoO8UXelQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eryguHsf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eryguHsf"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so5549369a12.1
        for <bridge@lists.linux.dev>; Tue, 07 Jul 2026 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415482; x=1784020282; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hNuEiSmMfMRS/Sppafm7I7/IS/ncJPWRF2xvpsmHdUI=;
        b=eryguHsfE2hua+uJ4wmE3YZhYTSi6/fFmg4xKFbVdifqY19OEhxw/CU+nTggopyIYW
         858i9VlxMJ1vewpXK3gT7R/SfPrEOA7yVeq43Qhz1vxUujwrj2BoRWCX45ue2jxO5m1A
         J41mlFjviAWrCbFeo3br7xmPgCxSEDwmagWqWnZBXdjjZoDTOPbH4L7ANKTipEUg//l1
         xVtLwygk/LB1Px2yjmBER8XWwMNefDt9Dr3jMYdldNFNBOUg2JNOVklP/fJMlVCW3xQh
         NueBQ1THcJirlq/jvMzJbUlVedhZ3R4W8Vj9vOOwQhYM1V5Gmb3RBOuNSlCZkzyOC2Qr
         QHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415482; x=1784020282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hNuEiSmMfMRS/Sppafm7I7/IS/ncJPWRF2xvpsmHdUI=;
        b=ZcTQPEvePC3qtXNy5xtCmuPxWFDIZybuAnszK7BtiBUb+vVmirAR9BqwqI2yVHY7F+
         xRXYTVKWqL/ZKa0WjyzNM2nm9obFO2rBUfrfxbQhh1Hflimqe7sltAgwJItNomBXSjjF
         S8U1793qFSfZCw7NeFPy6UOZzEzrLMmwtFB9JqDkIQVxM93LpIXvkr8nomD1icZ3hDrn
         tY0+XhijqO6KjiTv1nLgaoimpmAu9W3noAI8QygJkj1S5EkO1skmUe1YwBEHssHvxVlw
         9f3OeIcUzcv3afLyg0e31Qz49OYMRmklJfsFS/1iFVsKAui4tNq8gQNJO4/2E0ZN33sX
         ODEA==
X-Forwarded-Encrypted: i=1; AHgh+RpH1USa4RPXuVCo1QhDN4/fimvH6BShsNOSgLZXIOiE6dFijQllGSUN5h+NFaGl7jxbDcTJElY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzass31pFztSfsjBLa0HiNIvFW1Rq4TcnB4d9YkXKa7fmfMqubY
	htusRKgMybE5niOBZcC7ypk9qRfDLu9RKFMFeMlk2DTONv/BEg79rucHR/GeYw==
X-Gm-Gg: AfdE7ckA6kR6FbZj8p8gOn1ZCU9yAQFf5WPqBLygm1Hr11bQYX7ZHZGoA2+fGPTNzfT
	O4hRMYvfLPHpHCDUMfed2akP4GfYjKVFEfdsv6xhSJyPQWccSzNgueaHEevczsIbmEGJDehSpMy
	xUvOdHNeJh9zBLcoXuSFUq5OO2JdtbdQ1rOxN2LdxJjfQ+tLp3XOEUaB+ZkEFyHNKQspvoHuwYg
	4p+RRFfC/JDlJ3geQFSRPcFe+eS/Uq7LiTCBS1PgmuyivmJfI4PhRLpL7tb42oeqg5P2431GyG8
	Bog8La+55xRJ7a4UlEiEqvF4sCb9bzojPhnFP4i+3HFRRTk24c5kpwX9OIRjpV00L1qHqtnqq2N
	fjihiXAWFxfGZd5LOb5k7o72mGHsxRHGBJrsOkaxkLX3gIE/4KnTQKRMvJYLNWvnfE158snhCnw
	9QgmMDix+7srpFGeZUvQfOO08qDrC0cQG9PLbAUkjNlHciaUkxvmumL74uxiBO6xuwUMnj7Dz3n
	JvRwGr2J4Hnz3u+yMps3cr6eu/Wqjiz1kfZ/KDYzqKk
X-Received: by 2002:a05:6402:a2c9:10b0:695:9b77:7c3a with SMTP id 4fb4d7f45d1cf-69a85c1747amr1674170a12.24.1783415482470;
        Tue, 07 Jul 2026 02:11:22 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd87d6sm5297152a12.6.2026.07.07.02.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:11:22 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v12 nf-next 6/7] netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
Date: Tue,  7 Jul 2026 11:10:44 +0200
Message-ID: <20260707091045.967678-7-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707091045.967678-1-ericwouds@gmail.com>
References: <20260707091045.967678-1-ericwouds@gmail.com>
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
index 4f68fb64f1657..0be62841155b6 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -179,7 +179,8 @@ static int nft_flow_offload_validate(const struct nft_ctx *ctx,
 
 	if (ctx->family != NFPROTO_IPV4 &&
 	    ctx->family != NFPROTO_IPV6 &&
-	    ctx->family != NFPROTO_INET)
+	    ctx->family != NFPROTO_INET &&
+	    ctx->family != NFPROTO_BRIDGE)
 		return -EOPNOTSUPP;
 
 	return nft_chain_validate_hooks(ctx->chain, hook_mask);
-- 
2.53.0

