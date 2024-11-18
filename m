Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A165C19644B
	for <bridge@lists.linux.dev>; Mon, 18 Nov 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940404; cv=none; b=MiJNsDonnHv6D6NFq9/q9JDHeyNwV0kXRzky6ahCgbZbNlW7rMhuCBSBX7MyKHZxV7eE/iLvpsKpCrwRiXdyj7uUjiPK3CP9xX6W67Lo0CnN1AEy5PgVSnqoKuGQ62xOvojgqwzi2aEZPRqH2NXfYiHHM7+Ij6RX9g77ZF/Rd7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940404; c=relaxed/simple;
	bh=R2okbkGGv03EaZoNX3EjievQR0H31mw0HCvCROIPr9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihd0Rfmhv50v+v1zLyUTgrhpHeRXoH9CdH7grAaXV2FtOlCPj8/84Oz+WMCQuF3HxGAhIkFVY8sZ1eK5hedNg9DupovfTfwR38/ENvMFSdKsL9lmXC7IOAcYg0jNfnyTDUyL1mqFPkyy23K0Ts/UfVxWBoC+uv1E/6DYCAC9viY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhJadzxh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhJadzxh"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72467c35ddeso3021423b3a.0
        for <bridge@lists.linux.dev>; Mon, 18 Nov 2024 06:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940402; x=1732545202; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
        b=dhJadzxhukstHmjlXkUmR18uEauVgtCabeY16h2JmDEe90ZLb1wJmM/qVncbG4E/Xx
         Olhs5cnMH9gI3XQArQTvu1z6xS54FguL/8IQoIf4fMT58MjhD0eEoYBOvyUMLSjmpskC
         xfMf6cBfZFcn+kKVjaPKJDe3XS64Rd9vk2kFKnn0YRDMxyKdl160xNygkXoH/9BAi40/
         jKVw/4xVxxlJZRt7da3AiJ36NXq6hiRID3u01B6V/1X+PR+iF3wDJdrXVKyjS8+2ZRcK
         yDuvvmhOqfUjF6Kmmljk/iqjp7EfIAn4QoQE3C3+aSVucyFsuvRF+/4gc655PT/zul3o
         tlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940402; x=1732545202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
        b=Gs2lfiEa8Ysam34Zz2AMitkl3XS8eMOjF6o0tkt3to3RkvgG6Arud06WqPsJLun69V
         OwG8kjStKjfiRQR1440/635egNcZHNz2XlWfvVhjHH0h8Vrly0Vv47+7IlSzg4J7JcHr
         3TbaNK+HIU6ODn332ZJsVPOcaTafJhTFNerKCeT/N3Rpfgp8P4wmcl9GN/Qgr/FiBNQN
         UWnyR140l1wNjSKlN5Sjs19qmCtlzj0OHMz8/dpUFrwGljcgUj0Y0iMiFHjxL+EaYjSs
         4m+nIHhS6UoOESBVpq1rwd424cg3ZFZtuJ1j0GxvLdFhcfZcODg2EagBRyE+1L8qgBB+
         NU1g==
X-Forwarded-Encrypted: i=1; AJvYcCXcUkMaJiQYwo44J5yVNKmSmPAKRRHVst7h89jNh0EpjRfPV+Ud7g++JZdwErk03iJAnz5iFpc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwlH/BZaX7Ra/YhV4I1eezCLXEHEjdZ/cOhQJMgDEQ/gEIeeI/V
	Yp60sUJXlTqiJtNrd6eTqNeJVHCF0bWb5wS3S+oP+BabljQXePKG
X-Google-Smtp-Source: AGHT+IGzbRz7s9CT801paPWPDasO606/jlaO2UpnfJMF7tMlUetZpF6RTCqXaMFrG8I7wghYj9+EFA==
X-Received: by 2002:a17:90b:3c4e:b0:2ea:9ccb:d206 with SMTP id 98e67ed59e1d1-2ea9ccbd33amr1559048a91.8.1731940401993;
        Mon, 18 Nov 2024 06:33:21 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:21 -0800 (PST)
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
Subject: [PATCH net-next v4 1/5] net: ip_tunnel: Build flow in underlay net namespace
Date: Mon, 18 Nov 2024 22:32:40 +0800
Message-ID: <20241118143244.1773-2-shaw.leon@gmail.com>
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

