Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72631E5B6B
	for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969501; cv=none; b=ENEtjcYDnj9yAZJz7G8Yy7Agz5kjqSX0TdnKO2JGUfyCQSzi1DV1o7ryqrtCgztE2GUjnR83MtuFcz1akE5DDfhQcHExSfsmTtcKT8EIf+AVkzp0QSs8ARdrDf7BzONndNd4A+wf6PUjCfg+tMLr5SqN/ae4pyetUpNjyZZsaF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969501; c=relaxed/simple;
	bh=jZGAovV5B1ykmJN882YjcynX9CWKmzmbJdKE/yIxe+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBHQU7JPN2JKyBY2Ob7H2oD3HIs5SfQY8fsVj0jHMmYpVTsvP5wxTLh1mhPV2qBzy+ONjnoDgGPMo/jgch74kfciznnc2ofsYQdV42J94utB1duCVnBNvjCW71MAonCd0DzP83yLdMgPSw7Op7nshtAg98r6r2J0aW6UxnKi26k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb4py1jx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb4py1jx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22100006bc8so75683905ad.0
        for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 04:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969499; x=1740574299; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiGtI+5ToMID9TUSdNCghgiM3EXs9/d4cQAhclrcdwo=;
        b=Kb4py1jxkz9S0vDR/0cJegwBKilIVplPa0+YW7TRlbn7toHH3z2Nadw7dOHMTrykcM
         8vBIqNKfd0di+8SHk+Uz1O7F8c55huSQCaQ59OatqpBaOrNVEIxQ1qKStTqIpgKBJ25c
         S4fINet4JofvTxuiEK73uHHWas9nxGrr6IoUZvHTsyK6L9Qvl65uDwjd+a+dqPYM/xOU
         GaF4mqvyrJocbRrRbWEUcBmZsDWxFUQtO0xlI8ZU+92+Jk3KKPTJIdyD641uCdeQ/PVw
         /gqzeeoZs1NlkRXHEjdgVXDXv2k4nOtihaED7zoVp1LdF9WtfXKN0dyhkjWJ6ixqQiNa
         wG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969499; x=1740574299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiGtI+5ToMID9TUSdNCghgiM3EXs9/d4cQAhclrcdwo=;
        b=kBpo2IF36z6pLpl/0Fyu3ibwh+AApy2YX9W9aV8U9sK2sqW9uD4zVj6GErHtkmtmmH
         eE/1m3HNb3xOfiNYIBT933IZI/0hghd78EBbj6fHK5j6xriMUIa4voKpMbEnksBHhKy/
         jFifIrqSuBT8UhzuxtyYf+h/Olx/r20npsMf5QKWv4rqBl/8+CNvwYl7VIlsSCPTHhvM
         lrXlMxJ9WhQORcbz48Eu9H7K9xPjx2y/89OP7YhZqmEeWacX9QN+kBAsEhEgLnIwluuG
         kLUmh559q4tFU+K5wxzOBAveApyCsm3vGw0xJ2BHKYGkLWvU8s58D94KnehIrMf4Na0E
         wi4A==
X-Forwarded-Encrypted: i=1; AJvYcCWMQfbLdd/GOQXDPqlLB1P/NPY+yj7xDSQWIUE2JxHkgzNvGv3Ct+fVRSC888UNLkqJDOGo134=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8+1x67G4AL8+o+LdltZgNTyd5tVZbwC8lCyzYJfbxGRNFy8qJ
	eAA2VHssYzgPbcNyUTsniGKcqI0bebRuvWLmEPdbjtHFpjceVNfF
X-Gm-Gg: ASbGncufm9EsT+s4IseG0zJNU08mnSDyIoqQr051bA8+6Reg5QHBx1XcHR6JZ82N7Rw
	3HDqU/IgqL6rpuxdPXH3zXtjrjsa+Aalj5iMm7XZITt8CJdC0jZUEfZQGnM2bjiQyIMDeljDZFu
	rIxPOqpURVUp58/3sxEJ+dwpiSr5JI/tijyLyxw+NcRIKB9Ou8llu47B/tyN+a/EJMbF57dZ5og
	n1ITlCAr6pUxaRwtHPXLSEiLPZ93RceRyzQBulLbUjHRgqqzIm6NtY7qmFQxyC0LPmtujqLnp17
	tRO4/Q==
X-Google-Smtp-Source: AGHT+IFttmTeAFp7rRNlCvGNA6c3f8HloQtXmzYtg/s+sWnJsGTKFqc7jLE1fU4ek1ihZeJfgcA+rA==
X-Received: by 2002:a17:902:ec83:b0:21f:5933:b3eb with SMTP id d9443c01a7336-22104087bc1mr237554135ad.31.1739969499276;
        Wed, 19 Feb 2025 04:51:39 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:38 -0800 (PST)
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
Subject: [PATCH net-next v10 05/13] net: ip_tunnel: Don't set tunnel->net in ip_tunnel_init()
Date: Wed, 19 Feb 2025 20:50:31 +0800
Message-ID: <20250219125039.18024-6-shaw.leon@gmail.com>
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

ip_tunnel_init() is called from register_netdevice(). In all code paths
reaching here, tunnel->net should already have been set (either in
ip_tunnel_newlink() or __ip_tunnel_create()). So don't set it again.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv4/ip_tunnel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 09b73acf037a..dd4b4e5be998 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1326,7 +1326,6 @@ int ip_tunnel_init(struct net_device *dev)
 	}
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strscpy(tunnel->parms.name, dev->name);
 	iph->version		= 4;
 	iph->ihl		= 5;
-- 
2.48.1

