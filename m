Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E85218858
	for <bridge@lists.linux.dev>; Tue,  4 Feb 2025 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698597; cv=none; b=HtLBihpAWJ+ZdYhBnJOmN3x6v6q8W9lEXsDPYJCCbVz4Lx8tx2/XcG7RAVxNDFcr2kQaIZWN2QinzdLHwRYLVNZ843OC4x/xv/NID1kyZWDDj48P/sIGXrnHDu0tW704OHeNJOOA8cxXfiBnx+jnNsnueJvF3iChvApG+zxxOcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698597; c=relaxed/simple;
	bh=rTY7nGpwAt/CvtxcIfBc/CESYzTMIKrQGo6gR2WwnRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4CPtYS6NbXTf/hOLatxQX9Df1w+nbVXpnUIP7vubmFwFlwDKlSMUjSI2iaoqHfR7+1svmbA/aHCDDuFikXOCTJDxNV5tTXjSAoHtLdiDIDb/5ufou+FiZORnXLr5y5/dqGH6dK/iZ84FFxUtoXbL76BJycRcce8HNb2utnx0bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmI8nwxv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmI8nwxv"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso1227362266b.3
        for <bridge@lists.linux.dev>; Tue, 04 Feb 2025 11:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698594; x=1739303394; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYHS436MhCvQPNlHTWPNiRlg7kt4orCDQn4NLGRznHk=;
        b=cmI8nwxvJxmQ99K9QEfC2l8IQZUaIClMo4L+/FoIO62WlfbfkEsHnYTdyMuqT2c98l
         aZKhQPgqD7zLCVPC9N9A6qb/nntsrCMmvDy50nLZF1RadHtr7kBeg5+ydvGUhLgeQZvq
         MgMckBFR8J4KXx/4YCHdG6MNa8xnhTXrIWz5gOkqx9aL8KJq4EwCPYTUBo02ySXuMqX8
         UqFBlWc3ifbh/+q7PkaiwRv86mcQaU9OCNvxNa78d8sI8lXXRq10OiLXe5FheXrvQ7is
         lELV/CStJGKuM91All8jaOnWj/NfdJbIczMGUZc6I5WqlJxai6Mv0OsWYa31uMDVWY/J
         gEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698594; x=1739303394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYHS436MhCvQPNlHTWPNiRlg7kt4orCDQn4NLGRznHk=;
        b=vt0ECgq7r3j2YIJzpIrLIXlIDIO4axz3s2eV9BJiYiAmuPqRrH/c/01m/tjecaPVxf
         k8VPzBRFUk++fopj/o4pHVojTTu0loOObU9c96finW6+iFhAlZNQHFcE7onX4w80WZ/w
         JldPQPjkHUhAF5DCSESJmqsISj99928wJ4qW0zp4Ya7Aq1TxY4LgnN5UmJ9DnZ6uW1UZ
         fBwd5UUAKUsTMHDHd0OkHDDBVv7LTOUzsKWF26wEf+3xnPXAN5/bnCZ7lDNFyrQIUaF9
         tRbsvOwSrJkvBCv1UcuY5xuH6aR5ghu+UZATsLV6srl+SBNzNQwQ+wKi2Cj26alemOID
         8+qw==
X-Forwarded-Encrypted: i=1; AJvYcCUsaAXxII3Q4hEkIFRS84SdFAWjh4ZkOKoQVTR4+WhDdh6U+omscsqo00OUj+/85NgSFCXrSJk=@lists.linux.dev
X-Gm-Message-State: AOJu0YyXXfP590j1US4pPScTni/cXl0WNjIr5iFFYso1njkIRR3kzVFx
	c/ewgFE/2kiExeplraj1N2EaGnMNJMl0f0qwaKcDA6HSn7T1h15W
X-Gm-Gg: ASbGncvTnVfiDRBLZSj/0ckTACcmpAhK6odCyxy/E26n/xJ9ZHKNMs91N6JAJdayaoO
	9ox+P6u1GpgQ6ZWZijS5kuWuw/GASbUdpcekBfjxSksfZQdjJu7lO0TB4pV/nKNBWci01h3HUX+
	S9lt44fs7EmfXXQ90aM+4erRu+BNntQgAvAg+po/Mt4edVHZRr9p/XuQE4pmAXChUaGsxUw3ku1
	rXJuGf51HFeXbPM4qPORY2O03kZNxZvcgwQ7Q0UMpRRFW0L90O2YMALv6Vs8TvXaIPp/kyRhjRo
	eO1T1Zt6g7+zrap3xDiC3AqLuQqmlii6OhkqOAI//0aZB9hNiRP+gzLraTNvGyRF4FlH2gop65C
	LWk4h16BfiEk8XXnL5J2BEcp5NLZ9cbJG
X-Google-Smtp-Source: AGHT+IFfJwb9MQyefWJ9mzFYp2BV5PmqGkhxPrYjuZLqNPTns6xWOMQoNOZAbpkulbWsZqH9uAZmRw==
X-Received: by 2002:a17:906:1691:b0:ab6:d686:de7 with SMTP id a640c23a62f3a-ab6d6860fc7mr2382446866b.44.1738698593832;
        Tue, 04 Feb 2025 11:49:53 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5635bsm964684466b.164.2025.02.04.11.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:49:53 -0800 (PST)
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
Subject: [PATCH v5 net-next 02/14] netfilter: flow: remove hw_outdev, out.hw_ifindex and out.hw_ifidx
Date: Tue,  4 Feb 2025 20:49:09 +0100
Message-ID: <20250204194921.46692-3-ericwouds@gmail.com>
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

Now always info->outdev == info->hw_outdev, so the netfilter code can be
further cleaned up by removing:
 * hw_outdev from struct nft_forward_info
 * out.hw_ifindex from struct nf_flow_route
 * out.hw_ifidx from struct flow_offload_tuple

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

