Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB0C2343C0
	for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823990; cv=none; b=hV2WADD514gmiHxFizJAkO4OuzgGNaG7quRYMmY1E3We3CvGAGQ6lYQd0vHP/nyIBPNzCKL1JQe7vbVW82j8zT4uCnl6ihUdgn34cet2JBaJ1sijdkZAYeZI3qyL4R9I+e8iAz2ScpodzA2i2HxW8aCYspZOioUXqqd36aFhD58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823990; c=relaxed/simple;
	bh=dxwgF+fYRk3V5G96b0Vv6EygsfQSyTWaswg0nQK3KaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tghqMsGcbOrf88n4OnhV5Hr44Ue406MZrmIrXRY8l5d/aFPghYTnqnHc8r7icR1kIZBdDdWXfOKkYf064Ms/yCmBomClouQitUHYRjeGdVJSg+ZvB9Y/6wWSxeksp3O9MASl2PavgLJX5nfnBldfZuHasn8NsvWYD6KL0q4uS5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuJJqbYl; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuJJqbYl"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso2136225a12.0
        for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 01:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733823986; x=1734428786; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dC3jhTj5HQrnKJfxc0SY/ZIZuFArZD9eLZZ+JbLbIJI=;
        b=QuJJqbYlrnP4Y5rLOX8zSaPFqKX02gbg4Trvw6K+qYwR5A+6W1BzBYFdn6lxdiniqP
         o+/GnB27cJ4EydjR7ps85JlhZKR3bj0FvanlxzqrbXh6yaizYYrbTIfjags+njRNeybK
         GLaGOmYi3Tsyhpz1BrzffbPc4NwpD7KpvjW9HjLYJ2kAgBgqv2S9d6qz8Xi8qFkGzfrz
         h2XX+qRjMkYPdTwOxF3CYpNvVYSRrDVKZ5nHfQahgdmwL3izvgxR6nPPpg+VHOSQC0AG
         u0zQV6CWS3GjVqmOUwuWHj7O6eH6tPfSu7IAnKHZMTvWGxDxa+M7bYsGwjt4oRb4wi6S
         t3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823986; x=1734428786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dC3jhTj5HQrnKJfxc0SY/ZIZuFArZD9eLZZ+JbLbIJI=;
        b=NAP5HXiFotyN8GzHSwxPJdmlpHkWnvw2E0qMLsLr3C8uujy4+js0YrU21SBejn4POX
         Dnz4Y0yOqAk9S+sIMs0E9KtYfL6j063so8i6qV+9fDBhrCrzyAN15mq2tDgkHT+it/Ry
         ySbbf3jsXSecpgVvXuL0JHEXHQwqcfMu38c0FIBDvcZefcJ9IafYMAov0EOMvoGH/skN
         EJd98d+seESrBCVSTuObJrGfZWa6inUqRGidVbm0SuSL2kaIk1THtDY0JFLLxepnMMFV
         KbxBlmSisB7zYkJeQNvTsRKLLjfbmLenEmXI+B7nKMgZ5U+QVtFZGyqN53qWkBsaxa92
         Nc7A==
X-Forwarded-Encrypted: i=1; AJvYcCVcNc8I9UegrE5/iz2Rd77E1gFAgJ3kA7rMqyrBEcCY3il/gXuYq5kgBT1tFxjf3WU/8edMcOI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzTXQstAMYArpBz/Ky14vDigoBDnHGQo+y6e7Xa04MrAAux9wRr
	yPmVatYXSDxDNH/vCpbQFOkD2o/G42ScsCz7A/01a3YvWhjt7EuX
X-Gm-Gg: ASbGncvsucaUwKSZuZaP/iG5rRPqjP8S+qsO4t8Uh+lR6Z1rP5rFwQ+Pyf1QrgFsSL9
	/2VYSzpO84ocLiQPfOV24gkh8B9BrTo+mdE79/Hy1TrdQ0e0dBwAIaKTHoDkOvCbeNQ6jR9gR6Y
	AJuZWnuGDsh3xKF8mOxoIA5VUYEyNnKOqJB+UpZ/aHNGwE+ddS3LZqMGuT+Q0EDk0t9vFUertfB
	eLPKQLIw8RszyxOPMPeT2yIQPJR2rDimBGxIS/gE0ee6mR+FVPE7B1VwySRYBVDMzMSpXvLhBeP
	GqZ7xSXnEGZgkCYph8sAMySKVh/kXqdWB6KP9PUyrxUkwh6D+AE6t/OcvJBGxOi4MbQSuIk=
X-Google-Smtp-Source: AGHT+IHlX9+SooPSE590CjcBy1PCTK3BSd2T3uvELFXCE//zwA+1O6qm8MPbAI3EXqA1jn0vY/Q71w==
X-Received: by 2002:a05:6402:1f8c:b0:5d4:1c66:d783 with SMTP id 4fb4d7f45d1cf-5d41d3dd1c0mr2691977a12.0.1733823986474;
        Tue, 10 Dec 2024 01:46:26 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b609e56sm7313936a12.40.2024.12.10.01.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:46:25 -0800 (PST)
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
Subject: [PATCH RFC v3 net-next 08/13] netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
Date: Tue, 10 Dec 2024 10:44:56 +0100
Message-ID: <20241210094501.3069-9-ericwouds@gmail.com>
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

