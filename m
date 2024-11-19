Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2901C9EC2
	for <bridge@lists.linux.dev>; Tue, 19 Nov 2024 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011574; cv=none; b=iamKgQHIKITEK1x8y1ES4+NuSjN9OBLqQeZPOyAWugMhpsseHb5wKvxNyeECi3+79BNhLetW7NjUjATVWwMZxZwd6cUQdm9rFcQTNigISF47mCLO2zVviAh4/AizkGgOKdcNvkILipOT9nA1ywbDeuz4Zf+drRFjkg05ayPzVC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011574; c=relaxed/simple;
	bh=0I6T/24QZkHjB/L8wZWMgXSyBUqTbRPz+vAmJSwHL+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wop8B9YTBkFsuQEupsWjnV4TgWrxxenesJvu3Brr12GyNF1ZSX7JncKkdNOQAvG5IdBB6DRzHJqCNunHZn8d2sTk+Dq/yz4A882JPeXCVt/VnPBwH3xrdrt/KZ3Y/jPzMajtT9vzsnjXicpbawDeZHzhTm3mL933f/w4+V+9wFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMneoEVW; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMneoEVW"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f2b95775so3255295e87.1
        for <bridge@lists.linux.dev>; Tue, 19 Nov 2024 02:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732011570; x=1732616370; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u3z/3aqnlj2QKTkwMuuz0nzsflPHuugQE1+9CzpwS8=;
        b=ZMneoEVWkEKc5I6MnJogfDuG5NHy9/HUqruRAEA02E3X2u00Y4obk7/eM9YeM/Pg/u
         WfJzY2JcqxBEnO0ASzyVT/9A3UMgl5ER6yh2UKBmn4gJzaXWPz9I0NZMLwn2aF+ZqJwH
         fSxqV8jVovA2xYfwwuJzRya5zxqHfOKo/xQ+9oiUeboFUgalek9AbJPv9a1DpVmusXyr
         Y3CeKCnKo5FSLQaM+45v53W12FewmLK9zcx1EwnTiSy6xRBBDtSBWTRfmKU0UGaid4nm
         3yvSj7o0cXe2h6/VNgf/uKk96g89EpQUzy/UQGtQBuiIZyZpj14v2PdLfNRTWh2qrFeM
         G9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011570; x=1732616370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3u3z/3aqnlj2QKTkwMuuz0nzsflPHuugQE1+9CzpwS8=;
        b=qbUq41L7dJdUAiPBAQDmPpNWoeWytPqzC91KmlGbN3yD9YoZMYoBGArqa7GQ23t6bq
         mQkC7qHHOeet1vp/1cv8hbT8SYDpFhZiAMavESciSdEuI8Yf6j3bPFLSGocl4pVGsllD
         Yk18osnAOXTZy8X+TmfBNDzeilxDQqxHhmsZCsuKLbcpRx2aFl4ZvW/UujZuF8NSsomb
         MQ4usZf5g0i9dY61yLmXpOAwEbEp0amHTJBCnndEq4xUxmFxgjOGJOmW3lB1zv+0xaSn
         sbtl6VX63tsZeiSTXYz/BC1+HCZmsswdSoF5a0gsxWr5IQ9Lcfh2Lko+VUT4YyGa62rV
         FnXA==
X-Forwarded-Encrypted: i=1; AJvYcCUWL5WGV0Fu7BUpV7Ipk3v+DT6FptSCb/pKXhAIMd6dikGh6kdViw6OJDgbog5Mn3tqq/ifPOU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8naqGcXEd2I2/AHzYEj7AWp0YUOs9yoVq0xXEt9Fpoba659Nj
	jPqwVQNMo3QzdUba/xJXT+R+np23hcGEyRhpt91Oyh68LQf6YeqC
X-Google-Smtp-Source: AGHT+IGkiRcx+4ntGYaz++MVtIBeL1R2ddFZ1Ewy1ZLQRMvnRephj/zyQ1UBYhWvJx/x9a4afZDUfw==
X-Received: by 2002:a05:6512:3044:b0:533:c9d:a01f with SMTP id 2adb3069b0e04-53dab29527fmr10641351e87.4.1732011570368;
        Tue, 19 Nov 2024 02:19:30 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e081574sm634875566b.179.2024.11.19.02.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:19:29 -0800 (PST)
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
Subject: [PATCH RFC v2 net-next 09/14] netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
Date: Tue, 19 Nov 2024 11:19:01 +0100
Message-ID: <20241119101906.862680-10-ericwouds@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119101906.862680-1-ericwouds@gmail.com>
References: <20241119101906.862680-1-ericwouds@gmail.com>
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
2.45.2

