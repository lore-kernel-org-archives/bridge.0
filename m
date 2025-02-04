Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562821C9FB
	for <bridge@lists.linux.dev>; Tue,  4 Feb 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698604; cv=none; b=jdgtYa+wF3uvoF2TIPH9BHl4sWyL5pIQSf8CFXpekAPzJkaEdykAh4B+u6Yyqqb6noKbai3uO/JEYrOxckKWV792y1kzIQ73gb/tuOy8Igo9s8E8bg6CMHimSYTM0nlwIo3sus+hJbPORtb2RLbNNfctTsFyn9KgqOoTAUI+Ro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698604; c=relaxed/simple;
	bh=Xmg/u/sY6eLFrKn3iN8YG2bBcM9CQwqTudcQRkmzqU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfPxZXfjnUZP5cT2DLlTWDaFs1PQGtJ0zm+eBbQTQYeo3BadOExQ2x/geFZ8M7cJv8raw7Q4W4/4mn+9YkJKlhxpyWrQtvP3NUYwBEGrmFZFgoFl9VrE11eX468n7kzPHfej5C9iU58Cn3cOlhAasbDO3QYjfdfmNFkGLxKXI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCxJBLn+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCxJBLn+"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so248524066b.3
        for <bridge@lists.linux.dev>; Tue, 04 Feb 2025 11:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698601; x=1739303401; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pk+qY6px5gG3FxqwFvW1Op3xt7LAoxtK3/4BHj1Cflg=;
        b=bCxJBLn+GtgOkRyA8Zw60Hcql/99dBck9+1RichYJd7S58UHEmr4LMssJvKNtL81QL
         M8lRsL5fgkKdNn5+6CRvYi0fNtWPqb0gpBBePMadiA39I88PjUFGKjTEwbZducxpkr3E
         Pc7OlX3EBxM1JN0GV2aMl+/lvJyFSseiAL7JKER6bwEdIFD7GK0V0bjsR7YIxHvOKNLS
         mTiip7PSVTIs3Svw4c8UQ3H9U6bvJJtk64wUqBzLydmg6brv+ZB1LekL5RkxL64I2dDx
         UWuvndSFJDKRjah+zYY8fNNfNoiGxZB/F7Ih/XHKQsfXygK8+n1t9J24u3x2dVDJ1UXj
         CREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698601; x=1739303401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pk+qY6px5gG3FxqwFvW1Op3xt7LAoxtK3/4BHj1Cflg=;
        b=lETGSXS+iIvlrankmGOIPTbbRm1HJwkf+SUdVm1Ykp74ZQ3SqG9ErcFyYkxSWhtUtv
         y4ElFFUugfUM7bL85TnLzXDCeZEIQgwUyebv9H0Cl7XrVAYr7TAOkz6NHwXe5Wt7LUv5
         nyknwfJaxp268qvIAaxarTS3tPq+urMSiq9DYYgf+FXapz60h/3JE1BMwxr1eyquioKo
         vSJNkXlGDyiBKeunjNMJZDCqya9JA6b5M/i+AROn6tjwvRJMdcgidDR5XBtAVSzkksMW
         u0KulQ4N5PfluN6I71ASyM+bZ5g7JlKG/Jq2iYZomgtJvr9aM03Du6ewDLL5FITw3a8t
         Nlig==
X-Forwarded-Encrypted: i=1; AJvYcCVItmbpMTUSgVffavIYuCJ49IUsjNHth+dZLqcALneQKvzbX0iMoxyu6cCoHp8jAIwirSCSmYg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4LBNGpLyjX47ZokP6JdLpcMMv4uBqDc8cyKbOhXF1KyKAU5xO
	Dhm/UfvBRcLkUIIcHN0RpdCHlA8i8gyw6+sDzYm2TXiG4hdikF9G
X-Gm-Gg: ASbGncunhJEmcL17cXePhyZQSfsrDFP0XJkdlyVQtma5eUK0Qn0bwW6P1P4iiHGWuRp
	5hq0xD1DMDf6UCUwfCDb9MLgL7Khv0CfK7Wj1fVHnaMYoHoaHZurRj7mKI41NNqvTibN7vKGdye
	y0/RuIv0xDTaK0Rkb1uVwPBgmGHfdzBRdkZHvaQGOOerlWAStbgOiRPhlKJV6R03/18gXGSL9j+
	pDWHa8hXt2Zl6a2Pf7T6SGNDmeF3TFC5jgRkhyOkqmmIujb5MxV37XF7soez0jfQz2Rx6VC1tfY
	rzVxn4OC+IG5Vs/5biastarazvr1g1IQDQEt9VnMTEBkBXFZ0bBo+Ck5f2QgAgk/87zWrpbE3JV
	1QjZTu+IBHV3Qf6ObZWx45ToIeZkD90qn
X-Google-Smtp-Source: AGHT+IEajcS3ZyEn4iy3BF71r5OWuaA3wC0VPy1tuH9m7gdyTO3QjqxLaSnyY8eDmuFb6ii+jRnHzw==
X-Received: by 2002:a17:907:3f11:b0:ab2:d721:ed92 with SMTP id a640c23a62f3a-ab6cfdbe5a4mr2881889066b.45.1738698601046;
        Tue, 04 Feb 2025 11:50:01 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5635bsm964684466b.164.2025.02.04.11.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:50:00 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v5 net-next 08/14] netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
Date: Tue,  4 Feb 2025 20:49:15 +0100
Message-ID: <20250204194921.46692-9-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204194921.46692-1-ericwouds@gmail.com>
References: <20250204194921.46692-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow a flowtable to be added to the nft bridge family.

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

