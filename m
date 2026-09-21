Received: from mail-qk2-f27.google.com (mail-qk2-f27.google.com [74.125.230.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344AE324B0A
	for <bridge@lists.linux.dev>; Mon, 21 Sep 2026 02:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959232; cv=none; b=VvZeEwlYlo3IhnOJcrYECzaqzQ6uvKJXeb8gRDvf6p5LzF/ghaVMsoHVfo5FF1OMGTWI2TypaH763rlm5Vlji6pq8BYS5ti7CVXRjgXycajnZVKbbiqQKNd6PMuHNdKcpT+/NCoBl0J2LMpNSmBJOEzyyYzIsDhvjAROKhIMRII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959232; c=relaxed/simple;
	bh=1z8hxM5s9yvUWFN2dVotJ68WWyLuICEJqjli3GIQhLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7hwGI3jYSkSLp2j0qWskyRcRnzvWLkhqk/sTGW/UUBUQbQtJQjASfQIGMnL/72t4hOmcStABqgNNqKmZ/bZNv5krD3Q+FINnP8fSw2vjVMKcU/EtgjyuzG1vOsMTYLxvtncljAUVvraYyYNl10UIHqEWjg6lBqWkYMJ4F9+17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHquYbeN; arc=none smtp.client-ip=74.125.230.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHquYbeN"
Received: by mail-qk2-f27.google.com with SMTP id af79cd13be357-939ca12ab70so317942285a.1
        for <bridge@lists.linux.dev>; Sun, 20 Sep 2026 19:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789959229; x=1790564029; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/1dyv75kvDtXna7My+DxwKsoa7QIaIFxsslk0GYF3w=;
        b=BHquYbeNOKgOvhlpgphtlSkksDzlskCqyCpW447vPYoyG+HxDMboCeM2aL6KfRmp9f
         pYKPaqsoUsEfnxA3IiR+D1Fq9DjX+C33Q/x6ToLLTAtE74bWS8IjaoU08Lto7ZEHVD26
         CkKs41RllsdQgI01goz5w9CZEbX5SmVHohIeMQhBdU3D+o14+j0tsCciyLQQx2qLfRge
         XDI/h7qCjxQApCsPcULNDeyplJRvFuFQKiefg8Vx+FI2wY/Xo9MrPC/0fA79cq8Ouy3d
         YkN35SUInlzC0+568SNaFeZt+Q45GMeLHrSWxZPTdhCqCIi+7IKeyVPHKPFXboERx13D
         zQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789959229; x=1790564029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/1dyv75kvDtXna7My+DxwKsoa7QIaIFxsslk0GYF3w=;
        b=ZezqzBScsUBnvXF0CngT10784dPk4cepmYMhE+eootLdpxfEMnTMNh81FcQs1voYg7
         oI/SipqYbvS1BJ4tcnwxT5ahXFYVAlKW+EP0HYKdtC7yhnENx91ycySvMWVsiE6tpX7N
         MjQ9lDqXrYGrDU8od0Hshu5oMFt1Cov9xffFNePr48rGBrPBRerSZ82adJbX1+abZ6Xx
         0dlzgjx5jURLoJcArv0I+0Y7nbO4hwYYGtu3AWg5bWuQny54kM0/4I0ERfIDRXJ4dvh3
         scez8MayHkhG1wjcyJ20HTXHEKijbSnB5G+nCf/HVOr6jFuXp4UKrxjcHujz0PR/MoSn
         mrkA==
X-Forwarded-Encrypted: i=1; AKwUvBwhLpvKqa6M6MewGWwtt1yWtrzzMq2C5G4w8paXOL5kKbos2F2tWAtDAjxT1rSmHZlT59GTsmY=@lists.linux.dev
X-Gm-Message-State: AFuF++lp6vJeFxRLNYMeoQzJYWOzcHxjPucLp9zrkKHid4U2oyubnqrm
	POZdDzCEgIrUOllInp81eTpBKgmMq6WprHoUsytrOnBS84kdo0ffUgsA
X-Gm-Gg: AYBFou2J7LfmIwhSjGjR9MdJEkd3nEHhfMjpS5P9FmmcZgf60EScCoMYc6oOboHRLpk
	QcUNZuqb1YfMKB2gzAoiFUtfL6gUW1kuxFexQ8yDxVbyRL+NUCEL1RqfjVF3OgnRJU8qFDEKZQU
	XFEv3Z3v6kP6f58WDrYgjUM1/RWgB5BwFYezB+St/Q+kOmfN6V9JFKE7qWDfzy8LrW2jdTuWgcJ
	1G53tDhNRMh5BoEtyatJxp0TrD44gUL7Cytppc4SGhxWOuZyMBQigo6ikdam/kbBLJeE6ra38db
	R901T9RK+SlFzrvghVnnwhYARtdBb1pYDdoVc53H8QClnWtlcRKqCSSdIusNwZaklmo0MwHATV4
	s7W6+1eiHHVFtaIHWnZW0lxXm75Zl4N2GUvaMwRQbGnh7hsJd1T6Nx32R9SoMsCYl3YSOpAM3/T
	svkzY+lwNEnwcuRMKJbU21rXuzGepyEdTex1Vg4eTQkxR9oXJrA/e9G1raAy5QcKOERK6yQHiJ3
	xy04tstRqPpY78U3wgZBsEcLavfOi0KfONqVZ8C5iiuiaVSKuHdI0UVq4iwOl4DyrCeGsMX
X-Received: by 2002:a05:620a:3187:b0:939:d913:9a74 with SMTP id af79cd13be357-93bf56ef696mr809392485a.46.1789959228703;
        Sun, 20 Sep 2026 19:53:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:64b9:5e22:f77c:324e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bedb3de58sm528732785a.37.2026.09.20.19.53.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 19:53:48 -0700 (PDT)
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
Subject: [PATCH net v5 0/2] net: prevent partial checksums from modifying network headers
Date: Sun, 20 Sep 2026 22:53:39 -0400
Message-ID: <20260921025341.44846-1-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260920004733.6473-1-habte.yibelo@gmail.com>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A virtio-net header can supply CHECKSUM_PARTIAL metadata whose checksum
start resolves inside the network header after link-layer removal.
Software checksum completion can then modify header bytes which the stack
has already parsed.

Patch 1 validates the checksum start against an explicit data-relative L3
origin. It covers TUN/TAP, virtio-net, AF_PACKET, UML, nested VLAN
headers, and tunnel metadata. It does not rely on skb header state which
may not yet be established.

Patch 2 independently validates the checksum start against the parsed
IPv4 or IPv6 header length in all four IP fragmentation implementations
which complete partial checksums.

The v4 Sashiko findings were correct. Patch 1 used
skb_network_offset() before all receive callers had established it.
Patch 2 compared a signed checksum offset with an unsigned IPv4 header
length. This revision fixes both findings and covers the corresponding
bridge and IPv6 fragmentation paths.

Validation included strict checkpatch, focused x86 and UML W=1 builds,
an offset-boundary model, and application of the exact mail series to the
stated base.

Changes in v5:
- Pass an explicit data-relative L3 origin through the virtio-net
  converter and audit every in-tree caller.
- Parse Ethernet and nested VLAN headers without mutating skb header
  state.
- Propagate virtio-header conversion failures in UML.
- Keep the IPv4 comparison signed and add matching parsed-header checks
  to the IPv4/IPv6 output and bridge-netfilter fragmentation paths.
- Drop Michael S. Tsirkin's Acked-by and David Ahern's Reviewed-by tags
  because both patches changed materially.

Link: https://lore.kernel.org/netdev/20260920004733.6473-1-habte.yibelo@gmail.com/

Paulos Yibelo (2):
  net: validate virtio checksum start after network header
  ip: reject partial checksums covering network headers

 arch/um/drivers/vector_transports.c        | 10 ++-
 drivers/net/tun_vnet.h                     | 28 +++++++-
 drivers/net/virtio_net.c                   |  8 ++-
 include/linux/virtio_net.h                 | 76 ++++++++++++++++++----
 net/bridge/netfilter/nf_conntrack_bridge.c | 21 ++++--
 net/ipv4/ip_output.c                       | 23 +++++--
 net/ipv6/ip6_output.c                      | 12 +++-
 net/ipv6/netfilter.c                       | 12 +++-
 net/packet/af_packet.c                     |  6 +-
 9 files changed, 157 insertions(+), 39 deletions(-)


base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
-- 
2.46.0
