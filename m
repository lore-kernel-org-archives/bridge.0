Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EBC22F169
	for <bridge@lists.linux.dev>; Mon, 13 Jan 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779068; cv=none; b=NtXOGATLViFmRZ3jvby11Fi3RLeXMED1XdhKdh0tE2cDKz3mKSAKCfnObVbLF6fdSo+sj6e2AX5/c0qU35wQ88fscf45CFhfs+3tfKH/ZBkHm3TfS/cGJzTl1gLm9znPL0tRB6Mt/HdY9GS65NO7KWxPk3Dq3Wixr3+xsd59tRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779068; c=relaxed/simple;
	bh=1RoOlxGJ2Sn6kgEHCY+FxkXtwcVhSAPqVZyj9KxB0EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZngoNdT/p5zftY+5604HyHjVmRiBKcRJijKLqR70inqrhBK+ANY3Ln2pbGdPoTlisQcSQ4Uav8DiaG/byDJIhptnTL+2qnEBZsD6NPIy/vqesyButDvee0FBZnDDqEZDl6dqpjFVEW4gbHnP3hdHepNSGslot5i4wUs6Ze3wsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTyCjZAB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTyCjZAB"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-215770613dbso52918635ad.2
        for <bridge@lists.linux.dev>; Mon, 13 Jan 2025 06:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779066; x=1737383866; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aStnhmnU+u9WzYJvS9wSRsKutCltWxiDBFKzpdLaN7A=;
        b=BTyCjZAB0L8mFN9x6Gge9K2nwEMDYjFFd4u9V2Ke+iuR3JqFBO7tVmZEQYzCShtMdQ
         2DL8VRr02QDGxTFDwCTcVnRTfgD/kIFXz18Bus1+LyfkH/HJA6dUaZ1QaWnRRCfR0Vcq
         GX9NZo0lq7TaeSdVk+5HEr+ow/wfz8lYku5QV0JZJovQVKSxivH3w0kxJLAV2L4yV6PK
         rn9Yh3eXy1D7LlLjX5bO2QdGh4rqfV5oOKdodlzSzaCt9xPFDnCKUnOUBKAiTRXVvKmP
         Uw/9z4WLLNj69PDN3j0fx0fvqWPCL6MerHolmmcC1XZDtlqxuTFfPL6c4yaUgEVmIYOE
         u4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779066; x=1737383866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aStnhmnU+u9WzYJvS9wSRsKutCltWxiDBFKzpdLaN7A=;
        b=wVDVWmXqrQkdCpvpEV/PUCRwwsplXyB60YAvudw6EzjVsk8DiRP2qaDkzGURnGiyZS
         bdTV06JXgrACyQUT26xrlXgVpNP0vgNra3G1H01HfeSYYoreBSpzZ21e2pVB1gni22ph
         GZYNdkyBZRIw7VXG4DYm0HtAtD+CHD+aM7vp4EoEHRgW+4OqGLffRxUtF3OV0nfCWzwN
         KyEGi3UJ0XbH9P8Ftz1g1LeM5Ud7nfR2JRlgjLmUZXRpunnubOCngjWBDVwJ1eWLtfax
         wzJL76lM4sZ0mrWehE1J61Yv4S1a9UlXFlLKNL7SQogaDlMYhuGz/Il/Ujku0Lb5CFFW
         XebA==
X-Forwarded-Encrypted: i=1; AJvYcCWaNt6TZbsIH15YjVezmnffmLfZOcXVz+efsFBOxcoLndtUu8fy7z9M8bVybmUbIUBD4e0iw0s=@lists.linux.dev
X-Gm-Message-State: AOJu0YwalEfHkoWbA4a187n9buJNKbM1CkNO9/HgMtbbPq/9CHiolAqJ
	vAPlI5BAPm+nTbFrbXV3JjVzAYiDtC5cI4CTimCckPDbxtQP0Dwu
X-Gm-Gg: ASbGncs//49TpTYiaS8Q+mbPJdkHHRQkMf3CEw0wAd8g6ANmg58JB2JaIpknLF6FdWl
	YiwPB0Ogj71lxk5UUzTw3sRWehg3NeG7aZHcD3rufcMRyUyHxu5eQpzMdFU69RF8yrBPZRTNHuB
	fZe+LEt81ZyV1nNYekSlllZx4CpCYR0ZhsclROd4W3lTcrgQr1P19uZ6od3fz43EkQh9kLe99Pe
	4/EXHDChjwH7G8OdR1sZNXOLs7ISiCLwFqHhoze2eMeV+E=
X-Google-Smtp-Source: AGHT+IEEIzRcAyOPsqmoPyg3LqUO10MpSinA1zy4f8+lVawQb15WuSETw63Trl8RPwnuvmvDM8k1Dw==
X-Received: by 2002:a17:902:e74e:b0:215:aee1:7e3e with SMTP id d9443c01a7336-21a83f36d48mr318259495ad.5.1736779066532;
        Mon, 13 Jan 2025 06:37:46 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:37:46 -0800 (PST)
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
Subject: [PATCH net-next v8 01/11] rtnetlink: Lookup device in target netns when creating link
Date: Mon, 13 Jan 2025 22:37:09 +0800
Message-ID: <20250113143719.7948-2-shaw.leon@gmail.com>
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

When creating link, lookup for existing device in target net namespace
instead of current one.
For example, two links created by:

  # ip link add dummy1 type dummy
  # ip link add netns ns1 dummy1 type dummy

should have no conflict since they are in different namespaces.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/core/rtnetlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 1f4d4b5570ab..ec98349b9620 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3861,20 +3861,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct nlattr ** const tb = tbs->tb;
 	struct net *net = sock_net(skb->sk);
+	struct net *device_net;
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
 	bool link_specified;
 
+	/* When creating, lookup for existing device in target net namespace */
+	device_net = (nlh->nlmsg_flags & NLM_F_CREATE) &&
+		     (nlh->nlmsg_flags & NLM_F_EXCL) ?
+		     tgt_net : net;
+
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
-		dev = __dev_get_by_index(net, ifm->ifi_index);
+		dev = __dev_get_by_index(device_net, ifm->ifi_index);
 	} else if (ifm->ifi_index < 0) {
 		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
 		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
-		dev = rtnl_dev_get(net, tb);
+		dev = rtnl_dev_get(device_net, tb);
 	} else {
 		link_specified = false;
 		dev = NULL;
-- 
2.47.1

