Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA55522F0C
	for <bridge@lists.linux.dev>; Tue, 22 Sep 2026 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116206; cv=none; b=BJEdoCZ5m6VuAziJZu3imgWyKUoqV6RGeoZrxWWR5HC1ls7x2Xod4OWkGUUBFSPI1a0EX1w1+r2w+KoWHqb71MtdGoE8jaCkm/BrvuswZ7eeKKx3djuFJgiakK6WHf5nJGlSSFJCTRoz4eiYvJmLGzbvWF7XsIO3VEB/4SsIGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116206; c=relaxed/simple;
	bh=GPLKcgE/IGUmibjYksV+m38Ut7/zFBjUgzhUH19TbD8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=meL0dfIHzUYMlJZ9Y5McnJstqdlVzhmJBlYWTLmylXf9flShtPPQk/6DfWmF/BViM1I/DJKWZTOKJYAGoEeyb7E8ny7473a05ddRVEJTLoJNosO/La8/T1UH7lDRBwGlNIkiXViKqsalDgOyBfAnh1B1mmliEgF5ZcabUO2L7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dh+9zi6k; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh+9zi6k"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d45ae011aso6075147b3.0
        for <bridge@lists.linux.dev>; Tue, 22 Sep 2026 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790116191; x=1790720991; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0qPZh/r/REXP5ZSy0nxs+oUBSRD0aY6qVWm9CYsML3E=;
        b=dh+9zi6k29YOHXOI95L7mm/zLAVesm8aybOR/mSE4cMZsD6o7wE8xPfsa17uf2bKiF
         okQnYJtIRdsjAmOAKXe4L1iPwGkz8LO9MA5iiJTHVr1uN/jGDv99X00FBi5rBqE+GBUu
         V0lLXhb0RlWaqAX7lqhGkRhwxfc1RpjDu+Oe+M8Zs/2ERQ6Zl8wFWvRqJYWEGgcRlurv
         Sxi2Mw7fwf+aNECxi85UC9XOVeVTz4a29XXhQDdjy3qC7y6ZT5+q23Kq3RyJkqm4lwG+
         +AWlk2sTGrTo+aMzIJBJY5YHjV+T373FsKqifqYHlmJmnzYcbcks9pA/sDg3N1Fr6MaN
         xpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790116191; x=1790720991;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0qPZh/r/REXP5ZSy0nxs+oUBSRD0aY6qVWm9CYsML3E=;
        b=dycpQ69uZF36WQ8I7mm1LO15qAQI3DKB0dlpmm3Gk9NlImz+7L427JMrPcEBfFYHvs
         bNLvGNCn43FTHjHNnbsz54uuexw8YoSKWsRX4KFJ/TtEqPki1UZnp9paZzST4pBlnEWt
         f7pmcV+HQXOftMfNO0ar0ndECgSIqpjlunw7F1H3W6ESpKFnMTcLhEqaEhnBuQ/+bH1E
         u6bSvuCK5Y++00tqOrMzbBXDdsYM1GgEN3jGNFxIkd8Xgtd7KTBfUoKsgYC98jlTPkFB
         cLW7/i/zU3YMBmGm+ZXj/EeiHuqhZFzXgFCCVdlCzSfDAB/cHygMqANmtZTDTC4kxmVl
         mTEQ==
X-Forwarded-Encrypted: i=1; AKwUvBysHKPO1qovGL4gWrdOmQ9krnHiAC/C8MERCIs84hg7kVUtv+haWUqncpuAoGz6V2aHRu37OLQ=@lists.linux.dev
X-Gm-Message-State: AFuF++kHe+dqXScbFc5+rWW+5wJDFAAqImBe4GkFWuKS/PvWuB/FIdgw
	Get4HmWjF56kXjXclfi7pP1cHlJVpYdX0RyYkdHGhAgCkRn3J+euUTtC
X-Gm-Gg: AYBFou2VFXCADIs0Wk+On1ExrzTneNUpw1mzkXgXlXVI7seqiQTmVOS2nuDtRQWGDKA
	4zTyGrw+JqbkExQ5E+cl0Ndu0c6AJzFceCl6dH4zeXhAfgU+t54JmVxNVQGZvo7ZhY/AfN7vhaa
	rPc0vR00UG8M84cvFWGj5qHJhh6aydxl1ByvhZoBpuUfLJIgXOkJw75uQP3/Lwo6wtB9Ps/fs7l
	eQ1WUaMRNteK5tIZOCM6aklq4Me0dyLWCWCfabi77d/bnNwcb38ZsNbYjqbuSC2AkH6LOakO9qW
	Dk/XecRW7OKpKHyBv9JW2Vrxo58OOPqD3RHAqBKrrYuLC5tponYk3XCxCDBMbAKfoASMjgvhl21
	IHmWsqZA1+naHbmiIhr/9++YEbN5J2i9Jlj1ilXPsMCZYvWaKSgAcCLUcAgJYvUcpRCS+ofFPC3
	S5g1XE09zxzTiDMrj2ax0BXCxOMuwe0PwKpWDLxAFOST36x9jQx+gWGM6msv69EZZsFte6fbI8F
	bObkzH8+p8M7PhGziS14QJDGnRGgJZ/Fmf3lfwq2UNX79F57pdl
