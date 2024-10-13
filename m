Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2BA15747A
	for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728845748; cv=none; b=WdXJHGbZVk9ctsh2BY3VfdfC2xrO7i3BOdmMq8raIAELDbmy783tkHOsEl8a8Am1+OurT7tT2cSNYDSUgIFM59GeVbQ8kDiz4C0MeCSq6ypuhHcd3dJO0RsHMp1pkPB3RJE/EPlRAj1KK7hSeDpMTNZ/MNvj+13OT2VWBkMozoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728845748; c=relaxed/simple;
	bh=LbQq3WarvL86qr5fxHFaZ7pGgCWpQpMufczHVKCXtSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mjx09XzkDopk0/a5IBJbka1JDBymwisy755JQkh4SB/ymO0M7FTGnCuC+gThZi0DYccVU/dF7OIVWZRWpevTzc4j0nfV7MJJSXg1D0+GVUAjImCdBmdte+Q5vpJNusy0mGMRr1hi/tCjQFQGVnhbOn4/Zt1WsgF3DNqMRpwyGUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T022AHIo; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T022AHIo"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so46791866b.2
        for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728845746; x=1729450546; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DH9O06Lp64TibMF8pahG9IPkhLX3XCOl3DriGpuFd0=;
        b=T022AHIo1xYEuNoFpbJXyddfxKKqcPvb9rhDB/q9NJcHTXWUM+1HBT+varKIyH0GEu
         kKh+kpaUSxxdp7MMm4kQBkK+Fi2qi4dvA2MBPhyDPzsL5p3S9yQ+B38SqxNUs/6IWSKU
         4U12FxsaOF+D+NaFVbKViBsFG/qt7NiqjHLuaei8azYyS4qWHNZmC7dSE7ByEuhA0BFR
         ICblciULvZHpTxIXumBvB2RxqxYNg1RQbmL8Xr2DTLsAM9zkf0AwknpBJY4LaDEOHITw
         cNuz+sNLRlEmTJQ2fDh/afQKakTROZ4KeqY3409T8ywsAnmOhztNOGQnu34X7itVHskt
         BmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728845746; x=1729450546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DH9O06Lp64TibMF8pahG9IPkhLX3XCOl3DriGpuFd0=;
        b=fa0r9iaCKnkEdoNrSqQU0BOgtEoRISzs6DzDGwTZsRJKNzUknmOwnT8pbq6ND1N/uc
         kkHoDNYdiW0O7Io+oLV4HRJpnCQTSvt7MRtwkgGuKMWz8vdta3f0aNAXCTFZ2S4dsVre
         ceMtGTlp5mPLBvaRsxBEI52pN9yWnmkL007icDYedpLIJZk/2zovOpLrYLxFQwNiEHR/
         Z3+VRdaxop/lAn80FuSmukn+1JjxUFgUj3N61j15F7lGNf/IL0N7HYVXMMJn2yhjgVdq
         2GgnTMN0ItpXTLeNquYo9wplq6l4WLg8fTx9OnPBOGR729UTuvU7PaFRZi560YDWeHbi
         GYSA==
X-Forwarded-Encrypted: i=1; AJvYcCVJjCM/8NQQxtlqeaiR00WfhoHyXO1X4L+5/Y+R4QsZx/pe3iEiAM7I4GATsjX5WErtUOEMeRY=@lists.linux.dev
X-Gm-Message-State: AOJu0YyHrJftT8nQmyuo3sdd8r7MbCJdXSz7cuEySLCcrGOEsgyxoi1y
	qP0YlIefAoF0E4ZzMKTSgJzC6MwvZGIkUdDDA953yvUFQekxcLAG
X-Google-Smtp-Source: AGHT+IF3e958cm6WfptQrjYwvw+8nY6U3EWzISV9aoZ2s8HNdWFDat+7mlGlek7WSgxj3fgwgQWR5g==
X-Received: by 2002:a17:907:7f12:b0:a99:f945:8776 with SMTP id a640c23a62f3a-a99f94588c4mr336725266b.24.1728845745513;
        Sun, 13 Oct 2024 11:55:45 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a12d384b9sm13500866b.172.2024.10.13.11.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 11:55:45 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH RFC v1 net-next 10/12] netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to nft_dev_path_info()
Date: Sun, 13 Oct 2024 20:55:06 +0200
Message-ID: <20241013185509.4430-11-ericwouds@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013185509.4430-1-ericwouds@gmail.com>
References: <20241013185509.4430-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of using mediatek wireless, in nft_dev_fill_forward_path(), the
forward path is filled, ending with mediatek wlan1.

Because DEV_PATH_MTK_WDMA is unknown inside nft_dev_path_info() it returns
with info.indev = NULL. Then nft_dev_forward_path() returns without
setting the direct transmit parameters.

This results in a neighbor transmit, and direct transmit not possible.
But we want to use it for flow between bridged interfaces.

So this patch adds DEV_PATH_MTK_WDMA to nft_dev_path_info() and makes
direct transmission possible.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 6719a810e9b5..2923286d475e 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -106,6 +106,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 		switch (path->type) {
 		case DEV_PATH_ETHERNET:
 		case DEV_PATH_DSA:
+		case DEV_PATH_MTK_WDMA:
 		case DEV_PATH_VLAN:
 		case DEV_PATH_PPPOE:
 			info->indev = path->dev;
@@ -114,7 +115,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 
 			if (path->type == DEV_PATH_ETHERNET)
 				break;
-			if (path->type == DEV_PATH_DSA) {
+			if (path->type == DEV_PATH_DSA || path->type == DEV_PATH_MTK_WDMA) {
 				i = stack->num_paths;
 				break;
 			}
-- 
2.45.2

