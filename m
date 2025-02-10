Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF422FF28
	for <bridge@lists.linux.dev>; Mon, 10 Feb 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194283; cv=none; b=peJaFsgyQUe883ZixETm+EssQXdOy91pGTqGM1SolgW5PL43xiHfViLFgfg8ZLZFv8NgZr2hHr5tpRKLsvbtQU4REmiDrn0plgaZihOZ6bctQ2thxBJkLD5q09n/zdScCuUrBtXnhy0EPbMfcfQq9uWq4UXgTfhb3RkXOWj8N6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194283; c=relaxed/simple;
	bh=aKbzZxou1uG+4UzTz9mjeL2/4viaECGZ39kotodArQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBoYtAURuRkpa1R1/5QRLfchn5HUuNUztlGSrMIrBsLLN+Fu0bgwmp4Ry/Kj5C2et4oWtR9F1IXy5WM+ITSHmWNbp+NToBoVgAvedIxjxyOK0cSv4+pCKAV9ngy4e47A7cog3r6EkcYYxyGO3py1AiOsbLvOlRecdnkPIp8rBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcZJExe2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcZJExe2"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f55fbb72bso47190215ad.2
        for <bridge@lists.linux.dev>; Mon, 10 Feb 2025 05:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194281; x=1739799081; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
        b=GcZJExe2LRp9WhIA/2GU3JHo/tmPJHDiII/B0uox89XjgJB8GHZi6JUldJYyxdIb+5
         L4Q8QG63hsovjgznqa2zkbDuG2ul6DjNjUga7ImyquvbbtFktYfq8nlnwnLHaP+9vBgV
         yTW1gGFhoM0V4fIJJ1XsfVIULgfgeQ7tTEeh5rIhvwgsG103meleFiX1MmmHH10BDXcl
         kYnBZ26UbgrJ7Ug3Q7yyEDLi2Wju1v6tB8jeSaQ69Adq92p0cyBticl9RdoeiW+mKaKv
         MLUG/C5iIQpBzt5trQQI0/5KhsnjzjKMEsjn035mlKNXz6xjrFjeRCz5qqZBNQIVT1UU
         vBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194281; x=1739799081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
        b=rKN2BK+Joea/nE/CbVZ1Ki1i8GpRU2Uwuvf3VfvaXW3TqCHbjrcxFG1aRU9XVNXwdi
         88T1RRdoEClry5CUF/LSfCf9fCQR8Rw44gWH3WIiCYvv19FQU/VLAZFCUGbr3HRIVaBs
         Wy9K1Wttae0/Uw/SgcTpieuZv+H7eC+71iD845h/xS9saLQmJkCeSXiw2uQgGqo2OCMn
         Fvfh5be03GLXxyoBYoPyBs8Lz7Ueblk1+Zt8uew6N47WMKVPCmYn45lLPrGmgOqG2Qwf
         FdCnlRNbi6cYzUnd0UC9FT7g7wlWfiJmeZwwHDojPlfyGuyxwdB9aLnFmINncYyIHE50
         Eq8w==
X-Forwarded-Encrypted: i=1; AJvYcCXZaQ5lrD3sGz1jnyrI8XYdt52gmXOs7SP39JABB5CSpoH2Rxofd6NipublY7+Ec3AhKLZNslQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxt3W3ke2Ci/IhlTP85sDhwrrOq4eUfl59BkpaJ+f1JGrzU6BFL
	C5zAphVQzB2QNDNkPeDa7qiuM9pTksQCOjirLF9WeSkMsWAQWfgz
X-Gm-Gg: ASbGncvwsA7OHCEgRPkMNHWDHCjuhU1FeqJnKybrhxjqriD2gMMdCZcrHYOh8SWGey9
	WzBZPpicwJh23+ibIz1QxtsWlOfvQ2PPBglYgPEus3kesQ14G9pTjULyZwmtF4zjpzq66f0RXpq
	naW6WuXFNiX+lpve4CfNzaGqjN2EJRMmp3/6J/bsQbbWoWvWVhwnRM3iaLF/RMRIyzGAWdyb8eX
	Eps/Qu69t1y2DUjBohWoKv7Kpf6tDMXyOoxVkJi7JDZTXAXAqFYPANazQgOi2hSZeo5bT6erN3s
	2RS+3Q==
X-Google-Smtp-Source: AGHT+IHeusvrHP8M+FV2U5mrdVgA+KXf+BNwroimzhQyBeA1391Nd6kFx/ISaagEKEOW3Rex1VbPJw==
X-Received: by 2002:a17:902:c94a:b0:21f:8099:72e4 with SMTP id d9443c01a7336-21f809974bdmr103657145ad.28.1739194280801;
        Mon, 10 Feb 2025 05:31:20 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:20 -0800 (PST)
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
Subject: [PATCH net-next v9 07/11] net: xfrm: Use link netns in newlink() of rtnl_link_ops
Date: Mon, 10 Feb 2025 21:29:58 +0800
Message-ID: <20250210133002.883422-8-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133002.883422-1-shaw.leon@gmail.com>
References: <20250210133002.883422-1-shaw.leon@gmail.com>
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

