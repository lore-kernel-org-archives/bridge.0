Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D57304BDF
	for <bridge@lists.linux.dev>; Tue, 24 Feb 2026 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915995; cv=none; b=uskwrRukh5MGrsOi3o0/WJ/0Aqsikb7yrNHoM1Rxc7dlWTHDoBEjBXDvWjr9dinjakf5FHkSIIzyHDw8EjPvjNlr3hmDhl+QCeScohvsqj7UljRgF3n1iHuQ5I9ZUzZeG+ghumtYyDd5HYRIjaLBnYxtNKGwuWlntkXk0FPwlO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915995; c=relaxed/simple;
	bh=lP3kra2h8AICEkoINsLGhXhIuRHfsSfxRft5F4Y06uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G1rHh92SXepSrt6jsibcWV7YNXl/+GaIGDgHx27dR1Kqvml694v/vHYiUG9sPgxPOYrJrMvqVbRRfTNs/mARTuxz2i9KNva5wvEw2M9A3wnr9w7Y4DTI1M3evgEdw0DYP72R3Un0Y8c60XoHiRlHJc+1Oc86dYecUNBaM687Kpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI51qpmk; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI51qpmk"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65c187dfc82so6201500a12.2
        for <bridge@lists.linux.dev>; Mon, 23 Feb 2026 22:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771915992; x=1772520792; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zv3dlNi6mMAZcD4s6zkCWcTjX0AEel78U/A2n3eqi1w=;
        b=EI51qpmkZ7GgUlxG+dhMfSKOWkzyA6AqTU+T7bbuQETpgpPTl9CAwfCYzzGnI0nso9
         NGQECXQ9Rt5SlMaPkkigWeo4/dPqrlLdJK5rFQOXdyRCMigRhRUvBq7owNpl/cTk9iQZ
         hNuWZMrsaUz30sc1S+f05O2wz5mZhRKcR1vetagsDP54rFi5OmL6/xtKQJuqM4uFvG24
         WWzHgZq3f9kYBOWAnyHvPzVQP1YAbVwEIEYeZJeQtF9K7yYMS78QEHJKQw0MyO14kCw+
         UtbqBjt7ng6tX6jKGaNe/uAjKxqUjyEOHUrh2hT3a3JGWyECiBeYjPmHrHF+gQMfqBNA
         S30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771915992; x=1772520792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv3dlNi6mMAZcD4s6zkCWcTjX0AEel78U/A2n3eqi1w=;
        b=M21LuobhiupW7lc0NclrIOXthwWRTBxAJQwOKvVhfuCoCSxzlNxLft5xZIw5SHFr2h
         /4+DhkaaLXG7o4LFWIAZFUwo69UANf4T1F6XpbQNIxbHPA4bBrtzpeLfjMiZKDhMKDPz
         /mx44yBpafI8jeJ4y2JHYvqac4S+SqZrAV1hwdSn6vY7A1z14TD03P183T6OdfDExiOX
         SOfNzorZj7zmx6fan1DVccpr4MzP8ReQwHjw5zaCVliTIRzlCxgmbRb+uc5EL2Jsi9lA
         LEeEmQAmd+eRBBbp5+ZMzSHFy+WpgIinoiP0jB616m9OXG+vgCHDScs+qd2v35J3gtG1
         O9yw==
X-Forwarded-Encrypted: i=1; AJvYcCWMQyoNFUylHw/w33DH2AMYB3AWTWGsYXnJTuXTTWghqumyhhx35NlN7XZjEK/lTW8WDPfwS7A=@lists.linux.dev
X-Gm-Message-State: AOJu0YxA59x05CtPMtsrCI0n+NZVJXGsWrjuTDsixWmhed2zhyI/dukg
	6o0b/QVbQDci50kXAiKZqzNIIne/JCOIWIx+nL4R7cD6QhnxnkLl87Jv
X-Gm-Gg: ATEYQzyhuNgCmrl++BAm1LnkDxczyY52GpA/6dYXBKIu3ikynBT5QrKCYuANoFQ1MkB
	XH1UlvP9+oGJUVEOR8ZBChYzS1NupfEfH46wTcBKRyFpOZM75xMlPO7gKIBWGneQe/Xe5qMifYf
	qT29SNlPupxuGd5dSsQOSbhheJ1zVSxtVltEoRPMB18yhInh7ySAFSDRfG0KEsTzuFuD+AWIH/x
	eBAI01NNAweUVbOPqS5zrhyKeg6IE25xuuXJfRSYR21AeA2Rbe8uqIyziNDOqIxELRIi2o+k1ro
	J+yOfrxIbjsd80KiP35VDR+SfD9ToVXruXb0EM4cXoUfQU7BZZE8LI4MyqEkw9ij7Ybixgps11L
	oWB/H2zoHcMyHCKXbHQF8JUYf0g6vHkyK8sYraTpN5yLgm5iGsDnaqq85TVbVfLNz0/qMt1KoUA
	Xz+a/2RfnXV5Vk75Y4uRAxmyVLEOvtExapDYY+/DGadvIC03+O7ExdwkeWsOFVQctBoANa5DYY+
	4kItWOS8Pdg6+4rXYQV7+muHowDlvN2q5mGwEF+82mTFD9M+JMvlak=
X-Received: by 2002:a05:6402:2346:b0:659:4b76:74f5 with SMTP id 4fb4d7f45d1cf-65ea4f06505mr7015657a12.27.1771915992251;
        Mon, 23 Feb 2026 22:53:12 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eaba13866sm3096698a12.18.2026.02.23.22.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:53:11 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v19 nf-next 0/5] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Tue, 24 Feb 2026 07:53:01 +0100
Message-ID: <20260224065307.120768-1-ericwouds@gmail.com>
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

Changes in v19:

- Add net: pppoe: avoid zero-length arrays in struct pppoe_hdr.
   (It was part of other patch-set of mine, moved to this patch-set)

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

Eric Woudstra (5):
  net: pppoe: avoid zero-length arrays in struct pppoe_hdr
  netfilter: utils: nf_checksum(_partial) correct data!=networkheader
  netfilter: bridge: Add conntrack double vlan and pppoe
  netfilter: nft_set_pktinfo_ipv4/6_validate: Add nhoff argument
  netfilter: nft_chain_filter: Add bridge double vlan and pppoe

 drivers/net/ppp/pppoe.c                    |  2 +-
 include/net/netfilter/nf_tables_ipv4.h     | 21 +++--
 include/net/netfilter/nf_tables_ipv6.h     | 21 +++--
 include/uapi/linux/if_pppox.h              |  4 +
 net/bridge/netfilter/nf_conntrack_bridge.c | 93 ++++++++++++++++++----
 net/netfilter/nft_chain_filter.c           | 59 ++++++++++++--
 net/netfilter/utils.c                      | 28 +++++--
 7 files changed, 182 insertions(+), 46 deletions(-)

-- 
2.53.0

