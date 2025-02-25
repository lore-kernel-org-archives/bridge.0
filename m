Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466CE3209
	for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514592; cv=none; b=YVKwIoKJDHatHUaMUS27Ynq5F2gq0jb1MjRj0iK9EDhUSSEiFdf597KT4kjw2NG1gPZA7SZa/jRGb177Ku9qlWKOPQc//nO6LPVHowwnuJSd62q9hi/qs6LoplNod3I0cilQzwy58rlzr6r+ZWKsxaqwFLuiQ9UGnGXATLa0dL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514592; c=relaxed/simple;
	bh=G4AeYP9zNF3PKma7qNeEx/0jubqtWO3LgYnYYjWH/PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsF47WFztK+Ons/9YFKAnJU2AnSUjuA7XaOxa1jx5bH4cvgPysISr7GnVdCwN0p9Q45yOG7JWWFK19Tcf7xTe2yDdfrBvZy7nPxbV8/j/8OSJo9XU/N160HmfWUJ7YcoMhx0MnujpHEoDG5rOYEzNFXEc20DFAYOVmBp2QnUAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi00HGi/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi00HGi/"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb892fe379so911887866b.0
        for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 12:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740514588; x=1741119388; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3xV3TA0ockrC7/s5OEcRj/pNoR8pLIoTTKhN2eYQLw=;
        b=Zi00HGi/ZHqblGk9+IKIPwddzhh9q0MqCfjSbCN5NZ+pB6T7zWPP7Lp45NfwLmAMMM
         NSEGfVV/YbnOPUk6ddi3sZ/Vd0gssJKQCzIo7NWU8tYIZulrhiSw2oj3AZhNgCdSErGX
         oW+lVTyi0aMYs9jNbyIC1f3IztU8WRtVLKNco4wfVTc5JAcrLna/FhXzO53/GOcbk2Nh
         e8n3u4u5OWigOCxUKTsowQb+35n0AY2Z5fMJDzHm69djcAi+liwbb16v5KVg1G+nN0Fg
         Kw8/3zQenZICtLvrEoVQv5Mw446vkFPRI5dqyIW9Nwv4OianyVOJvIObr0Ymj0vzRzia
         ReJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740514588; x=1741119388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3xV3TA0ockrC7/s5OEcRj/pNoR8pLIoTTKhN2eYQLw=;
        b=go8FTMqfZQ74bFOqqwD9xAtd4R07nSngILXzgm7KdHWRWptLLKYLUWj5pkK1VWX/md
         ySWsUyHwU/15efao0Oap9/epCyDp5De7NUaahBA0OHgOGJP7CZYu1bA5hs88/BNcKZjh
         avuBDcfRxu57rAJPTOky1ytClfdBNzWe916InCHWJTIuyzhqf8eXg6dNpfwP/Bldfa8L
         9Nx+b3D9Xk8Q6G2/Xy/hvVHBVgOfN7odrqqFyu8FelTrYITC14IK5x1ksxqXOE5Jf7LF
         mCShYjSYKIbR19IvI1bAGYDZH+rpKpSHdYHynLGsuVH2XVpzi43NVpLXHriFkm12heiF
         nsMA==
X-Forwarded-Encrypted: i=1; AJvYcCWj1Ew4UiqKnsccBoEnLg0HzpC6L89f8o7WEqBo7omf/fKBgRzYrgcmMn7HbBTBj+HveTMFkeg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz63Uhu0z0TXlyckmCllksLI8us575p3c4pd2oV9de0YlUfUaJ
	X91/mkuI0mCB+VOnQ2b8wwt+KUYWEtUj16CmGfQN3dS4bDfItElF
X-Gm-Gg: ASbGncv0Lvo7Rd46EyHvZE44w7yxXYcEfEbNX9wVbAnU/afq2iEYjvQPzI75BMEzBl7
	DiyK79j0dora/uiNvqKIdT5rIvznhqQXdX9SHdzlkBRB2yhOU1UdLCPEjqjW8sPRmE93COqAvBC
	jNKuELzMsZJOI0O4Z77TEP0lMCv8YVWKdMikoJjxDvwjW/2MldTwJg0Of9hnVbbLlB4AjLxtrSG
	rqtzbB6DN3rAAvQ9va7prTm5RJe1/EGyNbo88OLkhlYBwxa8HqubkxhjS2e+iV4yMaH49PwNuWG
	478oYwAYgk0TmDFz5i3Nqz1K2xQ4/LyQG2EyhbnUyNbemGNV/5cygEz3kXyTooxHoBr9Kz9IZLe
	GB1JPuZzaQAlQqmYsIwBGX3bXIODm3kko1UIyNVRJvX8=
X-Google-Smtp-Source: AGHT+IFi5xh5+qQVymlO946K7Lt3PSU8gs3AiUL8uPpi5lpGCGAduFw1hnHU+RygxLF/r/WZYXOsOg==
X-Received: by 2002:a05:6402:2812:b0:5df:25e8:26d2 with SMTP id 4fb4d7f45d1cf-5e444853ee3mr10719586a12.5.1740514588315;
        Tue, 25 Feb 2025 12:16:28 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed201218fsm194319666b.104.2025.02.25.12.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:16:28 -0800 (PST)
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
Subject: [PATCH v7 net-next 02/14] netfilter: flow: remove hw_outdev, out.hw_ifindex and out.hw_ifidx
Date: Tue, 25 Feb 2025 21:16:04 +0100
Message-ID: <20250225201616.21114-3-ericwouds@gmail.com>
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

