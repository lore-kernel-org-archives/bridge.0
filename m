Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773F38399E
	for <bridge@lists.linux.dev>; Tue, 12 May 2026 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582055; cv=none; b=mpqAVb4X4H+Lm8Nmr9mSy6LHABwEJyGXHLdb2wEsb0pqSA/Ao5EWpaN+9eK6ouvhekE+rx06XM100akmnTtguzXWyGBNDfgavfyEJ9W16wQ1Zz3+7b6uHRX0LjPRaCUqqVzok3GWySChjZeuQU/QeJ0UtGysX2ehz0tiCqeT54A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582055; c=relaxed/simple;
	bh=i9Asqei4efexr6K9Dxu3hIacS9ENwy3ZmHOz6cviPfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOk7zesIfsL5Wg2KxiQvdnwL/liC7xYvlf/jCCIzRKBvEiLpm9Z4t9NsUHc1oi6iSt3Dxj/uHf2hWadc8AZoxnEznWgrHTafwdMYV2HM4Zs6ULyJlCEKR6kgb1XiXwzMcMwMHwXpKIYGGlDxaWI13oFy7OTGGBY3LLZNTBuD8dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKVL7AKZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKVL7AKZ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67bc8609a9bso9859726a12.0
        for <bridge@lists.linux.dev>; Tue, 12 May 2026 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778582050; x=1779186850; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e6uyOtwIR++/MDHnkbSW1HQI60jV8V86JJaTfeYsrdo=;
        b=GKVL7AKZ7N0A4wcmAwf9C7ReFJ1PpvT23r/ASrRAmIh1577Y5r/0Rd4tmm7Swwg9vv
         TY9HvHq0r3NB3vW96bxXWzgt+QHHIuob4L+ejNSl5+mBI4M6OC0Zfp4D5rweSUlupkdF
         9DnyrPxsef41AXMq3nfF4b04DQYl9lKEG5vLzJhEMcyvmY00Y7f5wGMAHGIYEZwEmvWB
         K3uJIqIZB7/7NTDbdkapWkZwONcwbcZeL5psCn7iFppi6Wnw8HdMZEfrReJjZRV/mxiY
         L+7AzZQHgieQeUjgfc4XdqJw/NLfp616/Zv1F3xdiEcDHf1Z9pYFtXFBQCUGGmh140PR
         FNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778582050; x=1779186850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6uyOtwIR++/MDHnkbSW1HQI60jV8V86JJaTfeYsrdo=;
        b=QW24Ya3hFIcDAocyJbEzqOyqNqOLpMDMK8+ng/cWUDSj1c3Fw8Fw/OWdHvgKuvjYsE
         Sal94ILGPym/afN+Rguy5E691S4uRdkWhoIkRSiP7R8pnMhu2Cky37a60/KTVbWSutwc
         JEk6RQhgdd0cU5NJgdGEkJ9gxjXK087C/osOKSn6lGqTVRT2ArQ0ffFXJ2UgzxOq53/Q
         jVSHJrZN0XavSYXBODKJmrdr3GxkVqa4x5+5usWLwYSwfg/KTr9IOWbkQfaqTZsNR6Sa
         IWqtSRhgpXPd/8AzMJHl+YtAsz+MOmFLf4dZ4/WglrJea+So0aMe9D/At0HmgVoMjleg
         TfiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2NHOgJVma39cgdnjnRlzxkcDkix9y71n+rk/2mlgNxwmsgRq8x9nbFBrDzQAt9yLwxRXNdgo=@lists.linux.dev
X-Gm-Message-State: AOJu0YydFdaa4XfcCfV2pqiuLEGhHxW6rDzjqjD1I8YTyxGTTU7jdR42
	BGH9Ay+fVP8Jimc7dy3GHrMJcxDKCSCj+G+s2sQ8w+f4jkP8TrJqty4B
X-Gm-Gg: Acq92OEDX1Om+vLA1BRfMp3vHf1HoEOKK91F4u1APjxUl0pwYxiYGpjNjxfePrW0s/S
	XaUMG1GFybDcXHQknglDeFNrX6Qj65pOft0fu7RktBij6ASsEtcNCiKWVYTteWm/ALX3dsfcisX
	q0FKR/oyKXiZs4NgJUzg/22RY9GvVC6D0uztyxdShXPlXtCFCF26LcjilvKXYb39qRTV7JZsU+d
	LBDXdrh2+O/Sbl2EKUMW5yfPSxrvm7Kngc2D1f4O9CNyQUgMAfbiRThei3JQsTxUnCa+Ws58p6T
	ZczCgVjfWyUI/VtliSxI2TePpQYJ+XbiU2PSxqgVifJrVaioSWS+7bp7+bF3lr3ex49FzXUL+Sy
	w7OuVyKja22uS97bZEQrDOGGmR02m/w3d4hbKFQb01op3WAYLdrgTNprQ1KUikvsQk9Cdwq5Q42
	x6HI1yl/lTBj9s9LaWUIDUwxKoBy5UMlIEArQjbSkiaRoXc7lz9vRi5xnmBW6G1XH/1q9rnbUaB
	5xNQokHZRXnTaiYsnXODmz8+8pDEWikbBO4UpkI3fOSnSjuyAASwJY=
X-Received: by 2002:a05:6402:4315:b0:66e:8ca6:e79f with SMTP id 4fb4d7f45d1cf-680cf3642bbmr1368517a12.13.1778582050230;
        Tue, 12 May 2026 03:34:10 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0e1c044sm4629218a12.27.2026.05.12.03.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:34:09 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
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
Subject: [PATCH v20 nf-next 0/2] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Tue, 12 May 2026 12:33:45 +0200
Message-ID: <20260512103347.102746-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
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
pppoe and pppoe-in-q tagged packets to bridge conntrack.

Changes in v20:

- Moved skb_pull/push for icmpv4/6 checksum calculation correction to
   underlying functions, as these underlying functions are also called
   directly. Adjusted commit title and message accordingly.
- Altered nf_ct_bridge_pre_inner() so it can also be used when doing
   re-fragmentation.
- Added ip-fragmented packet handling for double vlan, pppoe and
   pppoe-in-q.
- Renamed nf_ct_bridge_pre_inner() to nf_ct_bridge_inner(), as it is also
   used in nf_ct_bridge_post().
- Dropped "netfilter: nft_chain_filter: Add bridge double vlan and pppoe".
- Dropped "netfilter: nft_set_pktinfo_ipv4/6_validate".
  (They are replaced by other patches using meta).
- Dropped "Add net: pppoe: avoid zero-length arrays in struct pppoe_hdr"
  (It is applied separately)

Changes in v19:

- Add net: pppoe: avoid zero-length arrays in struct pppoe_hdr.
   (It was part of other patch-set of mine, moved to this patch-set)

Changes in v18:

- Rebased
- nf_conntrack_bridge: added #include <linux/ppp_defs.h>
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

Eric Woudstra (2):
  netfilter: utils: nf_ip(6)_checksum(_partial) correct
    data!=networkheader
  netfilter: bridge: Add conntrack double vlan and pppoe

 include/linux/netfilter_bridge.h           |   6 +
 net/bridge/netfilter/nf_conntrack_bridge.c | 203 ++++++++++++++++++---
 net/netfilter/utils.c                      |  52 +++++-
 3 files changed, 228 insertions(+), 33 deletions(-)

-- 
2.53.0

