Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599515;
	b=eps9/qv/hhjpGMy2k+f8VNJxPe+nywS6/w+uG51WD3gNL91vKZcie784sPdhvzCwz5Yf
	 YehqoTju+wA3ffxhN12O00AV3ZQpsR+iyE7KXUUtXHI+xH7T4hCztuzFD6OaHVIeviVCx
	 OT1tVTFM56J0AWsMfAcoj/a9WiLW6jbe0d+z56+bRW1wNxJewJCufftzPjBEUOPKEv4Rv
	 rh3zXLX3DbBgIIPgAT4kjPOCRKB/k5LiKyBLvb5brWmH6i/oXJekk3u1pAu6xpprgSV3d
	 bloaZStyw0UQOC6uL5rGnHxeX4GjN0Ma/G4ODXvfmurVvRSUDVUE9e8zdhcsYp3+sFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UrbNAcrvvqBJ2+CGBxSM/krMHIMJIRsTQjY9f7twsUM=;
	b=YG8wW2i9V2F4d+eeRs3UI/AZdcRcf7EVWJ2yLKwLY7pvuO1W0y6bzHkPR8Iiq23XmNLT
	 bzQMzHZ3dGiAwSjw1V+XaOKvGc8/T4xsv9ELUTH4mjTxVTNNx5T9ZqTpArILnNHrUw+yY
	 +fDoQurxskhXEJhH+K1v25sYhrrjUhUNJwget7Unqu1RzqfydHf5Bni3Qr6bqhlHWfQ+q
	 ILJxPBYYxHHMeecCikbT+VZI/hj4pb925c2yqzQfuYXad5LGYsBfoGKpdjTjfkjFbEy8E
	 IzDz5nu/iec7x2idJm5su9jSHZRvC9/4Fi3cTwlTI3Ms1PgFMnlGBqbgGqFu9eAjcTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qYdVcKNs;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B86606BF31
	for <bridge@lists.linux.dev>; Wed, 21 Oct 2026 16:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80B86606BF31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qYdVcKNs
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so590878241.2
        for <bridge@lists.linux.dev>; Wed, 21 Oct 2026 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792599513; x=1793204313; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UrbNAcrvvqBJ2+CGBxSM/krMHIMJIRsTQjY9f7twsUM=;
        b=qYdVcKNsztxleXKzUwLa3nh8zmJgP6jawwP42i0gMuU6FN9qCX7xfT1h3aSMj7ldPV
         mRQF7ifLMhKQYnPR+pj/piPVL0RvuoFC6T8EiaHZ0Z1hgWCqYGxUnQ/p+bcGtRzMN5uS
         4jgi5jyx8v+mUEkveJNxz27IcJzRvi/mqoTxNFGwTwByN/sXrDZ51WznTY4A4ujAweRM
         PFG7PWGvEcgZhdrLHV4Hd73SjNZV6nm8pfi7D2DdQZDWqTe8aP5XCJhc0mVrUV/izzsj
         rw+GgnaI50bbf8imQcxKv0vYBNc90ERbZ4Z1N+Mk5NAuhze42889UjqxW6Z6A99+6ZCx
         OTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792599513; x=1793204313;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrbNAcrvvqBJ2+CGBxSM/krMHIMJIRsTQjY9f7twsUM=;
        b=vI200VFyvLN94nGthFZgANJUCs+EL03PBzXcO6y5gLaJzD0VdVmu0ZzY+YEYAxI9GN
         xd0SZj3/oPSZd5hXJDRV1NSrG43JkIgIx3OVRGhEDFtWt6RSaugFcb096EiZhRdMBXTN
         KtOMLYyCUaYIgzI/NowXNU3alFm3FI85LBExoric7P84FPtimOGAGxZ4Nu9RZQ99LM4B
         +l7ydK9TlNY37hgByAmExG5dMuZlVIOKxlssXjXao6paccTE8c5O4/0ymPgHVb0XHO5l
         3ASICs7h45R4OHZnmfPzPKDAIbzj4OMdvBIRVx9zpHJWS6V98NMKlngHAK58jvKgC46c
         DLDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwV8R2N/0d5eA4haENdVQ4WSSggjuzw6RTrZg11BO4HBJyEvIeoremQxE4u8gEE6Wf6BIwI/Ss=@lists.linux.dev
