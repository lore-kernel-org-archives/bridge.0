Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5EE392C4C
	for <bridge@lists.linux.dev>; Tue,  7 Jul 2026 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415481; cv=none; b=rxL6BGGWaAB5Vkts0dmQwG7Lj4GqMqzulcezH6+P1vNyl0HpoSb1bPp0wDVBdGEzOseo4I8lohxNx0F0uenVj9ET7omRbzCQkbr4azUf9nXM/ICMqyCJln142KFM4OE3ZTNJ//xQpxz4MIzcSijPmhtk3WHaTJk+1vrdpJob1IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415481; c=relaxed/simple;
	bh=s02OZU6yGbhZS+80+Db+cUZOuelG+2HfZ5D9w07AOX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkYbOOVfknqc38zxajev51a3ZIfIHlxY6AXN66t1UGni4u1qC31XZbpc/B5w5FhoXr0nh1ZFWHZwYLikQ8Sa2U7joViut1da3OYGdlm8kOZlY1EjtCKYcCPO5ESqfXWFgsStc4+dMACl5jzpPSY1MqCUJ9WPoToGLd9Qo4ZtyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN8ABEs8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN8ABEs8"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so5549250a12.1
        for <bridge@lists.linux.dev>; Tue, 07 Jul 2026 02:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415478; x=1784020278; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GTNzg7neY6XAYNOZrTHnOAN/xy3esmxWmnvFgBYG4BI=;
        b=QN8ABEs8q3rYFjap90cpJvSSi+ww82SMN1CU3yLXsmCgCfpahXzD09zpifEp928zY4
         YxULaFcGM8D9L7XWNRxj2OFC4igXMte6BE2U4xVmhr5MrJtxfFC+j5XiUyo2/rtP0NeI
         YQfAQzb7TSnjs2cWo35/87+DY4F+v14JbLISduE93233RijRiaAtrGs8EwEbs028XUsi
         jDt/3iPh1hgvnATrCubeyPVGl0zK8EzbkU0SpHpr0HRrGLp3/09Fj3SOTS5lA1pHGMzk
         rheHhoaDnZU8ds3CqlzMgNe1BnFEySik0kEhMruobtazuZoTAJsxUnZxz4NLCv0+0XnK
         BB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415478; x=1784020278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GTNzg7neY6XAYNOZrTHnOAN/xy3esmxWmnvFgBYG4BI=;
        b=KRZ+hXUiNLNkUJZZinuIiqPNOJQvdgx9I6teHsvnEJOq0S4V2/opUHhfuLUeVlcZtD
         BsS78qfqPPT8y3syIelvuvmG6J1nCGlP79/rID/43pRsRdEFeQKNtN0mXfruPYJytRyh
         mBZeOxHuW61NoJSMkfM18GPtlL3q73PMGCEIWmp8q6Z9LHPYkFMjl8cfwlv+8VYvn0gn
         ERkTSI1V5H+Sz5L1W3vz8eVxJZKiKTGPffV0p90K8FhRuhEPfGDANZPOvkHmc5ETRklp
         qE2XLKIn+76MRXkCLgjEmoC7IXAUgosutbzA6FEwX95mEoC7NXdeaWmhAOGPSJnYYJK+
         Ojjw==
X-Forwarded-Encrypted: i=1; AHgh+RoEJsGffKylZxn+Lg1a3IaDLg0p1SZq1EiwIQMSAdhSG2flUTrm1rE45/KYP9G7W//CpymvQz4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5P2cpi975Huhsz7uDEXw4CxViBg5XmCcQNBuxnV8jCoHpFiAN
	STiy5igVIIGRGFp8gZ5MwCQ0lpj0o6yiboyFJlLTVkrClzsnaVwZeA3p
X-Gm-Gg: AfdE7cnSDMBk6CFJPVQd3H/AGviJceV4gcOip4WTJKGLK77OI3gHN/KnpsCpKfY8zaK
	r0vox+cItHqjc1ThU3NKOahHTl/kKwz7dJaMhqpkKfxe1EWiEuwCnbbdIRpHNTbASw68gftTIsf
	TWtfKEEHi5bB+B/BLMYAU0ZW86yudkwv0hAB6H9QpKd5qHpCfujEKCHLzkx7450pRc7etV/Vqdv
	sSfKKnz0d8NDFjAPJGpCtdj0cnmdXYvAH9FI99MhAc69fxkqhkkVh6rWZTZBEjYjF/oRy4ANgja
	UisvEj90eM7Hiy4lAEpkJt+5o2xo6GOuBa5/7fg5FbckjCKeAzCEzhWHzuE716l+u183AcCya7R
	5Eb804NqSisn0prDUw6Upwy/fhdWpN8EzhSOHz+iC6nzmr2LI/9A6DbXJRoDqpoqy/cDo/cyO1i
	VFffJhBUhgoNwvRNxQJpLur3QfVD0lJV9M9B53pI433NDQrLiT4m5wHJCYYfhrXzEySXIx7grzH
	L23utx7OY0+8IZDl+s3XUrJvmM1lci88rXJ8bhmKbSh
X-Received: by 2002:a05:6402:2483:b0:698:ae69:3992 with SMTP id 4fb4d7f45d1cf-69a85b9cd1emr2231989a12.16.1783415478241;
        Tue, 07 Jul 2026 02:11:18 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd87d6sm5297152a12.6.2026.07.07.02.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:11:17 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v12 nf-next 3/7] netfilter: nf_flow_table_offload: Add nf_flow_rule_bridge()
Date: Tue,  7 Jul 2026 11:10:41 +0200
Message-ID: <20260707091045.967678-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707091045.967678-1-ericwouds@gmail.com>
References: <20260707091045.967678-1-ericwouds@gmail.com>
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
index 7b23b245a5a86..5c6e3b65ae85b 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -368,6 +368,9 @@ void nf_flow_table_offload_flush_cleanup(struct nf_flowtable *flowtable);
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
index 002ec15d988bd..5566ebda7b7d3 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -740,6 +740,19 @@ nf_flow_rule_route_common(struct net *net, const struct flow_offload *flow,
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
2.53.0

