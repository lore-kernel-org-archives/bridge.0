Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EFE1E9B01
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240779; cv=none; b=tREroru1Ouh15GGvLUh8BGfh80DbarETnH6a1fs5nzrhS4jkXVcDvjGLbVmi63JXj5S5U1fUGEGTwx6zy7/XEdNovjkSLCJMkrotcS30l1jhNYVlZzcowGIdcLxaJZLqTNu2arQ9ekTn3vVngEnMQswKcGymPJri/WozjzIiocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240779; c=relaxed/simple;
	bh=Xmg/u/sY6eLFrKn3iN8YG2bBcM9CQwqTudcQRkmzqU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkOhZrs610rSHTfvLUPYgE7A+ACt9OJMosNzEqFwmqtIMRRVDpwuOT0CLI0dZVErWssEi/hI0nwU9p+9n95PlVvi9kSYCAvtvpM9sxjqeQBeH/vcY2vYYKLGbpVOeCMIM5euKsMT5Nwo64L36pXvyzDSibpf0tUMAbmb8Xbe7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3539AKc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3539AKc"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so26710743a12.2
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 01:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736240772; x=1736845572; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pk+qY6px5gG3FxqwFvW1Op3xt7LAoxtK3/4BHj1Cflg=;
        b=M3539AKcBH+Wr/btDmGCRBcI9yRmX75RwlxNFnOiLiquAV18frtDaTXCzNfASOAby5
         GvQMJNGDs39DSs0ihhc15gb0/gN6gpzDiMqTmi0Bs9g0JPeh6bsxErqMAOZPsGT2TPlN
         wQ31YMI1mPpD8xFkpnT5FvQpCEvdybXWWvhjub6z9++7F3Wa1N0sxu4iG9lAFu8bmcHo
         gbOLO1lo1jaFWCs1B2RA+Et0xgxdcvgOexxn/jrGEIol8/3lKiFZhSl84XQsW6kl0+sq
         g2fJa6aFMwZ/KcD87PqPUMlbjYy0luDk5TFISgfGGmiFSRuOdjYfh9xSKWBqK/j0mWsE
         uZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240772; x=1736845572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pk+qY6px5gG3FxqwFvW1Op3xt7LAoxtK3/4BHj1Cflg=;
        b=hrFbAyNRiFeNw7f/PI+opopsiXyxA+ADbe4QlBzMqbTJkeQB5Y782DevMaZ0lfJp7U
         gGJYSh4oG2H4OBpACdntPwxTd5mi9tVXjI3oRGLz6S8kY+7PTy3GdA0f8Fx5q4N7jDbt
         zHPj/W2FTilkAop8/T61YD8BMRtN7Nmwzb705ywAQBoYhmugmBWZt6vhIumIZqr0+1Yg
         KjAIjhYNtbUgO/BwPrVsTwVuZH/EAinGfaMW8YJVy4GoXxa/u/5olyrbiy0OHHhOJ3RO
         cjnRsHErq3vg09lnzEGatV4gXIJRSokmmMV4QJ+HqKdSVuQkFjg8WMmjyuumIPm2RzVW
         0GXw==
X-Forwarded-Encrypted: i=1; AJvYcCXS7Tnye6iy3XoQpO8QwjTE0phk1nLEIMQEtvC938W2KmcdxDkAzB4N09DKN0vHuvcZscrlFjk=@lists.linux.dev
X-Gm-Message-State: AOJu0YzLIVcvTomWE6EQ9F5a+JP+l480JflVs+uoJP1q6Ujlv8huRprE
	JitHC8NGdLIsdLcZFonU/bOa6f1VTkZqJIWNtYAtK6dPWZQGXfxv
X-Gm-Gg: ASbGncvKYYFnK5WXXDVM2nq6/Icj2Ce9FtoHVXhW4lfQmgVvpaQyZi26PUweloHWR1b
	LaS2G0TgqSMI1Y3fRZkxyFTokBVoDr9flIgQ4iQGsmdm7GFqj5J2Yy8FzlQrgAd/3owCmmgyyEE
	SivG+XNSc+h6AQEX5a1igZqPrhC/X+cDebdjENlCSHFA2lLTZ8nKOJ7a5b91C3HmVcvcmtK93qv
	Rbynn3OoOfCPVxeM2UC5CirhOEE9ZxI6563Ws8zVPEtuGoSnTTqq8zP/hbqw4N9GQ7b41V6IuEq
	l7nGxqJQcIYMeYMvjb8w+YwKpvhBaEJhsYnBqYvy5InG65MOuEDqV7FuM2Xib0Zx80j4e09GOg=
	=
X-Google-Smtp-Source: AGHT+IHcdg7P37o5nMvJ75yJzAoKxUItlEfQvHhKvQ23cSiQG4/81rp2XgnxG7pSjApH8tUEJOEr7g==
X-Received: by 2002:a05:6402:35c7:b0:5d2:728f:d5f8 with SMTP id 4fb4d7f45d1cf-5d81de16998mr67591761a12.27.1736240771891;
        Tue, 07 Jan 2025 01:06:11 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f3f9sm24005333a12.23.2025.01.07.01.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:06:11 -0800 (PST)
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
Subject: [PATCH v4 net-next 07/13] netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
Date: Tue,  7 Jan 2025 10:05:24 +0100
Message-ID: <20250107090530.5035-8-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107090530.5035-1-ericwouds@gmail.com>
References: <20250107090530.5035-1-ericwouds@gmail.com>
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

