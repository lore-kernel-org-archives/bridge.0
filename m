Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EFA28EC66
	for <bridge@lists.linux.dev>; Mon, 13 Jan 2025 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779095; cv=none; b=o1IRnc0qq/bs6yNO6jaHILwLuj1YfvYtVGEeIstYoTRgcGUNxMnLkFnJiyjHy9TmfOVzxKbWtOB7KEVbarpCo8foYdi91uMe85yFJl8YzCesk2M1mGLfEF3GjJAFavXTSAxokPU91fO0ipniUUtapGFdhBkheT2jD3UzJk7MDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779095; c=relaxed/simple;
	bh=UswJPFD7QmjNf9lnKyVnvoe2wLuFgTdsosj3eJpjk+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rU1LQnloHgZHL4NlwuudT81AYvJeol6BYUrj2rMk6yhhfX4qAR+JZGq11Firgj2IueUmTuNLgQ+1/ELJLvECTJiZSzqfVJlftiBo1Mw3jGb8jOZ7hpYxGRMaL1ZD49gxh8K0xCcS5mwBomkM5cTCyiplj1vuIrQjFJjSah9kWCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3MJ6IGc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3MJ6IGc"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21680814d42so63198085ad.2
        for <bridge@lists.linux.dev>; Mon, 13 Jan 2025 06:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779093; x=1737383893; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlOA56xQJRVfhoUOrNRPIk7EOBdTk/e52r4/wRWgOdc=;
        b=A3MJ6IGc77YZD34bMpLOmGmk2a9KM6+b2qiBUl2nylskwJvvCvJWkdcAHcHyNglipX
         pJaOIE7Tr3U5na/eOTIKNAU3l1ImeTyiBWDFIMt/cByD6WffD8t/OEnXia1UNMJcUU5Q
         0wvpT3+NjAWkeaBA0QuKPRwjI1fCjYvER7SjtG+adNNmoJyAb+qUW+Oe+73yXjyLTonC
         t2kZvdLCf1PqGiKGv1qch1f/3E+W4/LejuYkB9hloJmt2PXTkuKTu6lqsJekaEwsX9TO
         7ET966RXwl0SokLEY0PtV5nhwDMIFEsVVFtTNxGdSTFW2o0YHdbYyAnOyd9+j+DWVdhQ
         iZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779093; x=1737383893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlOA56xQJRVfhoUOrNRPIk7EOBdTk/e52r4/wRWgOdc=;
        b=NkJcP/2dQ4LR3Wzz24cFLjS/Ehda7idCXiyWOrRMUPm7qAWm4vX5QJFmC2pDizG4ko
         Zf+4DghfT1Rk9m6Q1EsIaXstbWOpgmwKuDQzys4pJMRKOX0giIkursbJXb2J8HDaNPDu
         xH9F0afdSFsUG9ODHI0YuXft4HXFXZuXSSPFIQvukZukjhe3V3As1MCnYCHQf+xC5gfw
         /CKNs+uumX5rDb6jczyMPO9WOYy3eAKQbfMw3VaXT9T8mDRdngwAuYOjqI7Ps0akeaim
         fJEX46W89kWEVOxG0w8OC0s22bz3geiSEX3TlJ8DTCCsQNAPxZNtHwM57Qv94864ARsV
         TXNw==
X-Forwarded-Encrypted: i=1; AJvYcCV2fxco+QSXzOEomyM3ivWKurMoxqB1jV14LUcD2aTYHHxTAB8xdQ+ymvq5CEKGc6q6F84xHaA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/2TCTrqXEdu7rdf+vw7GAOzkWakAV4gVn+0pm6ZQGDKC5VdqZ
	QPyRmgi/yuQ4CXwCFZTXgxIw3uyPg5wKURFGhstH6RYasaK5zRv0
X-Gm-Gg: ASbGncsBp79CkqTQFyHyOBM5D5DLZVKf4xkkEk6A92p8BkSQ0mF/8IMJCPZ9YsdSN1d
	/TeOwdH+Xt/TU7Lln23AAS0JPRl7NEbAhhKODI/PfSWoGz4/kI+T8i9k1XjoDWL8Py23rTizCG2
	Ziy58lk16rU1ru1L79rEfpABHm0x0MD9r8DomyybRH4xZJXHnWOq6Trq8VOFWuMynbd/pRdADsE
	PRlHDDp8tp9wpddd1ojupaiiRLCII8KxNjdxsiSVE7CzgM=
X-Google-Smtp-Source: AGHT+IETQgOg7AunUSIVLfQXCmw6Miexgpzxtq5jBXEGmuKIo/a/YyzF3Hf0c0R30+3xPOc3lWG52w==
X-Received: by 2002:a17:902:bb8f:b0:21a:8d4c:a9b5 with SMTP id d9443c01a7336-21a8d4cab74mr209427215ad.12.1736779093022;
        Mon, 13 Jan 2025 06:38:13 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:12 -0800 (PST)
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
Subject: [PATCH net-next v8 04/11] ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
Date: Mon, 13 Jan 2025 22:37:12 +0800
Message-ID: <20250113143719.7948-5-shaw.leon@gmail.com>
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

Device denoted by IFLA_LINK is in link_net (IFLA_LINK_NETNSID) or
source netns by design, but 6lowpan uses dev_net.

Note dev->netns_local is set to true and currently link_net is
implemented via a netns change. These together effectively reject
IFLA_LINK_NETNSID.

This patch adds a validation to ensure link_net is either NULL or
identical to dev_net. Thus it would be fine to continue using dev_net
when rtnetlink core begins to create devices directly in target netns.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 704bf9e3f097..ee318d46817d 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -143,6 +143,8 @@ static int lowpan_newlink(struct net_device *ldev,
 
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
+	if (params->link_net && !net_eq(params->link_net, dev_net(ldev)))
+		return -EINVAL;
 	/* find and hold wpan device */
 	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
 	if (!wdev)
-- 
2.47.1

