Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF719342F
	for <bridge@lists.linux.dev>; Sun,  9 Feb 2025 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099449; cv=none; b=OqR6U5C5hF/twX4T8afShGhKLgG6+eWKvSBzg9uuNTDkV3I7kkgBM/0E/alm08yD+n/tvIFlaphdL4fjeMRj60sLb1kD56mYC7lanPW9HneQ0OJOiIaJv9kv1ZfjkgyGSZqXRxuxlXPYx5jgIbR9Ay/M6Yj5Ba+s3VMBR+AFAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099449; c=relaxed/simple;
	bh=G4AeYP9zNF3PKma7qNeEx/0jubqtWO3LgYnYYjWH/PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raKszrtp3slOZrI9p7V4QwlabYX+9zL/L/8zKZe+jtSb7hiip0mz0pZYxH/MVCoEfYRpesiyU3Ev5H14gVFjY4INefDE3XMQqQDJIaVCsLo70vzJJowEEUdMJL3hjjzH0BB3C1cweDtkrT8rrA4ZgeCkZ51jmY8SWIVJcS/1ikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOHmhRdL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOHmhRdL"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so515755566b.3
        for <bridge@lists.linux.dev>; Sun, 09 Feb 2025 03:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739099446; x=1739704246; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3xV3TA0ockrC7/s5OEcRj/pNoR8pLIoTTKhN2eYQLw=;
        b=dOHmhRdLTBdMygBTAS3OEHetfbOMl5gOFSTK9++4zUUCiLxwFP4Z3Ie6Aj8SqDEBxW
         7UAPB5BxHX2ShyUFSgvZdKZbhj1upOimBYpvAjma7qe3dJoaTLJNRxeeBky/C/Hf8/CF
         G4LXZ9zQxpXdPXM1NY7W+xhiQxvT3zJ7CqVL8g6Lq0+Cw/VNDWSRsMk1h/P1yEcuPbMT
         dQPZ1etCDB4Ipb/eOEyGNO+EymChG9J3/QeH2eb0DDIJsk5yMJ27Cw8B4xq+EPy8LSc+
         nmv/5rE4e96tZWr/HDPEE/NAcGJLrCwbGrL4Q4Et4C2iEEnpDKstMRHRwgJzCqQzLRWw
         av9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739099446; x=1739704246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3xV3TA0ockrC7/s5OEcRj/pNoR8pLIoTTKhN2eYQLw=;
        b=imU7eu2ZDPNP8Dv3bk9rZ4G/hI5fkVDR3uEO2kbUYny7m7r9SXYd3FR6RjIqytXTdf
         tjIqC+WKCu/o4uk0pEV1OvBuyAfR7POKmSzl3oizLf3sO5LDRT+zW/5jK2D87Qx5ETWP
         UwVGzkqMZvWzLIxb6DqUi6ZLUBOtfNF5GuKDPqZwZ1TZ5a08EKOJL3aaal9HDfZrZSBO
         peTQ8FCNle15cTac7oHVkG7b9hAx5fzdagDdzk6s/jUnN8+UC7tUF3/8I2EyTXAWRGOI
         J3QeUXulL/lD7+62DiKPviuYhZGU+cV1oFlY2KbU0Fc9gNx0Sxj5ocI09OiYU2+cDgMO
         46Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVMaVuricPRIVHsZiIqK7NdOtBw/LE+LR0wuwyWNAnoY6NvToGufr3fWOO+/+kx0QucQXmhzR4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7EcE9plQ3pYo8U0fYG6xxnzUSApYWsikFyhg3cJPnyzGv499I
	UJLc08+/3xCcQfXST1YvxfwwRQ2wpc4zOoHf+VKFYTOXNUyQ7Fmj
X-Gm-Gg: ASbGncuqdqXDQGjVg9r6A0i+CF3Vzjt9LV8Y+dKidA6PSRgl9TLmczuX+hjr1+4u7B2
	/xJUGxj9NDcO4Uot50JMq3nY+XQ4ajItePMCMj/7614IGeLZl04KSORNShLteIBxySXQYjvy1Mo
	EMnYeFS+SvofrN/f3hUJ1QxOdBUD0CRCX8oe9QszDw4+7xsDnrKNqIJDRb2crXjJaCeK5nzD85U
	JEhrvKAZXodUaorNOAZ6+XbupG+Xt9VFkNCMuriAmczkiUnpR10u8+Rz8oMkLkK0W9/pS6Yb4DF
	LnmPlT+m4ZWkh8ibxgvBtFSwxxSMECw3GJXWivapdIfErxHjFJzyHNg/O1bGp4Kx+bD2eRz1ARP
	y9T4TUEsyFG1HK4xGKfVHpvoe1on17vb5
X-Google-Smtp-Source: AGHT+IGgn06hMTlVvi9pNiIOCGf289zNj88FfDXoxW/6B8WNNLYcdoNWmCMQN1J0/mTfbfKOoidTdg==
X-Received: by 2002:a17:906:4fd6:b0:aab:d7ef:d44 with SMTP id a640c23a62f3a-ab789aecd06mr902224966b.24.1739099445427;
        Sun, 09 Feb 2025 03:10:45 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79afc7452sm357516366b.163.2025.02.09.03.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:10:44 -0800 (PST)
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
Subject: [PATCH v6 net-next 02/14] netfilter: flow: remove hw_outdev, out.hw_ifindex and out.hw_ifidx
Date: Sun,  9 Feb 2025 12:10:22 +0100
Message-ID: <20250209111034.241571-3-ericwouds@gmail.com>
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

