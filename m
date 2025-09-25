Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB4123957D
	for <bridge@lists.linux.dev>; Thu, 25 Sep 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825062; cv=none; b=XJp2z7gDVTvwRLbPGcdkT/6LhtaKxRpTxRYGJw9qBRu7mOQu3/HblAiay6Jmr0dZQ/rOfan4h1K1rtiwpDr/3GNRam9uPoXpcnM1dgQioDFUVeBuSGv89VcI2vV9JGwhD/RhG7mQmoO/acX9o3yI49jHFOtGtaGLH/pvoBYJU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825062; c=relaxed/simple;
	bh=mWfnCyX4ZXZBEuQ+MvwGx9mVDI5hxd/cIA20xBbVsbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2yvnHRG6wgMtErtWvgUMCsZwBlxfyVxZjdx/FZK4gLcLVFg2EZQWd9Qjwcz6y0uJLh/spV+TFWeae+GZr3O+Ia68Dy1I1TTxInUNR378Lv0nhv2uiV+hfRr/XX2oypFIV6O7QLIAYFRPIWCXyyn3zsB0xFKADYhSZa24ATAaqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqrmAqDK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqrmAqDK"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3727611d76so68646366b.2
        for <bridge@lists.linux.dev>; Thu, 25 Sep 2025 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825059; x=1759429859; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7V70C2OYgSvApO6vEjdxKmgkWi6ODruqlWoYJimYJ4=;
        b=kqrmAqDKXQpbqIOR3//wEPwYy579VBvMU+2WLHhf/fkjsZDnh//klVZ3T3m+Subyk7
         g1+YGP8WmMI9SZF2Ajc6+rXn0tgtPgSioeMpegqSHMEmd1TxQ4pqJKzBcihZTQbk82Gq
         qYyHy5sRO3ssKHJPUO+lfaKPdtrVXnLtm5JSkNx+30t0NCXiJJIMlhK6NbAJT772qBHs
         VDRBDTYDIxABWfq9UBh8A3DRSXyfdZqOs5J9oslVRIC2iF1/DPTwO49Hl5T+D5b6vnXM
         GbSW0bMV3fthx2eS+XHjFTdTLYeMJatbu9fv3NHCxDSM0juZB9/rcGYUo+tVx6G7KvZT
         qk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825059; x=1759429859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7V70C2OYgSvApO6vEjdxKmgkWi6ODruqlWoYJimYJ4=;
        b=lbK3LIIvPGkaIU0PYRGqyPB3E0mjhZ77CTGa2/s1sL4mXWqbthF6UJumz5542iwR5K
         nBcq/iLknX3YDb5Bs0AO3aTiQGVogv3DXvpoKj64LymBTbh22Pv6OknmUszmMCcEOaLT
         r8MvWJf5JoW2RfAKtvdZ+NxABtN5Bh3672Ss70WFN0eRZXp1yxPu8T0JE4d5c7xbbJX1
         RU1K+hHB7FGSQoCT12y/sB7R2jglGzkwUTTcWDEmDCxM/NTH6aGSMedSa//Qona831+g
         SbLV9dnEcuJMU+ir+HOZmPHqEKGj+i1jP8uOkbrb601eTPzEmg61t59eBLhXAXuAqMbY
         sqMA==
X-Forwarded-Encrypted: i=1; AJvYcCU571XzXHY7eP4pLZIr8qss0MvW4e+MR64HvMBAvKy52wBXAdpb2fsC5+DtNgb1D4n6MgP7O9E=@lists.linux.dev
X-Gm-Message-State: AOJu0YxOnszYNebBuc9ZdJpV6/yCSRd8WkE579vBUVH1AmjtU2S4jcXg
	egPXsu9yYVtvpsGkxdqPbjLLvVFSKxwoRLtBuWniz+89UJhPOzRMEYZo
X-Gm-Gg: ASbGncsttIfhUGR3kjanmfUj1cv7ZMIgqbC0XjKLXTVGEyAPxa1AzR3TeLTlW/6CPPj
	DVReaRAiXsaG6GZzKBt1qf9aBy5lxgtS9390Oy76MU8AWsjAxVnp9J5si/6S2yZ1Buc2qAzVc+k
	62bEJjHMtjKP3XfZwf1xJQQ1uI3Vl0QPLNZd5JvvVGj3dO65eFkD/TDW28VBqv6Hqux0OSYy2na
	tOpw5qsa3mEmVRFAkP3FLQ5F453gDM/vpOcUzhTRkScgOJq8aNSsksYKmu+UhdJSHSqxVxMvhBO
	CRlXrMd0QIg9kjStvtmni62SlKde8nMMjtVt+ZaeXE03jxj3ploT3XmDtNGJJEGmulxTioGVaIS
	ifMY+Qz3AEajLfZ/3pErH+CvCJ/V0TxBbuWJTu6H4Qj3hjnehJ2R4XZ7POu+0OHGMbKLssFonO1
	kyG4c9rJmNCSJcP2oOGA==
X-Google-Smtp-Source: AGHT+IHkLAofooZVh3BAd89JwDIkjnucLG6nJfCAeGHO8bJNdmfj/gTKINUMsN2WpKXV8iwBOnj4tg==
X-Received: by 2002:a17:907:3d4c:b0:b0d:ee43:d762 with SMTP id a640c23a62f3a-b34b9f5b4c4mr419901366b.4.1758825058790;
        Thu, 25 Sep 2025 11:30:58 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a9c560sm211198666b.107.2025.09.25.11.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:30:58 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v15 nf-next 0/3] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Thu, 25 Sep 2025 20:30:40 +0200
Message-ID: <20250925183043.114660-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
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

Changes in v15:

- Do not munge skb->protocol.
- Introduce nft_set_bridge_pktinfo() helper.
- Introduce nf_ct_bridge_pre_inner() helper.
- nf_ct_bridge_pre(): Don't trim on ph->hdr.length, only compare to what
   ip header claims and return NF_ACCEPT if it does not match.
- nf_ct_bridge_pre(): Renamed u32 data_len to pppoe_len.
- nf_ct_bridge_pre(): Reset network_header only when ret == NF_ACCEPT.
- nf_checksum(_partial)(): Use of skb_network_offset().
- nf_checksum(_partial)(): Use 'if (WARN_ON()) return 0' instead.
- nf_checksum(_partial)(): Added comments

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

 include/net/netfilter/nf_tables.h          | 48 +++++++++++
 net/bridge/netfilter/nf_conntrack_bridge.c | 97 ++++++++++++++++++----
 net/netfilter/nft_chain_filter.c           | 17 +++-
 net/netfilter/utils.c                      | 28 +++++--
 4 files changed, 164 insertions(+), 26 deletions(-)

-- 
2.50.0

