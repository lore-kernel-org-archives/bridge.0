Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E88394E93
	for <bridge@lists.linux.dev>; Tue,  7 Jul 2026 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415482; cv=none; b=gxOh1SRxwJkWPL8CcLLkzkqI+HqFvyVzvGI2Tt2ATjhtX+xVQ1b6TNQSWdfbd+nQSeDEUTNkLnV9zk5NZWpX9BoakQyyFEKlbro7GgDSzKDhHN094SgsqBrilthGUULrn3MSaFHTtVKExfA06BWA3sImtU4z6NKmbaS651OnLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415482; c=relaxed/simple;
	bh=LwGdfVE6zCNMfNmWNHYheA/PzogaUt5+b/oAPBRLVHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzACKRRN5AGQJJW8h+uR1q+VuEvaVC/dtQV+YcdLL3MLnn8snQF+2fY1Q67dUGX5ikdGwumcSgs2G9PjnYwNeks8Zxm3DFBcwJYHUQ+uR8gcWHihi9iS19a90efeb7zM7uhVEMMovv7lC9O5QaNBYFYN/tID9Y+3CSTjSfpOAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITgQAFGA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITgQAFGA"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-697763eeafcso6253027a12.3
        for <bridge@lists.linux.dev>; Tue, 07 Jul 2026 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415479; x=1784020279; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=017gAsipokr31hcEOs9r+XS73NV9N5N3+SvjZqA1EbI=;
        b=ITgQAFGA4QExsRe5TSI4pgb1vQkckSoKA6AjcmlmWyGXL651vn31eq4XQ47FHXs1zs
         qZh6S2l5q8UzmwBeFSnoJSTw4yGEd5kJ6DVp6MIrzql8lxyMuP1VmpfU90GilueD4Q22
         rdF5tdGZe69P35dDfZmpeofWEm7nz+j7aY9QqUs9dE7aG3gWq7u0WFF49fvJj8dvaWyv
         xClEbD7kzQ2jfd5tY3y3Trsgw2q2Y63/8T0eQS8aBhAf+sYxmPFAjUw6ofzff6d1SDAG
         r3Vp2Xss0stpHaCg6AKc2lDiSWzIJ/8IkodAGV4PMFVKodwwn1hMmZgEcxTFlNjFP69P
         SYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415479; x=1784020279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=017gAsipokr31hcEOs9r+XS73NV9N5N3+SvjZqA1EbI=;
        b=h9RWM0oPavnGcjXH9Wqa0zrI/D5JDWYBPukEUacOXv9vLI3vT8qoeiPi3dmgaK8IL0
         GY/hYKskJ3mIMafLdTDGOR70T5rbkj8ndstKBGTh0vfY/nNytSHo/UaXceGN/biSckLo
         9QkCoVsLIAluhtroTv0XCPjBhYgwdNILY9jSgQsYIHsmdE+A8/g0O4TlXCg/5VFdYloR
         a80n86abuYU8uYByHziSjPPmpTdLAB0VjHvwABNRf8w0Ly1N1x4jyv9yUxCAY1g6Ww66
         qq8VHmfo8qpGX06vdATqq/X4g0gVwnFcl8/zq5ueVMhAlZXMrXRZxYp42ZO4E2tst/u1
         Mrog==
X-Forwarded-Encrypted: i=1; AHgh+Rqt+cNwK4ZIpGT6LqxWr4tWwtERVfO5utPfxK/q+axyWT9eeEJi+6evRNhAbidT2z+9EoS7BGs=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0IC4K9vB7XqwFrBTGA4MszXc6aSy8nK6m1mwjYhNDgEv43dBx
	5/EH61vMwaglRiYJ0xjqFV5TansAYEDMRGnozF4bKVMFzhz6xnPmQPjH
X-Gm-Gg: AfdE7cmB/+bKb3bDvcDaABApsGRNQR9EordEHO7fL9JCk9JNfq1AVP7phYPxisYk7gU
	YbPOPpLnQMigMTUyCdJ/ZBSwWd/mLtzTNE3Dw4MSN+6osfXVGVyQTY6AK/4TcGtt5Ea2ch0vUQP
	1GC+a48FEhhZsInXf9J6gMvW/8ZT8VEQGrQCmym+Sb4Ic156St4eR9uZx4CfHCfyxBR1UgFOmA/
	+BNthgd0LxKA7GOD/RwoIa/CY7E6Lkocv9Z01tc6cfbnQ2/GfY9ozgYcRI1p/FQghvjb6aVJkF0
	FfCGuIuSUSQK0guWDKRIvubMZHKIa1nz7oLVf+IoiY7UHnxqkT1IAFvIyx6+N0dLoFk02Z/RjWz
	Fm+Yz0+NkEO+0ff+GH8zVN6evHm4EkSOdJmmLvc/EKGGbhdIdWu5r/tVbE/h5752/7SbwYOezyb
	llEssRU69EP9L5UZqsM0vkTKqkdKkUyenOf8UJDflr0wO9/KmOT2OZrAmLS2Vhf6GRbYUvGe5eH
	h6q589dlgu0w/KYR+4k3fpnWUE9c+FW63aExQMTgTt0vZqqHgbxmSM=
X-Received: by 2002:aa7:c588:0:b0:698:be56:d7cf with SMTP id 4fb4d7f45d1cf-69a85bb21cfmr1640778a12.16.1783415479480;
        Tue, 07 Jul 2026 02:11:19 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd87d6sm5297152a12.6.2026.07.07.02.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:11:19 -0700 (PDT)
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
Subject: [PATCH v12 nf-next 4/7] netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
Date: Tue,  7 Jul 2026 11:10:42 +0200
Message-ID: <20260707091045.967678-5-ericwouds@gmail.com>
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

This will allow a flowtable to be added to the nft bridge family.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nf_flow_table_inet.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow_table_inet.c
index b0f1991719324..80b238196f29b 100644
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
2.53.0