X-Gm-Message-State: AFq9FYKm4OMuU464wRw3lkK81LheqOy/CBANK6c53/HnxFkqv1M+ETMw
	hrmyYkCfvLHc2DtTDdfprO8arQzfB17i7TiCXOC6JfDSR7vd76lpBlaL
X-Gm-Gg: AYBFou1jTkW5RxssP/1I0CW3whJ2XOQBAlgu23Fg8U+KHluJbiwvZv7ybiW9RllWf61
	gdm7FgUAjgGGDwPut/r5Ac0sN8tODd0x02aMN4tmJ1+KJla9MX9jbSSUVPWsFQZN9jsSBxntHU2
	zRDWQcgLVo7qUfQfoU+7sMtCi/1EZRID7x/LtJQOlaYOfQb4ySia1Ssz77GqTiOkifdSbTOIJlv
	+9sqZwOCBsGbZuljoA+MRT7lnh5OOGB/GPZ68jwEbryj0UockrXsB0g+vXVJD6WjiqgrUQx4KDk
	v43KW4NXKeBJ2EhEUYru5CCoFQI489Asn61ighEk9GLY+Gl5ACw3D602HfRVjEQEgkCApV6Rn+P
	v8dlv1EKpRrTWwa0w3Xrm3LXtKY5Rh5vcm1KTiJQOaGHq7cis3+OUL55qRvjZBUjJFRFMaYcAX+
	uKjCfzXthtqvcpdSLTHtfc59P16j9kJTfRlxjXnhJGbFdD/uXaHMCnGQdMmObdQG0caCSf7R45w
	L84lwC2CekXn63VfoiAC8NcK6ZQt0phiE0hM36EnHgy0By3X3Hk9N5YJHUJNcAhhWyfahVvJhHc
	UomO3SYsBqyopXka2dRUxD4QqsWl0bZKkAcCEdItFd+Wyha1TnRXHim1sMXlFJkHMlGx2xVnXIT
	mASqVo5JmKW26Bauxmvg6R+GDrhWfWBofshWlV2Nq
X-Received: by 2002:a05:6102:3e8b:b0:79e:2b00:b4da with SMTP id ada2fe7eead31-7cc9263e66bmr1074589137.6.1792599513253;
        Wed, 21 Oct 2026 09:18:33 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc9236f63csm3160917137.5.2026.10.21.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:18:32 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:18:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Florian Westphal <fw@strlen.de>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, 
 bridge@lists.linux.dev
Message-ID: <willemdebruijn.kernel.c4a4cd674948@gmail.com>
In-Reply-To: <aa1551c0357a149a84d01761872cb4d3b489d1af.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
 <aa1551c0357a149a84d01761872cb4d3b489d1af.1792565282.git.mst@redhat.com>
Subject: Re: [PATCH net v4 6/7] net: add ip4_parse()
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> Multiple places in the net stack open-code the same minimal IPv4 header=

> validation: pull the fixed header, check version 4 and IHL >=3D 5 (wher=
e 5
> is the fixed header size in 32-bit units) - and locate the transport
> header at IHL * 4 past the network header.
> =

> Add a helper for doing that: it returns the validated header and
> the transport header offset, or NULL if truncated or malformed.
> =

> As noted by Phil Sutter, there are more places that could use this
> helper, e.g. ip_mc_check_iphdr(). They will be converted in a follow-up=

> patch.
> =

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Reviewed-by: Phil Sutter <phil@nwl.cc>
> ---
>  include/linux/ip.h                  | 30 +++++++++++++++++++++++++++++=

>  include/linux/virtio_net.h          | 28 +--------------------------
>  net/bridge/br_netfilter_hooks.c     | 15 +++++----------
>  net/ipv4/ip_input.c                 | 13 +++++--------
>  net/ipv4/netfilter/nf_reject_ipv4.c | 13 +++++--------
>  5 files changed, 46 insertions(+), 53 deletions(-)
> =

> diff --git a/include/linux/ip.h b/include/linux/ip.h
> index d11c25f5030a..aba37cd60212 100644
> --- a/include/linux/ip.h
> +++ b/include/linux/ip.h
> @@ -56,4 +56,34 @@ static inline void iph_set_totlen(struct iphdr *iph,=
 unsigned int len)
