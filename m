Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96761C8797
	for <bridge@lists.linux.dev>; Tue, 19 Nov 2024 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011571; cv=none; b=cOnCXN0cEB0yQi+j+DhRJCyVWncSCV4RcrB/k78VrZgX+ywQ6xVHitU9hvJr1FkI9HRsxH58iXdbNYJTqklOI31rukpHSOmMu+qfrr6tB9beQaFQ9H/PkXo00g03IbeankMzdxV+Nk9xrvkh2BsAOx/tUlTsbm+7T8xmbNQ3AYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011571; c=relaxed/simple;
	bh=hGsEEgBwVWVwF5UUBIOEi5WjCie3Q/gi9JKsnhC1X8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpJ+BSFNcJFyyBHsoskF1l+IrP9+eMXu6wJfV7BxaT33SN+ARmBXX1AUuJkJI1bHWBbu5qlupyhPJPa5PAwvphnD5TyStP1iuAlFoVYWEhUMbani07fWuoMsPermMj0fp0qIpMdG2v03c7D13Ft3Dz8OGQnskp2KxetVtqPj9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMjSq/WF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMjSq/WF"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9ed0ec0e92so428322266b.0
        for <bridge@lists.linux.dev>; Tue, 19 Nov 2024 02:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732011568; x=1732616368; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdMZzUqlItAKYCipC8R7CKRW4bj0To7qOhyuRvVgeD0=;
        b=VMjSq/WF1WO5ztbBGNWwoJEX7gDtJ35kqxOAoiYO9skydI+i2krIAU7KVHJ96CV3M6
         G/rCPOnooOqi8u1cMOZ1QfuCXoTicXV9PCd1gY332jrz7MCFht8n2L9oS7W661SmFH+1
         hxlFlkW0E7BKhpD9c+TVv7AFSaX4Inc0SISm4kZwW9qD6giW8agFRP/Zf4JR85WOi/BP
         A2U2FjdWZ13iSj3vBGTxK5NfZWCGNesv6fSqR2EG9h+i2cj0QCDV8hdLdG1SAVOzdFDu
         EGTRc4CVU8DFyDOPhsgC8HBM+0wVLnUPHugneIEYDewmjtl6QdpdwcDVHrGZbDi4eazM
         O5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011568; x=1732616368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdMZzUqlItAKYCipC8R7CKRW4bj0To7qOhyuRvVgeD0=;
        b=ORDlxk+rCIkS2MhSO1HtRDyTHwRERTDZwf9GI4Ujfx4ev4X/cyIkgTCYFXGMBx7fpA
         gyTkq3VHax+2eNFcnqI3p8EH+FTwDNqOd6sXx7dEVD+9K/mLukegKDeHhjdkXymzy2Fo
         5+4CdTmjenyU6Gv9tz3VOtLuv2fLODTDYgzYNnFlliqIH8ddg9WKNIXSFlRCH6bjcB8f
         QtgjPhca6fmspeIDb9J8dE6Xa7ZAnG7opPusetQSHskLB7+0NzDMyeUzqBdGNjpMS/ca
         PVrgmVHt28zncigxBG6vbH6Ta6J9557gptum82yBgi5LDXvGQrcEI00GHq+PsX8f4iJF
         iJMg==
X-Forwarded-Encrypted: i=1; AJvYcCXYHC1w+xfi9xl4MmL8rQPdmqp/0WmqI5lhVhZUbNshHPPjcxZhugDvT3xfAOyBeXZyoTueNCY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwDgLBADIYD2eg3tJWtexItmMHerwl+SMlp1jdPc/ZYJ/wrhAJw
	c2Vv9M7SyRHDT8ZY+0ZpXAlT7UkTDAR5jdA5HCvh7DItR3uPT2gh
X-Google-Smtp-Source: AGHT+IE5L4vgeqmlwvDR/7799c7w2L3XGWClbNm8n2h6VzOovB3/FqcYwFKbh7Ag4naigGnLrOKLJg==
X-Received: by 2002:a17:907:7f88:b0:a9a:7f84:93e3 with SMTP id a640c23a62f3a-aa48341a1c8mr1497903766b.14.1732011567950;
        Tue, 19 Nov 2024 02:19:27 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e081574sm634875566b.179.2024.11.19.02.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:19:27 -0800 (PST)
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
Subject: [PATCH RFC v2 net-next 07/14] netfilter :nf_flow_table_offload: Add nf_flow_rule_bridge()
Date: Tue, 19 Nov 2024 11:18:59 +0100
Message-ID: <20241119101906.862680-8-ericwouds@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119101906.862680-1-ericwouds@gmail.com>
References: <20241119101906.862680-1-ericwouds@gmail.com>
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
2.45.2

