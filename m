Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3972297EA
	for <bridge@lists.linux.dev>; Mon, 13 Jan 2025 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779120; cv=none; b=hnclJ5RML024VD1BiCq94QqRU0ULIZNFTZSbBNMu4ezQiTepW9X/Y3+yXFO4/+7k1aFVR3nW6ToUjBoHXJ/1g/xm/j0mRO7qMe+hNt7KUHQxwCVqvTgsqbrIbVR6klSRXb7500XU22TsFhtqU9iQ8+0D+efGlEbUmAtSXt10dFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779120; c=relaxed/simple;
	bh=pUkeHC9Duzkf0b0cEfL+7VFfzV63XchEu8lpcFtp5IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOQFBk27T0i2ffNE0hvUFqY4goV0hjmgfyFvzwdBJp7SYm7dNBDJknvT6319IwBnFvFyYzsLGhA6q+oh+HueovzSvBD7GY8wxFcfUgJZoGqbcJg347ynGSimrSlM8KdtquDjaWUH7krzUh8aquO6dmsF0lPcO+VxT4Ym0jVSH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e70lTYG4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e70lTYG4"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2156e078563so64658475ad.2
        for <bridge@lists.linux.dev>; Mon, 13 Jan 2025 06:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779119; x=1737383919; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n79rk6b+8xqMmWjuAyko0er+FR6QjAQIxOU32J9enis=;
        b=e70lTYG4j62XXmUto+yTQ5Vn8eBngCC+y2kdwbTY+x6Y85NGX6pdJfYKoebpCpD9FH
         xNXJ/F5XT3aEJ/qJwmaNZrk2bK18Llgh6Aln5wMqwyOfN3yVzluBEd3q1mgEORcGugF6
         ij/v9KJ7BKXXbx0iP60m3qamKCXqv1lbE8udVLR/tni9hFRprOZgaWsYeBg6UPbBDH4F
         6xFATx3ObemgQv6d3N67mpvpprqbqTKThhqKUE+rh+B/eolGw0IVCSFTUnfwsixVcf75
         79Rq5UFcBvxt+rE6vEcQQbghFTAiXfainiLNcrbcoI/j6ovDGPlLTHEHNQCTjaqi870U
         RVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779119; x=1737383919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n79rk6b+8xqMmWjuAyko0er+FR6QjAQIxOU32J9enis=;
        b=G0UrHg1l9JPbtDDneav6EQPnbyXI1HPgMoIZtKUn3sFoMJpjtb3PobYOZVJcHAflWr
         GOJ0xdHPyn3r2u3iD35pAsksd+wQk8AvxLSnC1tea5SSsQpFuPGQy/gn/tTMPSRX7UqQ
         ITPezr/BflS3GBGTU1Zmy2Uc01tvbEgHN+ogTvsLXK2ZugRv6iK06P1+PjktUiK31a1S
         Q2ErZePpHcAV0pQVi4b8HuGNAyY78WvLvfXVI3vUvOK+kD/IJx8D+Yaz/7Xff3ne3Vli
         ZIGLZjIUkkpmQeEj/C6DR53rrsltGrUv4O9Ac0vALNVTB9PhlrybZOOXGIzL7UR+zfXe
         3OlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5l8d9j0x0IpNIxv36pfa63uaPPZ95Go0s1TSr5WK7e0WjUHSNDB+zsd5xkgW9lZjnxte4GsU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxtv23Jl8HABDZGgbRLSm2nvC49+4uPQ0OCQlAO3e8vxzHk+cu0
	W1PI+bbo0MmM7o1BUz3+jfrZhXU8kzGsNrmdolPa0alwYgc7viFL
X-Gm-Gg: ASbGncuzCcf+WcRqvFJC0pBYfL10SrfZcrGMhCsI7VTIHoZ9jDhh+TUyOobf3qHW6Ry
	Czn8APScBxBuDOH/jfnNrpYXTxc5Ig0k/m2rURBHxaHptqR9AM1FchkPKbcIciInjmURwXkIcG3
	hnH1Zact1upkGC2NypKDLZ6/ELrJZFHGtVM6qjU6H/kugYvun2dlQRb6aeM+K6sbP8PIugKuumc
	o9BGSDPQVuX0cInEfutD9stQEwvJWueR5/ufmf46vytJdQ=
X-Google-Smtp-Source: AGHT+IGazeu03SiYco1yjo+DeQUEtizAzSGgMZznFsd/ItXTJBGhLqoPfMkABloEPy5ZTJeLHULJqw==
X-Received: by 2002:a17:902:cecd:b0:215:6995:1ef3 with SMTP id d9443c01a7336-21a83f3469cmr286693405ad.3.1736779118671;
        Mon, 13 Jan 2025 06:38:38 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:38 -0800 (PST)
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
Subject: [PATCH net-next v8 07/11] net: xfrm: Use link netns in newlink() of rtnl_link_ops
Date: Mon, 13 Jan 2025 22:37:15 +0800
Message-ID: <20250113143719.7948-8-shaw.leon@gmail.com>
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

When link_net is set, use it as link netns instead of dev_net(). This
prepares for rtnetlink core to create device in target netns directly,
in which case the two namespaces may be different.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/xfrm/xfrm_interface_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index b7ac558025d5..b87a5c950833 100644
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
2.47.1