>  {
>  	iph->tot_len =3D len <=3D IP_MAX_MTU ? htons(len) : 0;
>  }
> +
> +/**
> + * ip4_parse - pull and minimally validate an IPv4 header

This only pulls sizeof(struct iphdr).

To match function comment and generally be robust: pull again
if ihl !=3D 0.

Apparently virtio_net_hdr_tnl_to_skb will set =

skb->transport_header to the thoff reported here, which may be
beyond the end of the linear packet.

> + * @skb: buffer to parse
> + * @nhoff: offset of the IPv4 header within the linear data
> + * @thoff: returns the transport header offset
> + *
> + * Only the fixed header is guaranteed linear on return: callers
> + * that need the options or the transport header must pull
> + * further.
> + *
> + * Return: the validated IPv4 header, or NULL if truncated or
> + * malformed.
> + */
> +static inline struct iphdr *ip4_parse(struct sk_buff *skb,
> +				      unsigned int nhoff,
> +				      unsigned int *thoff)
> +{
> +	struct iphdr *iph;
> +
> +	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
> +		return NULL;
> +
> +	iph =3D (struct iphdr *)(skb->data + nhoff);
> +	if (iph->version !=3D 4 || iph->ihl < sizeof(struct iphdr) / sizeof(u=
32))
> +		return NULL;
> +
> +	*thoff =3D nhoff + iph->ihl * sizeof(u32);
> +	return iph;
> +}
>  #endif	/* _LINUX_IP_H */
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b3bbecbd023c..724ab8659501 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -53,32 +53,6 @@ static inline int virtio_net_hdr_set_proto(struct sk=
_buff *skb,
>  	return 0;
>  }
>  =

