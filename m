Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275E1CC177
	for <bridge@lists.linux.dev>; Sat,  4 Jan 2025 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995525; cv=none; b=RE7VsJF9M8XrD9MYwR8nhb4j/8DupOT8baMlIwudXcqw/gM21Nd8CaPvyowxHCV446ykqrX+3ApLkOTL1EwUkBqkXlMMU7hCOcb0ipO1FKu66OCnOhmizcAED/cr8NL5r9D3YTra9SqESnc4XIkgBsEb3A1D5lgj62/p9kVtcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995525; c=relaxed/simple;
	bh=FrNFlIgaLGZInVfg7c+Ua7z0X9F1i2NtBJYO15VwRj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJeSFT7QC0gV47Q5GgpF25jtjqQ4VXlNGRWMlna1qOl2dEKPptT4xGfU/cpVidZ34rCI/c+nsBtOZZpORA6oNx8XNeelf1qHVydnk4cih4gzmY+1bA6tG2glgaXB4ciZufAnaODwMWR0dkySRJvY7DkJ8VDbFB/Hm/bDW2zR7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsd1UqU1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsd1UqU1"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2161eb94cceso128978155ad.2
        for <bridge@lists.linux.dev>; Sat, 04 Jan 2025 04:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995523; x=1736600323; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
        b=fsd1UqU1UbJWfAOCFqo6uBiOYTMoU/UK6qraiiEcrOnMe+aP5jnVdJN3+LQvzmyuK3
         dEGUdkJDC0k+D71u79KPrBvCXwy+VCFkYjx4cAnI+aaz9PlwTQBTS/G4clazaoZB+Evb
         q/LeG1RO9if+XP6XO/cnPJmKboLRUFiz4hU1BP85unDQQtIn7ZUjjaZ3SnfzRIf9iL/u
         yC7ccae1Y1OEc6jdD58iupj/tPdQ5FLrLF1QapRxI+J/2gfZns7uVjiiAFzBP9Kf12rK
         jwdD8V0wywAXyzeIkkP5ZNgvrMi1RkqkloUccm6YinkT1mUSjrF2hVxwHEm6z+mjr6cf
         VfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995523; x=1736600323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
        b=kIp8KszM1/ATnhwUEkX0/4kX8tBERD3NtTxiJc4LG4fVOEl3zXkHvk8GXtonJU4H8u
         xSfqqyP9mBHhgnD+7M3VYx0JIF0et7+UOFW6ms8yXzjaDTNwlxpi73ao0vsR6WkoE96+
         Sw1TOHwMtaaKFrDQCtIfuJzETW+zoQSii206SH/Nhm1MM/XVsgNfAfZLmS9uRJNMyVBw
         25OoKGjORIVpeXK3Uu6jtLrFRRqnqEaQ04F/UGCmCOZjWZucgg1dz+zrMoFgZBzT11Rz
         EAsP6fWN7vJFLtEv9BClPd8hUaAdNXvUHJCxt045equdEZB6AAnGCPYLBmv9oQsMwDOU
         ZpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZmxRfn6Ig/Ofr20HINs6WhI6SqJwEQD58r3jjnQoQjXg06xiKFq+0J//qXJ1ve56vTYX9ImM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1qjeM+UP8DU0W1qVBh8o/Naekm+TLyWwFCyYyL06VMlrGU0BI
	m6CMQY4E+FhIbgffTISlAKI8OrSbi0ZnptJW3oCMH5wdBA2FXAIX
X-Gm-Gg: ASbGnctvTpMBxrtE14TAFcVyzfR3uyfRsQBsLNcF91WB2YhiQ4rsBhnj3N0Y06dZEPA
	kEZ7IJcHublDIDhI29QhRVoPk9dTdsWBVj9GsVrPr4BOWx+fBk7pqTAxrwqJJMBc6Yz3wv0Wbnd
	Aa7eVxbkeRNbpqIcrJOhWJrf7len8AlIJyx9GGGmF/cE0Em5PAehJrvnSpb9shAWq8FzQUvErZP
	rU2bqNaEwvlRLfcld/8K8KGqhlcELk3dbe0dgNY6YO5KaA=
X-Google-Smtp-Source: AGHT+IHa35PYbmCu1uOx6CEp/EQWjQpZHigmf2PgIvsgkyK5+Nfa2PQvUpv4CIvsSLNsXb9/anYWIA==
X-Received: by 2002:a05:6a00:cd6:b0:729:a31:892d with SMTP id d2e1a72fcca58-72abdd9603cmr90325957b3a.8.1735995523087;
        Sat, 04 Jan 2025 04:58:43 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:42 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 07/11] net: xfrm: Use link netns in newlink() of rtnl_link_ops
Date: Sat,  4 Jan 2025 20:57:28 +0800
Message-ID: <20250104125732.17335-8-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When link_net is set, use it as link netns instead of dev_net(). This
prepares for rtnetlink core to create device in target netns directly,
in which case the two namespaces may be different.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/xfrm/xfrm_interface_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 77d50d4af4a1..d1198c63dd23 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -242,10 +242,9 @@ static void xfrmi_dev_free(struct net_device *dev)
 	gro_cells_destroy(&xi->gro_cells);
 }
 
-static int xfrmi_create(struct net_device *dev)
+static int xfrmi_create(struct net *net, struct net_device *dev)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net *net = dev_net(dev);
 	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
 	int err;
 
@@ -819,11 +818,12 @@ static int xfrmi_newlink(struct rtnl_newlink_params *params)
 	struct netlink_ext_ack *extack = params->extack;
 	struct net_device *dev = params->dev;
 	struct nlattr **data = params->data;
-	struct net *net = dev_net(dev);
 	struct xfrm_if_parms p = {};
 	struct xfrm_if *xi;
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
 	xfrmi_netlink_parms(data, &p);
 	if (p.collect_md) {
 		struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
@@ -852,7 +852,7 @@ static int xfrmi_newlink(struct rtnl_newlink_params *params)
 	xi->net = net;
 	xi->dev = dev;
 
-	err = xfrmi_create(dev);
+	err = xfrmi_create(net, dev);
 	return err;
 }
 
-- 
2.47.1

