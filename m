Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E722CBE5
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122507; cv=none; b=cOeGtmfjcmsvagjh9ruDGohs8KMYuJpR946AOPfd7FRhsVp7VOKCX79QmeMq1gtHFEj9VAl68CGqe6fVorxntGqBwumV7szjNTk3lHwuwwE/dwSKLq1GSFGI9QAD5t2WsyvDExH5nlUYnPB0nEWpbvUTRwbAqs0h/ULeBLpzePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122507; c=relaxed/simple;
	bh=AihhYJGwJTJyObdFZSI/rxytC55wEnFe8EzDy7l8A+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URStS9NjbNJcDeNxPBLvDPgcSgK3lDmYrih7x1mHyyN8VDUG7WtdV7huddX64YCEisN0l2F0n/TY8HUUWqoms1RI3Q6ONZJr4CSRLzHwo/0vomDCFDZHs5iEPJv9ZjtRkB3Tfqwfb9UVQY8x/LoYgZKc8PrkmaCZ4jQ9+J8f0Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NntW1koC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NntW1koC"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so8251132a12.3
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122504; x=1744727304; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/OfFtkDCpNUsNNnB4udxCcQxzWSEZIHYYoj3YjYWKw=;
        b=NntW1koCnF9yFx3y3PeaXUgYY3kfiNjeDJz80I9qpRId13Je7BdmmVmiKipeduuEu8
         9zSbPiLS/mBPhZAXhDDmFy6/8oXjuDpe9qkTTlNEeYQFvRq2ZwT9s5B2ZvYEm7jTvkKO
         +uzH540ooEmG3k0StlFg3K7w3laeDb/IwULKAZ98FdEeLD7wgbPvkV1Gm6dRAe0iOnXY
         +9LXR1x5NVxUnDRCSLnhQ1WL610RtJ04bnQT614Z6VgqBMg3L8EiBb1iCf/GQfo/aPEm
         u4KNPcL0FqZVuTACaftUS/jyxaKWj94/2H/cPUTZ3kAPyhF3GhrmcQBY8fopi3PypIau
         eSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122504; x=1744727304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/OfFtkDCpNUsNNnB4udxCcQxzWSEZIHYYoj3YjYWKw=;
        b=uH8IqZw0yQIwU3A4bpsAFNPHC1y4glJyhs+wrkF8kDyQL19cGvePzI1fyMRO7gToz6
         xtNW7IXNrzJcuXzDaSFpH/cVRU7hLr06NbdRGRbcLWJEaR+ugw/5gwwezt6xTYCwlEEJ
         CD1Sertllc6S9bxM8vUkjMK9etRKQk5m0iyEjufDXwtcPI0hP0aH8ZSXLOXqLGGIklgt
         +Z/D7UR6GTR9/RQ16izcqh2zdDfsFAhVXVao1iG239P08L7KL7N5KYD+JmR1Kn/xgs23
         5TEziB2YO70xfszKU4ocnTMWZiFgJT2Y6ssqUvkc94RcXcmO4sf2WLynHM2GSMdl08Sk
         pumg==
X-Forwarded-Encrypted: i=1; AJvYcCXfKIdNfrxJGgNFiVpyTXt5JjNwq4E/AQyXHlupb/624a7rVHQRUW8DKbdDixwjcddByyE3ucQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzWloKUMaVMnrzKOn/th9oLb0U36fJrKfnuHlY8ukXG9/MT1cEb
	PBgz+aIeJ0rxykRWHA6yqZ3Axv/gn/Irnm/KaDrolGLNJOv8Tgq6
