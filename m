Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917CD1E492D
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240773; cv=none; b=A1C69L70iaXOK9AI8THO5A2JisJfummYzuFk0IfItxAHvYWDbF+bYIHpd3P2q6IrkaEiHjOfvSimXUaCYgBCahx01DLbRF0Cv5SCjKsM5qYmCmdcmV9AZdBw2UHU95hzUYtpCtxjWN4IjlWxBAn2Plt98K+AdAtZ88NZqDhbnLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240773; c=relaxed/simple;
	bh=BvqBAh9vpYpaQZe3zOQxhCXX2RDxLCUEfBQIamImBGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4y6EfGNST7EP+SC1qk8iBs2j5EeOjHz2kxye/8ZwXulPXtoH+JJsTtZ5ZpvRK4UAvAtSRMseJq+WvJAaJ1OHnhMEipR6OhgOsFKId5PtOmMn+1TeDiB2IHPukpfFY6Cfy0DPMQiO9s4PymMsbnXEpeR0TrUFy9EsAGyB0Eekqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZiCryfr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZiCryfr"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso29788131a12.0
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 01:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736240770; x=1736845570; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IPV+/btLneRoSo5HiyXyxa4AsB3fEttv56AKWcCbic=;
        b=HZiCryfrkfD6Cm+kGDhOLG4quBZPHZYewigxbFBIVQeZu7RXIfyqt6S72eIUh/LN4y
         GKiT+VJ8LoL+qv5W7z+ZiWoI3nJc6SL/Ro6d12IYzbzym8AUCHp70Hp9Y77qNVQugfMr
         +spZSuVFjBtPN5SqUUjhuAre4wt0GAjGrkW1YXT2ehGw9kD6nGYTcxaxUwIKlJ/Gjeu4
         blOYMWo0ZQZhyDNwxqVQpKUS+K+MVATl0oFiJwpzeqHvYYGv+GDGO9QyLgt7ri8WFqmh
         qX9V1oNiXkaRfNX4gIXNmlRSXnunhcRUkX4X18ywlAxZYF1mvP6W6f+BbZC/NGJBhvh6
         npxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240770; x=1736845570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IPV+/btLneRoSo5HiyXyxa4AsB3fEttv56AKWcCbic=;
        b=Y6QOZgb6Oae4M5f1HulvMfFH9IuV7ztBzmzPklcLu4EslmIBaUz62zEcnRM+q5RYEB
         I6ujfC2qN+ESknoAV5CvrvYMeLKPqgvwZ3coC6dhbBCO/q+O+pQmtmS28pQbUFAghbao
         iW68/6rw03jvRkMQP4ZLRBd1F2vJCOGdwjShBA42RzibdUVpcTrwnnMAq6AK6rJ0dImi
         uUNvdAVx7Ok5pdLmkqv5+dmVWnt9mxWjSAYiq7Ohe60Q3OZLajN3gJuh9uFdy/Un9O9u
         t7LnEjrlYjAtUPu+vYli2x0t/aNc93iQPUG6dnqq/3ZVj/maKJ4dmfVGgFOjD4Zcja1P
         Vz9w==
X-Forwarded-Encrypted: i=1; AJvYcCUDhBxNn2MmofAAe8sjttTjYJxtGuKvl1GN416HQOCFerl98Yy40y/VwuyIetwqHJlqtHZQwhs=@lists.linux.dev
X-Gm-Message-State: AOJu0YwF5sCeBX4RyV+g6TiIKXutJcYQuCINkxwyZcGjZoQQfTHG3UmE
	x5cZCh2iZ+UiX2pNnACktzDc1jHGhq0jtfTYZKYMDwyeqL7Z5DXP
X-Gm-Gg: ASbGncv7Zy7YCJ9ZxHylhbq44+fb1B60zzm7rgWh7wEvcPOFrrnuMUJyuZuxIR12O94
	dSuP3AZzddaGni4GxMq7NF8FNOxwao2PQqDdoZhp7SVKbW9kFsXhaCJhQrZ4dS3i4I2uSGbfAmM
	8OD9hj+RY3OamQDjgUnh0N2WFgYdcj/2BG665hx5/4avgdklEmn1GdvAOJs16qUKXjew8dfFWS+
	2MTp+9Fre5yL359HybpKvn9Q5SFwsTALUIqfcbjkD2hp3PFVMtkz/+/le/b7iCOYEeQvIcPJ9Zh
	6tXlaN4FjJOs0BvOJqwHYuf4lgXJgbT9axObSe+Op7H722XuOwzkAafZMGGxJ1I4mWlHCKxkBw=
	=
X-Google-Smtp-Source: AGHT+IGuwqZCeoYTDAlGotcMA4hMjnDwkRNwCsaQvYcPeOTdVvTuTBvdK5LwWWAVBu+HrkBFOHXWUg==
X-Received: by 2002:a05:6402:26d1:b0:5d3:e9fd:9a16 with SMTP id 4fb4d7f45d1cf-5d95e916b32mr1930324a12.12.1736240769741;
        Tue, 07 Jan 2025 01:06:09 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f3f9sm24005333a12.23.2025.01.07.01.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:06:09 -0800 (PST)
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
Subject: [PATCH v4 net-next 06/13] netfilter :nf_flow_table_offload: Add nf_flow_rule_bridge()
Date: Tue,  7 Jan 2025 10:05:23 +0100
Message-ID: <20250107090530.5035-7-ericwouds@gmail.com>
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

Add nf_flow_rule_bridge().

It only calls the common rule and adds the redirect.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/net/netfilter/nf_flow_table.h |  3 +++
 net/netfilter/nf_flow_table_offload.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index b63d53bb9dd6..568019a3898a 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -341,6 +341,9 @@ void nf_flow_table_offload_flush_cleanup(struct nf_flowtable *flowtable);
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
index e06bc36f49fe..5543ce03a196 100644
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

