Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0C20E026
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170622; cv=none; b=gfT69CAZB1KMj+YfJUfu9UheK0P3Nz9kNkgurGTeP34qb/fw30PWXOpH5/yn70UzMkjqWK7PFiLaqwa1bXQ5wgUt1dC0FlS0n+XBQCwssFD9/Kbm+JVJZuAvdWjgA8EVgATQisJni4TYPPgz9hext8yH4vK45Rm1gOHtGkwupoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170622; c=relaxed/simple;
	bh=8dcYAV0MonhKL6O5x+ptHAAw+fbiOOhKssEKku03mBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjISLpxz0/dSsBohNv3K9e5L3Vjxf9S+YK7XAEyH6exF5fHXVRC6kpcHpCYkd4PfXxPomtUKuCj1kNxQtkd3M+eFOx6Tv+OLqaGBHk+cqvL9gQweNZZXZnU1J2wNol5+ZOpUMeP65vGii6jhGduIENew39r598CzA7sMzSFzo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpIuzMQc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpIuzMQc"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so313538a12.1
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 02:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170618; x=1741775418; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVAkTZii1Gy4XRugZsnKaWDIV+1UdUIxS1E1wVQkwnU=;
        b=mpIuzMQcRhhHVSacBilGMJlYXdzbDuXo4xqTzGDgLf51ef5r8ceR+NrChPVa4BwOOt
         gOOEEwSVOmEXXjPEp7qocSY2+6ZSlP+OczgHkmA7zT4BSxOL4RmGtVmEm5ZtBTNRuBDM
         uxk4E+/YtSuynLMmdWZdpDj1J3gSrv9DrckLID9JB4BmBWbCJNS0Z13EX3pyufGTYcHg
         +Ml83BckYOD3WIovO+sq5g6yxEdYpLAI9EYYXT5XsdGZdozCTZrZHWsDSzvl5Wid/hvK
         ZmV4u5he2xjsV4IM/FPXc4WjkTxS8dNTYc9siYoLYGu4cfRGIRO0bIg4tYDmLHanhZwC
         ktnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170618; x=1741775418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVAkTZii1Gy4XRugZsnKaWDIV+1UdUIxS1E1wVQkwnU=;
        b=qHxl+41OwGg8V1J0sBSzgXdINELSuN846YEbFwOf9DGcN4bHx27tl78hukX8WPf2NQ
         ZyiQlu8/phwxRgECMeTxGirkS2YfW1SO3DCe4L0ExiGD9PZezpTffMZRQZOzC5lZcjNI
         GuamcIpHOM7vMlwgRliFVEXo4u5XWcBkkqGjvnpSxsehlfhPLfdzJo5X1pC5MSHrcAS5
         qgmH2ye+ycHZk05nEr6TUe7THcwB1FfYRkM9kzyV19w52l24M8/nU3maGtLanhyMwmam
         FH/woC6+u2Rx2Cm5AoOMc1DZDIm39AMwnkylm3eCMH0RwhJ4fXYzSj0JPpEZH52K6NwE
         f+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEL2pQ9X0KtF5hGkPoXE7lqQu5jMUYiTO5KR1SzeoFWIBK86rJuqFJsRXAogSDw7bBCBjI1AM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj4wlkP9DifIzblyzQEeRno+AupPvyLO3eUMVaJTpKJiYktjqL
	Arxrs9TLWQ1Oj4Isagf7E+/Rt7tNQgX+5MQA2Jz4rUti1aM49dEC
X-Gm-Gg: ASbGncvNX555la74sATW2DvT4mShMT94rJXj76+29B/qHFJnB58wrsYzOzSUP4+jE8l
	aGtzDIGJvv9DfOoHNyqkOHrNsQLepZOlIuld6Eb19vZk6oXbARV5enPDmo2UH5nR54uk7tTphZE
	9P1CVw7Lc0BTq5Y9S74MTQ+Ymz7C8x3o0bXUxVEdmBxVEnzw5s6Vmra+pV3m7By0KVxM1lJ6d1T
	FUxF4lEm5s8twSwwNQCphgq34uGVfWvycJQBoWy/TEarco+PZi/AOFSWqzm12OODVS4UvAinx8p
	tu3xzo5EXi68h2EDdGlIjUCoQ8YwUOMXVvju/9rncH9mZyQWgQPr4kqPR3Isw9yD/ZAOBRDeHdU
	vW8P2NrO/F8xzepBwimgNPQvUmF68NcBgcdnGmW5kKlAKI5X/btbHcW3GO2xteQ==
X-Google-Smtp-Source: AGHT+IH76j7PuSAp246zNAO/9bTEHz/TOOLWKA15shLvAnk2YElCcj8yD7y6QikO3QGYtioJiV2+DA==
X-Received: by 2002:a17:907:6e8f:b0:abf:663b:22c2 with SMTP id a640c23a62f3a-ac20db005edmr280954166b.51.1741170618037;
        Wed, 05 Mar 2025 02:30:18 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1f7161a4esm247154266b.161.2025.03.05.02.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:30:17 -0800 (PST)
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
Subject: [PATCH v9 nf 12/15] netfilter: nft_flow_offload: No ingress_vlan forward info for dsa user port
Date: Wed,  5 Mar 2025 11:29:46 +0100
Message-ID: <20250305102949.16370-13-ericwouds@gmail.com>
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

The bitfield info->ingress_vlans and corresponding vlan encap are used for
a switchdev user port. However, they should not be set for a dsa user port.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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

