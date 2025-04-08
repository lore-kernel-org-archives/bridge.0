Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4CD2063FC
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122453; cv=none; b=ommxBgEOdr8l3e/GOQpS6s3TYHG2oFDdWj/EEkV3VxYE2SI3hzCqPjccubQPXzukW9FS9tN79N9Z9bhnNlFBHtDCCrqlhr2OwE2uigIsPwOQL8dMsGncnXs+7bvETDhMFI9BVEuya7rjc2CtAGb65NZZLEeIzSUyeyunWO6o1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122453; c=relaxed/simple;
	bh=eoY5ZDeqkWc/fTWUEPR+4PRh+ioAiobGt1prQcCq8ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmKUIlOx2DarYzNgTUycQPuK2V7C0yHZNNmbg2BwdPUjifPc/hy27C+K8vJB8Ug6J8SAd2yIxwOisR1iL0v9uRCli0adC3E0OiIMatdpHQJYn0YgwCURhkceSmJh1AEfPxO39oc8Zki/vIcD+8BzcRfwhDj5SJDMyFa8oqLI9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWUT2r5W; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWUT2r5W"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso1066825666b.0
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122449; x=1744727249; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZWb82/PgasUd3hxc4hu0fam4KL28GGEvVzyBGiqFMA=;
        b=kWUT2r5W4b6KCjxc85ZBujwsOtuoVDeyn5ocrwP4NHq+rOIloodwRh89DtZOivL3/t
         u5krVE58EXngrlT/DB39IiA31emTpMxTF/1rO8sq1IBi/hPU2yIdu0JQzPEM1zpC9aPT
         nzvQ+g3X13i52w5oMgWX8rEhbh1gVxeXuyPG8HxJ94Y0fWCPe0bZplXDmE138tHaB1yw
         0Qo5YEeqUXtMepnTj9u7jB96bhquIfOGJage0F/m+f3vpGg4zqr/h/pFiCMgcK9JdhkB
         s6CrK61LxD64x3f9Y9u226l3592TRN5bYxZVNsm7ggYAq3CBafkr1qQBFxga3judyndI
         IEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122449; x=1744727249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZWb82/PgasUd3hxc4hu0fam4KL28GGEvVzyBGiqFMA=;
        b=fIRCjIG98fy5M+Lh38cLIOl+Om18JGw+tCKqY2kIvVv9su1WC40eNlwbQrxnKe+cRb
         p/hxgsR/EwmdGh58dEvS0SeFUFnoDPaMSk5cJOgb16KI0ZfxzstC3tgDUS69AfkcACVx
         bu0hbSx7obrofY0Xf3+MZgNiMEpi3tP++i0F7zzh8nMbAZ+lws6C54UE34j0cpY2uHqO
         tLkU/QYxdSDvM/pH/1662cFDtBqpuGLUBn+kavspvYR1LaODeWV4xtR3o0LpZl6g2Mwh
         Bsk7PLsTS822z2Ilui4Oy/DCLJjxLn73Jp/O1mhkAVMC7ZZfkBOAIh/68evBpvzHwQLn
         irsA==
X-Forwarded-Encrypted: i=1; AJvYcCU3aUuKwnnp/7dWwyS0bfYBAxC+UM5vHCMLoPJ3ooW9eG23SG+NxuIAVpFDGs3oOyDQysgYU00=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4jrpJufxgI0RzOR1dmnyqHuLBlFtI6+EFudwEF3Yr8wjjrQyz
	nQmlHk87bzs93E6q5IlfWD6ZWSGYGlfgHVlLFOJHbuRyJ4GInbhi
X-Gm-Gg: ASbGncsaPxyfAUMhc7MWYuPnJGa2FJP5it19Jx718oXzHgVJtYqTXIu7GMjX3ZWDfTy
	e9CjOdNGC/JfvMZFvfuNsdfzNAsyThqZFzZ2fvZ6/pOZqlxiibCizLMvmGJeBFnuZkdRnJBzF0b
	r8jdxydzHOK/Bkca8wDT/qJlWP8HZFEqnv5ch50hI0B8cgcdRT1EyyBn25iikeyAu0/ZLGmEUSa
	ldwH6tmhQjNmZxoFoTDpdXrDNhEgizdHyBigmBLHBBb18efyjNNxrPxKHyezADhvP76bNQDSx2F
	YiLyGWN6mtTOYGlV5gKSldj3HJWEQj76z4XzK19GBsXPUk6s4lRXssE2DlhWokh7SG/h8PQlpzK
	otIcTercwM0agLg0qLcHSY9JDCTtmv7uQpQi/ocZYZ/KmkjCM37w5FGD7/XsiHos=
X-Google-Smtp-Source: AGHT+IFVjpjwhiim+Bxc5j4VTe0TH54Bm1QrpuWBGrq3gtJayc9WyUqiJ7bQRpxPiIXdRTszdGVxkA==
X-Received: by 2002:a17:907:7f90:b0:ac1:da09:5d32 with SMTP id a640c23a62f3a-ac7d6c9f77dmr1145483566b.6.1744122449312;
        Tue, 08 Apr 2025 07:27:29 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe9be67sm910393266b.46.2025.04.08.07.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:27:28 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v11 nf-next 1/3] netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to nft_dev_path_info()
Date: Tue,  8 Apr 2025 16:27:14 +0200
Message-ID: <20250408142716.95855-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408142716.95855-1-ericwouds@gmail.com>
References: <20250408142716.95855-1-ericwouds@gmail.com>
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
index 221d50223018..d84e677384da 100644
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

