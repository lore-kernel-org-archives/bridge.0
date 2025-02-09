Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3A1BDA89
	for <bridge@lists.linux.dev>; Sun,  9 Feb 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099461; cv=none; b=tp+z3bbMaBndA6ljLrDSwRFQfPp+Ip9s6PohQSLjHbp6qYMMn8Pcx8PxdbZTT7TPJcR3o7PT/5S8EKsS/FLV+VXftT1G7ixxgggxuTHnrAtzamcU+5sbNnIyrqZQ+R8PfcknKFIj36MrexrENc2ENCc/EmM0bgel+ZRnAOlCHas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099461; c=relaxed/simple;
	bh=Vja1w1A/Wnz062ttT6Bt+MXuQBy3cdFVFTFu9bvZ8Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkBvWYibCbv6bIpNXR+KZNIvYLrh5eLPRaO8qIciPTXCItCi+kxjP5ckdATPji7EKG3X1yKj9i3SkMi0DMm6D8w6NcEQdk1gtLoGT09ND7h8WNytDhF3qxEfr8wnOgWqRnCHEY6HI46jUaTFQWsPUKn1PGX60i7qDnxnCzd5mNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTxVmU7i; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTxVmU7i"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7a4b40cc1so188360066b.0
        for <bridge@lists.linux.dev>; Sun, 09 Feb 2025 03:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739099458; x=1739704258; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr1wMzwLJ3r114jkr+fSh/N13xzOYrfc9OnXbfM4Z7I=;
        b=ZTxVmU7iLNyP3pAs0LERjovJOIYelbd2YubovKUGski8tFDY89UWzLHJp5KJnT5vm9
         mMJqHYvBh6ZMxph72JPmZSWqj86EXtnmXgyywHX88TK701rLsW9pLF8Qyd2uh8TX15PM
         /KtZ/FOOcjCsgHUjW4Bx0KKACvoObYeWaXkXr3u7/KegMzj3U3ZyM/LIzGueOoUKO6Rr
         GGJLMIihM3vdJ8zueNfvTvZRLp4Micy157r52tLX2Gxw2KuFFViHZxRK/f6OYJl/7K9N
         vglt2NmHzR3mi4bGgf74YPn58sMO3XZB2Wrv7jCa2yXQUkZLW8iX8dRPqf4ImZbKk7/O
         HM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739099458; x=1739704258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gr1wMzwLJ3r114jkr+fSh/N13xzOYrfc9OnXbfM4Z7I=;
        b=u434qABClxO4DY5a4Ch2UaoXjKJ4dY9u64TLsplZiN57SFYdMHTA1svQIvLNr/aT86
         taldE1SO/kdisKokvN9bmCzx6JnJF8aOeY7YPBS1/opFG69RvfdlS1rsfhy2ooUnX1jX
         a9Ny3IvlNfATwA2E3Ad141FLrup04RoHRXVWA7w+B3Co1cyeQAtBI3m5Caes2PY1YcRb
         FKXMP0r6YEmLAEKR5EzvrZxHYEoJDbVHJHidJU3GH4rPRzkVC9TFuY2qy9HjxnOGSZWf
         0r9ocTcphSSjgTcrvDi89/33dcm7bC/X0mMcEQbhFlwkDYkQc+YX/8D3SLJbld1bSDFl
         HZPg==
X-Forwarded-Encrypted: i=1; AJvYcCXxK9aY6yodZlKKHJRw/OvAhPLX58vWSRBaKHJkc9b2lVb8uYzilC/8aSAzG6vG2pmxwfgs4Fk=@lists.linux.dev
X-Gm-Message-State: AOJu0YzWbnASWlYs8wWdi8KFpuvW06tM/S/m/fGhkq9FzAgL2xbRu/mg
	bPtlGlW5K8EKr9SoOpfGvgFyNf32hViFsp0/vcqJY/fUDaRv42Om
X-Gm-Gg: ASbGncvEckVzIg+tUpspVZozCB2uy9XFdrIKUkElvmoa5jWYpKEcPcUQ1rzYOjGak/P
	xhdBLrtY1Meoyo+IIZ/EXi10rzd2mmVeQHxUcspYod3z91y+tygr0Ykm5H9iEIUN5suSvGnrAng
	E4ZsH5iGlBZ+p5OGPm2ef/Q7SehDof8dtqkU04xLVVM2DSGJLSNrvngNQ2r/eg6nQrWWwutsv2F
	pq3bNm2MB6e0mlcoynXVv5k1e6cRw3pr/7fxkNq7ViChyXWY7ed4vnFJe7wRg3m9iTAMkRi4E45
	nL2pVxVbuCGQbmeakjPRwh2iuT8mOigFc001ZdLQ1Xt/uQvcbBc86OKvOJ2LqvPSLWp5kGuHPR5
	5oDJiC3dN49mO4cTb/ojw7eEGdlXYOulp
X-Google-Smtp-Source: AGHT+IFLIZqtdyB586XGL7BZF3ltsD3dhHx63zKrEdsvwLszqHVFUdLBJLGnB6J6lNIv2VbhyBQi/A==
X-Received: by 2002:a17:907:2d91:b0:ab2:b863:b7fa with SMTP id a640c23a62f3a-ab789c1ce64mr946683266b.44.1739099457511;
        Sun, 09 Feb 2025 03:10:57 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79afc7452sm357516366b.163.2025.02.09.03.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:10:57 -0800 (PST)
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
Subject: [PATCH v6 net-next 09/14] netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
Date: Sun,  9 Feb 2025 12:10:29 +0100
Message-ID: <20250209111034.241571-10-ericwouds@gmail.com>
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

