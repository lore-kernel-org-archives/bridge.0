Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473B22DFA8
	for <bridge@lists.linux.dev>; Mon, 13 Jan 2025 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779138; cv=none; b=klMEKurWNxB9btQCEDxTayqt6Gi6DAKmdM/7jUQ6yUNBUIlNs7o5HNx+GKSCoQeK6xz1N6GTC64VAIHIQYv3gfMIdlBBJs9GjEJCOQtAbMBFR5gN94P2b2jDTmMpFxN0LnvnbSoUNW3A9d6kltzreg4Xh1v+R4nSnYMOZAnV5wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779138; c=relaxed/simple;
	bh=HRgkD5FKjFgLgWVxBNT3gyl1M0RycbLvrFOZUB35tkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td++9PxjjmlCjNRnktdJ9PfYP/ec198sa5tkhTbe8w9BPY5oLGstcX4JhPK+qYlI8EijRt5M9140EzXgObwhg/h1H98fHdVHe5UwIn88vnhK6JLep0huV5iDyxsajXDePUi9wcp0Wz5g2wkN+Z0F3piQCYPYOb0HkuKVDEUCJvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beWPswWZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beWPswWZ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163dc5155fso80058955ad.0
        for <bridge@lists.linux.dev>; Mon, 13 Jan 2025 06:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779136; x=1737383936; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RwrUezkHV4Bxso8Lan3H8PNeHkallTCdG4JVNGo1S0=;
        b=beWPswWZdjswiKBbitI5L6IzCUdc8OiWfRAdkcWkpWfWdOSer+JWi7ovRQUNmlpc20
         /H7AcTbOjBvZ27+4Mg4Y91WrU9ef9UNt9vCRVZqkMNZluuMqos8zgErcA2WUjIRz2uXf
         B7YBqgUzIwNmM5J44zNe6p5Sdp0yExwHM57Rpqz4N7XSFhCCmQ3ScXhJg/4lkblI9x4T
         sO0TZPi2Ixw6NhuYgD/MOcftOuqyt5k1YqW71x84lZ10FNNj+kPBAeg1x/kiuOn1pY4P
         t+Bhu88ahgH02vSr6T5cn6aPX3UNmx5wQe6BcfsTJMejhBp/u3noAZosxw/wMR0bTqri
         5aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779136; x=1737383936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RwrUezkHV4Bxso8Lan3H8PNeHkallTCdG4JVNGo1S0=;
        b=ppNMhxK6AXTBUw6a9zpxB/I6mZkv4yonhBodxLRGCWWbQchG1BiXQH3LnvN8Mv4niV
         KXwqoOMNKzTEOit+eZ/K5mYANLaw/wpZgAniejxc6VFj82B70KRBsmNyr/RFAhxU1iCk
         8tlOZy5gzMygTunLl+WTSe4XOp8TfDSWHZFT3syck6C0A4TSBrSNNLw9YZBWK7hBJ2wV
         0+5ymo4rCgF159wLdNOizmSi+Qh+71fC4Dol1DZF26bVnMQG7i2CgKhXxzjP3u4My/Q6
         z5IkVD+DzlzjqWK2+jiP3w9lO9XS7bCbJmcmWOuY/H+fZHREwyguNl8oKbaRLG9YrgiO
         DzUg==
X-Forwarded-Encrypted: i=1; AJvYcCWFLW7O+FUQBdaGSv2kTKYIqvGIaccuSQ6IyNV362bGiCxWV497ztWG1scOw7QDftSUNOIOFtU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+5HmePaDQ0XALrY6I/5NRGzhFdhn0EuhwIaTmAJ0NQ7B0DTCS
	CN+F/HBQ/nYa7Hl78dBraaKVHeeoLxp9EuGxFny0NZOGMI6eKdN0
X-Gm-Gg: ASbGncvvmJY3d4xJQT8lmwPlSnlC8sKqnSIWS2+/xix+c3B0r6ZcYrBI79y2BMvNLf0
	uJrKa1Lz2M0hQUQ6qLu75VmYoLbY2Da3msi+QOC92gD0KaR1P+Lv+mL6NJQdeZFrtfN4jmtSB/i
	myycQJiTjOmml/peZ9UFn6kmeYXyO7PQ7Cg8A1KsCxtSOJ5nfWwRMhnIson0msaQ9otBmX7mK7q
	aLM4qlScnUawQrA7NJrWxS4QQYYFCnmCAyKwndCt3Bm67I=
X-Google-Smtp-Source: AGHT+IHt1nCTDh10fBQS9NHgK/oOky2VtiRHLWbePcQNxSAsFYQfmLDkyg61R0c+C95BGg+IP2F6xw==
X-Received: by 2002:a17:903:18a:b0:216:4a06:e87a with SMTP id d9443c01a7336-21a83fc7640mr358427785ad.40.1736779135888;
        Mon, 13 Jan 2025 06:38:55 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:55 -0800 (PST)
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
Subject: [PATCH net-next v8 09/11] rtnetlink: Create link directly in target net namespace
Date: Mon, 13 Jan 2025 22:37:17 +0800
Message-ID: <20250113143719.7948-10-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113143719.7948-1-shaw.leon@gmail.com>
References: <20250113143719.7948-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make rtnl_newlink_create() create device in target namespace directly.
Avoid extra netns change when link netns is provided.

Device drivers has been converted to be aware of link netns, that is not
assuming device netns is and link netns is the same when ops->newlink()
is called.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/core/rtnetlink.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index cce5bcd1f257..65f09ab616b5 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3784,8 +3784,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3805,11 +3805,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
 	if (err < 0)
 		goto out_unregister;
-	if (link_net) {
-		err = dev_change_net_namespace(dev, tgt_net, ifname);
-		if (err < 0)
-			goto out_unregister;
-	}
 	if (tb[IFLA_MASTER]) {
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
 		if (err)
-- 
2.47.1

