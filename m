Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98C1DF247
	for <bridge@lists.linux.dev>; Fri,  4 Jul 2025 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751656333; cv=none; b=R8jg9xLw6Rc96FYIC7uBgrDkELDBqz8J38WZ5KBGa+BK45NDWY4riGTpNLDHRuPN4stm9TrJLAlQp6JPDoZWKml56w8QWo0V+QCWpS74eHIudFNRXtFMbPDFPT1xScwGKUADm22OMsBBPLTUNEyFOn1Ro9ZaNvTBGaHCT3HtPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751656333; c=relaxed/simple;
	bh=fvcdIZm57nHeXyPVMFTsLNkqJnF7CdR+EZaQb7/o7S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/S16nbRIpq9IAEEkfseKlx0NmeIsMlbfIMVTMk6oFaWvBD6Os4i1sxm2G8s/6CYxHpNi4dYcvz5/YBC/Yw99JcpzJ79p8YBHi8dPaATRb8M6W9IssSRDjTbyu7Zem4ZMVt6ugXbVTsP9qhrALWyY1XsRjcfvw5lBUUUX1S2TZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4DJ/IWk; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4DJ/IWk"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso1937000a12.1
        for <bridge@lists.linux.dev>; Fri, 04 Jul 2025 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751656330; x=1752261130; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXkY2a1ytDNpXrtT0yG/AIElqJZI3+JhPKOh06544zU=;
        b=J4DJ/IWkZgV9JlL8CoZoy9MGa5fv3nXtXusNJ/bpI7RfsLV0uw1kgP1dM/TAua7ips
         PgJTAmJNdHi1DvReXmSuQ4YVAyvUQvQ5ei5nKWJY2+61/yjhYSBglWAPzN8fo2H/dsiR
         SGaH5BT+o6Bjbz6mZSP1LCg0zwz9KB5Ua9Uw9bnROvU6z9G2Wsl4GNx4YlPt2MvW8+cH
         6Na23NlgiwEHkn9Vl4VTCp3uSIQa4+wkVtm45VdatmN3wTasKhFr/edIX7ZjspAaJ9Cp
         qjiIGD3YnGWE01xtOEHQawyEPf0+k92LlPJSyuu42dbrzfwblk688uNcy9CM7cmRqY5z
         dGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751656330; x=1752261130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXkY2a1ytDNpXrtT0yG/AIElqJZI3+JhPKOh06544zU=;
        b=KetbaG5Qa3Z3od1NqfnJ+aDv74/sy/42pBeoTv44JctBlN3JOQTv0q4A8AHG+NzCwn
         eWI4Glk3yFn0UtM7Sxahi+KFmYTm7L2uH8Hgjl7EQeSbP1JsA9FCM+phMp8e6MwGTRAj
         sCG5HhxXjQ+zJHg15EyLRilp4fZL2oDUEhipmOiJXrdTBHb5pH5mWUbPEeHwV8BxbC2+
         hpR/z68nix0KmG7hveEhaYGx44q3S9oQi/xIMvbTPneMD5c6l9KIx06zybe0SnTZkhF+
         vKOXSJR8w9/5A8jQXSYjEOxgs5bQhQLoC8p7wKi4ornazNeGQqjdkY6ovA2JD80IVU8s
         svfw==
X-Forwarded-Encrypted: i=1; AJvYcCWuuN+DgZWRBiKkdlQKYMCTQmqLJNFkoJ8EVUeqd5OqZ7cTsI3A8bT3+lVhcPEFarz2MnUQz/g=@lists.linux.dev
X-Gm-Message-State: AOJu0YxzUGd/OhglHP9ZmpnqH3bRfP9Gc3XXCcDWGqh1t6hfMaddS1WN
	fqzEW2KFPXyFW2QrMH4c5H06HiCDYwVIvaD//RLg8ncWnXi/7W68X6uI
X-Gm-Gg: ASbGncvr5Ex4Zt4HO+zy4KDh755Zlr0+0me1akvmujeNtaq20LHE3Qa+VOpyHjtbCry
	p0qP4bzIYolG9HsvF4eChKCdLAgfMcJuakNgYtHnbE+9d42kmXxL3NX0rBird4DpKY7AsH7OAd7
	hR7Dy7n02krhRU7mLBCyBdk14gYCEQSni3DKQDAGZZLpO4eFfZW9ua9ZEB4UUoaJaEQFjWNnvbQ
	9LJ3jnr26PVANMtKecbJOhctsRHMssrHf3GWXEkyj0WnT9wi7W64pBDwmA0GYNhxNS8n/V2JfLq
	Zp+87sU+XHcGLip0OOiov9vS8ycS8BzZLwbnONIMXNkoZ7wXhPi3Gq+Beh4jaOOGR638qgba6td
	INiaFK/DMjwRn0wynX4KDD7TbbxjhEjOg7u8vCnCr+ETMJUBWcq97Qr/89cUFLnyB08pTj9rvMn
	h8YgMOXpKOTF2qfuw=
X-Google-Smtp-Source: AGHT+IHMZLKyR1a71IPIzjjzB/OGEY+8TxYB+dudEBZs9KdUZ7JSsRwaRmRCmFRjDHMFSzaFDUrhGQ==
X-Received: by 2002:a17:907:7287:b0:adb:23e0:9297 with SMTP id a640c23a62f3a-ae3fe6923b3mr332648966b.17.1751656329451;
        Fri, 04 Jul 2025 12:12:09 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac5fd7sm219476366b.103.2025.07.04.12.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 12:12:09 -0700 (PDT)
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
Subject: [PATCH v13 nf-next 1/3] netfilter: utils: nf_checksum(_partial) correct data!=networkheader
Date: Fri,  4 Jul 2025 21:11:33 +0200
Message-ID: <20250704191135.1815969-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250704191135.1815969-1-ericwouds@gmail.com>
References: <20250704191135.1815969-1-ericwouds@gmail.com>
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
 net/netfilter/utils.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/utils.c b/net/netfilter/utils.c
index 008419db815a..daee035c25b8 100644
--- a/net/netfilter/utils.c
+++ b/net/netfilter/utils.c
@@ -124,16 +124,21 @@ __sum16 nf_checksum(struct sk_buff *skb, unsigned int hook,
 		    unsigned int dataoff, u8 protocol,
 		    unsigned short family)
 {
+	unsigned int nhpull = skb_network_header(skb) - skb->data;
 	__sum16 csum = 0;
 
+	if (!pskb_may_pull(skb, nhpull))
+		return -ENOMEM;
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
@@ -143,18 +148,23 @@ __sum16 nf_checksum_partial(struct sk_buff *skb, unsigned int hook,
 			    unsigned int dataoff, unsigned int len,
 			    u8 protocol, unsigned short family)
 {
+	unsigned int nhpull = skb_network_header(skb) - skb->data;
 	__sum16 csum = 0;
 
+	if (!pskb_may_pull(skb, nhpull))
+		return -ENOMEM;
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