> -/* TODO: nothing virtio specific here, move to ip.h */
> -
> -/*
> - * Pull and minimally validate the IPv4 header at @nhoff.
> - * Returns the header and stores the transport header offset in
> - * @thoff, or NULL if truncated or malformed.  Only the fixed header
> - * is guaranteed linear; callers that need the options or the
> - * transport header must pull further.
> - */
> -static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> -						  unsigned int nhoff,
> -						  unsigned int *thoff)
> -{
> -	struct iphdr *iph;
> -
> -	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
> -		return NULL;
> -
> -	iph =3D (struct iphdr *)(skb->data + nhoff);
> -	if (iph->version !=3D 4 ||
> -	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
> -		return NULL;
> -
> -	*thoff =3D nhoff + iph->ihl * sizeof(u32);
> -	return iph;
> -}
>  /* Defined in net/core/dev.c, enabled while any network namespace
>   * has net.core.virtio_net_hdr_validate set to 0.
>   */
> @@ -157,7 +131,7 @@ virtio_net_l4_start(struct sk_buff *skb, unsigned i=
nt nhoff, __be16 proto,
>  		    unsigned int *thoff, int *ip_proto)
>  {
>  	if (proto =3D=3D htons(ETH_P_IP)) {
> -		const struct iphdr *iph =3D virtio_net_ip4_parse(skb, nhoff, thoff);=

> +		const struct iphdr *iph =3D ip4_parse(skb, nhoff, thoff);
>  =

>  		if (!iph || ip_is_fragment(iph))
>  			return false;
> diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_=
hooks.c
> index 0a394e5f4391..e89da0e41542 100644
> --- a/net/bridge/br_netfilter_hooks.c
> +++ b/net/bridge/br_netfilter_hooks.c
> @@ -206,18 +206,13 @@ static inline void nf_bridge_pull_encap_header_rc=
sum(struct sk_buff *skb)
>  static int br_validate_ipv4(struct net *net, struct sk_buff *skb)
>  {
>  	const struct iphdr *iph;
> -	u32 len;
> +	u32 len, thoff;
>  =

> -	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> +	iph =3D ip4_parse(skb, 0, &thoff);
> +	if (!iph)
>  		goto inhdr_error;
>  =

> -	iph =3D ip_hdr(skb);
> -
> -	/* Basic sanity checks */
> -	if (iph->ihl < 5 || iph->version !=3D 4)
> -		goto inhdr_error;
> -
> -	if (!pskb_may_pull(skb, iph->ihl*4))
> +	if (!pskb_may_pull(skb, thoff))
>  		goto inhdr_error;
>  =

>  	iph =3D ip_hdr(skb);
> @@ -228,7 +223,7 @@ static int br_validate_ipv4(struct net *net, struct=
 sk_buff *skb)
>  	if (skb->len < len) {
>  		__IP_INC_STATS(net, IPSTATS_MIB_INTRUNCATEDPKTS);
>  		goto drop;
> -	} else if (len < (iph->ihl*4))
> +	} else if (len < thoff)
>  		goto inhdr_error;
>  =

>  	if (pskb_trim_rcsum(skb, len)) {
> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index 9860178752b8..5adf01763e85 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -500,7 +500,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *=
skb, struct net *net)
>  {
>  	const struct iphdr *iph;
>  	int drop_reason;
> -	u32 len;
> +	u32 len, thoff;
>  =

>  	/* When the interface is in promisc. mode, drop all the crap
>  	 * that it receives, do not try to analyse it.
> @@ -520,10 +520,6 @@ static struct sk_buff *ip_rcv_core(struct sk_buff =
*skb, struct net *net)
>  	}
>  =

>  	drop_reason =3D SKB_DROP_REASON_NOT_SPECIFIED;
> -	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> -		goto inhdr_error;
> -
> -	iph =3D ip_hdr(skb);
>  =

>  	/*
>  	 *	RFC1122: 3.2.1.2 MUST silently discard any IP frame that fails the=
 checksum.
> @@ -536,7 +532,8 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *=
skb, struct net *net)
>  	 *	4.	Doesn't have a bogus length
>  	 */
>  =

> -	if (iph->ihl < 5 || iph->version !=3D 4)
> +	iph =3D ip4_parse(skb, 0, &thoff);
> +	if (!iph)
>  		goto inhdr_error;
>  =

>  	BUILD_BUG_ON(IPSTATS_MIB_ECT1PKTS !=3D IPSTATS_MIB_NOECTPKTS + INET_E=
CN_ECT_1);
> @@ -546,7 +543,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *=
skb, struct net *net)
>  		       IPSTATS_MIB_NOECTPKTS + (iph->tos & INET_ECN_MASK),
>  		       max_t(unsigned short, 1, skb_shinfo(skb)->gso_segs));
>  =

> -	if (!pskb_may_pull(skb, iph->ihl*4))
> +	if (!pskb_may_pull(skb, thoff))
>  		goto inhdr_error;
>  =

>  	iph =3D ip_hdr(skb);
> @@ -559,7 +556,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *=
skb, struct net *net)
>  		drop_reason =3D SKB_DROP_REASON_PKT_TOO_SMALL;
>  		__IP_INC_STATS(net, IPSTATS_MIB_INTRUNCATEDPKTS);
>  		goto drop;
> -	} else if (len < (iph->ihl*4))
> +	} else if (len < thoff)
>  		goto inhdr_error;
>  =

>  	/* Our transport medium may have padded the buffer out. Now we know i=
t
> diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/n=
f_reject_ipv4.c
> index 59ec465a9df9..42d639854ddf 100644
> --- a/net/ipv4/netfilter/nf_reject_ipv4.c
> +++ b/net/ipv4/netfilter/nf_reject_ipv4.c
> @@ -25,22 +25,19 @@ nf_reject_ip_tcphdr_get(struct sk_buff *oldskb,
>  static int nf_reject_iphdr_validate(struct sk_buff *skb)
>  {
>  	struct iphdr *iph;
> -	u32 len;
> +	u32 len, thoff;
>  =

> -	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> -		return 0;
> -
> -	iph =3D ip_hdr(skb);
> -	if (iph->ihl < 5 || iph->version !=3D 4)
> +	iph =3D ip4_parse(skb, 0, &thoff);
> +	if (!iph)
>  		return 0;
>  =

>  	len =3D ntohs(iph->tot_len);
>  	if (skb->len < len)
>  		return 0;
> -	else if (len < (iph->ihl*4))
> +	else if (len < thoff)
>  		return 0;
>  =

> -	if (!pskb_may_pull(skb, iph->ihl*4))
> +	if (!pskb_may_pull(skb, thoff))
>  		return 0;
>  =

>  	return 1;
> -- =

> MST
> =



