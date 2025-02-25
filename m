Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A71213E74
	for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514597; cv=none; b=DumQIDecKLwfwVgNh1BJRKxtnl/Dy83NekUTItsXoVsjAzullxEBczgi3fzfw3qFmPqMxWa9l8lDAl1+fF0YezOS45Mlwtttqi06Ci9oWPcZbE+aY0He+g5lhxw8pP/G7KXp/CsOaDs40dqKiGafCFAMl8tq7v03u2QhW+t/rKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514597; c=relaxed/simple;
	bh=p1IsKiAxwq12F2MM7ABxyO6mLj6RlYFe8Yg33MCLfXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+KLBfgMtpf2fKO0Jcu8xISHC0BZTF5M4LovO6i7i2sSX0MkS8ubrTOv/hh8p+OxMC0X5yB2vO/gJPZ6phHyClv+1dyEBwIWCEc6R+rSv4iAzvzMwGbS0F4ikDj9q7P0QGQzwtemeHEKh/nXJxi4YHQTF5YhroXnH+QUvamId24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=au1DUG/t; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au1DUG/t"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaec111762bso407725066b.2
        for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 12:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740514594; x=1741119394; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAJ1+kbz8lZ4YwPg+OV3VOfAm0Jd01XhEIX1QeYwh3U=;
        b=au1DUG/tYXxbY5pbtGY8jK4aAapV7bz1nXe7GhUJ9FwrS2yphN495q73MmTKo7sE3v
         xvsA2n98FGVaUEI/DB9ytv2HZNS/+6eNAgnpM5gdKn6s477/1KFm73adRytJymE4rrRL
         MUJ4gAxv6aDUhtcrht/hT/EDqK4ywbMcvGXT4zfVegO3kISWskaq9edwe6N+KuWGE0jO
         nPOHkRQs0r24bukVi3ikYvcnKIHnAtOsY5AcV48WyFeLCiDuek2dqXyQMDFUjxtx0tD3
         PrzIqiztf3SFsN18ieKzLcnPxMhg3MJCWllOb2OtZacbaTTXt/QFokEY6JsFZFx4pN5E
         POAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740514594; x=1741119394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAJ1+kbz8lZ4YwPg+OV3VOfAm0Jd01XhEIX1QeYwh3U=;
        b=wSBVSPF31iHBs4Wqq81225Ioa0VZ7gY4O8+JGRfLUnvgt9n94rpRmdIEKgmv1X4TjB
         eSXPbhGGSRGOdQPg4FTaK+FGP4EkjqDF3SaZLG9ahMpg+cEUk592UJoN8t9zcwTX6Py+
         y4M9HowKTMKMFCfFJ1WLsbcUEn6n2BOcb5qfly89K3UOBuoNyesFjREAZLpexDQEtTyb
         RkbkU55LSFtGWiP6ZdOjoGCm0/QUSdtzyN0X1T0l0vxx7dF4SxdUCOdViNKocTk3qX9m
         uetszJgb1JcfB4JZsmfRBTQonFq/Y5RSH31hEbjawb/wO8a+NIErKA7bJz7YEv3mwbb8
         2CuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNPNwLhBr9hzlxuRoqs1FVTzQ0IhCV20lMOW+Zc2kjWWAZqEhICVBMCoUOPtJaU0wrwiTDPCA=@lists.linux.dev
X-Gm-Message-State: AOJu0YzIoRF8PrfdcSedS/7ZTm+bIS0XaFAbuXnlQjcYKRM7ubfRqZFy
	2KDPbGWzKlyR0mBizAdbGmtAp85fdrVONxBIRr7Fkya+U+R4sSyD
X-Gm-Gg: ASbGncvmV5bKRdImySedW3y/X60mKuFOgwKINv9ZStMhAR52VKRA61r7L3F1/pGnlqW
	S4i1QwU+ND3nTXa/4RhlU8g5RpnfsUZGUGTseHdR+FBHSOy9unjifptiWn3WI397DKN11whhVEC
	cPkE13btzHA+QEu5ZomivRojoJmDg6FyuRLdfvi6sGIUN+oq8OVdtxGQH9uYmSfgsoL6J/oBvV2
	h4wl3D/xkaiX42iEGnF77krx5p1HjQGGu0yaxOURCs1eaI/q2wokppirEsmcg80OuXbHp53MV7c
	+WIGw4fYkPdAV0JX4jD9/JHujv+Orunqnhs/Qn8dMhGBjCb2uaPODy6yQx0IaeV/zK43MiRBH94
	nqShBQKFCCuPzv+tkBvpbQB7admtqM7UDCsYPBUW1ITI=
X-Google-Smtp-Source: AGHT+IEwV1DfGXJRPjYjfUai9IFb7gVR/sM912MZVVj4qwykjTK4A5haj0vlM9CKbuHOZqsSxaDDSQ==
X-Received: by 2002:a17:906:3181:b0:abe:ea93:2ca3 with SMTP id a640c23a62f3a-abeeedfd836mr54526066b.29.1740514593664;
        Tue, 25 Feb 2025 12:16:33 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed201218fsm194319666b.104.2025.02.25.12.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:16:33 -0800 (PST)
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
Subject: [PATCH v7 net-next 07/14] netfilter :nf_flow_table_offload: Add nf_flow_rule_bridge()
Date: Tue, 25 Feb 2025 21:16:09 +0100
Message-ID: <20250225201616.21114-8-ericwouds@gmail.com>
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

