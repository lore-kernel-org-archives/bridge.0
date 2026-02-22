Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42D34F498
	for <bridge@lists.linux.dev>; Sun, 22 Feb 2026 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771790344; cv=none; b=scN8XUS4heFw6dqaFj8rfG5HBSa6UmQLYllSPhM8roYKnikBnFZsIe0AtwUvYSP05SNqdmecmMdQim3oxvPW7jyCzvlpVGSKeYY4nvc0ZMwn1TQEN/eu6jT3hHxF+OF80SRCqAG1xZtbxo7RZ/DPufAs/CIj8dyjP6IaE0+sRhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771790344; c=relaxed/simple;
	bh=2r0CUzvJW0jUKiBlQ8CAUks8FkA5M+bm5AgY23WtjyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZE/gNs56MKct0RSDDAVRD6mEg+2gLkCZii5qNKk+m790UHECgEGuPVBhEirVGcqFLzGGj3tPz9G6y5TPujv0mRzzcR8vXMLZ1E5ykaeIqsa6vS/1GSt31KuQDtPoUmhcYmeo0A6ItCZnFNWWI7olFnVHGWP2swd1LNAH+tREVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtcK8ip5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtcK8ip5"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8fbb24a9a9so676138966b.0
        for <bridge@lists.linux.dev>; Sun, 22 Feb 2026 11:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771790341; x=1772395141; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0QUz8L/CWko35QAQoLR3+2iYYOTyA5StSVzZHwFaV9s=;
        b=QtcK8ip5a1kfsMBubqUuKHi69HtvYBRbyGirwHTIRS5TzQmpWuMebE1bJJRDuZ9iC2
         M5CG0lC6JuVnKU1egpg367SweY/G1wFlONZXDMFgEG9CN+eWcnofncJT6NLrv1PgnGyk
         H9sW7ITaN2xZX80RN98lh+NAGBCoK9nCslB3fTlzkQ2FBG86zwTsZeHqfF31BtxzeULI
         /4dpYyw3H52f9rGXHMF+7F0T/Le2ywjhCVszfNXSHb1ED2Hb5P1I1f/Dc4iPFQ0x4yCJ
         GSJNyGR96fMtHQ23qjd16ItqR8+wsYExsfxnoQkQTa7TFUNvvl/31pR6+iqkgvLNzg7v
         7N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771790341; x=1772395141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QUz8L/CWko35QAQoLR3+2iYYOTyA5StSVzZHwFaV9s=;
        b=EGDM2SPAI08Q8ne4pcJrPaWBmw0OiRBYRQVgc5n57I90VVsRvGmFDNHkhRp98wR3Ny
         9L001TZLDOVuYHmyum9ADYlxEAxqFlxezWRQ70YbxxlpneytXRTp3V7W70PMBrC81XW+
         /kLspPUbnykMDlB/xtE8QJfsh/A97qL6F+zp1My2eNjYtR5G3hhWWN65qd4JCkVgzcEz
         vlkVvBxVpY94p3KV9u5TGSgMJdwbbTCpPqLmleVBh1jjImFMpkCgH46bpBfhhKmrWyfh
         cAZXhoS68A7Y6MXwndQRBdFh7jnwdzl/2LeMSeWIIip3tB8/EKblhLIG+Vf8abcMglDb
         mlOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk4K5vhivezS3KvmZIsmWIc/884YkmExT8dQC1azAdZ44XK/Tu/rIX2LzA1IgWwMql4loZFvE=@lists.linux.dev
X-Gm-Message-State: AOJu0YxJqZ45ql4qrGnX08QtYskL0Gy1Vk3WRyGGT2PkGkeC+TKE3Wzf
	64nzAAHHpemUbaDsj4lB7azQPK0nHdXoAx+B6iLzQCSOx56UxJn/qBFn
X-Gm-Gg: AZuq6aLyLgDx24m/Wrjj9Plv+mw5vLZvhAYIQqOHIwdk4SA9psKMzikRaltpS1gJ8lH
	tIJVx4NkcuwuIMM3crlMjcs+RzxxCaONYU+6UsvfKOAZFJZVgyaoabfdkTiqJpMaIDbFdjNSjen
	cs3DU7kNagcH+eCclCvafVhIXcNwlX2q4WQwGwlipIfrQzrlwjaFFjN6Ks7fLFQfgVbZCul0S/S
	1kJWznZZTB9q1bsXetF/DrSM5MH3c/PuJdl4faA7p+8yS28788p2k6EJa+yjVb1jFXo2FvTTulQ
	SI2++C1WVVO4Bo3y3wZ3y9YXPBzauorX3NzSXDyiR1MDeRIu6ZTIbu/Udp5HDJp9ZFBnfcbP6d7
	zBEZZWkjo6WRuvPK5o8oV0KjT7gZtB1jyW9ZD4eU1F0x3geyfDxTmwKREguGQFaBswYdhtGFJwY
	p8pLZG5bPg3OGY4tkkG7KbDQ/AUpCOszgo808ZpndCoUl6nRhHkUnchG/nOAfrysi3OZBoRkZOt
	0SLy3ah75x33F43RBAxwied0VgAtc28sS+90Wu7VqluW9VzOLWd7LPKeQKPXSqwOQ==
X-Received: by 2002:a17:907:ea8:b0:b88:3877:d922 with SMTP id a640c23a62f3a-b9080f34a6bmr415866766b.10.1771790341184;
        Sun, 22 Feb 2026 11:59:01 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084c5c514sm246125466b.5.2026.02.22.11.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 11:59:00 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
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
Subject: [PATCH v18 nf-next 0/4] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Sun, 22 Feb 2026 20:58:39 +0100
Message-ID: <20260222195845.77880-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Conntrack bridge only tracks untagged and 802.1q.

To make the bridge-fastpath experience more similar to the
forward-fastpath experience, introduce patches for double vlan,
pppoe and pppoe-in-q tagged packets to bridge conntrack and to
bridge filter chain.

Changes in v18:

- Rebased
- ‎nf_conntrack_bridge: added #include <linux/ppp_defs.h>
- nf_checksum(_partial)(): changed WARN_ON to WARN_ON_ONCE.
- nft_set_bridge_pktinfo(): changed call to pskb_may_pull() to
   skb_header_pointer().

Changes in v17:

- Add patch for nft_set_pktinfo_ipv4/6_validate() adding nhoff argument.
- Stopped using skb_set_network_header() in nft_set_bridge_pktinfo,
   using the new offset for nft_set_pktinfo_ipv4/6_validate instead.
- When pskb_may_pull() fails in nft_set_bridge_pktinfo() set proto to 0,
   resulting in pktinfo unspecified.

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

Eric Woudstra (4):
  netfilter: utils: nf_checksum(_partial) correct data!=networkheader
  netfilter: bridge: Add conntrack double vlan and pppoe
  netfilter: nft_set_pktinfo_ipv4/6_validate: Add nhoff argument
  netfilter: nft_chain_filter: Add bridge double vlan and pppoe

 include/net/netfilter/nf_tables_ipv4.h     | 21 +++--
 include/net/netfilter/nf_tables_ipv6.h     | 21 +++--
 net/bridge/netfilter/nf_conntrack_bridge.c | 93 ++++++++++++++++++----
 net/netfilter/nft_chain_filter.c           | 59 ++++++++++++--
 net/netfilter/utils.c                      | 28 +++++--
 5 files changed, 177 insertions(+), 45 deletions(-)

-- 
2.53.0

