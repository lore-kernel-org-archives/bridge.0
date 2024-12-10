Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA122F3B0
	for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823986; cv=none; b=WoxVVS1OrRFWG2Uql98sS9I95X2YD2NKqIUpYZiYNLIZCF8OZaI+SZfY+To0g2wzEAMyxtzF8aJpM+7vEqZfbdr4LjXXoKEnudiwvUw1yEEM60HeqoPhgSjgc1Oq2Bma8g+AADm06zS9t/nTjNmx0Y8TCecgwEKxhhX9jMdNHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823986; c=relaxed/simple;
	bh=Xmg/u/sY6eLFrKn3iN8YG2bBcM9CQwqTudcQRkmzqU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKIPVlwB6hL1SgxwrmvpTtoBGP6SodNoL4AIWJqUj7coD99ghXbxXFM1zjuhh6znNgObrSRvI/KhMhK4a1upRD/31OFO/pXK/zQ91jkV3XRFZC2Jaz5K3Gkdm0iOvTjmUcES1nkx9YgN8HYY/XQg7t0eTnAheNr/d1CXFNEOROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RemfN1p8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RemfN1p8"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d74363cbso5305327a12.2
        for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 01:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733823983; x=1734428783; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pk+qY6px5gG3FxqwFvW1Op3xt7LAoxtK3/4BHj1Cflg=;
        b=RemfN1p8MqSy6bQrfmZTvdjSxeoOtgfeV5RTXEEgE+Hh2rsi4i+f1Ox4jUXWtLVkZh
         Rs2/HfFOfuMose9hSSElihl/Usy0tANeGzbyIkPyMD+puhO7BrIqXZEU9FESLyuBEp82
         VAyGUvB4tFiEt2jOytKaYeZharKMHOpb3ZgLhaz6LxTqLtY28aefeBKB4WtBNANYJlHi
         4wJ3pQGj3FIekUqMFd4V1tj9wN2IX8OoRLAbIEH65oSgDloYVl1SnBtVQHQ1XbNzqMIg
         oHRjlT3DLNCCxXyhov739DCUXeT5JK9DCxN0XV15uuMpJc4S5lf07Dd5JN4IboxLn6kG
         xyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823983; x=1734428783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pk+qY6px5gG3FxqwFvW1Op3xt7LAoxtK3/4BHj1Cflg=;
        b=M0jQWjvIGaPKdSGZYBr7ecirbYXgP6vrhML/i2TP+ddvJu13Y5Pzv3bV3WMmODPiJr
         S9yyQ9nwxEYLdkITwp8XcI4MRHJ3//V5BKgCml8ZbMnye4hC1bqoqYKLtan59AHC6y10
         ESuLQ+8oLXqH4xPshKBoiaJWSH+Zr2jDpUHi7PUxaBOM0mj9ShvkTUYxHUmYbHJ1tjog
         k2heuKhjLKJf6mGlbFMQ8YIVgXzktP79RbFxM3N+rd7CUFvTlOWKD09oObNTymLSpK7F
         gwHS+dhr55WvRnAdKa/eXnoplVZDqE8DRboAzlPU4zvUaucma4BOJf0f4go1/F9A9bAy
         m04A==
X-Forwarded-Encrypted: i=1; AJvYcCXC/z4C5f2RgBvGCJOodGp0zJeVdV7bP8PnROTZBFCmLxsXp4Qbmk6fihuH3CgX7hBc7eq61iE=@lists.linux.dev
X-Gm-Message-State: AOJu0YwOH37CV7ZJqq+iih7POxy9btd6+/B8dNWbeBxP55+UVbuZMA1Y
	xwMDebzbUJ5skeEZjcPH829UhVaV6LsIWd29mKrPWcxTh6DSMBwr
X-Gm-Gg: ASbGncuL7oVTQPvbVFE/C1Hp25oqWY66xfN0ktvk8hQanSDFx3MgVh4RzSL+W85sTYF
	Lf25zLi4FdWRhZN5md/StF9jMFebS7O11wOs1WP1iLlIygbSgGVE869XM00SPltp9C9Mgr99ncI
	JLJWdwuf54G70w5AiVnO8Neim3QFRJ7kfaXniXeYBcUCPlpwnE3W7fPvOhGf6wrUu2x6maDKMz4
	zjlhrMQtlYBVrUoCvJGsGU8v3gLxUR+XwnWYyboIm69Hz61sQp8g+LtTxCLcttwsUgV2XbTWJ9G
	U75nQ09dBPt5I6g+VhHTc9DVBL6RB4kHv04PI4CkavPZoAPmB58iP7n9Ru0EROZEZOoYt78=
X-Google-Smtp-Source: AGHT+IH4EN2bl4nM1hM4vW3lNE4AbT4jAUoKGNPh+jpctdHbiWVvzXPjIW3iNo8T8bSk3yNngjltIA==
X-Received: by 2002:a05:6402:3484:b0:5d1:2440:9b05 with SMTP id 4fb4d7f45d1cf-5d41862e405mr4691569a12.28.1733823983340;
        Tue, 10 Dec 2024 01:46:23 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b609e56sm7313936a12.40.2024.12.10.01.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:46:22 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Ahern <dsahern@kernel.org>,
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
Subject: [PATCH RFC v3 net-next 07/13] netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
Date: Tue, 10 Dec 2024 10:44:55 +0100
Message-ID: <20241210094501.3069-8-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210094501.3069-1-ericwouds@gmail.com>
References: <20241210094501.3069-1-ericwouds@gmail.com>
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

