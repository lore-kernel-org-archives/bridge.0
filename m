Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7D20C023
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170618; cv=none; b=kigaoNsD0L55gY6UxaFQbnB7fec/eOoNpInZC87iLQhYi6cG/8aFqXnxiKOyF03oAd5JI1+bnIe0qmcnBSp406D+aZA4AotCWZbK18lujaSymDAn3Dw60VZ5AMOTMrwpnZshcD4pt1vVt/NHujT82SZPjqqIjGmgc5m5JF0iz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170618; c=relaxed/simple;
	bh=AihhYJGwJTJyObdFZSI/rxytC55wEnFe8EzDy7l8A+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kI0IQ7L0qCBuATOF/ewrUnYtgLE+Af7fAnwMzAS+k0kdUxKdflWw5xZkjVQSwRujyDIQrc2Cn0N59qBYLou4yZxRxUJznkQIT8+K2SRarhxWcqutz8/AZVdnG8LwOExD24JBZ9kR7PQHdZKcqybyaM3GRSj2cvN4XY7C3FEIZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOvoxI8v; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOvoxI8v"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5050d19e9so8565062a12.3
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 02:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170615; x=1741775415; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/OfFtkDCpNUsNNnB4udxCcQxzWSEZIHYYoj3YjYWKw=;
        b=EOvoxI8v5WdjZw2PXPO0vF9xkvZOFGqJvMSECMoIrJBjtnBa4yVYKnQt+GKm49bD6h
         ZY6BUunLKgzMX9a4cCIBmn4h1DFDG7ySgCGKqCAUT+HcKqw87xQx/iDJSD7fcTF2SDC1
         vRUoX3IAny30+p4n4Gth+iu//y4J2ej2fLyZWB/gy1WnI1T2XaglVUYGrme7oUJKOMU2
         MbVESzdPKFUQcECiSJ4Rico4ADzVuHq/9qbrrH8vpBhSabZkodYzz4egYGN9UwiSZOTB
         MS5xkB8vll5TcdmhAmebf2ELzmjyqVstm8tVa4/GyUOXmkStQsDJ4b/gBc+t0lE2h69M
         O2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170615; x=1741775415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/OfFtkDCpNUsNNnB4udxCcQxzWSEZIHYYoj3YjYWKw=;
        b=DJ85SxNw13Z2aLy2kxgDqwddpJY124uLyCeiI1ayDWpTQJAhFvIpJSYyaZ7ThKW0Hc
         xvvmDAFvTesYEzxqvT7d87xS1XxmJx8J2e4tASOOIRI3AoPqX+2K9m5la5KrUZ3sMnA1
         jzakc21XEu123xQqZ9J3hU0pJwyFYiMejorK7QtHKHPhn9oaThtkPmOeCl7mymN5HJrZ
         QbPXIKvRlyz2QzFN59U2jjA0Tgp6/lC2R8CXKEkJjkgOIRg4e8o3fw6/9RAOt5FR5Id+
         TWlxoSf+GnEQsSNdTTpZEm0wNVEhpiuL5cPyz4ttLrUap4DDyNJoZVNhodzeCxrferpE
         U5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCX1E4SWC9vyk9+NKZa97d9d5UUdNhncMp1AQeGhj8NPSPUSUufIkspnWOytEpVf5joYOopBLQE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7++zkfsHk5/O+Eu4l3+EPskmiwztKEjZSZjgp8XYEFibSUfRO
	fkyeXs6yiBnrxQFTECKVtUoz5pYJCF0WR5qW2ccdNRsdwPibr+7b
X-Gm-Gg: ASbGncuGTAOwLY36rZFDV+LAouN0oYYiePybyYWG2cwcHxgcvnC2cI7Lxy0EWkG7hSB
	0aiTEEmWzK00X3spoZlIKVS90yvNhtjSwCBxVVFF1F0evLBhDWJtuI9+RyW8uzjzP+oXnwG3CH6
	CF40XWnin0k41Xv8VaVpKH6rS8qNC7VwKZKOLjcGCZE04U3NBd3QZseB/40Gv4ibWFSv26Mf3Gt
	84dFXx/qFGtv/KVYdy9bgMGKnlMxbEumNzYBwUDWbPXUUeTuSK1SiKymoibxjJLMmcF+bP67W0Y
	hHKOlUs91F5AalTAoJkA7yrvG9t6l9Rjir1GOxTF3Wt1EbB5j5CrpFXiKCUouf54qNoImNUwKDV
	BXQt9x6hpzgPbxFVRiSCc234pHK03mico+RogsLoF7G6oSTH/1DxvFWxq8e38cQ==
X-Google-Smtp-Source: AGHT+IE4FBEQwtKjza4fXvfpF7ocHLI/77Iaa2ed5/2y+GnUe2UR6+/DugyKaB64GhmbWBt7MA+dgw==
X-Received: by 2002:a17:907:9726:b0:ac1:da09:5d32 with SMTP id a640c23a62f3a-ac20d84621cmr283526366b.6.1741170614628;
        Wed, 05 Mar 2025 02:30:14 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1f7161a4esm247154266b.161.2025.03.05.02.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:30:14 -0800 (PST)
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
	Ahmed Zaki <ahmed.zaki@intel.com>,
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
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v9 nf 09/15] netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
Date: Wed,  5 Mar 2025 11:29:43 +0100
Message-ID: <20250305102949.16370-10-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305102949.16370-1-ericwouds@gmail.com>
References: <20250305102949.16370-1-ericwouds@gmail.com>
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

