Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A291B87E4
	for <bridge@lists.linux.dev>; Sun,  9 Feb 2025 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099458; cv=none; b=gpP/TLuP01aDY8yxfT8wZlP82yNQ1urU8GM176jFoiHU9bABMRDEkB43zQRs1imRUACkm8/IdtX8RO79HDZ6B7lgI2LjvGNQ/T1ETxfavKgNcY+qdLLDbfTNNaSIWUuDsBsEcrtyLf3rOP0ar6wIph3CgmlR/bJEwpFrS8xP72Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099458; c=relaxed/simple;
	bh=p1IsKiAxwq12F2MM7ABxyO6mLj6RlYFe8Yg33MCLfXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2Ldh9JpzRaz0rzfTt3GgrnA4K2elyvU9Xpm4dySUc9UyPmwKwLT6UMWJg299gVjKNO3ZhKtX9f5mT3U7JdWgLwi2GafFZX1hTjtwBpcNy92g5aYUNFkDdxC4ICbOuYcDTLKnw+B9MPxhlyqtHyb3Xved0ejU3Mp52VGFz9eGYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnZz3n9D; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnZz3n9D"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de6069ceb5so1603973a12.1
        for <bridge@lists.linux.dev>; Sun, 09 Feb 2025 03:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739099455; x=1739704255; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAJ1+kbz8lZ4YwPg+OV3VOfAm0Jd01XhEIX1QeYwh3U=;
        b=JnZz3n9D3pnjTHyWZwmBEyJhw8VT7cDwV9t8RpSGGQ/izDXwFxEugLacbER+EUTpLE
         8K2xNW/vjbd+tbK/XMrLsEcI/RQmPmDU6C9dx04L66CgEPaIpnMO7VcBUHtMwbqvwbVH
         L9l9ztWw/RE/BRSs8ZUIdAnfeB4ygECQu7cYupiCRdhrefMvR79bDL5EoHy9uJOZDL+I
         l1x8wtAKaFDMqzwyhsTlPGFdVjzFe8ce2zL8fdyaa6GQG5fIDmp7vYaW0IC7jMpHpi43
         b4wHm0WTUU5BjootFSsDBfJMqGn2LUkeDDcQ9qAwc4FETZsNBYF48aioteIJyHwp/yXf
         qePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739099455; x=1739704255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAJ1+kbz8lZ4YwPg+OV3VOfAm0Jd01XhEIX1QeYwh3U=;
        b=xBHGSfSeZqM4WZpApTf66xdolOtzH6oskzroF3UFV3gzmLFPO+87KtL4omj4IEuZJ6
         HeZ7u6tY7XTNwPd92pWiIGW5Viaw+5TTmRBSi/7efxwhkM/D65b9hG8tfLTh6dP5qdq9
         VOFPRaHeUFdVMo2L4NXxNX5FPp1+TwSVMUrXv2JN6X+mcrMZYExQOOxgZ0T4qZLlPTQ2
         4HwKQuGaEv7xHpIy1lIn8yeskTIz1ClKkp3DDqZZ+r0plkhO+CNO48lXnYFsNdP/KWS2
         BSBAj1Xs2qd8dujmIpJDR2We+fo3UM/Kuxv+x2ASYmi6xFxrH0+pV9fPf1V/SDUV8NTR
         KWow==
X-Forwarded-Encrypted: i=1; AJvYcCWXjrjFPFfqNbwaEa7dtHgTH7EQWsFZnvZP7evQJ7jIShex5biuIwH0dTbsby951R/nV5E7g5Q=@lists.linux.dev
X-Gm-Message-State: AOJu0YxVkrq05HhWmArFyGXZ1FKiJbR5s6Z9EzFipR1U3OAPojOFwbzd
	HhXW8lUWvq0QMOOnYsrr2C+032iYFhY+DpWKSU7lvohN+OgBL84O
X-Gm-Gg: ASbGncvFcf5hhYr2Nxk2gfb2IaAGu+XboqkUwj2R93CtPnzAkaFVun06mT6tqpIlt2k
	oE3ST6LWqZFIHrUyVqj80YELnzHLNFq6zhullvuV3Qpx/LcCGyAagti8gwAW+FYPy7lBaq3uc1+
	ltBriROJmpKSM6jIEgVAPcqDAe+Es+M9tkhdICUZxmJf9otAURq1O6lZf7VzmeHdtO3LBwUv9QY
	U7bkxomr6HiQ+he+3MQmoLvnnwurllNkmKKa2C4D9qaJg6RnBd/MWTf7GMS96uUla3KWdHrWIV7
	MtnZIfL9uvOhaMn47CSgkMIETOn60hRiy5637Ro8RtY7ivTSXPV5NRztTErh4M+7XwZqkaTTH5x
	4PdX3KMYHDYVVHesMynyLT2KfkUOcv94T
X-Google-Smtp-Source: AGHT+IETHQR7T52RBo2+4AcJP5+zLkS5jFUxhqgYRmiNsDGC4K0ZODmmfPCzwNhYWr95O8KmQOhA2A==
X-Received: by 2002:a17:907:ca0a:b0:ab7:a318:611e with SMTP id a640c23a62f3a-ab7a3186356mr452158166b.18.1739099454708;
        Sun, 09 Feb 2025 03:10:54 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79afc7452sm357516366b.163.2025.02.09.03.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:10:53 -0800 (PST)
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
Subject: [PATCH v6 net-next 07/14] netfilter :nf_flow_table_offload: Add nf_flow_rule_bridge()
Date: Sun,  9 Feb 2025 12:10:27 +0100
Message-ID: <20250209111034.241571-8-ericwouds@gmail.com>
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

Add nf_flow_rule_bridge().

It only calls the common rule and adds the redirect.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/net/netfilter/nf_flow_table.h |  3 +++
 net/netfilter/nf_flow_table_offload.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 4ab32fb61865..a7f5d6166088 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -340,6 +340,9 @@ void nf_flow_table_offload_flush_cleanup(struct nf_flowtable *flowtable);
 int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 				struct net_device *dev,
 				enum flow_block_command cmd);
+int nf_flow_rule_bridge(struct net *net, struct flow_offload *flow,
+			enum flow_offload_tuple_dir dir,
+			struct nf_flow_rule *flow_rule);
 int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
 			    enum flow_offload_tuple_dir dir,
 			    struct nf_flow_rule *flow_rule);
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index d8f7bfd60ac6..3cc30ebfa6ff 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -679,6 +679,19 @@ nf_flow_rule_route_common(struct net *net, const struct flow_offload *flow,
 	return 0;
 }
 
+int nf_flow_rule_bridge(struct net *net, struct flow_offload *flow,
+			enum flow_offload_tuple_dir dir,
+			struct nf_flow_rule *flow_rule)
+{
+	if (nf_flow_rule_route_common(net, flow, dir, flow_rule) < 0)
+		return -1;
+
+	flow_offload_redirect(net, flow, dir, flow_rule);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nf_flow_rule_bridge);
+
 int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
 			    enum flow_offload_tuple_dir dir,
 			    struct nf_flow_rule *flow_rule)
-- 
2.47.1

