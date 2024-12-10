Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A32343DB
	for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823991; cv=none; b=MB5AgneBI+sLxMzHSgZ5S+DC10lkwLNvIvjgdPOJ/8G0TJcqSSVYrxhQngZgcRhfxxfgrSH0L+Od/N57wVJQPRQEuriqVux3MkuGilOa8Jl54XiU3SKJzb/OX2QEKtEFCowG/H5TT+OqvTdV0hflWcQBPGdHSibBU7PDS3Hwe4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823991; c=relaxed/simple;
	bh=maNLh6FFLEFZWq9gMrHdXn5flUbXY1gxWqNWlBJHOOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HptuXMzFduelGUdPv3Wh/B7Ux/e6cijdYYWHitGwJE3veXvQSmFBiht+SO37kJ46ApHyY36q9HoT3kDe+upKjH23YDn6R7WEThCWHT6RhbuZpDXxYWonMq+oXEwZ51iDIMe+G1HrAC6HwikXYLG1k4TYrBUZwLXeOJ+Q1kskpQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjORuxci; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjORuxci"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so6690604a12.2
        for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 01:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733823988; x=1734428788; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtgyJTf0nGEQy8dIgfNuKn9dKl89pMTFI5gYmniF26o=;
        b=KjORuxcinbafeWJ0AHlnjhq3g7Y3mcKtUVu0XMHO4dh3X4vSGPZRQxHx5NYfI3bN+x
         4VhCJO+gfhP33pko0Ic9sYiRfyuR320fMf5qiHciRSISJotHKDOcb19IBmV/4ww20QNB
         9AhU8/bnu5+yr58LTXN3o0DN8HFeurznC2uExcyhcPNVA4yFRgfi3h3MHxC7B/XmCVqo
         PqpvvA6/dDID4gOYgXvWQaSErZqRf0eCPJEPm0B+V+jZtO2frj/krJcRwYszXAB377Lj
         g1UjOwOh0RmRys2AED4sQwS4U9qPxmIuX4ckhl6f8DKzXarAZ5qCuC3wDtLsNEet2smT
         1kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823988; x=1734428788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtgyJTf0nGEQy8dIgfNuKn9dKl89pMTFI5gYmniF26o=;
        b=Xzo2naK5UcjdxFvZ3Cot4M/71JnBKPgOFXOgNJ5Rqz5KcJYm1Q4XCBlJce4FIwdeas
         jeZDiZE4fxuU6V/e2Ir2SGIbSOi2KDiBxo5ASu1Yb1r8lB7pJsO/eo/7w1+SyoC//NCP
         GYMgLosspLxyo5JzB0rxYojQh1yfZtVwUTldOZvxq5uWnmbYxSwTH2+f8UO6Vs1kZKjU
         00HanGU4Es9Ut9uyMPk5MdBbUGcvKe626Gf0UCIXW4YZr7iXHu3IxIauPzo/MJBDyyca
         T6MXfPBmg08acs++3fAdV1UgtKldZzxpUsCCM7MWhKteK1xQgFJaIOtf5r4UdlCpUPbi
         HShw==
X-Forwarded-Encrypted: i=1; AJvYcCXH65giwNOBaUGZ6ccARXlLHaFXnfW+wtoIpqwkTklX/CT2yqGe6l9X0mfZ/bwLSx+05IFgHD0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzILay7Xnx33vJoJbBXtubF/7TaEgqsW05vZz/qHmNic1FiEwTo
	N5xj9iQhDJ/gaf0HnCr6vcNJXRSM0RZ1bry7wtuJ0MyOFs7Ll5CD
X-Gm-Gg: ASbGncuBohM9j6D/2QnenvbjRjTbP8LLVdD6ki7+a078oDCCSu7ndADK7DrsS4cc5cD
	ZXn63YlOMTxwkRRz4jBYcnPaF+TpcjCwUwaxq/eCH7hoa8ic8GgQrWveuT4/x7ZoiVTkr+f7DSK
	+Rv1DH9CCKn2mCNgLBBkQiFqhsWZmJV2J76e2LlvKncaOAhom++M2/TWr4kz/BAyA7hhoO41ZrR
	BG8F2KmX8eGMRxovZncTTbv7l91Skt/VfVcUVDj6z7AiWcv6e+aVdLeMDTQTb56F4qFcbzdwj/2
	jKIACo1DNAm7pq2DMv00bYniiIeUgiN7Qpd92q5ywDjjGarbn4/yVM7O6ObnvOdI+5icZkY=
X-Google-Smtp-Source: AGHT+IHMIuAkwd6n+zMlbqGssJrA/sOKUAdIFcZ0GUQzc6T7cPFdzuPhW1u/ZoZsTEDW+OJzrhPxJg==
X-Received: by 2002:a05:6402:4403:b0:5d2:7270:6135 with SMTP id 4fb4d7f45d1cf-5d41863c5c4mr4611870a12.33.1733823987762;
        Tue, 10 Dec 2024 01:46:27 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b609e56sm7313936a12.40.2024.12.10.01.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:46:27 -0800 (PST)
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
Subject: [PATCH RFC v3 net-next 09/13] netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to nft_dev_path_info()
Date: Tue, 10 Dec 2024 10:44:57 +0100
Message-ID: <20241210094501.3069-10-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210094501.3069-1-ericwouds@gmail.com>
References: <20241210094501.3069-1-ericwouds@gmail.com>
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
 net/netfilter/nft_flow_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index cce4c5980ed5..f7c2692ff3f2 100644
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
@@ -118,6 +119,10 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
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

