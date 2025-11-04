Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22C2E6CD7
	for <bridge@lists.linux.dev>; Tue,  4 Nov 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268298; cv=none; b=XEuGEnPrSYE4TA/8Y1Bp56usk4rIRPEaKUbkXheR7sOlxv9jNLm48cNynR4cSpoAdXJ3mYizwYAx/2kKs8iS7/kDFVg2mg7+yQQpyXbnOyhVIxV7B/m1EGS9C1r4sm+X/fcc1ZFk8PmbfV4Sj3f+igl0whFW4RwiXk0I9828dI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268298; c=relaxed/simple;
	bh=fdY4s91tI+lPau1JubbQ0x8fEYiPT2Mrr0LtPH6xCk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTps0R5uoyIC2k3670dZmLTyHniFjLnH6P0ofCIYouqRnCTcq3y74yimh6xJ3uNTsAIcdVKTwS3YjXRNJI3FU2d8OQjqRtZ8ZUN3oviI68rDyD9ZNgoQ4cbmoKX4ARLjumQXNLuNpDc8Oimm/uMjy9UKV725mO64gakLMPA4JII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf64h0Pj; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf64h0Pj"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7260435287so29960566b.3
        for <bridge@lists.linux.dev>; Tue, 04 Nov 2025 06:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268295; x=1762873095; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+3n/wt4G7GIqXmLm7jMx2L0Drt9lvIRoMC4cC/d+Ac=;
        b=Yf64h0PjqrCSKznWs+BLEhnieO61pkoGdhitZLR/8Ez9YwPau/RMoxsdtTz0uFOjTk
         uJItavEVMY8qPc1QL7Tc/4pAruckkHTI82T3eS70pj5VnpvB9C6zQ3MWbLMN9x7Axd0Y
         KRoomjASftBwNdSfJ0Q8BnNiqBJh3A4OO0XiFHohsLcrZ/iZjBTx35MiNXTkhV+bxbIc
         /kjo6UOCeXQRSGJDwX1kEh4l+TZJKOYRTVgcW+ZuvW6Lhwcu49ABlX83J6vTvV25Mxts
         fdJiUbkiWqTZLVwaeYVg2GrpcwrpP5teYVOE/7WPQrVMqMzT2/lxkZjcLtFlK0qbOHgQ
         ghHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268295; x=1762873095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+3n/wt4G7GIqXmLm7jMx2L0Drt9lvIRoMC4cC/d+Ac=;
        b=h5fyELXQPFzw6sfV5cQGolyvxSvzMsDHtCJxIJ/YAEUe/wSB1CO7QacAjl1rdnFCEh
         GJKL53eK6MJgSnGjnIMdUtv+fLIWcsepFjm5WF4k6EYZT5Y1Vm2EbbmTv4F5r9WAYBqX
         Kj5/KhCXhZVKPYBuQ3SeON7lLf0Q6NKkksS814iJuREndZ0Gg3kXCnzx8XtVPP/muMHV
         zZa4LZ9244EdjDq0qSA3iBVwNCLTY0uiIY5GRVsL+ZCCi/GVtt/9UZ/ogttUoQdMY7e7
         /MVwdjizDStLqpgngffWzU5ufRrjAgHJJG0czPY0hk+1t7BB02B+WtkloBAN9oyNUSlN
         C9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWuGpdjtSiYdhtswQbQwWWI7D1zQXjFarqMfuLBXpqDOV0vsjVPQAAJXFk0fqd2WOOppCl8dFM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzn+4Wd6K5ufgB/8DTg7Pu4SQMV+swjfQWzt/mDo8dlv62HNdIL
	EeJEOcHh70wtVuc7BjfCk7WZGRIAinH/H4TWJRElcJxkODJVSxwepZTH
X-Gm-Gg: ASbGnctRX7513eewmR5DjwCwtHLKisHxyoaImvh+SCrEVHQwJRFCTmH5IeMRtPEMLVR
	QJpszUzcpOEzJ2COSL66oxBoz6jeJ2s+gZrebeBnkGXkiyTW8bxmPAfLvcUIeE7QF5LZo/7A96/
	qusN8VarmeUq6ZycgbyfxxZg7J+/qAZInEHYInEEoJAu9q3MYVv7xMPYjUzKQ14dNEX6f7tjqF5
	Y7g4mLkVWED+uQpALXgMHHUKf6lg4Wo/FdTYx1BhGwdSL4zGGcv0eYG4JhxmXt5GaiVD3wLp3lh
	XHt+J6BGBGboKGfbol4XBL1zUhlFNcnPQz0dDLGjsJRmUVedqsfDmFGsA2N/ooJ6RrJKBuWpyUx
	OIOFFH8/z5KLGYJ7b/iSmyPdpvfq2PV9U1RAdCNfX76Ks4KACbYA4Y4jRTgYVYFa/Yk3XTxCz+4
	AJ1go1Jk3rxBwfAqOZZMSDAheDtlQbfD4vWfr2XDBFcGW/LF9ByTJF02Jaru4pjMUkz93/oKd8o
	RlI1cUoNA==
X-Google-Smtp-Source: AGHT+IEFzOrWccwmXLur6i4lkRajTpgN21ZDLR1W8fqsPoteNCqgZfo226NwiSt+ScF8uclULXwnDg==
X-Received: by 2002:a17:907:9448:b0:b4b:caf9:8cc4 with SMTP id a640c23a62f3a-b707012901dmr1744890766b.15.1762268294801;
        Tue, 04 Nov 2025 06:58:14 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2560sm232681666b.46.2025.11.04.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:58:14 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
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
Subject: [PATCH v16 nf-next 1/3] netfilter: utils: nf_checksum(_partial) correct data!=networkheader
Date: Tue,  4 Nov 2025 15:57:26 +0100
Message-ID: <20251104145728.517197-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251104145728.517197-1-ericwouds@gmail.com>
References: <20251104145728.517197-1-ericwouds@gmail.com>
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

