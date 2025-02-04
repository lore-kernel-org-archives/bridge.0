Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C82206AF
	for <bridge@lists.linux.dev>; Tue,  4 Feb 2025 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698608; cv=none; b=PgDyxgOL4ueAEDYXxDuIcgXoiAvfHAMBlBTXWl5j/CWu6yFSL6T5aeD2ioU9IvymLa5z6cc8qyDyFt6ACMOur57yshsVBvkSETwM/BStqT5gbCJy0KyVHEx7qbvIjQ75c0qsWMSPksNsDwjglFPvDsR3ijydx6s3w2Cf/SryhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698608; c=relaxed/simple;
	bh=wW6RAS7gIB9YtaeLFy71mruTN24ozacnHEEpdyTAFDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJJMCs5D/4IwJB8mDzEReE8GBTS/ohlT1lhzZpN1hY1J7LRA4oe2iPkujmW7b5jezvwLduw/vUFkZ2lwPq8Tddprzb9u4BwwIZfng15woB/UHtLKERDXhu+jD7m3kvqBRiVUmqfTVytC7DpgdB7nwvDUJNPraGEjAJOqgh3GuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuCwbWQx; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuCwbWQx"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab698eae2d9so1194095466b.0
        for <bridge@lists.linux.dev>; Tue, 04 Feb 2025 11:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698605; x=1739303405; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kADY7+7zs3VYeS9qt3VMln59cnXFpf9BaZ+2EYseZ2I=;
        b=YuCwbWQx23k5sx7kESAgqNY4qGgI7jOOlAZujQx2MgfwIEllmlWpsmz6NfMtU6aKeX
         Vv0TojQnLZL8KtGruKR68/pbKD0r9KyNLkq7LxC+xJVRK5vfiyhBHSoUhEsGSY27bTMS
         nJpV9nqvh1e/HytYA6qXZH7IeUIkrHHb/j8IyHJlE0W43BSbwMsdPXnd+b+igo+SUg3G
         fUgrRjCKGnvtgoNgVDYPXa/40nA4Mc2mjHPgy/elov1OtxbRe1SGZ1sNHvqxa2S4O4KV
         zSd7LbPRbm07rDCgZ5qzJm8FGEpMzLN+KWISceQUMsMzVBpCPcOgIKUNG7ByJEHwAsON
         WCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698605; x=1739303405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kADY7+7zs3VYeS9qt3VMln59cnXFpf9BaZ+2EYseZ2I=;
        b=lrtrm2JjGOTV49TOe8cXYayoOWqXkOFoCkgom5D6e4aTpyU3owkqC9OcUs3YwHeQiB
         E8DyKuEPOnTViVMVMwUzEJgYsBjuWyP89T+EYdL3Uu1Ftb3JT64t1BWumcnoKekeGEAa
         FqLVyJzxjtOSeUJBcmUEUwCLKpFfe28jVKXCUhfuFrqvoxqcDHOBV/RUnlIeuOF9Ec8a
         uXVqYTSUkzrS23zolRrR7ocWVtKCd0EMYE7EI+VKocDE2WaExMsDMNNGv0mNiNYg2ABd
         nEhyXmUVyC7KX3AgBdvv61TmXPkURtK+7GlqpvMvrSzlo27EnZGZl1g922Vb8XnGtQ5j
         U2ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUKZGNTw0bRkpJN/HVE5pwVPcyARkGAnDzriAVrI25Qrr5bJ4L9/lbsWsuR0EiWVaZqIgyytA=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywx4u7rNllCh459JeuoW2OTTs9zUPzpL1f2fq7knl9fPbc+Erya
	W5IX7SerzFFy7sN4HtFnpcImOMEUjsiH9vjWq/NCJSBdj8YGc8wc
X-Gm-Gg: ASbGnctHi3yoc4euX3ajzy+aqLD/vXbGEI7Iz1mBFQ7dzgH+QpudEbzKR0uDaRpyaAB
	SyJWtOkTQoJjn/LokM3J4GZtdVA6G6+8WwNe6daYar0QqlP/OjOrOyaI5rCjAKaDCfZIIwVXIFz
	WZ6U1yJcb5x1XOVuZ/WuI0Bd52QalXzokDDBPgwM4/7nB3Kv/cuuv5OkzVuV5WpFVx6nJzKm13y
	uAZRktXuEuZLTpzZsH2PnH9l8l8KezNowRntrukoit1NUiUvyOB/rQWdTE/3qvjvD/OOFeUuT+x
	4t959J3zP6ii7sbiH7Bbv0eu4DR+uFWX7l3qMZrfW0pUPgx/dke3m7bvDt34tKAWqiPl3FOz2Ru
	nv7hoeP2E38b1vXcoz2fHA8880UZBPIsU
X-Google-Smtp-Source: AGHT+IH3HgcqoQXvsnACIc49AeekhK/1g6HjbR0l0xWDGPW12A6kFCC7xX3W36OSBC5BU9r+MqXOrg==
X-Received: by 2002:a17:907:2d8b:b0:ab6:621a:f87e with SMTP id a640c23a62f3a-ab6cfda41e1mr3469521966b.41.1738698604888;
        Tue, 04 Feb 2025 11:50:04 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5635bsm964684466b.164.2025.02.04.11.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:50:04 -0800 (PST)
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
Subject: [PATCH v5 net-next 11/14] netfilter: nft_flow_offload: No ingress_vlan forward info for dsa user port
Date: Tue,  4 Feb 2025 20:49:18 +0100
Message-ID: <20250204194921.46692-12-ericwouds@gmail.com>
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

The bitfield info->ingress_vlans and correcponding vlan encap are used for
a switchdev user port. However, they should not be set for a dsa user port.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index b9e6d9e6df66..c95fad495460 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -116,6 +116,11 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 				break;
 			if (path->type == DEV_PATH_DSA) {
 				i = stack->num_paths;
+				if (!info->num_encaps ||
+				    !(info->ingress_vlans & BIT(info->num_encaps - 1)))
+					break;
+				info->num_encaps--;
+				info->ingress_vlans &= ~BIT(info->num_encaps - 1);
 				break;
 			}
 			if (path->type == DEV_PATH_MTK_WDMA) {
-- 
2.47.1

