Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AE81B4253
	for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969539; cv=none; b=doRDjqW0CW3kzt62xv6Qn+W/I2wtxl43DUJR81m6+ID9Or8P9xKo2jVyejRgd7l0Kz/APHqOHux6Y2Lcygjjn8g1Hp3tBDxWoM/gkTouKWgKrOef1d4jOED0xIf0ECEK6zyo8wocr2TMarjp2rAeyDd0idf+tgwE1sS859OgJ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969539; c=relaxed/simple;
	bh=aKbzZxou1uG+4UzTz9mjeL2/4viaECGZ39kotodArQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5v9yNSnu/EsFH/yTykOK0gnmNmUxkgUdx64iMVtJqmRSiqNS58gt1Z1g/5wi7Icw+BnyxN6K/s8XUT3ZC5nRbuFu8xy21MuTFV9w0Z5ei/etqbt+oSizAstHCMgR3hjL9dXldYpJGJ4MrI9fZpDrX14fQyr7cU+mWnh40y7RIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XctRj+XJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XctRj+XJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c4159f87so88471385ad.0
        for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 04:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969535; x=1740574335; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
        b=XctRj+XJKco4v9DD6a2NnmtOtJgtWTGROvjbj0APdYGBnpbvVJC5052ruHoFwjahSu
         EI3qDftHkec960m5Ne6h7ATkUmlgy5BCsZsnT4OiAaAm2WVDlORAfpOvCO8FVBJkBRlE
         gXQGF5HMIpsk1+uu2UCRkH7weu/0OlMcQKhDhv9kgSnjhmzmE85Sa4juVxWXnIFKbfr2
         O/SYMWeWDgi/9UhuuebYq5uqukvQmT2PNMpBVmZ72RAl2NDqzZYbgfj0SnKeYtyy8hqd
         2FJSo+Bk2AlN0ebHSfCrtr0Q47WQ5TpjvT76geOLYYKPVEtxog9Wj7KKcy1z9s18j9AP
         gyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969535; x=1740574335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
        b=fKFc/hBAcDQfFd/GU7yG00IikGTXiIBf4AjgoVwGGRgkJMd3Y+j/mtDh1vRrn04TwM
         C4Y/8l4ugPHL3psVu0wkadz6mrV4kcut4gqXzFE8v3l12dFQQxaae9bJEv/p80iPu2f6
         qNKCTevWRCXco+BwEHwg9+2sNlClv2dADivAeLZimv0a5PRKsrW/xFBqRN9FdJVYFePr
         4O816aCkSY4UQWHnkJ5brW8sOYhp5tAWWwDYFkTi0oe/CQE1aqQhdSOda/fjjqsrNGFO
         Fa16snPVRBpXzMdqf/rh6Hw7D5THBZQzX7qZLoD7nJKOWpUh4iArO+Kg6KAHITwFMHUZ
         42Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXIAAje0hP6uxqaZKLnVybrdosQrV6s0NhE8aUCMTc9CA0tC0VEd6o4poNXsKEZrs+aQgUwO54=@lists.linux.dev
X-Gm-Message-State: AOJu0YxzfS38BGJRIKje7JGFbPg1ZFQxIKR2eIBDRhb8lQTLwICWvuNn
	25/Ui6iJHSGoGZDXjHKodqtQ+Yhyji5/ILfDwYasdx+4P2eQiXQn
X-Gm-Gg: ASbGncuFLwEkIYGJ0wQjds13JceWajabo0DY7f1yiIHvf4Pt31CRpGgm6T0tYkpv7Ua
	lxFdf5JmUTHACJQJ0+0h2RhE/t0rZ5IGisog7E88/jqH4mrLmF84r4JIDU3Z5uTB17hMeBe2lM/
	DWGcoLeX0NSknPLvZM+/ov3rAjBY05U6nCzv8oV4BoGrEhJZytDZf7YD87iAtqk3Fj9p4w1DUbl
	QwIsIZPqoL6B1iMQJ8Hx5MRDSpdW0UlQUEgwro8CaNkzxhXBTwjMyAzN/9By5qwDrBEZM2HAR7Z
	mRKCjQ==
X-Google-Smtp-Source: AGHT+IGEFP67zSY2isKHwZ8c/HiTSEQrpqN9J90h0hy0pUrJ6TwQBaUnsvMftR+A8p8DsBy8+Vg8gQ==
X-Received: by 2002:a17:902:d502:b0:21f:dc3:890e with SMTP id d9443c01a7336-221040255fcmr244598235ad.18.1739969534802;
        Wed, 19 Feb 2025 04:52:14 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:14 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
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
Subject: [PATCH net-next v10 09/13] net: xfrm: Use link netns in newlink() of rtnl_link_ops
Date: Wed, 19 Feb 2025 20:50:35 +0800
Message-ID: <20250219125039.18024-10-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
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
index 5659a6cadd51..622445f041d3 100644
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
 
@@ -819,11 +818,12 @@ static int xfrmi_newlink(struct net_device *dev,
 			 struct netlink_ext_ack *extack)
 {
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
@@ -852,7 +852,7 @@ static int xfrmi_newlink(struct net_device *dev,
 	xi->net = net;
 	xi->dev = dev;
 
-	err = xfrmi_create(dev);
+	err = xfrmi_create(net, dev);
 	return err;
 }
 
-- 
2.48.1

