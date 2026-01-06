Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9CD27281E
	for <bridge@lists.linux.dev>; Tue,  6 Jan 2026 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767729313; cv=none; b=ZtsI9WjR7bbWFLXeswDB1815+F4QhB34pG4/wh8JSSjcDjKXXhPxJW1m+XRRXb0uFOeNLn/n/9fagEQnJ3aORu8J9YPArUUFcjdIML1fJSlNAWb8mpj0maHD+UuEtgOx7tyu9GP5qnN1rYsLqQ4bo5Jy9L406/R0pQsE8iEguOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767729313; c=relaxed/simple;
	bh=ezRQarOjjBM21zauRZItcnGzBQWgx/j7g7YBZfAhrFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLa9yi12fgOSeAT2jIflJI5Xq1rtzNDADU/wuaGdS7GOoNi0w6dDESNi4XnoKhka/TCFr2qKHDkSJihU0cn4xSgSaeVCDHqG5Fxm2RPEfUFyOSj+kJecbY70dYMD7iWQc45L7iuZ73HfjWWGTba7VJAwutlXQ0pJA+wpOS4NwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRwO74u+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRwO74u+"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so2001841a12.1
        for <bridge@lists.linux.dev>; Tue, 06 Jan 2026 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767729310; x=1768334110; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BmSo9DVOGxS+EqfPBwMvHqn9WrIYsrAaibtCJtd/X8c=;
        b=VRwO74u+ennJu0MGQuYurrL3NI69t4r2TjOKPGzqBEpJ4e1VZb98VuPc5ApxLxVhrP
         HBajWFGtcK8/6MARNIcR4OMOn9CNPPlAtRx6nB+JxeUx7SwQvlJTH/4M2AqNi18dxgyS
         qNisk+UhH/gBJ3BrPCJFILaJ9QtGJkFAXi3muWPxgvEKAbPnxvwNW3ZRV1n3qezC2IvS
         r+6moJ3sz/y7L7ZgmAefNwFJAjEFyvrq4xAFGOCY0HAsoF6TnDL0/AweHTc1ABZB4ORG
         uzh7EpnU/sCTT76QtAx6J6UxDfmiwku165I2Nsce824mdDFaHNOmzamnECXpIgiLC+Yw
         jrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767729310; x=1768334110;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmSo9DVOGxS+EqfPBwMvHqn9WrIYsrAaibtCJtd/X8c=;
        b=TLI+Mbrpa2d93L2sLkV7FoPERLMyXINS4IXQVX+pc2PCh03h2YU9x84NoRI0rkWKNx
         lowZlUouZuHpLNW7RFJH7/cnoXhqhQKOL5j3OzdFVuZUYvjsf5mp4R+4okOAsXiRUYt0
         NUC/7dqXX3GNv1FBDJDW4XC07Nf0udAPcrXgWDpIHVjHXf45kDZGU8Etni4WZ7Wu1Va7
         EA9DR9ZOO3L/kgZuvVC/Q8CwvtnpczLQ/u73q3P3ph9ruD2eIkjI6wlM/cpoVcFF8bQO
         Wtx9hdEVMOTwAAqh+2oIWf2OPZvwVnz812bssbVNeXsBCC9Axnq/B3uGWgkocZmgviw7
         Aq0A==
X-Forwarded-Encrypted: i=1; AJvYcCUHyx4Q6em03uboR/Z0FFiS/9rG88455YoRhXCa8oHvwnv3hWxVDkh7pVucgBl1vziUPGq+IW8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/JVvJXtPi175+aSej7ssI+PDx8hfK8/6jq9rQm+eDeZZtP9ZG
	XR2T/Mj1fYCDHLDA0v+XXfcfT8PPaydTiQPF8NxMZ/goVF9nhbJoAgvphzNTWQ==
X-Gm-Gg: AY/fxX4UXDak5ulf5wU0eCSmuGC6hSdsn0L0tXsp+4EwKpSKoJiUHJhGQ+6G5sJk2xw
	Ww1hqsL312iah4XxV5zjCNIEhemOCcZ5UKPC8qnRJqmVGhpNGz9xrlKH+h0DHtT4tbN97muOoBS
	pa40EI+x+tbPNOl1H6Jc8pOWEFqkJOJXiroW8bYRsze2wXrIsv4ps18uO1P7ENL/hR9z3QfFXit
	43MDTEqxm6NdK1XBV7CzXJ6jUGt5ZPFgXp0l835qiRczLv1Iv6d+h9ITPknswHtazHoU9FSNKXx
	VpguafqR7PdT81D+Hh1pW+b/k5GywICppxRrLt2/ynxdu5gt359xIo2qBrtaWMbyuBHQwZTn0eK
	AbLtV5qUHrn3SCXJHb6aqhRJ1NuuIkWgILp6Fqhl09PpsNyFr+LZShR1NxMNjc9WcQickassa/Y
	p8T4/qcjfBPzAh/Zt1QDg5TkAc04PaS3O7+YgeFkdLJ2YwG/ZnPPuSzbamMeA7IErCIgZRTmUBM
	0dPByg4hYmvNd9LsvSws5AGSEbFIQ8KFSw+BtBaCId3/FeRDjOTVveBurKkxGmdJA==
