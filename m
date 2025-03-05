Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AC620DD65
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170621; cv=none; b=sSDiRfffalCOj7VWJmYJjk3DsVAm/z8Xzj/UAe0d8XN/zN0EFiQkC77RYcEXHV5/2uiHUd9Q5UwvtD3/ZvXOqLd/B8Z3jlndwUKjqqsfZdPqEP8vIvy+I1gNutkPMTWeFoA9ASyIAjGqfn5/2l4s+obHGOlIZVgkbmxZH/3XF30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170621; c=relaxed/simple;
	bh=nk13k6wj03cZHg9dHsnlBzPD6tzHgIxvMuOve1nbFK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oU5jbhscZ0p5myckuxdh5eGa5gj7fHj7TTAeaNlyW5fwcHepFn5zYHnDx/PfhRjtuUpVRb8VNUhKVlVe6+XETt1N1SzocTP9muKdt2cilXbNbe+AFWFcs+rnrTEngVcAMx96mtEZhR4qXGWop++xnfhsrWIOmKrEUZFtrKYNDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liVZ6M1g; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liVZ6M1g"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e57c81d5d0so3226855a12.2
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 02:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170617; x=1741775417; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIyBMmpEX16BmxV1lcAMHYOSL+4ClOY5xXpYYnXA1xg=;
        b=liVZ6M1gVIPxTqW0WtukW+/F0UuP2QIyy5bybKyc6Ic+kHR11w+nTBQHfVo9UD2os2
         TeWFQ9Bg8aCX6llPK/Fw0GXc55sartY5AcZ3KB4lzwI3vSc2w62kXXAEQsikwF1N38Qq
         NCVCS5C0Gp/5mqFZi5FNOr6uhVUaqHI61EFxEjrnOrPd05maLw6nHNThsbLY/CicCfkf
         o3j+izuZi50bLK36uY5DUSH+lH7wO5w+Hi10kSBrRLGVzgjfPf9i8uOwIhzmUKUy7lSY
         s+cUiFNdhPaNLW7lCjs2N0smJiqtS5Dj0B26wHHUae+7FrsiNiwOdP8pmVttEQ5sLY5N
         c/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170617; x=1741775417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIyBMmpEX16BmxV1lcAMHYOSL+4ClOY5xXpYYnXA1xg=;
        b=tEn3bacg5O6f44uNcIHu9BZp1TtblqDu5OM1F9eBXKjO248eeAuaLjn6dF9PXu0W8I
         rRakxexC4wApWCMSxF5qsgfNN8zYhdwDWxIMSnMfS0oOYTRVfIEldX3g/n5rH2CsuT3T
         2tA9RTNIKeOSszxFtUJ81KGdyIOwaObC9Evor8xuijaev4h5BFH3bZiH0STs7TVikwFY
         4xwX6BkCKM/kRLz3QNS7bLCkIyfiL3jCxToLlBAMN0Oi7ZFpTQE6OYJ8SuV65oODrMYH
         de/qShunUsns+PI3UcL9omKotElgNV1zCQNuo3FSrS35S0mrbPH/nkwEhsgmSQZgX+zG
         yb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1wKIOCDkdwtJGZK19RNCewhrddy0eCkKwniIyWB19iat5Lck5kafDwaCHHRmZyRZwOBzX95o=@lists.linux.dev
X-Gm-Message-State: AOJu0YwJWHGVuiMPLgPYfIcnYvb2w48yJf29P4DdjGWVpb4E6C3Q+HbJ
	ZkAV9iPgjOoluxCxOTkLyCtnct1XOoVjf5zudh8wdgulM3PFvgcm
X-Gm-Gg: ASbGnctq+iwoFk29WpNoXoJrsSb7JIDtiiQpGrb8rBqAm4Xi60a1FSIaMk6uHe0yxzc
	UzKFGQtNCaL7VoAtKHu6QAe7zo8Xhj5MlNcCGNC9PTlpFIE+RNtg7jF9t62cQhRohCrZ9gkRxbx
	mnWLmIS4uaBSiPyGSoe5w64pDwzx7K4puTqndWKRnb6hKqUxcxGvwe8Gnqak7C3N6MgEKZnh3za
	7THiKLeMyGYj+a9Avf969xN4PnGNl+z9ww3CeCHNbCiqJMUbNWatxH8UOx0W7OjxYdYPEraOIEU
	h25IeziHquRNGqc4FmsPwoDyRVtglB3X/rOmX/5ugTrEO50GbYgP25oMLXlowGE3ZT6/y9BrUmj
	PIk6IdM++XrWKsYw2mcVwStR4P53+DXN+KOmLaHJ9mwJ3nYn1WDaeZel6PolDfg==
X-Google-Smtp-Source: AGHT+IFpDcHd77fpjokL8xxmcGiwz3SLhwhSLzmlQa1UAPVTwjRjFufxV/YyrDHwyugNXvXH+p5hhQ==
X-Received: by 2002:a05:6402:5109:b0:5e0:8b68:e2c3 with SMTP id 4fb4d7f45d1cf-5e59f4b6e02mr6129743a12.29.1741170616901;
        Wed, 05 Mar 2025 02:30:16 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1f7161a4esm247154266b.161.2025.03.05.02.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:30:16 -0800 (PST)
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
Subject: [PATCH v9 nf 11/15] netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to nft_dev_path_info()
Date: Wed,  5 Mar 2025 11:29:45 +0100
Message-ID: <20250305102949.16370-12-ericwouds@gmail.com>
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

In case of using mediatek wireless, in nft_dev_fill_forward_path(), the
forward path is filled, ending with mediatek wlan1.

Because DEV_PATH_MTK_WDMA is unknown inside nft_dev_path_info() it returns
with info.indev = NULL. Then nft_dev_forward_path() returns without
setting the direct transmit parameters.

This results in a neighbor transmit, and direct transmit not possible.
But we want to use it for flow between bridged interfaces.

So this patch adds DEV_PATH_MTK_WDMA to nft_dev_path_info() and makes
direct transmission possible.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 323c531c7046..b9e6d9e6df66 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -105,6 +105,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 		switch (path->type) {
 		case DEV_PATH_ETHERNET:
 		case DEV_PATH_DSA:
+		case DEV_PATH_MTK_WDMA:
 		case DEV_PATH_VLAN:
 		case DEV_PATH_PPPOE:
 			info->indev = path->dev;
@@ -117,6 +118,10 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 				i = stack->num_paths;
 				break;
 			}
+			if (path->type == DEV_PATH_MTK_WDMA) {
+				i = stack->num_paths;
+				break;
+			}
 
 			/* DEV_PATH_VLAN and DEV_PATH_PPPOE */
 			if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
-- 
2.47.1

