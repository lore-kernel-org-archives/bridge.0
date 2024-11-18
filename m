Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258671A9B3F
	for <bridge@lists.linux.dev>; Mon, 18 Nov 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940412; cv=none; b=aUHeAYnFWZR9Ed2iYQKd/2AB6k6/nEojMl2dooPc0LmDxNqTolp/ZTtyaZM+XBsDHniRNIvc5RdUvMOAytRRQR01sRxRqANZ1Pdt2y4w0YfmmuTkmyvmDKKILyK+rz3WAJCodlhyZ1BHyasGLWGP+Ruun/DcvhoYqsbkZOqZ4VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940412; c=relaxed/simple;
	bh=nxdsqBvo0hyUQybkrGt/3BQTttdYFRelexxuCroUuOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAc0Xzi0cwnxVvKNcSu6v5JAPMj8pQ+vj7hzN1XvzW6L8OmEjSZFS5lvfDR+ol1FWgOeOWpMpLLZ7N8eV3SrEsEhBuBbP40YJ+CrSabSDLkCkoMaQIZ9VPpXt1d+0dOI4qWdd0FuMt58ihfdI4Qvg2owTd3j2ljoQOFw8ajlG40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMDjPf52; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMDjPf52"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so3066505b3a.2
        for <bridge@lists.linux.dev>; Mon, 18 Nov 2024 06:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940410; x=1732545210; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYvUg1T5qt/avqeB8QMtp6GEfshi9DuIrKXfHc0mOQw=;
        b=TMDjPf52QIe3n38r7mff8qr0QVaZXi2ll1plpqiTK7vZy2BBg5Ue8N1rHRQflWrjgY
         IPe4ae2PgnJAHT5hUzb6jExfidyIMqDDmOifTZgb1FKZI1K4rKuUIajLL+tSzubVq/ac
         iqrSDsHlfOav4hORYRzPYkl4AS0myQOQ47HaEgdl+gYrXHsyxjZycZAHsLw4Pmpmakh3
         NzNRKQ2Ylg1TF+AJeH1pLgW8ZnDzHBWHLVhFEUv/IPHxk0baBazwaCf5ZdpjEYBb5B5X
         uFiQN7FS+iBJM6meuGPgpHkqDk6jEuKS9IvzYgFfHg3p86qaE+zY21i4UcJpGXBSVyW6
         1Hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940410; x=1732545210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYvUg1T5qt/avqeB8QMtp6GEfshi9DuIrKXfHc0mOQw=;
        b=Xz4WrWVOMT+pMmZ9/UEyDr+iW+G34lRYeq6oMqxVQ9TE3EmN5QdHYJ4UZ3jdqCicdB
         4+T77aqnk5DA2487axoS0xRMoT8xSBPe+m8seAoSP4tQIeYyVPeHblLCxGm8I5wT1qK2
         JVsfx99w5jRV/9yfhTGl860ob1PZl5X/kdJ1looVQh8/zWbiTzB8qhQRU4WTZCuIGSY/
         doKDeqzrpkZ5rUp/DFg1PwZEcA3F1U0Nsy3j61asYt58OeCNiy9i47B8AnGQTTGsfj0m
         vCF2/l+CQqC/6hFfGEEkOx+Yjwo5fYjTy+QR1g1BJE2NgsnCrhgNeR7TgYqLShXIKJUk
         EcAg==
X-Forwarded-Encrypted: i=1; AJvYcCWSiz5/hGkHQCY4KAoIW5U8r+kqLd8ZjDGAArEha9bLf70g8SzDbTyntB5uDkBWyXbGikBksVk=@lists.linux.dev
X-Gm-Message-State: AOJu0YwXGzX1siA9LBji3Wf08cxXKPTNKlK3j4815slQ57ByL9uvmoH9
	wOIbKmbk1fv+rtyFhvzRUq9mBnMw7waBCMxRDmVwyRfqoVMciYlf
X-Google-Smtp-Source: AGHT+IHPKnavfiiQCNCjr1NezmwMnBacyheV8zyl63QTPg6m3L868R+a4UJrSv5jLV5RsxhfHcRfpA==
X-Received: by 2002:a17:90b:2687:b0:2ea:3f34:f1a0 with SMTP id 98e67ed59e1d1-2ea3f34f38amr9406817a91.30.1731940410205;
        Mon, 18 Nov 2024 06:33:30 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:29 -0800 (PST)
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
Subject: [PATCH net-next v4 2/5] rtnetlink: Lookup device in target netns when creating link
Date: Mon, 18 Nov 2024 22:32:41 +0800
Message-ID: <20241118143244.1773-3-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118143244.1773-1-shaw.leon@gmail.com>
References: <20241118143244.1773-1-shaw.leon@gmail.com>
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
index dd142f444659..bc9d0ecd3a1e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3846,20 +3846,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
2.47.0

