Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C2C2E370C
	for <bridge@lists.linux.dev>; Tue,  8 Jul 2025 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987549; cv=none; b=t+qukyv7frAQKg/cIsHV7Ubjz9yV3yjxSPUfrc2HZ4rpllEdhkb1vaggzZOxIPg5uRWvszHbcb+R7fDC49Ls966LXyJXT+4qWwfiO36YEwjj6sTMX22mWC1GFQe/DfNQIH/aG+5rjj3G+H2SafE8LoOCx+sJP6N0IzN0yTXG0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987549; c=relaxed/simple;
	bh=v6IbabFWuSJOoL99Vr5mXorOYaAUJ0H1qpog1nD3fAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=js4FPwgz4SO667AwXKdi2xb1eN+jnwmRK02RV+/ar06nTwib1c5j9b6TMIANxX5HlLuKxl0BRKfFZLaTcob72oiEKi5R7uygsmxbH2QtKb0rvANAhfIEZzgJvHJL4pnGrryQtuRKfoX7BlaEQunwR4aBrSWONxiVq/kSmvFsbSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOFcRmtb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOFcRmtb"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso8669235a12.1
        for <bridge@lists.linux.dev>; Tue, 08 Jul 2025 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751987546; x=1752592346; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUwk3PviXxbrCjaDtVYUnNUgKSgyua01vTosDXLn6cU=;
        b=gOFcRmtbjB54NVECq9cELp/uGWutsO7RiOYeEN7lEiFNBJoxENGNk9J5lT83s3KHXB
         SKt4MI/JrdLeaiymzIjwhkcupVhZempk5LTDqRos7fozqHj3/xhm09kLPyV8Kmfj1MmO
         QLkmc/jFE+G44TI/xoUGvi2HbvxO7e7yudB7zbhH52LIF216Zwm6m9l6r1p7sOiV8UQ3
         dcNw+JpOe0T8koqCnSv7s2kneF9mN5Bznqly4svtQHdItcy+hUrlRRj8StXGw09oNdfE
         xQmxU3GFUQwPZ1+RL5baLHzB+ZvXqtApWWCmt8cW44ndlxauRTniHX9FchBbe9pxiR0F
         vC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751987546; x=1752592346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUwk3PviXxbrCjaDtVYUnNUgKSgyua01vTosDXLn6cU=;
        b=uiDcaMAUEquygvNUoX6A5dskgN2E0L7iNel3thpC8TNDjCby+QdgGM5vVhQ0Evs+m+
         h+8wkQFTrAK83210d3ECjs6sf2ALjFBWE+XLk+pdMLaPeVRsfUi3OCb1Z8BC0YdcKY6n
         GY/YRh1Vl+K5pXFUIbG07WCV6ioT1h5/wEA7BV89oYer1/lng/zy7LbcuWE/M+pwNebr
         fuWU158B1DvjFpJtBYem7jAU83zHTpXYN8O5cBXVoEECFOLVFE0mm+MOm3ZmStiMq6Nc
         /FcmbpA7lwIV+25Nf+Lg032MY3r7y3EsVSEkhid6utOEBu+/AJ6RRHBrrcxj4MLEmbdL
         zNOg==
X-Forwarded-Encrypted: i=1; AJvYcCXlki0O4a0gp21mg7yqKrWIoUMd6EK/1msGSWz8Jc+Xb4Su2hB82GL35ZhMPjbjL1Id9wSigVM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzVmKSiP0gsWaZI6veTwbW5IJ90xs1Hl8qlv3KfL6k85zagLaP/
	JDDsTvHmV7K1ON0ZQkoy2EDwq/kAvTtg6z0yjCqJS4rmYaHPZRjDYcvF
X-Gm-Gg: ASbGncvm5nVDtFzfQpAktgQZo+9elKzZ6YKZpKScaa7+REVqy2ogFSOzSHMWmc/y8ys
	TJb7C357NObYAiAQ+AILD2eqypvbgCH8QCCB+e5E7+a6dAt7Jwmtn9m+3N8F68JvX4J3rIleOA2
	I8EOD6XaDzcljApuamSkTVyaN56d8VT8/+xb1MbilDzE9jRK713puxAX8TSSfns6bVjzn0h/aJ9
	60C9BiRRgB/LwHLFPGp07RveGK/F5qGG/m5VOUay3vko8yiUyOago1IwR+5L+WuIbuagN4K9CCh
	Si1xEeG0HPza72sblNPEf0IUgEDCb1l0GYlAK07nn5gDBnO5QcgcECaJ/1tTBVhVweW1Vu5rBK3
	EO7uZnE59J2lDpbcrCiPHCOIViaWhevNzS26pa574ZkepL5qbEJEtpEMXhNblpu6m3NvKjpt0GA
	CklW3K
X-Google-Smtp-Source: AGHT+IF6CB3epAacm3o998BsP2ZMm2GHdUUg4vM66IUxSnpFqtqKzIJwM4AxbhZA4lacg7pZxDFlyg==
X-Received: by 2002:a17:907:7251:b0:ae3:8c9b:bd61 with SMTP id a640c23a62f3a-ae6b0596e91mr365931866b.12.1751987545613;
        Tue, 08 Jul 2025 08:12:25 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02a23sm907596766b.112.2025.07.08.08.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:12:25 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v14 nf-next 1/3] netfilter: utils: nf_checksum(_partial) correct data!=networkheader
Date: Tue,  8 Jul 2025 17:12:07 +0200
Message-ID: <20250708151209.2006140-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708151209.2006140-1-ericwouds@gmail.com>
References: <20250708151209.2006140-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the conntrack hook it may not always be the case that:
skb_network_header(skb) == skb->data.

This is problematic when L4 function nf_conntrack_handle_packet()
is accessing L3 data. This function uses thoff and ip_hdr()
to finds it's data. But it also calculates the checksum.
nf_checksum() and nf_checksum_partial() both use lower skb-checksum
functions that are based on using skb->data.

When skb_network_header(skb) != skb->data, adjust accordingly,
so that the checksum is calculated correctly.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/utils.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/utils.c b/net/netfilter/utils.c
index 008419db815a..9ba822983bc0 100644
--- a/net/netfilter/utils.c
+++ b/net/netfilter/utils.c
@@ -124,16 +124,20 @@ __sum16 nf_checksum(struct sk_buff *skb, unsigned int hook,
 		    unsigned int dataoff, u8 protocol,
 		    unsigned short family)
 {
+	unsigned int nhpull = skb_network_header(skb) - skb->data;
 	__sum16 csum = 0;
 
+	DEBUG_NET_WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0));
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
@@ -143,18 +147,22 @@ __sum16 nf_checksum_partial(struct sk_buff *skb, unsigned int hook,
 			    unsigned int dataoff, unsigned int len,
 			    u8 protocol, unsigned short family)
 {
+	unsigned int nhpull = skb_network_header(skb) - skb->data;
 	__sum16 csum = 0;
 
+	DEBUG_NET_WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0));
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
2.47.1