X-Received: by 2002:a05:690c:c:b0:873:5bb2:6c32 with SMTP id 00721157ae682-8a45bb75c4bmr5165927b3.57.1790116191128;
        Tue, 22 Sep 2026 15:29:51 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a465ec41acsm3153167b3.26.2026.09.22.15.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:29:50 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:29:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paulos Yibelo <habte.yibelo@gmail.com>, 
 netdev@vger.kernel.org
Cc: richard@nod.at, 
 anton.ivanov@cambridgegreys.com, 
 johannes@sipsolutions.net, 
 willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 xuanzhuo@linux.alibaba.com, 
 andrew+netdev@lunn.ch, 
 pablo@netfilter.org, 
 fw@strlen.de, 
 phil@nwl.cc, 
 razor@blackwall.org, 
 idosch@nvidia.com, 
 dsahern@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 linux-um@lists.infradead.org, 
 virtualization@lists.linux.dev, 
 netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, 
 bridge@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.259bc7096258d@gmail.com>
In-Reply-To: <20260922030310.8684-2-habte.yibelo@gmail.com>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
 <20260922030310.8684-2-habte.yibelo@gmail.com>
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paulos Yibelo wrote:
> __virtio_net_hdr_to_skb() checks a minimum network-header length for
> CHECKSUM_PARTIAL packets. Its checksum start is relative to skb->data,
> but some callers have not established skb->network_header when they
> convert the virtio header.
> =

> Pass the data-relative L3 origin explicitly. Ethernet receive paths
> parse the frame and nested VLAN headers without changing skb state.
> AF_PACKET uses the frame's actual L3 origin even when the socket
> protocol is ETH_P_IP and the raw frame carries VLAN tags. Non-Ethernet
> AF_PACKET devices retain their established skb network offset.
> =

> Also pass the actual L3 protocol so IPv6 packets use the 40-byte base
> header minimum even without TCPv6 GSO. IFF_TUN obtains that protocol
> from the packet before skb->protocol is set. Name the Ethernet parser
> accordingly, use the same origin for tunnel validation, and propagate
> conversion failures in UML.
> =

> The bound remains a minimum; fragmentation paths separately validate
> the parsed IPv4 or IPv6 header length before completing a checksum.
> =

> Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_=
net_hdr_to_skb()")
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO t=
unneling.")
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Link: https://lore.kernel.org/netdev/20260920004733.6473-2-habte.yibelo=
@gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
> ---
>  arch/um/drivers/vector_transports.c | 13 ++++-
>  drivers/net/tun_vnet.h              | 52 ++++++++++++++++-
>  drivers/net/virtio_net.c            | 10 +++-
>  include/linux/virtio_net.h          | 87 ++++++++++++++++++++++++-----=

>  net/packet/af_packet.c              | 24 +++++++-
>  5 files changed, 163 insertions(+), 23 deletions(-)

The fix may still miss the case IPv4 packets have options.

This version is a very large patch.

