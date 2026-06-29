Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F383406811
	for <bridge@lists.linux.dev>; Mon, 29 Jun 2026 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736413; cv=none; b=p2JjMYnF8bQcuVsRjHFrnTHAE6RLSMGV7RiTKV1p/cW50h1JFaf7a4COf15lHMlhzWCnmEmUmS+SSpvEzS0pgjujL3+BGEJUuia2Urxf9U7H4UnZLhU8PIOCTu3s5OqHApQFyGz45DPigY9Bnso8aZjqlXulViu3BRp1NEU9E7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736413; c=relaxed/simple;
	bh=to4R4ee8k2o5804/vpzYrLJhMjVE1Ml1XXys9wSRdes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umtpzgVSrOek0iEQSwFSJRlCCvJt1c7UEgzPgyyMwaor6plwQqPHe4v+UuhOrQoLJj8lRX/tbs3UWxuLxKi5tx3Z+REqnTc04VEgc7pLRUozBh3wIxqlo/Hebb4G11T1hLWzdR97wzThxRxV/ToTW2ZoWFtedBKWV8F6DVax5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYhUtCDr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYhUtCDr"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1269e4721aso128180866b.0
        for <bridge@lists.linux.dev>; Mon, 29 Jun 2026 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782736410; x=1783341210; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3SLRCeShC2U5Lb0rTb1U6hkwISYxR1k50UcKsPQ0QE=;
        b=dYhUtCDrBBPoNP4w9kT57vU0PI1UY29JxfkrpRm2+VH38ZCWQfZxAeS3JlNPgGJ2EK
         tZ94hy3cUj2P9zgArTQeeT4BvaRtTUBOVZK2HXvrW8kj4SlN7ALI6V+l+byasX2+6ha9
         HWA7I8zL5FrharCcY76qyq/e0vB//U8dThpScU1yvXrICMColZUx+eg2JTeVriJSEGoc
         IrEBf92Sj/SKKLKW0qFSyfLkJ0GUwVDIGwN5B4AiMU4z0/1Wf9g8zFWr0ETm4otIIV4E
         jz98QFoygUZignYVtjgLL0w7+EucDjDvswJtesaheNWOEbfBZ+qAhrI4sMzHi35s8aDZ
         zMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736410; x=1783341210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K3SLRCeShC2U5Lb0rTb1U6hkwISYxR1k50UcKsPQ0QE=;
        b=raRB0pI3jaOaVUfpx2fMS+zwHfenFg1ImYVSZjXZjpq2rItGa2fGpX+Dxnw7KPNpaz
         jY/+CbbHGz/kxM0+Tyr7xETBCy9v/Xl88fSRgZ/oHAX8yActAjcEGeSrzjQcKM3+lPGD
         ddL5v3/T6tpAfvuQn7Fh5tJmO/Iodc7CpHEjRV2klXPxgxIvX21uCt9o11vT26moGjeS
         1D1S+fT/bWGDo05x9ts1UhUFDNcP9d7qUC/qLIgqN2guGFnedCU1jPMokmrM1k8hgupo
         8pxyipArvgIUsUEox2DCe/2efhUtXg24lK0KPyXlajMnvO3SsF0SWCzUmcZgoamcV96i
         tbrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8EknzzikWuNQqShiWCBEaVUf+fpBeBprt2TGcHet/jTAH+POTmDKfBGFDkqt0WyeT5FTgrBo=@lists.linux.dev
X-Gm-Message-State: AOJu0YzTYgfAFYezsHyTQ5ULAReZsufB46YztwnhBVfza/tJTI1gbQDw
	j+HG961NUjWAzjqTu8FyN+hY0gkdfUyxhjQWim4y/tP+G/ZatKIDi51d
X-Gm-Gg: AfdE7cmsqJYZ2UakM/MtIKMbeZ0ntx3im1V6AyCfxMBzmbg/GCKdjlGJg5OF75C5zGT
	lgVSey3H6+sUi+ybi68pfC4yzimtewBbe2AafEMljgReK853rEPiA1OP7DxmSeXm+0PDRFt2GPA
	aSmOWMVHKm27SnmW0VG7XyXnY344OhC00+vRsKFz23Lhc4+EcpesHzkAz0UnykmscfGtb4Vf+nv
	jLNK3cze69RoKF5d3KU3Ie7PnfOa78sJ90ybBB6l7ovbCdiVJe1XoBDetx1RWMe4HQlD2s1CnBc
	iglFiBR6hwIfi7n1uUo46iIQZ8xSnfFbkrvB+zNuo7s7Fe6KpIG7NbjxMU368WtZQ+6eXk/Ije/
	Ra749P0GOfNnppeuU1G5yKUkgAwmo8qoGBy33dAqihzNfjwOd5nMxXO9Wbk+21Mu4mYzPYpKq0q
	eQCiHRvvw=
X-Received: by 2002:a17:906:6a1b:b0:c12:6b39:2211 with SMTP id a640c23a62f3a-c126b392346mr184315266b.43.1782736410170;
        Mon, 29 Jun 2026 05:33:30 -0700 (PDT)
Received: from fedora ([46.205.218.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05c22sm773866566b.39.2026.06.29.05.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:33:28 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	idosch@nvidia.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bridge@lists.linux.dev,
	coreteam@netfilter.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	rchen14b@gmail.com,
	lorenzo@kernel.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH 4/5] netfilter: nf_flow_table_path: handle DEV_PATH_MTK_WDMA in path info
Date: Mon, 29 Jun 2026 14:32:52 +0200
Message-ID: <20260629123253.1912621-5-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629123253.1912621-1-pawlik.dan@gmail.com>
References: <20260629123253.1912621-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Chen <rchen14b@gmail.com>

Without this change, nft_dev_path_info() hits the default -ENOENT path
for WiFi bridge offload via WDMA on MT7996. When a bridged flow goes
through the MT7996 WiFi device, the DEV_PATH_MTK_WDMA step does not set
h_source, causing the PPE entry to receive a zero source MAC and packets
to stall in both software fastpath and hardware path.

Based on a MediaTek SDK patch by Bo-Cun Chen <bc-bocun.chen@mediatek.com>.
Signed-off-by: Ryan Chen <rchen14b@gmail.com>
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
 net/netfilter/nf_flow_table_path.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 6c470854127f..580aa1db3cb4 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -219,6 +219,10 @@ static int nft_dev_path_info(const struct net_device_path_stack *stack,
 			}
 			info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
 			break;
+		case DEV_PATH_MTK_WDMA:
+			if (is_zero_ether_addr(info->h_source))
+				memcpy(info->h_source, path->dev->dev_addr, ETH_ALEN);
+			break;
 		default:
 			return -1;
 		}
-- 
2.54.0

