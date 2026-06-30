Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F003CC9F6
	for <bridge@lists.linux.dev>; Tue, 30 Jun 2026 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802685; cv=none; b=Q+IC9oCj8LSteT42/rnhr3BsWEwkW9izbQuu3cW5BazryY0B8uFp57j0sQOk7TRqJY/gutbfJwp058cqkmaOe7L4vyXRpTMXrzcWf+rGwZJQViZO//ToBN7EkO+FBYYVAuWdFank/sQ8Qm0w5bVykPnYQbSEojgzj/c9JqKJSLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802685; c=relaxed/simple;
	bh=to4R4ee8k2o5804/vpzYrLJhMjVE1Ml1XXys9wSRdes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NENlNByANvaGdANKgH9ApsZ6DD69HWUhEP4XdtD5+y4pgNgX7krwApMQ3uaFIBMufZiAmgfZ07fVVf9j/+BlZqVltNpd6UrIRFtqtYwRcRxi/gOhbU0pfRz5a8/OltZx5RIhX3s3XHvOhJdivstoHqrIdcuENlsXswgXx5hLgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIBEZ79V; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIBEZ79V"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso1613343f8f.3
        for <bridge@lists.linux.dev>; Mon, 29 Jun 2026 23:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782802683; x=1783407483; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3SLRCeShC2U5Lb0rTb1U6hkwISYxR1k50UcKsPQ0QE=;
        b=SIBEZ79VZJDmyFeABy0Stvcpt+4mCa1QEBzOsZ2CO4+Amae/Qko4mRXYYSFAR7OP+w
         sbB24Un3ic8l3uU5v9yLuxt2oLLVJPc+xqmHyctmDgDqcjV/sdCDYw/4AbqKDAbUD5x6
         QhscLbe52/HRIZDtll4BJgGUmHa65mruDefRfJzpzSx0QC17/p/WatorMiYF/WINn2hL
         w1vJFLO7dm2t3+Fu6br/nc1CuDnhS6bKH24jZuqE0LDrCPv5cZ6lqLlCK2d/VDqP8rMI
         fqj6roEYJvxPCox+LDwXnm1cypvzxj7tBuXyfMr8aTtT2Gik9a5lMjau3lr56GUvgSrq
         sWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782802683; x=1783407483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K3SLRCeShC2U5Lb0rTb1U6hkwISYxR1k50UcKsPQ0QE=;
        b=EYu+uE+UPOTrbMsA3Y0hdEv+KVPK/UjlIBjcKZaOU1JHm9zHxbtk14vtK2otqlx5Zh
         DRyuiEaGAnHcdZ0H3guZwHqEBl/e514aWWGlqB/Mnn39dEXuwElkWf8V2JNN+D8H0RLE
         RjfBDh8AMrX+918JJ/DEF4IDGuHHkwpKMY4CRE7E7dMecTvURIPat7c7PMc7m0Dt5I7n
         ZUPKncW00s1OnyptGApBUgMwcuUOF9XVwFs/MQCz+c82EDUjd5uOSrlPf1H46xA/EA6L
         Z3tt2V4dwjAmpSee+9TjuVs6K49Vtc9E1Y+NPR4lAIFGoOnlgHWHE9KtaNIGde9s5Yk6
         Xb4g==
X-Forwarded-Encrypted: i=1; AHgh+RqmxCVVRl+6P34pigTdiluchRH8pKqZxBcxqtJ3l3gDr272ZQJGeIZiQMwX1Y7vbeJAOJSbMQY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzEvNDSU8UvYEfKnBcbtkDfvpYDebZSD7YmBWCN6UXhUuUQs/zI
	rrVi+dkUVGv2uWchdnZKRrJsvE7nPXlpw02KSSYrHRB8HHWaG8OZxzQR
X-Gm-Gg: AfdE7cmfNBDfGtZgUKFtgdOyIzuL5bg1oSetqOFq0YJn/1RbUZAzRdBLbDJoiWPFspc
	HZtrmnKdKNOLgcslxC0eq75iRb6InUjE1VWldYRE9Sq+6Xg7wFhptcEz3ePzVhNUBk4eoRDZtPh
	Ot7KQJidC2srGeprAhDXkqu7PiSQDFjU02CERs40QjplDCu17YzFmK4JU+IJsnYwNLKGLjR3J6/
	KoTitgfygpb+aHYg75BKJGxV03bvRORVlQSOv8T2CZYOyqmp8er3tXEoj9cIgusf40kM4cU0ruh
	aDV4WRabbU6uNA/KBNvnNbHvBDXQvV7bfqqpGQIlQrhQYgGwPeso13WWEgsWGwMzCsBlKjqALvm
	8iIWhr5b+ohT3H9vDdjJq3+yhsEGCk/SqFZIL/4k2HV4/ZDPrYgKzMEjvl9fxFT+2KFfJflhiXS
	8oeqZYBag=
X-Received: by 2002:a05:6000:2c03:b0:476:135a:1349 with SMTP id ffacd0b85a97d-476135a1477mr139610f8f.6.1782802682657;
        Mon, 29 Jun 2026 23:58:02 -0700 (PDT)
Received: from fedora ([46.205.218.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf26sm4570949f8f.19.2026.06.29.23.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:58:02 -0700 (PDT)
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
Date: Tue, 30 Jun 2026 08:57:34 +0200
Message-ID: <20260630065735.3341614-5-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630065735.3341614-1-pawlik.dan@gmail.com>
References: <20260630065735.3341614-1-pawlik.dan@gmail.com>
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

