Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD521C18E
	for <bridge@lists.linux.dev>; Tue,  4 Feb 2025 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698603; cv=none; b=MRR1eocsnNAiE25qp2RJTBCiciyeep1iOcsBoSrohzsKm7CiqkItr+UAnJmrnVWxYslX1hcKswwKGeau2ToCTrIk3/LuOD4hHlHyRkUD8uWVstTEO637Fg4drRhERE5G26LS2JT8GnY+RmfFVuXjLLU9I+e093E62nO+sfQnPZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698603; c=relaxed/simple;
	bh=o5uKTl7le41zF9aDebFQ5O7fq0HuDrigyuv2o5ox/jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crVL9NZwKeTHT+g0jQMtRcUpOHhMx2c5SuCeYdbBnb7bbBh11g8gwBXgRo9kmtUlFnVInOhRxwHEB34YtDlz7xEeFz/quRVPeJksn0FEC54/sLvgOpV2c4XGB0jCI9PdSJfOOs3GhvCTTeDFy+y4gDwMvzNiIJtAeIYNT3f9hpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyozyemk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyozyemk"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab737e78900so377504966b.0
        for <bridge@lists.linux.dev>; Tue, 04 Feb 2025 11:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698600; x=1739303400; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xE+ROyc/mcQ2fBT7crVscR/jU0rSEqZAJgDthtdCdc=;
        b=cyozyemkZ2AlSPqv3xuJuTY+tGU4iuzRK5fJEUkQWuwcCbTmj0+jk0QcI0doiA4s47
         H+NiG9SHHuCt8PJrIcTu8yg1NS4Hv4WryYd7AXEHr2+mm2/n+6hxj/riHlG8rW1+KA8v
         hXA29rRRiqSltuOh20LxTrpFksFUk4tQuJ/JDuk4ZllK7CahxCJ3VYd/jgcyJdksKx9W
         eHSl0FIeT/Sji1ksbO26ID5Gm+t87UTIEqwn4NkmgLUd1QC7eI3YAiGtokqxh9VuoF4r
         lJFYNdpGpIDG2CSOYDyh6mS2XIDdiNzqCE9dSJvliUsKdIb6pgHTCOL3NNKoXpQml8iG
         PetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698600; x=1739303400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xE+ROyc/mcQ2fBT7crVscR/jU0rSEqZAJgDthtdCdc=;
        b=oF84in7Z+dDjT+hw/b0JUNenbWpmCXeajCPMuXnbCIAYt5ASWHOy5rxLCfpmwy+zEQ
         4/Zf0MoyMVhGmC3P92O05PoMurUb6b9b4VNl6fSIEGCeKonyGAYHyUfnKd8jZtngx5gY
         jLkR1GIq/FvZcDWbD57G4jVd0sF5Ly2+/epXidodkLBRW50d7QMU6SdbjhHQ9wXUUoZa
         INhgvWUvYLCFNLlL4SVTw6YH8kFLEx5XTlvn5HDlnxTdyBTE9+NFeJhGOydCKHBgWFYL
         0l4wIDKrpIZfbA/qC0pWzRE9gJirzaz1K8oyc3QkfwjM8qCQ3LHg/7+9cUjCkZ4Pz3qy
         F1CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO4U3iIXrl4WiHeNfJopgwSSy+aFJh731I4iu33mFbELIUCMwUldRts0mncVk6dJ5RdNaYgXg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+EptGPeUYPrnwzjgESh76fSeVpOTzGTFhdQzf1s8zFYkWhVT0
	kRKO1Ju2cNm6uNCHeFtPRbJvW7C78e9tr1ZPLeT0ovImXi7oG9dQ
X-Gm-Gg: ASbGncurPAtMswCFXEKR0aYLaymfvEdNrkLm5MxPqegWReiqFeu7buEWqpKuAAY4NDR
	guZ1mdUHd4iD7Suaeti/p0aoU4IdibifugmWvPGSpZ+kdnHAEfa73pNkZPeBHWnQFId0OQhC+4O
	e4F5AYlkn7TJzb/9Q7v8NWMXANLBca23lH7NLBOT72nbkQ1q6I53WHkh1sw+eXLNPA2spyfBlwV
	S1P4Fwuu2zk6W3qFTYRs7uZ8rtaTCwJFCY4/YpGfoX2KC2owMHZJVG/gCKtSfRjjeyMAdtictaa
	avRBXmGZ/AsHAi9r+6IJK7fwJJGOl/PAfG0R6a43+5LgQRnL6kzMFPJCF6EkfNjIAPnZMoVgcWA
	gZyKbAVCQAe3F/v5CCZ9laBwTfs+B+Man
X-Google-Smtp-Source: AGHT+IGHC1MVQan6DyAcHVPJFsYpMQ/lz7RSHxdEh7BdqhTUwrDVwvLIusKNv2NoZZcDS32oCD5V0A==
X-Received: by 2002:a17:907:3d8d:b0:aa6:9503:aa73 with SMTP id a640c23a62f3a-ab6cfdc5f5cmr3418392666b.51.1738698599948;
        Tue, 04 Feb 2025 11:49:59 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5635bsm964684466b.164.2025.02.04.11.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:49:59 -0800 (PST)
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
Subject: [PATCH v5 net-next 07/14] netfilter :nf_flow_table_offload: Add nf_flow_rule_bridge()
Date: Tue,  4 Feb 2025 20:49:14 +0100
Message-ID: <20250204194921.46692-8-ericwouds@gmail.com>
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

Add nf_flow_rule_bridge().

It only calls the common rule and adds the redirect.

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

