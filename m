Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6447827D779
	for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773793; cv=none; b=rvORA2+VEmmvsMRr4MUrrz5nMjaYM3qdFHAAXT7/caO193/6oVf1YYF3elsOb2KSnlMwQIEmmQ0UGol6K1s6CEQvZDofuxkKHL4zg+Vjx3bSacZNjkAh9imFbSyUQ/lNhpUm5cMUAzh+UGOowEvd26+kNLnBpuZtQAlGA1m+Yj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773793; c=relaxed/simple;
	bh=AihhYJGwJTJyObdFZSI/rxytC55wEnFe8EzDy7l8A+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMugv3qpjieDzr8Q5vhSwUXFpBeDVGjUijoCJXTml6aTO9L8dXCg2ExRBsjcGhEBUU7MThUqEW+5qXn7d+nxh2GOZ2kD1xWUzz8F2t86jnG8Rv0Bdhndn8kUm7LVEZ6sTucyJfXy+heDcPgv6UhSVaC5oQfEQvKXy9KYGaSzsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5lng6iO; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5lng6iO"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb79af88afso466880866b.1
        for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 12:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740773789; x=1741378589; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/OfFtkDCpNUsNNnB4udxCcQxzWSEZIHYYoj3YjYWKw=;
        b=R5lng6iOMnOxzuCQAOr4PuArUURwqIfOmLMPjUFe/vGbfFT618WrPdK+swlznYz1cq
         D/4Fj5IQREacG83A2UfBy2mpxtefTlXpVaTMVN7w+6tIj1rwWDt7FQL4FisY215kRwrg
         Z6MLdhMDe8wh/3dm3AI1dCdw2SqDs7INbqrLvWC/NXW5uk9qtugeKFQZ6/jUTiFoTE2P
         KI8ruPo6EOMfPNNknl3shD4CX427uT5BUqmQjUvcwydhyDuZlCoOK1JO0MsUX2eko1b9
         sdJ+Yto33idmsxWEC/V2BSoRTzuGR3cIbrqMq3AN+HNK/TyJhdhkSgvQcfCb1XvXapii
         bstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740773789; x=1741378589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/OfFtkDCpNUsNNnB4udxCcQxzWSEZIHYYoj3YjYWKw=;
        b=iRhEHInm54tnuSMT7HaG1WkHpYZzq37OAajuoNDGjK/ZlApPESgqDt6BM8a7LzPEo5
         w6OnCtNocsGu+A4P2QKyEg7UDp/5QRXcI6nKUrvxvNDMkR6yz6v67ul1MW2XDIGbc19s
         oXh9Gx0erd0rq5lTU6mxFA9gmPNliDLtA6qJZ4lHlumw2SDn2CDP4QPTS3HZHBqacgXM
         Tye6zelqIqKeejuKIpPVaeywUAXq7/WW4yaT23AgLQSHl609DKZox53hQ1eC0IHTiVr8
         UnPwpoOElJGudey1eIIU31pPYKb54X4ssDUn6fu9aVvCEh8Ca+5toZQWMrvoh6PzC4NO
         qOdA==
X-Forwarded-Encrypted: i=1; AJvYcCVE7dzefPD709QSSK2rpZKc057b76n9Edg7TAPuMNc+Buvt5Y6v/u53HageAEaGYUG5VDZvFls=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3T9aKz/+rj7ut8Y3WAoTgiK2SWvoUl2qpCXgXOMxBvVplVCl9
	BQmoDhg7dBkEz6xp5hMohSfo3huHGhYQ/tb0G1bWeodwyxnOcGgL
X-Gm-Gg: ASbGncuFjnRST5vukzAUpcpxSFTM3lnMAGngGRuKBUyBSl7Sxs5LNAtH4ZGM4l5cElr
	ykgp9/olC54MpDXav3g+lJ8Xnt+0mEHAUaysfdjifclxqqQbG6ZXAd9majxDLFFsKBJqjhtn0lb
	h8rOOuUGBPvtq/8p5U01NflXkcAHyEN222O3QXSkxo5SB4oEQ5dDOsAY1bqh9qJHk03mlvvI9Xi
	hAP/5Csa8eZYf7JzUMEOcsfnrRf2i5GXpY3FndqYAT8DcOHtoKrjWhvq5cq6EwdlnpWWEffpfrh
	C9wjBqz5IHp1rQTIpJ3vg7J2RxI99Pi9xCgcTLEU2CLRewxQDzFIRS9XecnY1q6dgQjlol/FYTI
	LM/169r1cIL40y9wtlK1BALb3idgtxU02wsEdCFYcmc3NQ9KmgSumRLvz97fUcA==
X-Google-Smtp-Source: AGHT+IEQAXatFYtUv180Nd/vAAtHbNFD7uOybxHOrydax27b/c3kzdKVO8+x7rEp/205E7ETT5lLSg==
X-Received: by 2002:a17:907:9620:b0:abe:f8c0:c1ab with SMTP id a640c23a62f3a-abf265d3be4mr498901466b.46.1740773789267;
        Fri, 28 Feb 2025 12:16:29 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c66sm340812666b.136.2025.02.28.12.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:16:28 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH v8 net-next 09/15] netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
Date: Fri, 28 Feb 2025 21:15:27 +0100
Message-ID: <20250228201533.23836-10-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228201533.23836-1-ericwouds@gmail.com>
References: <20250228201533.23836-1-ericwouds@gmail.com>
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

