Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6266215175
	for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514599; cv=none; b=P8Sf+j6S6cq/0q+a8gAvFVqXknRIqNnMdLOPUWlaSiI5JmVYiv473B0QXXw5jMz3kk9LfGHbC1gu9JYb7py8Kk/H2j3RuVKXGbhKxusKd8nmwXsD0Hcq1tI4yYuTHqATgZqzPJ+3NuHMIpL3VCKZxFlFbFJJAbB+4Z2mxdtHxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514599; c=relaxed/simple;
	bh=Vja1w1A/Wnz062ttT6Bt+MXuQBy3cdFVFTFu9bvZ8Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqiePzd1Nal21RwIY9wk59YlHJTb6S4FmJ6sydy/ur24VlkUsflZuKlm4SG1fkXA0KUvuG27/DRHcLnNSNzk13zUoSFO3gRyEnR3fWOhGaTQTZbJWLpSkDHaoooxITk08rUHWgWqIU02pcGWuSTah1DOv4lmGigsjf2iTsLdPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS/GhEDH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS/GhEDH"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso943896066b.2
        for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 12:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740514596; x=1741119396; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr1wMzwLJ3r114jkr+fSh/N13xzOYrfc9OnXbfM4Z7I=;
        b=mS/GhEDHGPH32TSdbrQE4DuVOz/CLr4ykC0kTroED7I8IKkWg1bP9iNNLlijHR/9Q7
         ZgXxvjX1o+4+uYu43+LymRqu+c9gIKycTM/uAZ5SmSPqSeTYfj/S/g3cWl4HkT+01fbn
         CHaampdCTrtwjgyjdnlpDw+0BiKtCvTKw4Y2eA2/opW3VCqhtPQpJO1oX/oirkScNcsb
         SaXmJduJDrUrgMXvA3KrXxZd7a5CTesfbPOk9gx5sSo4TISN74J1eLofWCIQgTVXR6Jk
         +Gu2nBEpFHJDQWcXX4pTkBSC6xEPmyjyYBnlcEPUF0xALLrIAmZPHaHdDGDJjLhIsCJh
         5Agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740514596; x=1741119396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gr1wMzwLJ3r114jkr+fSh/N13xzOYrfc9OnXbfM4Z7I=;
        b=lA3iLxTxEX2dvtXeOeGvwW0LMdHxqsugKoSO7aK00/GYqAkqxB8I6owQbtZ+7XRRZ5
         hUwM7KiiILoYmwind1nOUnO5avYsl+wzJBB/PwcRe6dNVeJVyLrTDbcgl9TLHdys05aZ
         E0ZJYys3a4Ndiob1bJfHko3PTsYGf8xh9JtlUveNtMbJYcCQf9ngbR44okATVgcrEeY1
         tQqzKcTEFBnYJlF7keGmEU6e/yGYoJouVE6DAtKLtCgK50nR/USV7AGNqnQiq9Y1tBwq
         VkOAMeL3WBmdPLcj5VNLs3U+lcIL2slr8f7f48zWAyAirdpuSZCOrZcU8zciNg7v2gX3
         gEwg==
X-Forwarded-Encrypted: i=1; AJvYcCUqUMUNmjP6uVa0S0+BHHhcp6BEVlYF+D9cdJQNO3u84emw7UWL6f1ymhH8rhRZMvjolj/Xsig=@lists.linux.dev
X-Gm-Message-State: AOJu0YxN8ei02r4eQwDFqNMUCJ/5c7jruCLojodqlE2K2wCY/YfTxNLU
	MwnY9+3oKW9b9VCDo3V9/1Ohtj0aj8lNms6hVvfrNyWFGexPZJh0
X-Gm-Gg: ASbGnctEH2zKb4ZyMDY60c/+OEsS2fqZp+JPr2vxw++02VBG9eUAEk5Up4AzLwmdyAz
	J1lGPnbop5iTEpOp+qnbxrK2kCo3/0QkI5diZk127XSyUnVDqGHj0GI1wITS/XkGXJCm09VBmMw
	XYwY0xLWRAkZCZSxKKqVeNI42jRB59YYs1oVvWB+TJcpO59Bb9qYM5a/e8Ut2dQzjtd6JRqjC1A
	W47kphq3KZ4095DCP9uK/1fpJqGfNGmG3p1qIuIzaKYIClZeod6r1+gSjV59R842hq8ZiJikWjW
	KQ8b8tpEOeFfG618wJhpEUhKqD6T9C/Vsh0jCz7j879juCt3fLjIAnP9U+aSQpQ3XDiYTVXJ3wr
	FkxU4fE3Gth//28WNB+jKIQpA9ChMsCGwangNyidgG9s=
X-Google-Smtp-Source: AGHT+IFQrPMr/zga3A1PXJqgdsJBXZ3US5klRSnZht6r010E2CvDfRMDZ8BFvHY6Z6/b4s4s1eKUxw==
X-Received: by 2002:a17:906:30c4:b0:abe:ea7e:d1af with SMTP id a640c23a62f3a-abeea7ed9e3mr122695566b.50.1740514595791;
        Tue, 25 Feb 2025 12:16:35 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed201218fsm194319666b.104.2025.02.25.12.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:16:35 -0800 (PST)
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
Subject: [PATCH v7 net-next 09/14] netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
Date: Tue, 25 Feb 2025 21:16:11 +0100
Message-ID: <20250225201616.21114-10-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250225201616.21114-1-ericwouds@gmail.com>
References: <20250225201616.21114-1-ericwouds@gmail.com>
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

