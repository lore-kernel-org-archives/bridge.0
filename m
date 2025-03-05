Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E332080EC
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170610; cv=none; b=Rfe+8Mu4Y1R8x32N4cAbPEXMsbZD+z9pJ9nBTEOe3T/BaW4AoPYMdaQd3mC7W8sUzyzNFIgTpgLijlOuVloTyLn0sfpx8pNLyPlsi34uBCf8H7j6F+++dAiMKIAt3QfVtpPYwUMV3e8Uy6w6h4phXpkNz2MJBvbXZrTXh+LQadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170610; c=relaxed/simple;
	bh=G4AeYP9zNF3PKma7qNeEx/0jubqtWO3LgYnYYjWH/PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meGRRopiL6NU8ptXkASUz9YiZ2qDLA0jqEmW5GKCj1fqrYTjxQZShNHEjvkz3CwSImIByt1nyRB4YXykXvweWaNQKngCsQaZUEedM6SHe/gSh3kAyVLwNI1DCHaA/c114cjuoQUZ1VwdmJIjfkNBzrhQgPl33rsatLNeoozuxaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeuMPESF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeuMPESF"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaecf50578eso1271890866b.2
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 02:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170607; x=1741775407; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3xV3TA0ockrC7/s5OEcRj/pNoR8pLIoTTKhN2eYQLw=;
        b=SeuMPESFwH0+ZVj9LAX9oyEL+lf5rIgrfUv6v93oFNyB2qhekqAGnc0qLQ7oZW3gT7
         R8AH47mRqWNq9eFbXnAyEq+kJ19f4BEouzuOl1mZ6LswJUx7W0zbxENo1K0JT2ULoATq
         NUZ1afvyyo5P+Pw4EfBYRN0UBifmFtaHT+IyoxDzgCDgAFTiZsbC/zM5P2QGT1h21JAb
         mL0fqcxzzQQX3YiTFiti3o4GAh187N57WQGj6XNXyHJ0+oo93YOlbYlgtBWYW6wq+jVu
         kSRlnF/UcBGkQKOUXpS+YYKDBBrHRw1CvDxrsP2RzGMUWB0jn6frtt+e3Um3L7RrnpxV
         AWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170607; x=1741775407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3xV3TA0ockrC7/s5OEcRj/pNoR8pLIoTTKhN2eYQLw=;
        b=LObkAVpwZ/lvyjNBgZ7cS3W/fNQvzS+WTGbMdZLDUhvIKmsMT5ZTdwA0MVnzykqXFC
         6DJdYnO2tozjqJ659hwkhZZ2ZV59k7Xr9OEYOUqVFYygUeaOokgTrzOfCjwcEPwB2NWU
         IrgPaE/tLA+OUXXBV20jTyNJtKtGUY9dXnuBF/vli3/o5rKIKWU6VgR7/PmGmD6DcKsg
         vLDuC5ikaMgqBgdK3XXEpoKG3BvmBCjRwNcgJPQjbHvsHiBUQ9AWX5Dt0HyZ5lIq57Y9
         tUdRA3gGGdWHwA5Pq+CdYAzYM+rjOq5ZnW0j2oL/uohpB4XNWxuie6PoyHjL+mI0a4oj
         cg3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgTj1RUqwI3oDbWAULn7pKqtmfZOcHZyBA1kojnfMgzMv4b8o3XSXdNng06iQ8aZmtyGyKDPQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9DULdhG7/mNep68+Dm2qSSRaYZfEuLKAHcXybMrM1S05VHbji
	RmvCh9Q1Jb37FjO6nbcDBS4wd64tDDi87yxgAW7VBwuR9hzbW8rd
X-Gm-Gg: ASbGncvVcaCv8QyNDZEbt5vTfR9odG3vGwHFdXA15xum9QqUdeWRsA3S5OwINGidqbS
	T6qaXwJ0MjcJpqnHSzDtomF9Ld9uiEd2ksujLDaAKelPyr/dHAGFMV3vFHbF8gNuJcC9eSzU60Q
	SiOCN6ZAVvwxR+/gGX1FqZTemslw/9DtBm8O3wDqwD51VR1ECSiSCSMWHu1uTiG2kcsu1M63LwX
	IHkuyTwotJ2KkN6ZpSaBJCnr+ycuNEiZ9e1HqPs9nsW60ChkXTOdN4EsYiLTcwAX81xweoZWmHm
	ffP10B5nFGoPrPPDcT9Da9x4eBmPkWO8aZjHTaPfE96cdpa6GLzvYA6SojKeixDwDiyZpCyhSjC
	EA4Xlxu9eCJDhjnELxBfDcirk9OBK7vhZ+EqU1l8sLFumhg3k6f1Xd5EclcA9dg==
X-Google-Smtp-Source: AGHT+IFiJqR8AW9q4B4jV0oBAldSkpb3Cory3PfYPngFhkXoybiZBDs5zVQJdJ8Lft/VnBuwHJUAJQ==
X-Received: by 2002:a17:907:8b97:b0:abf:4892:b6ea with SMTP id a640c23a62f3a-ac20db37c07mr294449866b.25.1741170606779;
        Wed, 05 Mar 2025 02:30:06 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1f7161a4esm247154266b.161.2025.03.05.02.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:30:06 -0800 (PST)
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
Subject: [PATCH v9 nf 03/15] netfilter: flow: remove hw_outdev, out.hw_ifindex and out.hw_ifidx
Date: Wed,  5 Mar 2025 11:29:37 +0100
Message-ID: <20250305102949.16370-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305102949.16370-1-ericwouds@gmail.com>
References: <20250305102949.16370-1-ericwouds@gmail.com>
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