X-Google-Smtp-Source: AGHT+IGFE95wEtpfFwtjTiCcDiqd/x/VRp77b5we3rDpWf3zlfvwo6wItKcd0BaEkVYOWNXABbIVMg==
X-Received: by 2002:a05:6402:42c4:b0:64b:7b73:7d50 with SMTP id 4fb4d7f45d1cf-65097de8202mr162574a12.1.1767729309560;
        Tue, 06 Jan 2026 11:55:09 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4454sm2902324a12.3.2026.01.06.11.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 11:55:09 -0800 (PST)
Message-ID: <6d77bdc4-a385-43bf-a8a5-6787f99d2b7d@gmail.com>
Date: Tue, 6 Jan 2026 20:55:07 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 nf-next 0/4] conntrack: bridge: add double vlan, pppoe
 and pppoe-in-q
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 bridge@lists.linux.dev, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Phil Sutter <phil@nwl.cc>, Ido Schimmel <idosch@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jozsef Kadlecsik <kadlec@netfilter.org>
References: <20251109192427.617142-1-ericwouds@gmail.com>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <20251109192427.617142-1-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/9/25 8:24 PM, Eric Woudstra wrote:
> Conntrack bridge only tracks untagged and 802.1q.
> 
> To make the bridge-fastpath experience more similar to the
> forward-fastpath experience, introduce patches for double vlan,
> pppoe and pppoe-in-q tagged packets to bridge conntrack and to
> bridge filter chain.
> 
> Changes in v17:
> 
> - Add patch for nft_set_pktinfo_ipv4/6_validate() adding nhoff argument.
> - Stopped using skb_set_network_header() in nft_set_bridge_pktinfo,
>    using the new offset for nft_set_pktinfo_ipv4/6_validate instead.
> - When pskb_may_pull() fails in nft_set_bridge_pktinfo() set proto to 0,
>    resulting in pktinfo unspecified.
> 
> Changes in v16:
> 
> - Changed nft_chain_filter patch: Only help populating pktinfo offsets,
>    call nft_do_chain() with original network_offset.
> - Changed commit messages.
> - Removed kernel-doc comments.
> 
> Changes in v15:
> 
> - Do not munge skb->protocol.
> - Introduce nft_set_bridge_pktinfo() helper.
> - Introduce nf_ct_bridge_pre_inner() helper.
> - nf_ct_bridge_pre(): Don't trim on ph->hdr.length, only compare to what
>    ip header claims and return NF_ACCEPT if it does not match.
> - nf_ct_bridge_pre(): Renamed u32 data_len to pppoe_len.
> - nf_ct_bridge_pre(): Reset network_header only when ret == NF_ACCEPT.
> - nf_checksum(_partial)(): Use of skb_network_offset().
> - nf_checksum(_partial)(): Use 'if (WARN_ON()) return 0' instead.
> - nf_checksum(_partial)(): Added comments
> 
> Changes in v14:
> 
> - nf_checksum(_patial): Use DEBUG_NET_WARN_ON_ONCE(
>    !skb_pointer_if_linear()) instead of pskb_may_pull().
> - nft_do_chain_bridge: Added default case ph->proto is neither
>    ipv4 nor ipv6.
> - nft_do_chain_bridge: only reset network header when ret == NF_ACCEPT.
> 
> Changes in v13:
> 
> - Do not use pull/push before/after calling nf_conntrack_in() or
>    nft_do_chain().
> - Add patch to correct calculating checksum when skb->data !=
>    skb_network_header(skb).
> 
> Changes in v12:
> 
> - Only allow tracking this traffic when a conntrack zone is set.
> - nf_ct_bridge_pre(): skb pull/push without touching the checksum,
>    because the pull is always restored with push.
> - nft_do_chain_bridge(): handle the extra header similar to
>    nf_ct_bridge_pre(), using pull/push.
> 
> Changes in v11:
> 
> - nft_do_chain_bridge(): Proper readout of encapsulated proto.
> - nft_do_chain_bridge(): Use skb_set_network_header() instead of thoff.
> - removed test script, it is now in separate patch.
> 
> v10 split from patch-set: bridge-fastpath and related improvements v9
> 
> Eric Woudstra (4):
>   netfilter: utils: nf_checksum(_partial) correct data!=networkheader
>   netfilter: bridge: Add conntrack double vlan and pppoe
>   netfilter: nft_set_pktinfo_ipv4/6_validate: Add nhoff argument
>   netfilter: nft_chain_filter: Add bridge double vlan and pppoe
> 
>  include/net/netfilter/nf_tables_ipv4.h     | 21 +++--
>  include/net/netfilter/nf_tables_ipv6.h     | 21 +++--
>  net/bridge/netfilter/nf_conntrack_bridge.c | 92 ++++++++++++++++++----
>  net/netfilter/nft_chain_filter.c           | 59 ++++++++++++--
>  net/netfilter/utils.c                      | 28 +++++--
>  5 files changed, 176 insertions(+), 45 deletions(-)
> 

Can I kindly ask, what is the status of this patch-set?

Regards,

Eric

