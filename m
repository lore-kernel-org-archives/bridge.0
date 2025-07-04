Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4BB18A6CF
	for <bridge@lists.linux.dev>; Fri,  4 Jul 2025 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751656332; cv=none; b=oQXZVTzHGY0cp1l3+kWxxmDFJvWRvBWE/ZxqZsDAhmpiSbMqYkKht1o2iBW2l3Fhl0eVQOC0rCXvbzvLuNZAEoswo/0JEWUmsy4gjOeQ6VHMGvwg2eksyvLijN0zUzAX2pJvJK5l7ayN/MX0PCoLywFQ7TxRhomBdUWQ9+oRLs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751656332; c=relaxed/simple;
	bh=gGLH/JlKTyA6/p/VgBdxmkkBmO8oVKYwNmqtLQvoMnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXc0noYXHtfJYfi4EdThgr0fGeTlCxJ9nePVZkknX5mkujXz6pJffvCd1Xs9O9Xtuo+IqQ79YCx3atX/8MBl1bJaP8JDw0i0mKIQUBjJ5frOuqa5vJn8xtZtqh9RGlq9oCeHsKBuBYay4eYAvTLNGoV0LIHPXxhNCA5MLmJPuiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBzP5/4n; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBzP5/4n"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so2468733a12.1
        for <bridge@lists.linux.dev>; Fri, 04 Jul 2025 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751656329; x=1752261129; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=arcq/ErtOfcFvfh9otQX41x8yyrUNGvPRfyCCfAn7OI=;
        b=UBzP5/4nP0//8HXHNFPty7Lgmn5Kzlv4pLMfs0Nc0IvrO98UsMYoaduHYZ7EbwVQU6
         vx8lxaccJC1ggszuBqsR5gS86NWAvyHEWbhSS+6IE9zG6VH0ci7OMm7ciJuFfnl4jFmP
         j7qUOqCOZbtCUvbzlfvH7IN0AIZSQWodGArc+czcHtTPAwt7wMLC9o2oo/SPFYFilsrW
         qf2KVyN4cvDs4RDetUr5WzYDFuQ5svTye2AoSesbudyNpKnXO2g05lCI8XTkR7e6MAoi
         dZ9rKLqqBQ3c3cv0zdt47a2fx6rNHyHqJoCYMvJHCfbPdUavJ80yzSjMBX2uoHVP/qqW
         F7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751656329; x=1752261129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arcq/ErtOfcFvfh9otQX41x8yyrUNGvPRfyCCfAn7OI=;
        b=ga+JIJTkx1+0/gm6Cg1LJvJRw0O3V7O7AYQ6zYDxexcxdyJXPreaDvIsBgX/05Vkbf
         /worD0hSqH4w6vv9q0Rh3kEEL6dbN7FKBvBsM3wGe/t2UhWPbGUftsRdNS1u9wyuFcld
         PgOH2JreUp9tbvgtu5M7Fbd/lRmkBihrzW6KthKPkOpcQp0kjwu9NKjv44r3U5qWwqVE
         zd+pnEcKvu2ZKfdPrWkvL145xHYsIRpOpIj7pfRK7JICZwieUdciCisPCshDqEEZnr4h
         3jue3R7l/obfy9VdeWh5kC1gCG0m6B9LGM80/Qxr1mYUzwMcHtJv4xdrbFrjKNgliBMf
         rXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh0r/qw3pSt6zo/rUfLZ8yJ0fwl5VP1pL/VZKrsRmKffgGy2DiLJJCcyQczTRZ+0qZEEVXAkQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzjUDEnNeQnWD26CavqNNtIDBWh6bMKJrzfgb23ZTspXMb9W4IR
	RhnIim+7/+6CPY3izLzza21YwkAFGHWIWHzUtOMT3Skem+4BUT215ImR
X-Gm-Gg: ASbGncviQuZaewDxX5K/A7VX5LgjRhI+w9iLnibdXpP+QABg8EhkciBbkb7sfz+75ez
	YlamvLtCZCnIukTe352j1CkShobgY5Bz75e2L6L9buDNMl2DswLc2UNAzYo2LAMBJWWfsSvoh9R
	0USUEHhbsfwLrze6+UuaECcob3Jetod2Qztnr8ztZypjKUnZYnM94VrZZt92EDjp8zFljlR624t
	kZuQhmboEPF9XsGlJ1VfnSr4kkti3imUjk0PbTac07zNWQwyxHuCUlJKQc6b1LA22hvEBn3kQXh
	ec1Js6S7/VB0LGgV0cd5rL1Hj/2n/se3V5UXBnbzqeMY+JurDtUSye8DJtNFeWxcIwzz+XVQPgV
	GkdzVMeCN47QV+ZY+H6lxVPOD5Y3NGV65QeRp+2NRTk6zzfZqNQSw4rI5E6284QVuqehvu0N7lN
	hJuZsO
X-Google-Smtp-Source: AGHT+IH6Wy6t35yxZwdbREf2KP8F/vMkR0pCc84m0GGVPeJFvjbmyJnNONYiLqB7H1xjJWBsRk1v+g==
X-Received: by 2002:a17:907:e90c:b0:ae3:5887:4219 with SMTP id a640c23a62f3a-ae3fbd49cbdmr332139166b.45.1751656328560;
        Fri, 04 Jul 2025 12:12:08 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac5fd7sm219476366b.103.2025.07.04.12.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 12:12:08 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v13 nf-next 0/3] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Fri,  4 Jul 2025 21:11:32 +0200
Message-ID: <20250704191135.1815969-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conntrack bridge only tracks untagged and 802.1q.

To make the bridge-fastpath experience more similar to the
forward-fastpath experience, add double vlan, pppoe and pppoe-in-q
tagged packets to bridge conntrack and to bridge filter chain.

Changes in v13:

- Do not use pull/push before/after calling nf_conntrack_in() or
   nft_do_chain().
- Add patch to correct calculating checksum when skb->data !=
   skb_network_header(skb).

Changes in v12:

- Only allow tracking this traffic when a conntrack zone is set.
- nf_ct_bridge_pre(): skb pull/push without touching the checksum,
   because the pull is always restored with push.
- nft_do_chain_bridge(): handle the extra header similar to
   nf_ct_bridge_pre(), using pull/push.

Changes in v11:

- nft_do_chain_bridge(): Proper readout of encapsulated proto.
- nft_do_chain_bridge(): Use skb_set_network_header() instead of thoff.
- removed test script, it is now in separate patch.

v10 split from patch-set: bridge-fastpath and related improvements v9

Eric Woudstra (3):
  netfilter: utils: nf_checksum(_partial) correct data!=networkheader
  netfilter: bridge: Add conntrack double vlan and pppoe
  netfilter: nft_chain_filter: Add bridge double vlan and pppoe

 net/bridge/netfilter/nf_conntrack_bridge.c | 88 ++++++++++++++++++----
 net/netfilter/nft_chain_filter.c           | 52 ++++++++++++-
 net/netfilter/utils.c                      | 22 ++++--
 3 files changed, 139 insertions(+), 23 deletions(-)

-- 
2.47.1

