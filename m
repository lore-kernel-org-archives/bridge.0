Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7831BC066
	for <bridge@lists.linux.dev>; Sun,  9 Feb 2025 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099460; cv=none; b=LMwKOkV32sKr0EQVPwbgEdCYUQY54w93nHzxia+F7fOf6is76vZ9eDm2JYZyGe0Wo2PsdjVxx8Ct8v2cu6IeV0hUIpFlO4KWHPOixfIGOy2A5ZfeXK0Qks6oBReQiOV9AKiEfngsRgdaTXNl6+4Gid2i2Zcxc6fmjt7nnGf6acY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099460; c=relaxed/simple;
	bh=AihhYJGwJTJyObdFZSI/rxytC55wEnFe8EzDy7l8A+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfUDjW2zseL6cYnz1w4NRGMaombXGPbXEeECpWG3PCBU0msAaOqPj+UOK3r89p2SeMvtTLpuLTjFuQYMYqoovoUp+AF3zsD6D9RNDnInhz1VeHq3CC5yzhP3bXxr6gtk4aPB0wamOEEHpmLLTAMvEg6KW+GpqoGbX5mrzCfZ0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ0lRk9Z; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ0lRk9Z"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7b7250256so49418166b.0
        for <bridge@lists.linux.dev>; Sun, 09 Feb 2025 03:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739099456; x=1739704256; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/OfFtkDCpNUsNNnB4udxCcQxzWSEZIHYYoj3YjYWKw=;
        b=FZ0lRk9Zas++WYnFaA6sfhjdfWcxZsgjmb/rTEMgtXW3thOfc7ku9FDybTpGUh+pkk
         hovWLwN3n4Fq3DTOjfAVDrX1QDE37BBxk+7PX6Y2MYLoKR38YkTqlkrkPOhlWcneZvU4
         1w0veOjVmi6WiGvI4SZ5oLord2eSDHohRCx/TBntbExwWGV8JwhPPhe08Mx+163RP42g
         mZ1lxjEhEbOh49lgXNMgjtparZSl4dc5J+QBvSI2PaQfX5cNEgCRe/mbZjlwqammSTo0
         qWSYYAi7KRuUx620+aV/24ZbTrdee80VxwtTSop5pHeNzXxOqjRPa+NCSztniOo4CrJE
         y4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739099456; x=1739704256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/OfFtkDCpNUsNNnB4udxCcQxzWSEZIHYYoj3YjYWKw=;
        b=dQ2PfS1Njpb+AW37aqKvEehmaqRmT8Z/19xa16itbZOA/5MLPvfzUGJfTpOBeI+Af0
         GaZ2gdiuAGTOmoafGHXD+wKUtFce1tf5x78U/xi5mtCu7RivEhqAWitD5FLBGERcu44v
         zG2Y1o2OOLXxbqOImnItoUffHksE5BbZE4WYapnHJDzVJ7Ve3VYhAZLg49c3Dym7AhQ9
         0Ih3fN+DDDK84R7d1ezRn/5C+z52qEa8X2AIAKJqEDu4JA7ra7MCrjQDc21QnWO4Eo/P
         uO6A0FYokTRu9sMF6ErGRqGudWATEN3wK1u93n6FbG+88mPjL86fMRztACWGY5V67hDJ
         9j7A==
X-Forwarded-Encrypted: i=1; AJvYcCVEuillQoGZLQFW1+r3tIkdhptFPsExyuQfJA9fco+Aqcs6J6ABli8mixAQHJB5dcatBAH6DpY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9FoMKfK3Xwq3mjD57aQXPAcrM6Ou0m8SddiRStSN1zkTLPVWg
	jHod0e9lx0e3CETDmVVu90VFBODwa2ZHcegoumWaxTFxhZ6GAsqn
X-Gm-Gg: ASbGncvAuE4zFrVczBYR6njziH8c1/wV1W9HmfmoiYwaNhNdkcI+nTdIfjYxcmS4usz
	g1nr6VCCTqSMBu2DvXU7cQKfatsyRGCpTAizA2AW94hu7IOVRn3j1kOF46+vwxn8jE4Xc1FsRGB
	BjDCHomozoNJGGWV3rwGBEcOYmyA9A3PCEVIwi2aKJaWGkrC7/3WVxZJ8e7N5yN5Kt1J/2TWNoZ
	Wiq0CzGWZWgmeEEKzMywHKgbw0frce7cmb5fz0+c4dD3HaeGiOSPFJ0+lqkzrqDto0d+90hGozd
	JclWqgRTp+WhkjqWQYtEOagLQsi8mrXBs1G7uN9L0l87lIvEYGcGYMytfjpW0XvyvAReBc+uHuD
	z2XpaXIpqim6mk3WQ3aAJd/GJayYdh67T
X-Google-Smtp-Source: AGHT+IF7fuTwyISchVVytHDMJeeoIfh3ZpQJUt8rRdvlwIphExmlssHSJ85LTIMEOJAJqtrSBebVEg==
X-Received: by 2002:a17:906:31cf:b0:ab7:8fcd:1f1b with SMTP id a640c23a62f3a-ab78fcd2196mr966938266b.7.1739099456462;
        Sun, 09 Feb 2025 03:10:56 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79afc7452sm357516366b.163.2025.02.09.03.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:10:56 -0800 (PST)
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
Subject: [PATCH v6 net-next 08/14] netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
Date: Sun,  9 Feb 2025 12:10:28 +0100
Message-ID: <20250209111034.241571-9-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250209111034.241571-1-ericwouds@gmail.com>
References: <20250209111034.241571-1-ericwouds@gmail.com>
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

