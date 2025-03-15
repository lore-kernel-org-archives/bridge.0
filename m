Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853211A0714
	for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742068929; cv=none; b=PNSSK+qtksfX2RpKBcL18NxaMXM+79eGcozo5puEs+altvbDpbrgqWx2vQKOHxa5uUVHzxR06X5E+Gz8xyvk6dfzG9f4wz7Qx5Z3lkB8I051uXmtH+m0NnKZZiq5Tdki70QlXjH6uhh86ByjXqScJUf/jR/pHxgvD2vFgpyMfuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742068929; c=relaxed/simple;
	bh=PQaRq495yBD2gObfPrbPn3PgSekFS9Bzk4unPsNuczk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXlQirMsbRhwOjGDx3The0YXXGb4wR58mVos0onS5XPvmhqBa4ZK9ruQb3AXHpv/DQdMINmuVvreog5jN4/BCtjlMX11ZRQ6NzGXTmiGT7t5hnBhZU+Zucp++Gyscpet3DCtAUXvDHKpbvRlckPYlRjKRbnPQoWYG1UyQNs/yHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvE1MqNU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvE1MqNU"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab771575040so812709466b.1
        for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742068925; x=1742673725; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnv8s8ozBwrftot2Snzl1fMe2ZQjCLjk8NZLpN8fPs4=;
        b=OvE1MqNUMwS1vsrk+PZn/ui1Vkr8VTExSkv2BSPKE6QeVsuLrZ9dzrOf33Mwi1IFix
         83A+tllsEXtbkxml5r+J0OMwt03QOXLRlunan+pk/Miwv1UtWBOQprJfnmm1wmXceWlF
         UZz8ScNwXIuKsyFPvVZiYolwNgcb8RNZRHVc9Nv34QKQsVPrV4+5l0ErK69yl4PYe0zt
         j3dwE231sjx5m9wJgzBdy01+quy0VUj2PhH/sD5exfBi/IhSJVVgLbieiGED27ZMH886
         ioN91abLJwOLT/hPi1DpSsKtSk2Smeay7+MIUwY0GCaKA/7UIVLErxG2N4UavvPCoP4n
         GE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742068925; x=1742673725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnv8s8ozBwrftot2Snzl1fMe2ZQjCLjk8NZLpN8fPs4=;
        b=aurFjGkAioXW3U7fV8V7tQdgeKyQe4osg3mScrZSD5j+DVGgVROzl+jvBLXJSfAuxN
         OFx0CPLMsqYthVTMV6i3P+Wsj1rP4cnEOeEOKt4q0pgWepv0KpJ449mv01f4FfyrXQ4U
         ScjzbEhParH5g9A3fhdVmu+sF+dyRwMzMxUj7pZc5mw+/FrnR/V9OB1MLLD6Avbv6AY5
         RMzRPoKhKf6bZrCVVwbZ6Ia01DUnhHiAhQyV67qYJQ7/OGpa3xk53iwDadJKtSQG4b+P
         y2OPO9Rt2Z3B0wRohG0Yv/qS0wKSJe1zVyS1WOrb2D76yZuaVr6DgsyhfyayQzVMSnnz
         nSJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIZzseGvq+MnwWNEgxAuASJWNtQ0Ytgm2A6rWS9QoOFpJPnjrZijbhn7M+Q1euI3TkHHj4UR0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxBF6xFSpwJyM4Gd+oQlqoj6u8sdyhKWQbnOP8zOrR1yo5fp/Cd
	4cr5wnOuIVi+GqrJLlt1s5c52Nvxzivi7j/WjpfT+ZKZYXiFJ6np
X-Gm-Gg: ASbGncvDICZQYNNOZneqexygtksM/eTY7tB3KBu/PE4OvgKrZEiovbjkKa8t0ZsPM8f
	LI9sRf61fKAZXIB+H1F4hBcUW5YCKgeKSXqAQE5S2opdLldYqCBI1MTs7U/0NtHm1aE1Bor62do
	OwUd8CsJ/f1nfNovnvC/cuI4/VGq+wRL9FEActGCUQxnpiZDrEZqOOnW8AD9CQAWhdPWciXAL6j
	znDptoJN0R2rU9CsRbOdko+s+U4gPeB3Ope8WZ854qcZvcA/uo2AG54WuSzdghEgb+SkkBUIGh3
	JpgFQ7m0d1KLUtUAvk4631RUP9jUd+bWV5cNXlafy41Ds74MO9Tsnwg6y/v1I9Luf5ydeybIODs
	UCJ8QxkSQVEIh1nuGrarxBcudMmZGbZAU9u8peAhc0UDrzrG01UipE4roVWJ7Sb22E36vVKOfjw
	==
X-Google-Smtp-Source: AGHT+IE7wQUwPzmc9fAU28R+QPw4AyOXOfaovqueWq9l20dn3Msl4kW9Ypx3UjNa/A+DViUSNtfwjw==
X-Received: by 2002:a17:907:d38a:b0:ac2:9a4:700b with SMTP id a640c23a62f3a-ac31234318amr1268268766b.16.1742068924742;
        Sat, 15 Mar 2025 13:02:04 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a489c9sm411456766b.152.2025.03.15.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 13:02:03 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v10 nf-next 2/3] netfilter: nft_flow_offload: No ingress_vlan forward info for dsa user port
Date: Sat, 15 Mar 2025 21:01:46 +0100
Message-ID: <20250315200147.18016-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250315200147.18016-1-ericwouds@gmail.com>
References: <20250315200147.18016-1-ericwouds@gmail.com>
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
index 05786d856530..a2c7b64261b3 100644
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

