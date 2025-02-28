Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3211D202990
	for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773784; cv=none; b=D7jXu1Y0wfWu4UhL8gWgSqgQOQMadRvcSjRZKbuQhMndGepsVb3yy1KFBSWuMwOCqdghRVWQsnszkAIMih7plzUtfOCTTCiRFRp+NoF3OPTlzCJcItxdk+P8c4ee1zXiHxS51DRpXPM+vYwfqTHOFztC91WabmW54yvDnbECJ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773784; c=relaxed/simple;
	bh=G4AeYP9zNF3PKma7qNeEx/0jubqtWO3LgYnYYjWH/PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcYpqKAjo5U4tSKouR7fFwoU26aVjyHtvmI1i778fGMS5IAzy/y3yqQ7bN0SQ7ryl6WnEJ+Z4MmPqHRl5AUMfI6VCW5hdm8kdOawljXKj2fSwtaetQdsSIKH3DFBrvwSgrHKTkE0onjsERZEw3wX30nYTANzRGpfdCTcdI3589c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+MguDbw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+MguDbw"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abee50621ecso339199666b.0
        for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 12:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740773780; x=1741378580; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3xV3TA0ockrC7/s5OEcRj/pNoR8pLIoTTKhN2eYQLw=;
        b=a+MguDbwr0tgH6MHU0t/UUyj6bynAyGA3cy0u0QDlhfmlg8U1V8cEtdUczaSAwhkrq
         wEW6S+/jNjIdSHvq88rbV4+/arHmNuL3N0Pw+G4MSzNHOg8PyOqnuAKfucfY9r/EcVTz
         uTyCUYToeKeJrTFcx0UL1uu8D3p82q/xuNB1xW+OxINCn6Gf96ZUVJEfnu+gisUDyoB2
         lVuAhpv9d+vbzgEb0dPbHgxQ7aMk+e5GCsmDxHkixDLsDFqR7ujkpO64qb6rY6JTP4ej
         lkbTUFZ6wZ52oiwTASo/JevDGPmehL5E007xNRUfX6Ix8ZrtVHRWP7JnUo32xc59/sN4
         fFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740773780; x=1741378580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3xV3TA0ockrC7/s5OEcRj/pNoR8pLIoTTKhN2eYQLw=;
        b=DG/MR/fnXECirXsWD2ah05AaUbgGjU32WuSovUaFm0ecLGB9OpO+lqM3KHvaSbMkNj
         /ogdc5u6RCqzd0d7C5r/aiigOAf0fH7vGuKwWG5YFpJ6qrstw6N/7bWDnwu2jqguD2Wr
         ubrHsFnGBNM5YmlDgZ0X9pcayCCktwkrcFX00K3dPRkBYuDPYD2jNt5kfr9Fn8v7oT4I
         ChpCAOAvBoxLW2FigO3feiAHfTgq5knsgdsbJLK8p9F2qjXeeK0Wy2uYIGwK3XfbiGjH
         L2Tim7UC6tmLmgfw99nI6YOWwiTvfMgPLVFj7tO5vU5WxumOBiEdFMz7/PFtQYFDf/u/
         WxJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5/ZRJS8YAaGpLx41CEznoxAvRrMHv/DOBCGi0UPU5bDULfOIzFXDdrmxzo/si5PCwU+cqb0I=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyd174TjmSaTS+PDm4MrBxsr5+J1cu6x1N3zpgT+/FSSejNIHXt
	8/IzBn0Ixl05Fq1kcqNPyBTFWacqd+EzYgJCb5yD5prCys5K4/bw
X-Gm-Gg: ASbGncta1DvC3hgv1LwchAKPsY7ehmnjnG2ZxzhorZZPlYkGbT1sa/Id2fiji2bw++f
	rAlwiXhPmzqIVhMWZzXiAhWu7wt4icZny2sHXKLg2ciqmBv/S5oYnPIOHRwGJRoHeRdbdezdIYL
	HLGrXEqblQ2O2uM/mb7cXBXQWad1Y0ZJHo2Rg2XCgiZQFOJG9je1rqlYyBi2B3FgY90ggOmimWV
	ZQsK/CkS0uAGOmow6f/fDIjgXNKjQKJ1VN3mQ39qyU1QcbIcaAF6tL0zlzdOzKsycN1ljE2+eC6
	RuiWlYcgMFpe3hR2uPucU/BoV7QEoxRU6Noza/l73Rl/wqWB9U/qovZG62F3kwhVKAGG8CiQE4x
	u7/X28ayNWt1XHhREASLVG/zRUnZTX52SS99xpY2S/+Q=
