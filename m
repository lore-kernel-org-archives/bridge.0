Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F379340400
	for <bridge@lists.linux.dev>; Tue, 22 Sep 2026 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046200; cv=none; b=rDXDY5+nePwz2G0IhDyCtzRy9BQBvjN6ixNXwYxhjEYvGk7TuKe2pQFI4kgmzP5PS46i0fCODVmJeLQ4ffgpnbauwYJUX7wOyADYzD1dnDDemGVVKVqfs0v676dz9xneSe7cHzGCvhMU1AkLnwI0RTSI8a97cTgjbOIcgPJvEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046200; c=relaxed/simple;
	bh=7SODR36kHYK1IakVc5HOz6krTaW3m9saxbK5Vnu7M34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mKmktuE/D+n8a3ozEYwNPqW1PwrxDY53yuJJ2vwVEsYESob0tw/S5mD6sAIcIxIiZ/0UVsbEBlk8eIBr/UNrW8iG4YZ++g57X6x+cExXhO0+OY7/2qEQwRUwrRO1b/aZebPULh8AVLEu2+zmwipjGr6IaKXjeqCJzsEzCT9u1Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clmbFpQ1; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clmbFpQ1"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab19127so3964155d50.1
        for <bridge@lists.linux.dev>; Mon, 21 Sep 2026 20:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790046196; x=1790650996; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ixt/Rxi4OM6LS0sSMn+Kn0k0Yx5XJM0PK6LzpYStkGc=;
        b=clmbFpQ1b3oFQG+eJ27xRA5YK2+SUZ7xj57wWVNOjlLnm/txW0ZuOkkkZMPqc46ldQ
         IAofaEcLb/XnJSLMuhj2e7VKQ38ooZlBtZUbmnlKMGp2CPshsqhiA98gSsIEQx+IFMvd
         WDjPPZRPjKTKbwdvSgnDVqeHeuMncJBOth4piOMoOYy278TUyKws/o2NUnm44CEsyUGE
         gXD1KbohWlBfWISgAdvsjmSCzezz47pB0rJCt/6VJwS1ob7GJoZUUFntYjXoiUlbf2hE
         PEy6NCqi+GY62lczkgX8dqsYjwWa4pLu9Qkd3rFFkRNijja352whffImgZbVkfiB1GMj
         Jlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790046196; x=1790650996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ixt/Rxi4OM6LS0sSMn+Kn0k0Yx5XJM0PK6LzpYStkGc=;
        b=JHukDnysGLYV+jFgQNy8GHSXGqB6/3TwRdVhOfQGzmin5lOhoTK85SiPwSnLBqLf/b
         GKwpECCKgxhGL5e7tqBRBVzk2bBDoh4zXPC+2I39fI+mXvPbApptoPOUdQdjH3tovFj/
         tgbWqe33cfnEJKUbWskrP414ighTtJHzdowTjxXFnlH7ixQXJFVpqa7KqUkiGzOv0AwK
         vJJt/sGNI+jscZCwBbAruJibf6oabJWMSOV6X4XFI55myrAwx6DzGrPPnHnLZKaK6mQe
         jzhYFXG3gOcy2cvwXbjEj5R/DHIKgSQVH+B6TAaqzDI7MCZ6FW5X4wIbQQcJEQL65D7L
         butA==
X-Forwarded-Encrypted: i=1; AKwUvBylMuaq8h1E5I56ONkBgQgHGYS/M0V2kfnMdJ4ilMh1eWSB4gmE2VbxWV8s+jDWeOmTFHyjY8w=@lists.linux.dev
X-Gm-Message-State: AFuF++kfGRzblW1WL0SsvB8W0KI7vEUcqop+COsTdBvnRBpCymtQphnu
	rSlP2/KjtikXXbWxHAmEFeGAz/JekxR+j2VFlkscv526MBSzaSe/j+8a
