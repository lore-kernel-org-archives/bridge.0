Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46622538F
	for <bridge@lists.linux.dev>; Sun,  9 Nov 2025 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716285; cv=none; b=fMXNX0U50tkpwnQfrtLiSy9l0bNzJrvpwjnufBcX8oMVtBw10297wNpOoNxAi0fEbqwu3EnRqSbzv8ztgdeyupSNBcOauEQMkjRtJ+AJ3wiIcNBQn6u8lGi5s1xWNHI4yACa+zoCETgAcIl2X0O19/+89FvO20oRQSC5EwGc3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716285; c=relaxed/simple;
	bh=fdY4s91tI+lPau1JubbQ0x8fEYiPT2Mrr0LtPH6xCk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNJTqYzrlrDWqbM9UQ9MXhQWFWEY5hZXpvRzSrtBRy00s6okQau5Vx+P5DxW9wb1psiP6P0A+IJopy6dRppUkgBgoXi/wVeQVzMM+rx2E6rAgn7jcrn5PHU+GluqnHj1qsLmvfJ7YztY2nnUDT6Dpwgs1kd6/ARoIPKvWGjIm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWvVF8iN; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWvVF8iN"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b710601e659so370525566b.1
        for <bridge@lists.linux.dev>; Sun, 09 Nov 2025 11:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762716282; x=1763321082; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+3n/wt4G7GIqXmLm7jMx2L0Drt9lvIRoMC4cC/d+Ac=;
        b=ZWvVF8iNHF7MB+GEAbjFnxtUS3+O0eUjztBCSlbX9oUMjaIAR/nR+4Feb0H8E2ZU7g
         s9QFHh4tQWbG88em9ts/4Z6VTDPmX8Uhtvxj6lbj5sBTpeCzJZNCoCaBcwb47QuEMUr5
         qJKFONitDWahG2yGg7d7wy2CSp2XoPeq95HEeVyLRMfQB3vXG3MZDIoz7jxin4a+Ji9J
         C8Xpe+9ENjnlNKre8KNctTwnG3WVv1M9uFN+RSUx8oyUoO9qP9WL8c794UAde+04t0hE
         ch0euZuMkRNckcd6m3InIM3xGC+gJ1Idf4pxflmVr6RTVes/FJo+YvxwKYyREwjnO5ll
         P3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762716282; x=1763321082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+3n/wt4G7GIqXmLm7jMx2L0Drt9lvIRoMC4cC/d+Ac=;
        b=oY7Ev/LvTX9MK4/g7wQ+U0l3ffzdBXXo6dz7Hq+QbMszQEE5VvpoQIgxPd03OnNLMW
         KXXmliKuDzzs6mx0GzA2Fbs4oWNYmqiZwZDMayJcV0NPaRBdFV6aitMVwK/39Rg5Czkp
         TOkwJ8GKmWkWY6X8bJ7b+cXrOanJrW4NWAgngZcx4aXSPNEyxyN3fBLLiQjVUDkkvKMp
         ggEZ/Q7aWKaUy6tpT9kyf5EtxyypbylLVlqxW23jQZLSu3BaTsEhLr5884yZ1pr+M6wj
         rwjL+wApv3nV8+0tP3dDgu4FFuX7BeASwnc+7C24AgEG+MlBiQbdj63UzBQwTEXLUM3T
         GStQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB2Amqwu4TwygRafFlxPNn/hRjKkCOW5K4uTYYRy9TEVH5g123lj1If6uDFEYB7ugkdFSNydQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7pV8HPKpIh+wGIclhkmk2yrTDMeWA5JTtJVj2vLT+lduNKFZV
	6Xr56SPIQWChjbw5cvyVwsXSyMPImE0HmBz5/k01eNBGYlpxGGbNVdZNMiz1qw==
