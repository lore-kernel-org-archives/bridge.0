Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A727CCE3
	for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773791; cv=none; b=q5tIitEmkdk9c1fBnLr2DmlDWCSWWy4oqgdkdsv4BHo0CXe6SkUU4fsenfzXpRhhh2ZuVEoPQwqcE7OJfCsKSjCIDgKH0lT04FYJVNrO5W0ET+ew5gvl0EqBKWDj4KNezJ3hg5VK/Oy/Fd9gkWBYE4NpeX6/+CgXD052QMW15+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773791; c=relaxed/simple;
	bh=p1IsKiAxwq12F2MM7ABxyO6mLj6RlYFe8Yg33MCLfXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWKU+tDdR90IeBmuQExg4WVzZMc/pQS/Ijhe33AMXZ0JYbWgp4PxEpDgSus1CmeTB3NMPV7eLdVADqkXYEinlkpBZC4UQBIEgB1eb38LaqhU0/TnmNhYzbuEVg4SG6PlPAJUgBtMR/gCQu+ARryq1iFj6LYGaszIZ/VVqMg6aO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dofoAW8i; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dofoAW8i"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb90f68f8cso484996266b.3
        for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 12:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740773788; x=1741378588; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAJ1+kbz8lZ4YwPg+OV3VOfAm0Jd01XhEIX1QeYwh3U=;
        b=dofoAW8i28fCDzggEjijwWma/qthib3SuarOYXCsbU9y4BxGeZ6+0dmoyA1f9u3eXW
         mKFscjpU69bD/9Ka9BVJaMfbQo0XVqauAfA/GOUDRQy7mTcLZqcBDA9V5OJsZGjvWTPD
         B+gHXvP2O4rRgYKLVU/X7L8A62qfmwhcDFCoUhCelPzq0I0fW7lG6vBsIJHohpm7fb5Y
         J2JFCRegX0KSlMLdhSS8yE0SY7pxY/4cOGCejd6K1hRQiqRCPB0Fr+iMAP6vHA/yb/fa
         XIMdP5xYhCsBJsZXI7zX1Q6EvI01uNLwkyBnSCGVPj26g5/il9u9mHeTAxrFeLZdY1/h
         BZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740773788; x=1741378588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAJ1+kbz8lZ4YwPg+OV3VOfAm0Jd01XhEIX1QeYwh3U=;
        b=GwXppWYv0/BBu46Rhs3V+oo7RUlJIBxxHlgNN8PQUKDIoyzmSljCpWCWLnBbywKsrN
         S2i5voppUk1iDsUCvNfwmAU4CNzK/ISGDegI8Ec7s5f00CK5d+N8eY26F3N8zPsoT48A
         FUk5sRpg8T4UQpWN2wMsvV+T7U44yGd4kSq3LJv4nZr53Gqcl/5pUBpNhbOdlZynxzFN
         TakUWMW8zrhYYKRrOGkmmjMneQGROYjL0cfLLpdLylW1zGdN4at8rEBcPET8ERPVfF3I
         WT2jZrI7/oJ7KoSoD7FotT5Wenna63n8+ClC45Oa0vxNGIVCUDTA6e8Cxd3MRz3R9nst
         +uXw==
X-Forwarded-Encrypted: i=1; AJvYcCVxsF80piFU5dSc3jh59AidbnHX+7NhtUoBrBw+Gy++//2OZ6hBrAFTe/WNBHzYF2sxKoLMQGo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2RCAu78ToGQPd7eqSw+s2z47awZ3TUXIXKv/CTSdSH4BSy3eF
	MLEthN4iURbyLETRNWtK4jMdKGYSbr4LRENls2M+LgAVrKAW8kY7
X-Gm-Gg: ASbGncv0YzRFpeomZvnHAf6/Jk+WlQCqcuSWdomKPLuDLN86imKBn3uA4XdP3aiyyjb
	FECvQjZGj7zKe/VKCUAvxqlEKlPWZcP81ApwhYCnPTowr591gJN4Xvalx6dNi10LVLi/Gx5RGkQ
	vJGWb1yweZYlo2jqR/tt3prvuY9jABlUJNnKxn9J8cCsPcaCNaPKy8KKToMz8s4hmtIsaMzQ+gb
	G3bmbrBHdDIv3heKRizAxNZABS+zNjFntdD1/Xqu9vCFWARBiaqbFSmS4EqsxZ9hOxT5kmoJuIL
	cuFz74XAGlOJDtvVRDMBvzghOm0d4f3amWbPWWx9HmtUBaKQFrbm014lHTUDnFQJsAO3zAlhxFE
	zLWThb2IUQnP+VYcaxAVWR1wgyf0fGWK7Qdoilp47qcU=
X-Google-Smtp-Source: AGHT+IF4o1r+k6+nG0zNGywKeKcizMy8Myj40MpWCdBkkMqspA1rSJwU0RPTkMPYXpO+ucJWx86obg==
X-Received: by 2002:a17:907:3e0e:b0:abb:b12b:e103 with SMTP id a640c23a62f3a-abf26218d27mr558296766b.34.1740773787937;
        Fri, 28 Feb 2025 12:16:27 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c66sm340812666b.136.2025.02.28.12.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:16:27 -0800 (PST)
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
Subject: [PATCH v8 net-next 08/15] netfilter :nf_flow_table_offload: Add nf_flow_rule_bridge()
Date: Fri, 28 Feb 2025 21:15:26 +0100
Message-ID: <20250228201533.23836-9-ericwouds@gmail.com>
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

