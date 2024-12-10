Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506EF223E9F
	for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823984; cv=none; b=FKAgNUSJsliIBEtLCrQ7wzCp2iMdvv9Pb0gB9yYN4sOPNhnVgBuLTddTqAQNcbYZuDdAnX9NQhxpwkmB20yr+4PM1JDzF42f8ztjrVp8Jj2FjCykS/GXCghLpDMMUZZGf5+QJ64qaIGLx29pCL8eAEyQVwu0YaHKyI/A9baqCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823984; c=relaxed/simple;
	bh=BvqBAh9vpYpaQZe3zOQxhCXX2RDxLCUEfBQIamImBGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBw4+cJEjNvcUbvobdfgfDGzERUbxnRy0dCcdALyC1gc8Ne90GhkDwNLD/+Q37+3muVrlBkehl/vvs/obCCTE2Uzrw81bwc4AwGWbqY8ze3y+BBw85YwyD5A4JOh5ppLXi2bGGsPixUxYz7af1bTPK08sQxHIwZk6AXsrX8bZlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHso9f+r; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHso9f+r"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so8353457a12.3
        for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 01:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733823981; x=1734428781; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IPV+/btLneRoSo5HiyXyxa4AsB3fEttv56AKWcCbic=;
        b=VHso9f+rRlXOOYuZO3sFJIWfHXk8TKhJiVRRBZZ1bc8TvTG/YpjumPOP8p+CER7PRR
         olHg6iyOCW7fAQTFpCGxggh5Y7kAqSJTEv1JFXjtIH1pTN8+dfRSZKB8quKG1teL2cs+
         POZNw2IVB6Pu1WWqSjH2d6gHCfv/GFeUE/G3Q5Iw5GQflI+wNrV0qOSIjL2DgOAtjRUV
         drdS3k6yVZvb8cBlxcl3LUhBcQKRDq5APOgRaeRsSBCM1W0ZaWKEXCkxbxHGwaWlMzQN
         ol8UAGG7s9aI/xYXXCfJ+0aNPlIJ6LszaXoP1/HaG5hJMqMeGbNyWM/8hShh3No/TqIb
         LVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823981; x=1734428781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IPV+/btLneRoSo5HiyXyxa4AsB3fEttv56AKWcCbic=;
        b=N0FB8HoDGmi9LraO7w7hs6X5zW2eRpeGMjQfxKltwBp3w1EYTuyaSALmziQZgLrZVY
         CqgcLA27Xr/PKwqDfSTgbGEQBBV9vgoyLTKSQDkSeORK6eCE3r/kwtpYj2R7Bj1hij4z
         WjnA/cvV5YE2CzCWzWWEM4+AihiGtfAuXswmgJA4MeXawfnIGiX7kG4KCBTsH8WTXgs/
         XNhxcpAhGPA2pHXREbXvYf5UHf3YBkDxhc5SZC7r+8CLe2wdk/8rH6oLvA2f4x4VdgN1
         Jp4L3fpgzHc3SgJFVJFXnL/s2rqB7bB+yqxEdF1+TzUCnu1I70DJ4QKNuvnC+/sc9SiT
         mp3g==
X-Forwarded-Encrypted: i=1; AJvYcCXyWFabkVYFcFkpbMrWHrB/qS+BQiUW7v6P6RME9i+MCXa1tkMqpJ80OOuDAJz32eEDHfEUiMw=@lists.linux.dev
X-Gm-Message-State: AOJu0YyrLwobbZbPCRkP4Mop2QGuqoTdC9gbuw1IjxPazxv5KmSjy4zm
	5wHQekx4UZa2DSp7VLkEdmWkwwF59mDQzvYZqr0atXlbXj1mt8R8
X-Gm-Gg: ASbGnct8x2+mcJbieKfSvU6qB9fEgFuAK3N+JTKRiu3OxD0dhzWH/nPsNtvVoIvi+Oy
	b7s8TP9MQMCGj9jzt0giIUweO59EXyqCtGh8pZjknODuS7ixXklfyKbLBQQQPa0NbfewihcKFNG
	PGoWczJr/v38ggeon/trfwA5v5sXR6f3QZPCqVyWX6edv4rR1iuEvMLPsGiyV6h4komZYZed9Yu
	1FwuaJg8D0d29kXpon/BRbQCpi/Z3m1HH7zfL5P5FpZ1V45Mctz2TpN2TMe9u2V3sINJgaUfJDR
	qIFd07AUnR5Vtx3GgYVqdAP/NiiNGRK/muqlgls0GEB2rKDCfP/P1x3ScCKzYbxxoenl49E=
X-Google-Smtp-Source: AGHT+IFjT0LuXJIh1LnKJhzqy9wN2HFcOfLo9WVivfUzaooRucqnpDZPHXE4LF68gVbRTOO3lAb8JA==
X-Received: by 2002:a05:6402:42ca:b0:5cf:c97c:8206 with SMTP id 4fb4d7f45d1cf-5d4185f8686mr4106270a12.25.1733823980513;
        Tue, 10 Dec 2024 01:46:20 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b609e56sm7313936a12.40.2024.12.10.01.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:46:20 -0800 (PST)
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
Subject: [PATCH RFC v3 net-next 06/13] netfilter :nf_flow_table_offload: Add nf_flow_rule_bridge()
Date: Tue, 10 Dec 2024 10:44:54 +0100
Message-ID: <20241210094501.3069-7-ericwouds@gmail.com>
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

