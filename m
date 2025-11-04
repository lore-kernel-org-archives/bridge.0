Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49B432ED4B
	for <bridge@lists.linux.dev>; Tue,  4 Nov 2025 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268297; cv=none; b=eGJKJuWI5Vo47Tp0e8JpHqy1b26Yfv1d82nvLsh8Jb9GbdNecKZqJQ/KfWHZztwhvUHvawe7M8wTX3Lw2ABy7y/hukrDo6WSCzMYL0yx43ZuNnn6abxq0m8u8CpjNTrWDKjtaANNHtVr44APxzD1msXnIQWUH2zxLmaV6ENAprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268297; c=relaxed/simple;
	bh=inDzx/S8cSkg3dwC/uO23c8W2vRyNZzLVUHSMHmPaCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXDNQwyycnIfchZWs8tTSmNZTPXVYDn3h7eCh4U6hwWe3oneMf7lI6cwyu3jVgFdGVQuvXXSeRJdMnH0hFr2OsWRpTmTKoAHn6pBrG/3SDAuV7S+CdFFYmjsQ/DmNnxhvYZkIofcQYG5vEhCsCTS6n3Eloyq7AC+8p+kyvBsyi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGuD3BPc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGuD3BPc"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640c48b3b90so3134877a12.0
        for <bridge@lists.linux.dev>; Tue, 04 Nov 2025 06:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268294; x=1762873094; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/l16ttdB2MK5S2rHLIiMDaDf51UWK0TbRnH8/E42ilk=;
        b=OGuD3BPcDRA6Kc+dGsjlw9GaiMTcHvgs9C1dUrWdtFtIgPgzKvKLHSX5mQckYXA3aO
         QDAnp+lytIcw37vvHYukPrEPokkwgOwiiOpR4CxB0FriZvIKuC2cJ69GIK2k1cM7XlyA
         k5hKzY8snG9Ub2uySofltPQMX8Yh8DITvsEpE73JMxY4my0WJ4aGFE9qzvrDMTBkU4DL
         fZm5BhdD0HkgGSaj6ZyXzGR1/6h6KMtgvu0EGlole+eFBM5Ko9T9MeqiAwpKDVubMVos
         WW62/5AQn+EbnVmZlLurEcv3IdEJ/HncI3SSHRYqONaVAShJRk4oyurehQ09758sGh5q
         ruZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268294; x=1762873094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/l16ttdB2MK5S2rHLIiMDaDf51UWK0TbRnH8/E42ilk=;
        b=J01iwhxU4QPlPoHy4LOLTYrkjXTgz1B/yhY3J5/hCNaVntkAe0HmjGPpU1WQMWqOSc
         FD0F+wenVvVaiw9Zi+uQNY1iVzzGCDD7Ff2GXw8FGmO57duxtjzsAOvIKlvJwFqUygyU
         iIBn4PBU+qKpQx83qNvP2vbTwL80EWUCU2X6A16ORUkvoFsgXM+u4YuIEnM/ri0Enpcb
         eNnPQ4Qka5UMETW+Z4fO8DAzUk/PbpW1UyNb9ShKiuFmTVDdaH9ymt8fRtGATDCraBwp
         B3T+Y9DjOlB+Flp6aI/sHkLzgUP5DUcpE3b2Ny7BXgpSDu+Nd0E+V1ibcTd+xy5WIpfF
         zKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgnpc9wRcGTTvgIPfXfCKvqSocbfgfaMTsrx2IqtuxjbLiKPODasoW2NaUjGJXfg4xdphjg1U=@lists.linux.dev
X-Gm-Message-State: AOJu0YzZmyJn7F1IVpRhVkxC2yVFm1YJvSsae9wNp0G7b2UjpaTuSSgk
	LG+z37w8umerqtvpUDfrMF9Z3xVk5Dm4CzvyuJsCCmC3GAs6kowK1bVD
X-Gm-Gg: ASbGnctFgE3eOTgjNNUTH2g6oRyV+dl0Xd/QfoOTgtyOypTR25F2lENdm6bLlVPrazx
	rRK2VckAw6c16q2y0zObK85MgAPclNGSvReQm2OTtPm9mntjzJCD2tPEiNlNfNcVCxw9vQlHOzT
	wUWTosnju8F1d172qerTax4RKdkLoQsDBuGB1kFG592EiVN55NnOtn5+GcBSHdt5YV3tS6bQX+9
	gTVrqMMEvPUq1sriVDj7iL8pxVvZnnqxRdxcEWsHoIp9yUm5Qqffdxzz5ps9AuIN0Pd1IK9WXdb
	ifbr930qKP9ffpK/24NDRaULQ8OWAyuBihjT+1aYJi5YNgeix+1zozgg/KoyDj2WUW1AWYTUZT4
	ZIRvzkQ6fbOgHWWluwAE8NaUq14NIWTSVaL9WmzM8+zQZmdfD58tDxMppat7ry3xUt3XyvtB1d8
	XMoFp44rk9wsY0XKXLqLcFyv0O2b8pjpXuOEmPVJdZ1bh+SIGF+qYcfGP8x+u+d6w6DONXfDx0t
	hcqa9RXoA==
X-Google-Smtp-Source: AGHT+IFoBSG/LmTvbfsb0CiqfJ3IGEEn0aKFuWDCFW1M6Vz6/5HAUfuq0eiik8IrlE2I5ZwBHF/nxg==
X-Received: by 2002:a17:906:b00e:b0:b70:7e10:4f4b with SMTP id a640c23a62f3a-b707e104f68mr1269603266b.18.1762268293920;
        Tue, 04 Nov 2025 06:58:13 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2560sm232681666b.46.2025.11.04.06.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:58:13 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
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
Subject: [PATCH v16 nf-next 0/3] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Tue,  4 Nov 2025 15:57:25 +0100
Message-ID: <20251104145728.517197-1-ericwouds@gmail.com>
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
forward-fastpath experience, introduce patches for double vlan,
pppoe and pppoe-in-q tagged packets to bridge conntrack and to
bridge filter chain.

Changes in v16:

- Changed nft_chain_filter patch: Only help populating pktinfo offsets,
   call nft_do_chain() with original network_offset.
- Changed commit messages.
- Removed kernel-doc comments.

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

 net/bridge/netfilter/nf_conntrack_bridge.c | 92 ++++++++++++++++++----
 net/netfilter/nft_chain_filter.c           | 58 +++++++++++++-
 net/netfilter/utils.c                      | 28 +++++--
 3 files changed, 153 insertions(+), 25 deletions(-)

-- 
2.50.0

