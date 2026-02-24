Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05EF3093BC
	for <bridge@lists.linux.dev>; Tue, 24 Feb 2026 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915998; cv=none; b=ocm5i7CVf052jaTRpo82kRsIYhltrarA6GF5SpxVfeJtdTmnlPRxhVABSA0OZMmdogJptMOUzp+dlZNbekrG/KZTOA4LwpKvQwY0AQvxAYdbOyWMRAN5qR1Cr9Njc+Bhhd5K6+3BuR8SVbG+dr7TOwRb9IFFZ3BQgb3wZ8iKHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915998; c=relaxed/simple;
	bh=YUxeWiumDIevi3pfAqr7wG32llGuW6KcesoGqx9k/lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPskpreYXFPEIf/HobfVDMl0eiAUoITfHeZT5LaVVUyS8uPrtEMcG6g4MNEpVTgHrhlcdAJtL9p7CgFe3+O5aRFfl4B13QrGohiUK0XONmAiBloq8l6g+xPi+Tk4fFGS456AvvQA8oy7YOamkHIk+ygypO26ExS+M/6CE5mQKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+SyNaH0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+SyNaH0"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65807298140so7666491a12.2
        for <bridge@lists.linux.dev>; Mon, 23 Feb 2026 22:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771915996; x=1772520796; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYuYJwbEOhynhWIFlwCSfc7cGmzyMZHQheg8tgUujHU=;
        b=P+SyNaH0EibGKl5AT0CQ6RZLIgmnPs8rV5ZCUOUZyU3pEdpjfDC3gYmUvJtdPE7T35
         1WrVzUhNosbfpyOp43Ci9IBRq3DRq9cJmLk8POr6Ihuzp2aLGWqBJ/EL9jDvZ2/UxoR3
         Kw02P+Ukjitdbl5E5WXRRCsDVwrqIYKxBqZgYLCZ0xWnwWSEjjpT3WeGZ2sYf905VR1u
         Z2AW+4Hb+b6vHWYsnVv33NKMNVNW4FpR2RdDmcVRoNkgyLoOEJKhv3JuofACPaLpsQ23
         C1IIS4wybPSNejD+5YXF97r1jXSaZ9pESVqLLY0sODClPdZrk00Hzv1IyIGwU6l6YWht
         HFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771915996; x=1772520796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYuYJwbEOhynhWIFlwCSfc7cGmzyMZHQheg8tgUujHU=;
        b=PZMjiTCaAUySDHRhWMU9GoYM9YTwW2anvLb7NxDEqqHWkI61VLBp5paex+yAf83byC
         +EGnANvsJdAxbotuw5IrsTSEdfBRDiCx/Qi2CHsHtXTWweHaBEFXTRpGn9u2sm2/NE+i
         spsQQUaO9M4+hY6/KphQdaXsru2pe1aU4hHjLIO5RRvtPj6oCO+rN7+MP4L20fZCyIQq
         UJqE03M8fIwneCnm2rf/4eMRLLE6YZhokpc20vlicK4pCVMaFztSEPZXgMzEqRD6Etcy
         wpeh0d8tEKrebaJss2VP1IvvR4beBZBEcQEIR4fl6HZwsRH0B1gXRQDQp6FjC7Z4nIK5
         OuTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGFF0rXnuj/RLgptBlnp87xGPUMay/1OvsN7nALD5iVitMYzcDSRzqYDMfJ5NHXyuJnan/6RA=@lists.linux.dev
X-Gm-Message-State: AOJu0YwxCk9xvSIG6jeis3t72KTkAczmdQgnkFCKZoFxPNfPVZw8SI5d
	ssFPditbe/gPOuNDCWVEgQFK/huyPTxma7ow/5riq0XEOh8Pkv6PW5Fv
X-Gm-Gg: AZuq6aKBiNd5aBrXzFO19Jh6pAZL0H2OWU3mxGI7RIGcnS/A146trdk0h9ciBSQV3hf
	jtV63kX/18XjXTBCkBpxpHf5Be48l/lRFF9Qraf/otPOozKJ56QBYtZGyrg39+a1OYmIMk9znw+
	CUZBNwLjt7OfBi1Sm6A9AHXC7DsuYLYlHtd7qoeaU81S4X2cUHC5mtifopLvvVf4sY8k7I/9OxZ
	FKNVkWsz8gsydHH1zbHPsjoS4kHMJeJBylZ750ndbTtAth9A6plSqBXLLyuQhUrCiKnt1Y8vPzH
	T3bL1k9prR+BYbDLmQ7iad6G61fmBoH3JmcpwSTMekXU/f1XPjQnw5Hc7C+yXQa8mU682B2YnQT
	8DyyFYVdnGVKpsFAPuZtyQ928v7AYtq1qjzmF/baKkQ894ZF5pn2WsX0axbZsszvkXJY3wTDL2V
	T8PJ3syXcPb7sxpq4T3M4OAwPxrbUERNq39QuDH2CRd3L1OaEAdZqtji/eEW+/rI378i1dHiOGs
	HvUYeeWN1r0OFNUbm8tZpjvCtdoyNvxcqOYFjlifyP5b5DCxVBuqU0=
X-Received: by 2002:a17:906:c08f:b0:b88:5b21:b162 with SMTP id a640c23a62f3a-b9081b4e959mr536995366b.28.1771915995872;
        Mon, 23 Feb 2026 22:53:15 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eaba13866sm3096698a12.18.2026.02.23.22.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:53:14 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v19 nf-next 2/5] netfilter: utils: nf_checksum(_partial) correct data!=networkheader
Date: Tue, 24 Feb 2026 07:53:03 +0100
Message-ID: <20260224065307.120768-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224065307.120768-1-ericwouds@gmail.com>
References: <20260224065307.120768-1-ericwouds@gmail.com>
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
index 008419db815a..4f8b5442b650 100644
--- a/net/netfilter/utils.c
+++ b/net/netfilter/utils.c
@@ -124,16 +124,25 @@ __sum16 nf_checksum(struct sk_buff *skb, unsigned int hook,
 		    unsigned int dataoff, u8 protocol,
 		    unsigned short family)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0)))
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
 
+	if (WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0)))
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
2.53.0

