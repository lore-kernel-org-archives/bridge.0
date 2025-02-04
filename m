Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3359521CFF4
	for <bridge@lists.linux.dev>; Tue,  4 Feb 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698606; cv=none; b=Aj9u3x1EZKOzah8sIeVIIBkgYgK9VmrKkF9BJIUzGZaD4qNhgLUDCNMOPJaCjUbqjilbytxtfT18V3Fh0flvV7BxKbZbLy2ENg+sW/+A6WYjIVRXFcKQHdAb+G75H6nGaypSvVAguZJMGx3sE3obWwMCWhN9Mvg9KNVlwN0lSoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698606; c=relaxed/simple;
	bh=30vB1mNe4s/jWwmqRCrvbxpqeV4vu0iBchGE3vNDSNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F46z0MawZdCpTP78af9qe/vi5YP4K813w7gwkp6OX5DjTN9ayhFIZW+wrGauO1px2/w8Bf9sieS/+Siv4RX2Y+cUD3c/3gQ7e+iTEKk2ZM/D1QWGEcwdb1B0mVTQMJsHsKzOqdYVSDfhu9Zu4REHRqYpCYfwDM9wD1lH88qsKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAXN6Ikd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAXN6Ikd"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab70043cd05so941988266b.0
        for <bridge@lists.linux.dev>; Tue, 04 Feb 2025 11:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698602; x=1739303402; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfNQ5cmnsawBulJakMMTQobb95EzKwEtX4OwcNbEVcc=;
        b=RAXN6Ikd3BakaFo7YuAoTiHDVdsF6wznUdJaOkH/hITYzh1HwqemMAryFIXdfpp6tF
         no5kTUpTgPkgBywdLUWIrTbep/q4ZzOUQDiQX3wRUkbcyUcK4tflzGIKgUyIiBma+Wsm
         UYicsto0nIJjutkmm6wrhzzu3RBkp1vIRt+GsHWWrFa1eIwDTg7tt6kLLeECSBa0SeBY
         ificHYOCaA4pvEipygSi8YEIREdbiMDLMfa7AIrhgb/CDnJLEcWbjED2KEv2DNLuhbAW
         7+e16yNnycQxLAMuGEC8QZi32g+qrJflrUE22B4dMixEOs4rrZnt6s6FO0WpKHk8IjIi
         Xm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698602; x=1739303402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfNQ5cmnsawBulJakMMTQobb95EzKwEtX4OwcNbEVcc=;
        b=dS3/R0fTTyHPAqpkCanWmVBGh7zYAGAKedo441GUxdgbvalsXRbfsir7KPVg1C55jj
         PqPCD3EH+3wdN9tZr9AYsWj/UEYgl26oVyavMoXAZmr+O84b2sQO/Hc2dE3yrliUxpjN
         fo4NJFq1nvZ1dTX2tUrZOKlwM73Tb3Y2oVS6e+jfL9Hquep6fiwViydQyAW4HuNUpqbc
         EbDoBy8BiIR/PbrtnBj5mFKF2E4G1S0xj66SBLNMJvMLCz1EPkjkLKu8vlUQRX/wGrce
         +awmYJMVXoFovOl/l4LrkNkYLUXjqSSXHrv6leTTwCbR/p1VHBCmR0TmWLNkgpg8yGTI
         bi7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLn0bU8K8hz/pkJAFcZESWJJvV5kh8feI48qXskDe0tmPlpgOzn+p6OkZrbToVOWK8GcxF0Mc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwSrlBsoIwBw6c8KYltzTDHC5P305ZUzaep/SlMy3htgGDPYBLJ
	Bml6PnliyPfkti6hLUhbuRNjGqERJkEofmseMGusGEN4ZxtNZrzP
X-Gm-Gg: ASbGncs61u3KPbArC3UxWxaB2FEz+FiiozazbHKtCdE7Sqc9u8Jv8uoJYF3mm8/XHxZ
	vxQfPsjuOY9LW5bMLJcoZ8BI/cys6+HTEdMLYsO0L0opymwNrrKGZqPra8IOBAaYGUlorNpQyhh
	vFDqJFrAY80MS4iQ9Xy04dkepO25Wjv0iHAQS1OQaN4zcWU5Swbs0Oa4ZXyGfNivCiCleHoPaYm
	LUKCsxNE5yl2x41FFkx/O1QtCN4HHswCq7YEfYGt5IQ8f9L4jha+LAGODdC3p8uW+jN0Xd0jc3X
	7Ab5Nk8dz6hGB1xravDuUsk3k+BLvrg2hA1YkFTyqRX6pXotRvGrBVT3AIxRqLoZgIxHPBw7ALj
	e23cEAwdUgVYuovSgaODwfg+NJdV0Q0Y8
X-Google-Smtp-Source: AGHT+IF0i6wSQMkgrmjCQzY0taa6wuEGcCy7CIK6oAwJpMPmap+r+O5XJX2h9JbKqG9hmQnHQyXFmA==
X-Received: by 2002:a17:907:c0d:b0:aab:c78c:a705 with SMTP id a640c23a62f3a-ab6cfe41079mr2625537666b.52.1738698602307;
        Tue, 04 Feb 2025 11:50:02 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5635bsm964684466b.164.2025.02.04.11.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:50:02 -0800 (PST)
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
Subject: [PATCH v5 net-next 09/14] netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
Date: Tue,  4 Feb 2025 20:49:16 +0100
Message-ID: <20250204194921.46692-10-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204194921.46692-1-ericwouds@gmail.com>
References: <20250204194921.46692-1-ericwouds@gmail.com>
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