Untested shorter first suggestion by bot, which looks plausible as a
starting point for discussion.

    --- a/drivers/net/tun_vnet.h
    +++ b/drivers/net/tun_vnet.h
    @@ -152,6 +152,9 @@ static inline int tun_vnet_hdr_to_skb(unsigned in=
t flags, struct sk_buff *skb,
                           const struct virtio_net_hdr *hdr)
     {
    +    if ((flags & TUN_TYPE_MASK) =3D=3D IFF_TUN)
    +        skb_reset_network_header(skb);
    +
         return virtio_net_hdr_to_skb(skb, hdr, tun_is_little_endian(flag=
s));
     }

    --- a/include/linux/virtio_net.h
    +++ b/include/linux/virtio_net.h
    @@ -71,9 +71,27 @@ static inline int __virtio_net_hdr_to_skb(struct s=
k_buff *skb,
             if (!pskb_may_pull(skb, needed))
                 return -EINVAL;
     =

    +        if (!skb_network_header_was_set(skb) ||
    +            (skb->dev && skb->dev->type =3D=3D ARPHRD_ETHER)) {
    +            int nhoff =3D ETH_HLEN;
    +
    +            if (unlikely(start < ETH_HLEN + nh_min_len))
    +                return -EINVAL;
    +            __vlan_get_protocol(skb, eth_hdr(skb)->h_proto, &nhoff);=

    +            nh_min_len +=3D nhoff;
    +        } else {
    +            nh_min_len +=3D skb_network_offset(skb);
    +        }
    +        if (unlikely(start < nh_min_len))
    +            return -EINVAL;
    +
    +        const struct iphdr *iph =3D (void *)(skb->data + nh_min_len =
- sizeof(*iph));
    +        if (iph->version =3D=3D 4)
    +            nh_min_len +=3D max_t(u32, iph->ihl * 4, sizeof(*iph)) -=
 sizeof(*iph);
    +        else if (iph->version =3D=3D 6)
                 /* ..here I don't trust the initial bug output, but the =
branch is clear.. */
    +        if (unlikely(start < nh_min_len))
    +            return -EINVAL;
    +
             if (!skb_partial_csum_set(skb, start, off))
                 return -EINVAL;
    -        if (skb_transport_offset(skb) < nh_min_len)
    -            return -EINVAL;
         }

    --- a/net/ipv4/ip_output.c
    +++ b/net/ipv4/ip_output.c
    @@ -772,7 +772,9 @@ int ip_do_fragment(struct net *net, struct sock *=
sk, struct sk_buff *skb,
         if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
             (!(dev->features & NETIF_F_CSUM_MASK) ||
    -         skb_checksum_help(skb)))
    +         skb_checksum_start_offset(skb) < (int)(iph->ihl * 4) ||
    +         skb_checksum_help(skb)))
             goto fail;
  =

And the summary of the problem:

  ### 1. What the Problem Is

  When userspace (AF_PACKET, TUN/TAP, vhost-net) or a device (virtio_net,=
 UML) injects a CHECKSUM_PARTIAL packet using struct virtio_net_hdr,
  virtio_net.h:47-119 validates hdr->csum_start:

    // include/linux/virtio_net.h:107 (added by commit 49d14b54a527)
    if (skb_transport_offset(skb) < nh_min_len)
        return -EINVAL;

  This validation has three bugs:

  1. Missing L2 + VLAN offset: skb_transport_offset(skb) (hdr->csum_start=
) is an offset from skb->data, which points to the L2 header (14
  bytes for Ethernet + 4 * n bytes for 802.1Q/802.1ad VLAN tags) on Ether=
net callers (virtio_net, IFF_TAP, PACKET_SOCK_DGRAM/SOCK_RAW).
  Comparing csum_start < 20 allows csum_start to land inside the L2 VLAN =
tags (14..21) or inside the L3 header (22..33).
  2. Wrong nh_min_len for IPv6 non-GSO: nh_min_len defaults to sizeof(str=
uct iphdr) (20) and is only raised to sizeof(struct ipv6hdr) (40)
  when gso_type is VIRTIO_NET_HDR_GSO_TCPV6. A non-GSO or GSO_UDP_L4 IPv6=
 packet is only checked against 20 bytes.
  3. Ignores IPv4 options (iph->ihl > 5): Even without an L2 header (IFF_=
TUN), an IPv4 header with options can be up to 60 bytes (ihl =3D 15),
  allowing csum_start =3D 20 to point 40 bytes inside the IPv4 options ar=
ea.

  This causes two kernel bugs downstream:

  =E2=80=A2 Bug A (WARN_ONCE / panic_on_warn in skb_checksum_help): With =
2 VLAN tags (22 bytes L2), csum_start =3D 20 passes 20 >=3D 20. Once
  eth_type_trans() + skb_vlan_untag() pull 22 bytes, skb_checksum_start_o=
ffset(skb) (csum_start - skb_headroom(skb)) becomes -2. In
  dev.c:3645, offset >=3D skb_headlen(skb) promotes signed -2 to 0xffffff=
feU, firing WARN_ONCE(1, ...) and crashing panic_on_warn=3D1 hosts.
  =E2=80=A2 Bug B (TOCTOU L3 Header Corruption -> OOB Read in ip_do_fragm=
ent): With csum_start =3D 20, csum_offset =3D 0 on TAP/AF_PACKET, csum_st=
art
  lands at byte 6 of struct iphdr (frag_off) or byte 0 (version/ihl on do=
uble-VLAN frames). In ip_output.c:774 and nf_conntrack_bridge.c:42,
  skb_checksum_help(skb) runs before hlen =3D iph->ihl * 4 is read. The 1=
6-bit checksum write corrupts iph->ihl (e.g. from 5 [20B] to 15 [60B])
  after ip_rcv_core() already validated it, causing ip_do_fragment() to r=
ead 60 bytes out-of-bounds from skb->data.
