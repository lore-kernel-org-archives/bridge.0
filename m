Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E120265A
	for <bridge@lists.linux.dev>; Wed, 13 Nov 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502675; cv=none; b=R8FzLm5kg1XLN/VqhmUz74KyIeAs3zb7cCzFu55cX4RiXBTZ1YffHpm+lEbSTKAWIXnBBkzD69X3UyfenA4/bhuvokuStDa0Sv3sjnWVDYobbpvRSyhvjDlpaowgoxsGh8tUVmZdCzyYQl7tgKkMPmNl1OHSY6GIYiRTT8qIdns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502675; c=relaxed/simple;
	bh=R2okbkGGv03EaZoNX3EjievQR0H31mw0HCvCROIPr9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNtjLcfjmWDL46ysosqXQ2t52swqiVdyT5op5UtbmhiMpWXwmhQl6MmeGcierpyZ74rDsWUf1dPlkEK9iGkKVS/P2ug779URGlRgKwEW2vHXnyScloVQbElUgk6HpQPTpyMfhXHyZnuuFfEZPe381tQ9iqCgHvoVP+P0RUa0WiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPyAA6A+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPyAA6A+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-724455f40a0so1943477b3a.0
        for <bridge@lists.linux.dev>; Wed, 13 Nov 2024 04:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502673; x=1732107473; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
        b=lPyAA6A+rDYVML/PSnQrL+YujMqklhNYzjbG4qo/y/uwwzWL+GT7Pq1xvKRsKzuomY
         kToREpGbDgq6L4Q07hXZBUdY6Ksh94FvSfQZ59JkLvVUsvti8u1JmgkkXNMa/Ljib9up
         b+CI7Z7wySvnY+QzzGRnmAz3uXkRHQHRExlsF6R9NZ8WSAPTq/wKnF9qYsSoRXvc93AN
         DXv9wJvPVB1jLeSYrjdgiKF+yFXYqv4Ofs8A2UcKsi/jN0LIJd4DDKQTKuucs96DHKV0
         /UUFpTuqDFVorIw401J7KIj3t3ZXe4Q3rgH5cbyjU6yOmH5JdRC6ffRKh09/xLTUo17O
         r3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502673; x=1732107473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
        b=qhz8oKzljH1VCgQWoOeVT+hIY/E3lvKjXrTHQOhDXKzArJlZmz+GfnGv1P5ykN0DOe
         qLoJhnGo9TGwmhPMEJChmvsgqiA4QtqvK4eukGbFWalYwzOXtC7OtPaJsFZhnFRzTILf
         u36Lwm7cZG2vSRSJ4y+dibMfob6lGu61cQXvLBbIt4iMgFzf4UgyjZQqswRDUk2OxGbe
         AsPGqbZa4OKIWtYbwgeZ7fM/81g6Lc6i62onRtdQcD3ngQOyib67fg3zfqcnfyfmjSym
         XDU8jb8z7ju6nRN+DALjfCbtpTojzSdOu2CSs3cBmyDVmWOHz6dUuOUZzt8cQGcosuuI
         RcLw==
X-Forwarded-Encrypted: i=1; AJvYcCUPfNPrvYm1+ebR8lrqBJN6W038Dn4zAMSpIIHtsRM0K9oH/c87VSDuiKQ/80WMVzT2xIH/lEo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx87F++SIEEEvcAxN7i7A4fnPkjvlzy/sUkDopdZY+WRhbig/js
	7gwbyhmGI98vdo0ChTNYcd8vhYusq7S9pVZHfVhfc6kAja5h9xyH
X-Google-Smtp-Source: AGHT+IGJi6Tp37K+i8d+pRtqcGbSCXzQQJQiHEkYvBXRMyT+Ytmcy1PnetStqWOPaDWwW+msVvcvjQ==
X-Received: by 2002:a17:90b:38c4:b0:2e2:c6a6:84da with SMTP id 98e67ed59e1d1-2e9b1799123mr24937176a91.34.1731502673070;
        Wed, 13 Nov 2024 04:57:53 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:57:52 -0800 (PST)
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
Subject: [PATCH net-next v3 2/6] net: ip_tunnel: Build flow in underlay net namespace
Date: Wed, 13 Nov 2024 20:57:11 +0800
Message-ID: <20241113125715.150201-3-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113125715.150201-1-shaw.leon@gmail.com>
References: <20241113125715.150201-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Build IPv4 flow in underlay net namespace, where encapsulated packets
are routed.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv4/ip_tunnel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 25505f9b724c..09b73acf037a 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -294,7 +294,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 
 		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
 				    iph->saddr, tunnel->parms.o_key,
-				    iph->tos & INET_DSCP_MASK, dev_net(dev),
+				    iph->tos & INET_DSCP_MASK, tunnel->net,
 				    tunnel->parms.link, tunnel->fwmark, 0, 0);
 		rt = ip_route_output_key(tunnel->net, &fl4);
 
@@ -611,7 +611,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 	ip_tunnel_init_flow(&fl4, proto, key->u.ipv4.dst, key->u.ipv4.src,
 			    tunnel_id_to_key32(key->tun_id),
-			    tos & INET_DSCP_MASK, dev_net(dev), 0, skb->mark,
+			    tos & INET_DSCP_MASK, tunnel->net, 0, skb->mark,
 			    skb_get_hash(skb), key->flow_flags);
 
 	if (!tunnel_hlen)
@@ -774,7 +774,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
 			    tunnel->parms.o_key, tos & INET_DSCP_MASK,
-			    dev_net(dev), READ_ONCE(tunnel->parms.link),
+			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
 	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
-- 
2.47.0

