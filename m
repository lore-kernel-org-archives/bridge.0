Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B031B2153D1
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122505; cv=none; b=G/Ty1dLxxmQJk8ahwUVOYTaVVGYGVaTGqPiogrb0np7hD6+oPFMx4xRoMJXdQJlDxJg6Aw5Pk7BlD+u1baFS853GFjh7TuK2QxWF7aPEmKEWeGP9y6bi7jXhKuJa87NbAhtkwpltoLSHezE/7RJFg1HWKl7CGVjKPgROr+U3aEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122505; c=relaxed/simple;
	bh=23EVXG7kfqfWj5zpc9iYyPrQjwTk0DrW8lEhtvwVJ0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQZhGeI58bzfTBBFAB4No4qE0CryrdLkfxx/oTbkeVGbTwSuFZLlkLY8vbitWY2mAcdlwP8IZLX30NyKHuEeLE8xvyVHn76XSy64Je8RzpmXwpKtpKlY5xY1Um6TqW0WTjam4yhAFKd9Htd4PNoVTVCJG98xK2qju16/+Xc0HQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMo4r4fe; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMo4r4fe"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so11289465a12.1
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 07:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122502; x=1744727302; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3OIEodSl6lDw6tf2ZiYVl8tYf0/bPtkzTz2bpfAeGs=;
        b=BMo4r4feUcuCDqWnA4TD1gI22HZWjpGloNS6CfWPEEGF4B3o5pDaQ423cqlEVgsPrg
         YZlCmYc9LtKnQ86WbXjo7x1/8FzutOPImJ4IL0KCU0+SQCGkooLEjcBDCyAhE1jGAGJQ
         wcXlCnyOlcEjbXS1Jg836i1wn4RsjyTZiWsjYMCRjDq9aIRyZhtd7ITNsiocw8bTVIFm
         HmHt/CI8UjItTBckqB+Osi9ApulFpvm/jTdB8W6SnrwJ9GWcrE4r8fvXRVdpeQ+nXvpk
         mdPBE42Jxp9HwbsN9gPhXOMlJ5pSVqqVKIsuXdB+FQn9NT/hFXMstOCHGRSMMin0wg5j
         4TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122502; x=1744727302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3OIEodSl6lDw6tf2ZiYVl8tYf0/bPtkzTz2bpfAeGs=;
        b=QpZZTd8KRE3kV6UpjjRe1PS4g/gIgBnovzK47fXj8m/i7ooo67uFCsTV5kOU3LPCRT
         hcEJz81ClB7NYxauztNxHSLP1MbfCcoqjaxDpEXzE83QwPCaj4j+e3iCwbHTBbSSxwNn
         PmMNJzKIGt9Nde1LxqvT6VQUpPmKXZQ4mbDhWFgdvkb6c71hcwlQMZo2D+5hzTtNuVfy
         FeETHJcUW/2OX3+lZHtxWVL9aqAKueSJ9YEBnHWeTSG4Ri7456BFXswpCcGjszJ3MGps
         GdW8N1hh/7kHO2Cn4RpCfdWHIH20/J+Jp6cUKdOiSngmrXsPDjJEnuYlor030o4E7Q8k
         zPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKzHlEzosW+fGnaBzb6WReiRpQluigzPLS3wHZhKGQQ8G6Tpv2QB6hWWHnuLqnHKYKLXd5anU=@lists.linux.dev
X-Gm-Message-State: AOJu0YzBkyNJSLL7vzoLUzxeVwIV5bE+WrYmbVHmheqfhz0WrPZD4BBD
	fBKTBtemgt9uk44RFIZEDBnUGR7XE2w5E+0LGpTZk3mMflBKbOMY
X-Gm-Gg: ASbGncvpyouBJ2RzmzXiZ42E6uoHJoDRaYHIPvsegQUowYAd1DJvMELLe1PprmY8Hne
	onoDZhVo4M/tjyXoGc4OG7hyyVy0RB4/bvkUfBW8DcjOfw7usWVLnxR74/Vdk04s8vFRFNjTjSa
	/Zg1WH3f4ezd5xDNgeH3aSylh45/FTdDGkFu13q0vBpPCIz3z/EBNAk/kDKudPLe4ODwF2BZJuN
	diCtMiAkSqJ9hzq4WfGMutKQ/rZcarrWmOEYG+H2OYal4bmiyT4pjbX/ey+MZYQ7mTofVivaQII
	LZ4IVC6VHypC3NWuLmE0fA1ixLrMZYvnRCwAOdwH3Sr6nVRaXdyvJrDU9MNps7jJ3iPgLt9+umS
	pc2v8JHOF/ErZRSqw02M8Urglm5aTw4gqRpjBfIUoRwaC2mplk0zLxkEN9KF0khfKyKB3m9dhDw
	==
X-Google-Smtp-Source: AGHT+IFtUh86dw5P1rvEOKZJFOy3wFYBIYbNLQmENevkMKk9v92p3r9P4/WPi1ZmD1fshbslhyGHlw==
X-Received: by 2002:a05:6402:278d:b0:5ed:76b0:a688 with SMTP id 4fb4d7f45d1cf-5f0db8a2343mr10499321a12.21.1744122502160;
        Tue, 08 Apr 2025 07:28:22 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f1549b3fd0sm2236164a12.35.2025.04.08.07.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:28:21 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v11 nf-next 3/6] netfilter :nf_flow_table_offload: Add nf_flow_rule_bridge()
Date: Tue,  8 Apr 2025 16:27:59 +0200
Message-ID: <20250408142802.96101-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408142802.96101-1-ericwouds@gmail.com>
References: <20250408142802.96101-1-ericwouds@gmail.com>
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
index 9d9363e91587..f60ecedf2fa7 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -344,6 +344,9 @@ void nf_flow_table_offload_flush_cleanup(struct nf_flowtable *flowtable);
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