X-Gm-Gg: AYBFou1cONmfYbw9ZDNQe9mTed886vVB2kFON5DSp8HZomBYff9VuZaEES6t6mDviyl
	g9e+hEXO26JuCwcYLTMgBfTEiQNe3pRRpRBUAZ0owo1WOE5f3LbZx4RMSC+O+VRg9+gwJ/gcAGj
	JLvormfljveXN/bCRLo0KGE7qPa8/1lGuO/Rhd0B9boOw6hQxLp0bU+O5v9tzwUm9jmNeez89Z5
	piSVP/+253Jr74Z+DeEKY1EjSgweNyjbAB0wFF0tzI/widnyLwWzuVrrgU7zBCcUFQ/WinNDJou
	kpnCYkeMQA7csjJ8SpBoh+JF+Q0DqhmEjwl2RsuKYoeza+bg8FKVmjwjZHNpaab9+wihXrFwwo4
	35SAO6VjRjAXYj0AXRWhCgRHtKXBKcmk3yj6sKcbMScp2qkcyEwx4dTLP5d8YI/+P6+0lWPneT7
	vZ30ggOGb7y9zc/DkIKi0hWRsd4nVzM+ROy2g7qQ7S93yUoyK0Oykghbe30dqlYzqMLo5do1qYP
	r93RoHgQOIkumxkbSYgKKXfdyhUMTctJYBWcii+TwJWxEonfHgIk5T8R9MHwZiffXISx4J0
X-Received: by 2002:a05:690e:1181:b0:671:70d2:527b with SMTP id 956f58d0204a3-6717fd6a661mr4352075d50.62.1790046196312;
        Mon, 21 Sep 2026 20:03:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:2875:43a3:e345:710c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a2c1b02abdsm1471447b3.17.2026.09.21.20.03.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 20:03:15 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	mst@redhat.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-um@lists.infradead.org,
	virtualization@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6 0/2] net: prevent partial checksums from modifying network headers
Date: Mon, 21 Sep 2026 23:03:08 -0400
Message-ID: <20260922030310.8684-1-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A virtio-net header can supply CHECKSUM_PARTIAL metadata whose checksum
start resolves inside a network header. Software checksum completion can
then modify bytes the stack has already parsed.

Patch 1 checks the data-relative L3 origin in the virtio-net conversion
paths. Patch 2 checks the parsed header length before checksum completion
in IPv4 and IPv6 fragmentation paths.

Changes in v6 address Michael S. Tsirkin's review of v5:
- Name the Ethernet-only L3 parser accordingly.
- Derive the AF_PACKET L3 offset and protocol from the actual Ethernet
  frame, including inline VLAN tags on an ETH_P_IP raw socket.
- Use the IPv6 base-header minimum for IPv6 checksum-only packets,
  including IFF_TUN before skb->protocol is set.
- Restore Assisted-by: LLM on both patches. Patch 2's code is unchanged.

Validation: focused x86 allmodconfig and UML defconfig W=1 object builds,
strict checkpatch, and application of the exact mail series to the stated
base. No runtime regression reproducer was run.

Link: https://lore.kernel.org/netdev/20260921025341.44846-1-habte.yibelo@gmail.com/

Paulos Yibelo (2):
  net: validate virtio checksum start after network header
  ip: reject partial checksums covering network headers

 arch/um/drivers/vector_transports.c        | 13 +++-
 drivers/net/tun_vnet.h                     | 52 ++++++++++++-
 drivers/net/virtio_net.c                   | 10 ++-
 include/linux/virtio_net.h                 | 87 ++++++++++++++++++----
 net/bridge/netfilter/nf_conntrack_bridge.c | 21 ++++--
 net/ipv4/ip_output.c                       | 23 ++++--
 net/ipv6/ip6_output.c                      | 12 ++-
 net/ipv6/netfilter.c                       | 12 ++-
 net/packet/af_packet.c                     | 24 +++++-
 9 files changed, 214 insertions(+), 40 deletions(-)


base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
-- 
2.46.0

