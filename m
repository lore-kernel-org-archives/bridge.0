Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A582264B0
	for <bridge@lists.linux.dev>; Tue,  8 Jul 2025 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987548; cv=none; b=TJmyotSJd50UJ7moK+wYKJiD5zs38kkI84ltiFX8rdwpzdOr+KAdDhU+ndcXyKhO5gtdJmrMsSnBfD3bUtsOuL2LB8CSCHlDBsFWsEmfJDz7Uu4bQsBH6P4Mun9V3jIPyu1KVcpcw/VSnVjtSEmkKIcip/Y61vKGnKFD3kbvhZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987548; c=relaxed/simple;
	bh=MgsSBh18JLwXEgMfnryp+3Hhf+eOukwRcV5U3PxpKmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Op568r+ezMZF1K6vzSunnE5l3mWP47IHryCak87Us3fRN76bhr4NC/etJPyZh0n1XsiPIZTyojhnPcgWShWhi+qUXetFoYtaj3R/yF4WSQaWTnecCjACAOh4oshT5urueXS2pcWH3fLRy6j0yhLYOl+K68WXnF2Io3deJMn+sqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiNe0K85; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiNe0K85"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so945096066b.1
        for <bridge@lists.linux.dev>; Tue, 08 Jul 2025 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751987545; x=1752592345; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZYL1RGMT/K0LlOy87I7m++u7kv6axMD0GR0HL7h5zY=;
        b=ZiNe0K85KfG7b1jaGeufbuClZ03x3ud9TtAla3LMGeQOWINpjG24XpxM0pE+TyTbCa
         1EKqSRNbAaMY3SazW8rnM3Gz1yYnhAISacfe+07RmApuRBqUJqKv8l44vpWYd2Ui9xGA
         sujwmfVb5UmDTVZwkIPjvNG6Vbm48EWAScY61n2m/YuYrrCptyDrCapKM7SWHonbvUVN
         AeLuBhwzld6wNLkyOx3WlSvRVhTAirxH4Szg0TAt9qpuWHH/+gAHxLwhU3KAoPdD04VG
         3nj69EFPS67dj/YciPaOxLIC+WcQoJKRl3gJCD7LwSu3HeGGvX3IienLmF87bDFd/bdi
         JTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751987545; x=1752592345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZYL1RGMT/K0LlOy87I7m++u7kv6axMD0GR0HL7h5zY=;
        b=nqIZxSXUetPRE6DT2Qo/Yy7c0IWcwM5NrcLKFHT48c5aS0ZSU//GHk6qGwwBBH78lM
         +2GZcJ3/hOXaa48r9LnYAbidSh3rq0MxeyEh1CKKId4o/QTi2KJ/IDUuCzwB1N8CzJai
         kHincyRsUfw1qbFobLUEsnBFY/kYklKjSAjWuXE2srybYMFdBXM4gwe8TY8Iy4dn0kpx
         wHgZoGISuWauwFrN+3XGWG6AgjiFcYoIRTABYla2SodxY6EAEzNu2SL6VEE7Mily9Ukn
         Nh26ajaY1ez0BSfVW9MvxKS21srggZAcZx7tIKVRlTTz5ZE6AehP1jFkkqymEeEJWihX
         dqcw==
X-Forwarded-Encrypted: i=1; AJvYcCVJDwdEOR30hxbcL+gcDO/TYRhQzdVg3cK3bVS1qwYQ3mnMX2buWwmwHEQhJ6tNbXcSuQ3a5fs=@lists.linux.dev
X-Gm-Message-State: AOJu0YwFrTejQpkiAkAI3WB8srohxCC1e+A5HdCz72+fIMepqZj9iJSe
	TgejOoOdIjKHji1x/3HzoPmKIibW5eNhAaj3IkA+OjJL/pjIGGdEUOsW
X-Gm-Gg: ASbGncsOWiAQ52YD1WEaAhnYW6BAtWj/IIqfrn/icdJ+hzbtYAQCkI1zTrvpUYmHE/1
	f4Fe5uW7hY8HJByxDhgYJtvD5cmbWxSHHSXzMHUS7BE5qoM9DPRfp4fpE4J9fCV/aL4Gx7oTZDc
	v5hi87I9HUlKe3RlpAaSYiye+F6allQEToqYOMkM6N3AInmWPiWaht15qqIK12VaCHojIe86+QM
	FgsME1pxYoZXCn+A1dXFlFZ3dOZS+7NCv7XvyR/plnAPheATZ4ZPju23rLoVJe3SWTfkmpCJPnC
	wFE1kweuqnyEhg75mOUhNArnvoVbkNWD6nqiE+pX6PuwxER57BuTkgpTNPEC9iui5kliabS0/fj
	O5vaUEjpItde/dOizmz5RnQdcltzTMxRPnwNoSSPiTK2pz05JJAFe3udEPmmuzgcBS7hKugdQkz
	TYi6N+
X-Google-Smtp-Source: AGHT+IEg50XwmWBdMLZG24B4Ehm6r/xs54BofsDZ22irp8Q6G+B8nupCQ9DaPVQAuFF45zjxCT1mmw==
X-Received: by 2002:a17:907:6d04:b0:ae0:34d4:28a5 with SMTP id a640c23a62f3a-ae3fe3dafd3mr1617297266b.0.1751987544354;
        Tue, 08 Jul 2025 08:12:24 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02a23sm907596766b.112.2025.07.08.08.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:12:23 -0700 (PDT)
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
Subject: [PATCH v14 nf-next 0/3] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Tue,  8 Jul 2025 17:12:06 +0200
Message-ID: <20250708151209.2006140-1-ericwouds@gmail.com>
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

Changes in v14:

- nf_checksum(_patial): Use DEBUG_NET_WARN_ON_ONCE(
   !skb_pointer_if_linear()) instead of pskb_may_pull().
- nft_do_chain_bridge: Added default case ph->proto is neither
   ipv4 nor ipv6.
- nft_do_chain_bridge: only reset network header when ret == NF_ACCEPT.

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
 net/netfilter/nft_chain_filter.c           | 59 ++++++++++++++-
 net/netfilter/utils.c                      | 20 +++--
 3 files changed, 144 insertions(+), 23 deletions(-)

-- 
2.47.1

