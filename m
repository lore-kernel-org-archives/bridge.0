Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8934A2144AE
	for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514598; cv=none; b=lk9VfusjSaPS0t8ftCYudSxFPv7ADMCvXGeXb4/Md1B+D9Z4/ug/BlcIGVq3mERvJZ2SjZJPSbXM2IhaYTC0VXuNAcrzKW02uKm3icAM4eMctNtNFjqWLS1AMC9jjRY6hkbkCbe7zVjLgrZfUBq/1UQ8Qa8jk/Bq2siaRWrJ/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514598; c=relaxed/simple;
	bh=AihhYJGwJTJyObdFZSI/rxytC55wEnFe8EzDy7l8A+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxQezfL88E5O3V4Mwtc1NyL73+y6RXEOeO6CG4qkagaBVIayx5F55Hd7XT/kjw+4TbPPKJxU+npp30JtBu3jGIoZFOoxgKmyPVcjqstwKgFU5bv9Lsl2uoFpNwd7jVIgAWm2MVsJcZC0p/f2Ly3EMQXpZhB8mG7uMzM6KuN45Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYs9dJdh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYs9dJdh"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb90f68f8cso1149577866b.3
        for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 12:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740514595; x=1741119395; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/OfFtkDCpNUsNNnB4udxCcQxzWSEZIHYYoj3YjYWKw=;
        b=OYs9dJdhqprZZ2CjopYRq7t21uDhI0rY7wunJpKxK/7cdapLG9LgpCJGW/iDw1xpNc
         CU8AYzD2iIOY8Qujf9fhYSXnvXEQ0QEpR2CafXrRlKFAOB9dgBuCNWPM/RBDgc3n7Gli
         AKGpkwa6sSISpB3ddirXeoh+wTVQb8cDyXCP8Qt2xzv1GvL/hYQ7iT/dyHsNYz6c9FCM
         NS7KOyEmpTXKiHDoNU1IvFzO3cxUCwJK5920Pk/eJq1xL4nwZ0sFtehY6HDI2crRqRmw
         emtsestT2xMP1AGpCEGMklrSHwW3dhbAb852xTK8vhLPszp8jJIneKy8KaGdBqcCK+OQ
         0+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740514595; x=1741119395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/OfFtkDCpNUsNNnB4udxCcQxzWSEZIHYYoj3YjYWKw=;
        b=mkFYhQSrI62Zvt0hrPV/vY1RMIMBhl+Oh4yMPr4QW4VLCOrUsTCfaUyectycPiz/yI
         i04iUdIlX8+AucaPqYwxkFw4sE/3bi4xA1WmWsp0YYu2p4AGNm4W/oAKYqKI3k3OGeR9
         hgCcaNQdGbd22ik9YIyW6Tzmznwk/1t+1TpnyKOa5E6a82fr41a/FyEzclYEQQeAmoZg
         GyoUrSxAarywsFqYlZL/6bgPmhVCZqf0dNVK/pzl35hiRvGZzQL3Y2TxqF/yNVJoOwDa
         Uj1V2c5GdMeL0lW85C+GpTWUW2druvfadGcz6iBjwhypMizwGDBRlMETyBL2FZrumKOM
         q+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUT+GONMbxkPqOETFg0DOxt3/gRiIXmpBOcVSWjHAe43Mr4ZPoJ9N7YKcMRG/amsK+yGI5FBLA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9DyBAGIhEtJ15oBgZ1yvz6EkFZd2KMEUmQ7km+wZFb8hYsz+r
	/RjAsRKGnZZfqZdkJmenNdyrVDJH/7GF1ilvdABNFe5W8rRwwh1d
X-Gm-Gg: ASbGncvGJWghswrmZ+ZSkz/lFCr4HrsZJgkvCw7wSK0xtRbzBm+GOXq6x5ssuGj/v7c
	HlRWgWzlBXQrXhVxb22VbDoP1K+fKCj+pHFO18suu2ArYbFS50I0yLLlYu6byCOr/nkf7WSyIGe
	PpyWG2RAT8e36upgfscsBjCwlltFoJ+0yijO8JaQdnMniHLpi5i73jJmpPjb9Cuj5fH7t++4NBV
	v20subJQqVkN8ApmyU81yeaoElraZlJRM36Rh+UHs52qWmWHkNV6bekoFa8oyqrwaqnIsRmzapf
	vyvYMOvOcrBOcFTFoN63ubysK386j5Cq5raxqED2ZSalu9sNouMNRpo2Z8hlow/BLfz8GwOq3Ko
	5xa7EJhBy/rD6dj+vorn3Cd4BlgW+0v039/HNzgba0dI=
X-Google-Smtp-Source: AGHT+IGqtwnhdQCtSmqLRlPPBdMfue3nuq7Am6Qo/bcDgts/ZRrpNQ6gtoEj1aOcPx9OCd4I+DxgEQ==
X-Received: by 2002:a17:907:1ca4:b0:ab6:d575:9540 with SMTP id a640c23a62f3a-abed1076c86mr522915866b.50.1740514594765;
        Tue, 25 Feb 2025 12:16:34 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed201218fsm194319666b.104.2025.02.25.12.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:16:34 -0800 (PST)
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
Subject: [PATCH v7 net-next 08/14] netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
Date: Tue, 25 Feb 2025 21:16:10 +0100
Message-ID: <20250225201616.21114-9-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250225201616.21114-1-ericwouds@gmail.com>
References: <20250225201616.21114-1-ericwouds@gmail.com>
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

