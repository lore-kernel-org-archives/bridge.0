Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C51EE00D
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240780; cv=none; b=Flk3FcyHxuV5UheZorj7mXzXYctXc488CBrX+dUyQAr8qYbYhOlskhu0hbEedrDbSKMP8E6OHUIj3hT7+DY/JMKO7txGPkh5FK7iwzdlCTTlQbVDckWrS3DUVil7hDMwydyfxIOOEGAsdRPHWrVC7ugTo1a+YCbl2PVOuWjMxWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240780; c=relaxed/simple;
	bh=dbAGsONnKRZzlx83jeLRPcTwW8qS9zwjqCZyp+6J28s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m57nAh6K2yYFPD+aTS1ytPTD9IJVFspJXcyipfPm4moC0Yyh9aEGuhcaSbfo7K9Xtrbov2lbrCpsY5v+jZvOVGbjkdac0lze1ugiYDWr9JXibW3p+m5bagAXc4KaAvwymiapMVajgGa8D13J3/SW/hJWx8L9VqqS7rfjPlqnmXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJtYqrvk; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJtYqrvk"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so7465022a12.3
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 01:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736240777; x=1736845577; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BztZ0cfqRt9dxay4EdRKv7PmLiYD1WDU1Ehk6gLPnTE=;
        b=LJtYqrvk1Io0rZ1Qystq9os8MahY3iJ9/kvJtCeaNTmGGSeoZ+Hrw9iBcsidtDldfi
         8k/sxb1F9JiKsMMecKck5X7cWCpBdo0PFOCWz4O2jxnjNSzULY7f6bleqzpMxa7exwvM
         0PRpWRSo0a7SVdsyTYbV4mDysVpAe3FVw8kNDk86ztRDl0hJbMAiW7zJgTWPIPrPZ2x0
         NriYDwvBcvUf4Zdw+tdFJ8BfPWHSJMGF19qZjJhc7jRohH/6xrZ50Vt7heN56vcD7lAB
         iYu5ME+MFrfrpeEwyHaz2XirQ+IC0cNWptjVTI5teJp+Ae2+I5SaS3b42OMYB664Zman
         94Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240777; x=1736845577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BztZ0cfqRt9dxay4EdRKv7PmLiYD1WDU1Ehk6gLPnTE=;
        b=OCYWojUAnN0Q3izbXAi130yayMhhijMFyf6k6SElekwlMeVNWKmgOAhnGiWLYBNbUD
         oMICME7+hr5ok6X7H5WSVvIiD2Uox/u0w3NbTESjO9zVNY7ybCu0Gtu1GZoNXXwLlCfO
         RI++Cr9Fy1rhue6/oxSaBr0lXc7aNU0MVslarVVPJvz/c7teP3P91ApaGr5xjOTbb1WS
         JQhMpojzcBCT2euCvSxsGsph3TgGojhDAmUTHF64bJknoxSAnr2gptnorEBFSDGCVTev
         dS7ZQLA1CNGrPx23AoBD2C1YyqhvU7k6h8hLO3fO7HU8pfcZyP/GBUin4SNKxhc/CtGq
         l5Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUChYM6BlxLa2+HdBc/mwfHDsKPZ0CszGrJgbYw6oXgonSFwNswidtKzUZPyF11/2p8SniRY5w=@lists.linux.dev
X-Gm-Message-State: AOJu0YwCl49yBRiCH7v2rBqzB93WlEqe5uqn9oNrILLj8kbAjLyGcvhA
	P0piiQTBeUedFiTT605LM+VbSCxFzUb6YiQiQ1IidPjzE2zJ9WCg
X-Gm-Gg: ASbGncsZZp1fR22EiB6SkpjqobojeV4smhHSpqqx3vRw4pRQkSUzdeR8uwzDXerRigk
	X+D3KgPbq4vJv/p+5nb0njCWTHQea3VHqBDs5X4TU+XDrJCKE7PObmCJNSjvZg2vSo8JsyKLwab
	jwNSYBLpbA1X3NPJ4Po4A3LsEV0r1fULta3Zkj3jwWmI8HTXCGhfXEAPQT0qTt6kufB185l9Pzy
	xFfkFScP1Wyl1Ns/B2njY4ucoYxM3MOnizUDHOwrV/p0Jl8Ys5WAcVAFjxhpquPytiv/ExrIk5y
	Zgfh4anI/gaLI2SnpYkplrP0qHlPWuSAeF9DEVbKzdu22eQMe+H76VogVdqQd1DcdMLuqJaaUA=
	=
X-Google-Smtp-Source: AGHT+IEMDL6I9+h+aUrnAuxFNluD15rn5fjLxiMza8iUCfO2DRYtl2bUPleLH8zIiEcHnLjnMReziQ==
X-Received: by 2002:a05:6402:5253:b0:5d0:aa2d:6eee with SMTP id 4fb4d7f45d1cf-5d81ddf7fb6mr57943041a12.26.1736240776693;
        Tue, 07 Jan 2025 01:06:16 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f3f9sm24005333a12.23.2025.01.07.01.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:06:16 -0800 (PST)
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
Subject: [PATCH v4 net-next 10/13] netfilter: nft_flow_offload: No ingress_vlan forward info for dsa user port
Date: Tue,  7 Jan 2025 10:05:27 +0100
Message-ID: <20250107090530.5035-11-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107090530.5035-1-ericwouds@gmail.com>
References: <20250107090530.5035-1-ericwouds@gmail.com>
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
index f7c2692ff3f2..387e5574c31f 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -117,6 +117,11 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
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