X-Google-Smtp-Source: AGHT+IEiUtc0XSpuKyIKeLozoVWm4Sd50Qjo2FMlO/4dpvxhs03yVO3P9mswx5jt1Mq2Z2AMyoPXJw==
X-Received: by 2002:a17:907:9408:b0:abf:19ac:76d with SMTP id a640c23a62f3a-abf269b9a91mr541954866b.51.1740773780345;
        Fri, 28 Feb 2025 12:16:20 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c66sm340812666b.136.2025.02.28.12.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:16:19 -0800 (PST)
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
Subject: [PATCH v8 net-next 03/15] netfilter: flow: remove hw_outdev, out.hw_ifindex and out.hw_ifidx
Date: Fri, 28 Feb 2025 21:15:21 +0100
Message-ID: <20250228201533.23836-4-ericwouds@gmail.com>
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

Now always info->outdev == info->hw_outdev, so the netfilter code can be
further cleaned up by removing:
 * hw_outdev from struct nft_forward_info
 * out.hw_ifindex from struct nf_flow_route
 * out.hw_ifidx from struct flow_offload_tuple

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/net/netfilter/nf_flow_table.h | 2 --
 net/netfilter/nf_flow_table_core.c    | 1 -
 net/netfilter/nf_flow_table_offload.c | 2 +-
 net/netfilter/nft_flow_offload.c      | 4 ----
 4 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index d711642e78b5..4ab32fb61865 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -145,7 +145,6 @@ struct flow_offload_tuple {
 		};
 		struct {
 			u32		ifidx;
-			u32		hw_ifidx;
 			u8		h_source[ETH_ALEN];
 			u8		h_dest[ETH_ALEN];
 		} out;
@@ -211,7 +210,6 @@ struct nf_flow_route {
 		} in;
 		struct {
 			u32			ifindex;
-			u32			hw_ifindex;
 			u8			h_source[ETH_ALEN];
 			u8			h_dest[ETH_ALEN];
 		} out;
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 9d8361526f82..1e5d3735c028 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -127,7 +127,6 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 		memcpy(flow_tuple->out.h_source, route->tuple[dir].out.h_source,
 		       ETH_ALEN);
 		flow_tuple->out.ifidx = route->tuple[dir].out.ifindex;
-		flow_tuple->out.hw_ifidx = route->tuple[dir].out.hw_ifindex;
 		dst_release(dst);
 		break;
 	case FLOW_OFFLOAD_XMIT_XFRM:
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index e06bc36f49fe..d8f7bfd60ac6 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -555,7 +555,7 @@ static void flow_offload_redirect(struct net *net,
 	switch (this_tuple->xmit_type) {
 	case FLOW_OFFLOAD_XMIT_DIRECT:
 		this_tuple = &flow->tuplehash[dir].tuple;
-		ifindex = this_tuple->out.hw_ifidx;
+		ifindex = this_tuple->out.ifidx;
 		break;
 	case FLOW_OFFLOAD_XMIT_NEIGH:
 		other_tuple = &flow->tuplehash[!dir].tuple;
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index b4baee519e18..5ef2f4ba7ab8 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -80,7 +80,6 @@ static int nft_dev_fill_forward_path(const struct nf_flow_route *route,
 struct nft_forward_info {
 	const struct net_device *indev;
 	const struct net_device *outdev;
-	const struct net_device *hw_outdev;
 	struct id {
 		__u16	id;
 		__be16	proto;
@@ -159,8 +158,6 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 	}
 	info->outdev = info->indev;
 
-	info->hw_outdev = info->indev;
-
 	if (nf_flowtable_hw_offload(flowtable) &&
 	    nft_is_valid_ether_device(info->indev))
 		info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
@@ -212,7 +209,6 @@ static void nft_dev_forward_path(struct nf_flow_route *route,
 		memcpy(route->tuple[dir].out.h_source, info.h_source, ETH_ALEN);
 		memcpy(route->tuple[dir].out.h_dest, info.h_dest, ETH_ALEN);
 		route->tuple[dir].out.ifindex = info.outdev->ifindex;
-		route->tuple[dir].out.hw_ifindex = info.hw_outdev->ifindex;
 		route->tuple[dir].xmit_type = info.xmit_type;
 	}
 }
-- 
2.47.1