X-Gm-Gg: ASbGncsgNl9gwf7Xmr0DT2DO8lbWgG4w1AF7jX3MPNo/HHuHRmFPLc6rTdR8oDbh6rh
	IpXkPHa96b3lpLtbgdmfcvwc7WwHNGVpAJFbM6UGGFDx4OcGISfHEqmlYlfQm1qXQ4WkG3rIJlR
	unAPj4RbnfZktbYM3YiuNf3ZF1oOfOdcWThxG61wv5+ca5F2JthvBKAyQq2qCb/b2S/NjqXPui7
	o/5m5CmRlkaNY5yeoVQ8b4x9tRIM9MKQrj8CIu7Fyalu9Hw/cg0uhFZ1wRCKqBxT5tnSPRgsocl
	FUtJz267SSg5nyPAvRD8qOGa7a6FX42usHYRohuss62IEBXpllYRBbstMgKOxVdsKMKO4EHmOFb
	vUzeV2stbGJVHn/B9Ef7F420gtAUSnltJlGM2P7KsoRiiILloIrlJxw0OrzBxEfuRNVIzTYKwpQ
	==
X-Google-Smtp-Source: AGHT+IE8DeF9/ROALbTtdtAvbb+dCnvx2F7Ufu1W76Y3vukns31S/rwSv+gn+OGIBluIbjgDwHlDpA==
X-Received: by 2002:a05:6402:510e:b0:5e6:17fb:d3c6 with SMTP id 4fb4d7f45d1cf-5f0b661a45bmr12658780a12.25.1744122503881;
        Tue, 08 Apr 2025 07:28:23 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f1549b3fd0sm2236164a12.35.2025.04.08.07.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:28:22 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v11 nf-next 4/6] netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
Date: Tue,  8 Apr 2025 16:28:00 +0200
Message-ID: <20250408142802.96101-5-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408142802.96101-1-ericwouds@gmail.com>
References: <20250408142802.96101-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow a flowtable to be added to the nft bridge family.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nf_flow_table_inet.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow_table_inet.c
index b0f199171932..80b238196f29 100644
--- a/net/netfilter/nf_flow_table_inet.c
+++ b/net/netfilter/nf_flow_table_inet.c
@@ -65,6 +65,16 @@ static int nf_flow_rule_route_inet(struct net *net,
 	return err;
 }
 
+static struct nf_flowtable_type flowtable_bridge = {
+	.family		= NFPROTO_BRIDGE,
+	.init		= nf_flow_table_init,
+	.setup		= nf_flow_table_offload_setup,
+	.action		= nf_flow_rule_bridge,
+	.free		= nf_flow_table_free,
+	.hook		= nf_flow_offload_inet_hook,
+	.owner		= THIS_MODULE,
+};
+
 static struct nf_flowtable_type flowtable_inet = {
 	.family		= NFPROTO_INET,
 	.init		= nf_flow_table_init,
@@ -97,6 +107,7 @@ static struct nf_flowtable_type flowtable_ipv6 = {
 
 static int __init nf_flow_inet_module_init(void)
 {
+	nft_register_flowtable_type(&flowtable_bridge);
 	nft_register_flowtable_type(&flowtable_ipv4);
 	nft_register_flowtable_type(&flowtable_ipv6);
 	nft_register_flowtable_type(&flowtable_inet);
@@ -109,6 +120,7 @@ static void __exit nf_flow_inet_module_exit(void)
 	nft_unregister_flowtable_type(&flowtable_inet);
 	nft_unregister_flowtable_type(&flowtable_ipv6);
 	nft_unregister_flowtable_type(&flowtable_ipv4);
+	nft_unregister_flowtable_type(&flowtable_bridge);
 }
 
 module_init(nf_flow_inet_module_init);
@@ -118,5 +130,6 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Pablo Neira Ayuso <pablo@netfilter.org>");
 MODULE_ALIAS_NF_FLOWTABLE(AF_INET);
 MODULE_ALIAS_NF_FLOWTABLE(AF_INET6);
+MODULE_ALIAS_NF_FLOWTABLE(AF_BRIDGE);
 MODULE_ALIAS_NF_FLOWTABLE(1); /* NFPROTO_INET */
 MODULE_DESCRIPTION("Netfilter flow table mixed IPv4/IPv6 module");
-- 
2.47.1

