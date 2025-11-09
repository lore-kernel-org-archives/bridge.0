Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DCC4C81
	for <bridge@lists.linux.dev>; Sun,  9 Nov 2025 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716284; cv=none; b=AmJCGPNV1zvR8TrEuCoFE+mxMDB1xUvyvLolV16oXimnqUNafgqjVZ/1EFjp0dNqX1s9brAMMXV817t0AHmm1WAC3TCCtIgszjQgL+pk4zNEfpjEBPLmMoHnzVUXtX0ohKkWAaJ5jRlkfzShae8lOHrkyp80Ja2Ir4116F0tl1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716284; c=relaxed/simple;
	bh=/E2065CYZGXfqGZTKvMv4TkgohZjDxfQeXejzHAHj4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyugGoIaLEniaOuD9GgyJYioHurpoogn0oBuSc44gu9dUe8wedF9uVzQ+7kUo5trODF8Xfahlyj3199wVMNRyL08n9+uuqcLLxT1YBvEaYyDJ0wrw/EHybUTfKLMSwmpC5Ya/u50NN4vSMmGzoPE4Nikhy9SS+2K8vLyK5u7YKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5DCIxQ0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5DCIxQ0"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso348611366b.0
        for <bridge@lists.linux.dev>; Sun, 09 Nov 2025 11:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762716281; x=1763321081; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TIKKGAUxLaG+QVE3XjDCtS0yAOmsRVmTQnPpcMwaNFo=;
        b=g5DCIxQ0yRW0gQpW+tj8fkenEq4UNesZ602fhTH9RZDzsOkNahI8Vjzr/B0CcAQlym
         zRxBt/9lO9VoDpJOJLzHRYSBeWZB4YU8Ss3haQyv0AuStC/Wxlza/yU235Eqx0f/Aw8o
         uK8miZgbrUZjky3t+MTbaL+KF8bSB0aXoei/M6Y8bnC0fcWPzzDk7UMpbJbufSksry4h
         K/VqfjnSn0nk8W8Ug/SrofU+evfLJyPqp2zlzqUoeoDDmVmvAR1z4zuRl7qSp6ZoLkKk
         fTJ8VFK/x/1DkiQNnSFol4eDMJH1jhWelJZVKnEu9XQivtTlVunBrs37vaeCbX5K3zDb
         7+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762716281; x=1763321081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIKKGAUxLaG+QVE3XjDCtS0yAOmsRVmTQnPpcMwaNFo=;
        b=doGFrLle3LqeQMvxhYQ9NnnilxNc6Ynvwyf0oEToanTIGr7OdbhuTPtFXKVS3wZzDa
         0fBeAwln/q8Zuywo2Z8d+HUvbkzwHMMiI7QfYhTsGI43ISXztmu/en8MXV93xsA/dei9
         sF9NTnHtDMOtHk7xH3q7lwu6wjr2JEiJv0sDIhI+Iw0mh0Ybk1jzPkbyqFCoRlhobOsn
         jhgwmv5dhczfAYbq9v/slxfEJHeVGIYwsU3GeRW1iS2UbVPM7BHpxUG+bnap6HeS61WU
         9CejKaTguWITWgBL2NojwetXom0xjOaEg+AjZ0QaVVK6wHvvEzwweUePPqTNoUiw8jLz
         Optg==
X-Forwarded-Encrypted: i=1; AJvYcCX5n744GDVmf4VHoIksKDIvXoM1S+VyabuW0Vw/e8umWUpxrB0tYT0xGl7CcawUmMNuuonhf4Y=@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ3yuVwvXhQ5MOoZKWe+LGs+9Oz+coscU6qsIi/N0TxCvPbO0L
	grNjshuPat62hRdT30nSpece3pOGUGXiin58VDEIIbrYa5/bKx7pGVUX
X-Gm-Gg: ASbGncvgjbhfRpLaNEbZ15a5Y+FMUcw873i7SQ7xTr7LX4cP7bEGlg3TbvMbicKebDO
	9FLC6sLD7smPytKs+NyRF3TfklaapT986oFXelDkH/KcaeKWpO3raK72A77oC9WlyPLlBkZMziO
	a1BX3WMRI/B/F1HkPgzN/rvJvuwx08mJtLJgDenqahaUUEIA++Di8xxZaOgaFkvJJGTOSBI+311
	OPfNyhSxFm7bSdIL5bt92wZwug3vIu1ehjIqzrrgfks4Hw1nYRUbBexsJIDrw3IzJbl02NHlyPx
	Pnr2axIQY3cNMk59KxXkexhbXAMiXUjascemTOTIju26XiM4f01Pm0P/MVS4QP+Gt+DcmnGlxFB
	DxmA06JXkMRkrjdDywxFceZoSSZB/QKp9q1Uj6gbX4C2wd68CHgZV4l+DAcmJ5buz0okiwRaUTp
	AzyCbqAEZ4hw0oIumcob2HDrTClQ+OnNweRf9MnqEHoOcNIi3JxuhuvgtIMbLlAF261Jw4X5E=
X-Google-Smtp-Source: AGHT+IHcavlGRtCMXIYLReGyT/wu2uhwzR3CuuOMBLjG6pTiN0jeib0DEyX5FIv4+8BofcYcOeVwtg==
X-Received: by 2002:a17:906:d554:b0:b72:d001:7653 with SMTP id a640c23a62f3a-b72e02d62cemr545418666b.19.1762716281018;
        Sun, 09 Nov 2025 11:24:41 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e447sm919652466b.42.2025.11.09.11.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 11:24:40 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
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
Subject: [PATCH v17 nf-next 0/4] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Sun,  9 Nov 2025 20:24:23 +0100
Message-ID: <20251109192427.617142-1-ericwouds@gmail.com>
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
 net/bridge/netfilter/nf_conntrack_bridge.c | 92 ++++++++++++++++++----
 net/netfilter/nft_chain_filter.c           | 59 ++++++++++++--
 net/netfilter/utils.c                      | 28 +++++--
 5 files changed, 176 insertions(+), 45 deletions(-)

-- 
2.50.0