X-Gm-Gg: ASbGncsJtzao2knngA1B7bM4SQx41DcGZ6DDhi16d8rirfoLHQcy0EiA3dBamF20edQ
	AkTPRggDXzsJN8c9jsCtjuWQi1bD1jyFYD5DSmJiEm8bboJ3BSTbpn60ttVz9HSxyXYHf8cHt5a
	aqX29eJM0UIsg/s4oynSyrkux0DQ2qirmfE+iIGRxqv//58szKbLbQew30ABKl2FAFMNRZVO5sU
	GxnSTTbKMfgTFPZ8Zl9oRZX/jRXZM6mnIFr02uudAAc6qmGJiAzf5WfzkEfidBgoMHketAFw+3p
	2EC5MgevfseZLodnBHpVHI2k11a7FEVUEVj3bfYu7wOmJTqMRNcC8/lLS3UA4IarH0ermDURUxD
	nl00KoCUJWqpRQ4BWeYwR1gfTOYn/fGy77AVEXSVfGPElm28wErRlYc4lWKhaagnkrgVW9gugzE
	DrFA9UI1K2D811y/LMOfIZkNECSoN47Drbr1FUCzqaVUqMUmh2erpdrNl5ITBcQkhhDhSF6P5UQ
	CsnV3NT9rcLvdK0IHA4
X-Google-Smtp-Source: AGHT+IGz2KRI1O39uoZsEqlvnLp53H/kYakBnxCti71eJRyaYaJ3y+qwmBNp1s7c1ixCSsXVxeHDAA==
X-Received: by 2002:a17:906:ef02:b0:b72:b97b:b6fc with SMTP id a640c23a62f3a-b72e03ef38emr633081066b.30.1762716282139;
        Sun, 09 Nov 2025 11:24:42 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e447sm919652466b.42.2025.11.09.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 11:24:41 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v17 nf-next 1/4] netfilter: utils: nf_checksum(_partial) correct data!=networkheader
Date: Sun,  9 Nov 2025 20:24:24 +0100
Message-ID: <20251109192427.617142-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251109192427.617142-1-ericwouds@gmail.com>
References: <20251109192427.617142-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the conntrack hook it may not always be the case that:
skb_network_header(skb) == skb->data, i.e. skb_network_offset(skb)
is zero.

This is problematic when L4 function nf_conntrack_handle_packet()
is accessing L3 data. This function uses thoff and ip_hdr()
to finds it's data. But it also calculates the checksum.
nf_checksum() and nf_checksum_partial() both use lower skb-checksum
functions that are based on using skb->data.

Adjust for skb_network_offset(skb), so that the checksum is calculated
correctly.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/utils.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/utils.c b/net/netfilter/utils.c
index 008419db815a..7b33fe63c5fa 100644
--- a/net/netfilter/utils.c
+++ b/net/netfilter/utils.c
@@ -124,16 +124,25 @@ __sum16 nf_checksum(struct sk_buff *skb, unsigned int hook,
 		    unsigned int dataoff, u8 protocol,
 		    unsigned short family)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* pull/push because the lower csum functions assume that
+	 * skb_network_offset(skb) is zero.
+	 */
+	__skb_pull(skb, nhpull);
 	switch (family) {
 	case AF_INET:
-		csum = nf_ip_checksum(skb, hook, dataoff, protocol);
+		csum = nf_ip_checksum(skb, hook, dataoff - nhpull, protocol);
 		break;
 	case AF_INET6:
-		csum = nf_ip6_checksum(skb, hook, dataoff, protocol);
+		csum = nf_ip6_checksum(skb, hook, dataoff - nhpull, protocol);
 		break;
 	}
+	__skb_push(skb, nhpull);
 
 	return csum;
 }
@@ -143,18 +152,25 @@ __sum16 nf_checksum_partial(struct sk_buff *skb, unsigned int hook,
 			    unsigned int dataoff, unsigned int len,
 			    u8 protocol, unsigned short family)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* See nf_checksum() */
+	__skb_pull(skb, nhpull);
 	switch (family) {
 	case AF_INET:
-		csum = nf_ip_checksum_partial(skb, hook, dataoff, len,
-					      protocol);
+		csum = nf_ip_checksum_partial(skb, hook, dataoff - nhpull,
+					      len, protocol);
 		break;
 	case AF_INET6:
-		csum = nf_ip6_checksum_partial(skb, hook, dataoff, len,
-					       protocol);
+		csum = nf_ip6_checksum_partial(skb, hook, dataoff - nhpull,
+					       len, protocol);
 		break;
 	}
+	__skb_push(skb, nhpull);
 
 	return csum;
 }
-- 
2.50.0

