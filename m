Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98528C2A1
	for <bridge@lists.linux.dev>; Tue, 12 May 2026 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563338; cv=pass; b=cNaztN9SLSx7jnKtF5d5MS0yC9ineWfiuiX+rjH8xkKsDN8A6Elt4L+Bb+zV3+fRMIL3BymjFmYS7qXEOTSjr2eRkqQVFg8vqNxrxq9ITlsyNUJ3NhHDNulob8wwpVc8qHwkZnkiGpEBcSZ3jLhMFMQmYLwgmFrb2oF9+Q6f/Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563338; c=relaxed/simple;
	bh=w6LcnvI+UACPGciOB3/FIjNHS7YFdMfDIftn70GGb8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGU6hHc347JpQZRm486UHENZJ2kieNBk7gqiXTZNsteIOIz6+4wvK0pUrA7fR/BCPEOg4bDQsJWOQ5ghFuoEgoVLNO4Pmn90fzhhrZxQmqUFmx6J1aHwKchML78ZGw3XD95tx910/s0u9MkEORlFY/w3BTCo/D2CG+5PRF8yH4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZtIMIG5; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZtIMIG5"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-6313c800372so2809791137.0
        for <bridge@lists.linux.dev>; Mon, 11 May 2026 22:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778563324; cv=none;
        d=google.com; s=arc-20240605;
        b=W8gTEiL5SB1efFboBWa+lALFUAQ6nzzklffMME83vVwTGhg9OhuoMdQjCLXPubZbah
         asqNhBRhBE8wlW9+w0/ss6Kz77O34dxOvtKpxxgUEUC/xjznMgH/aqfhNjf3VnYYbXRy
         b4ClhZ2ApNF4zBfOo568sB6hR3CZzfnRNWEFs3otv3EUQGSgq7GAKFIq8c/9Wb6bUe7a
         kR73FcoOQ2yRmJT+YhZ6rRI8nZVc5TLFXPR9v3jVG7LnRO5dcB5osGNLMMXpfS+IjPgJ
         obMOh0k1/NraunfPQhh7GIprRZ7X2iISkqVQC7ikzLyzhveIscmVOPew6Mj7jXlGpF4X
         A+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eYgT6JkoWsOe0O7WVvYu/GZhovUNbtX9Qj6rCvjhBPw=;
        fh=bMLoF7D5qUtqDSnNYiw+6Sd0oZPYXlojYu1S0SPylcQ=;
        b=g402j2kmRpR+V6RP/vgAiyE1M8oAUTR+E+uW/xcv3nWbgtoa7DCVLYeit59wohaQI0
         Ua6c5/xerl0/Wgz7otq7UtfA4S55JmMz8+ci/dKgxZMUDoI+qOlWdde9P6raQIZwYkn3
         uek03H70ubJiRF93pQynzUqsW0T2++e8zzMr97mN8EBCPPvq0ux5Gxn7kCfSOlFk5sHf
         9hg2UK4Tpj2DnWv8UEGcO92J2sqfBVCuN0G1DXwd/p4z3POyy4V58g5XMqhkPQ0WE28A
         F1Bc1022ppk3LqoI9OXwTRQQpmmxjXO4Dbb+WsKNFNzzmkWeLb7pE1wRx11WNQ0LdZhv
         Xs4g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778563324; x=1779168124; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eYgT6JkoWsOe0O7WVvYu/GZhovUNbtX9Qj6rCvjhBPw=;
        b=AZtIMIG5k0EA6qPB5sefo6qtj9bU/jJriepD6Di9SkjStqV7Hjk72gOgwkaoaWOR1l
         H83k+27WhWwAas9h6BwQgyIYzSoFxKAJR5OGfjSW3s1zwVGvjqYPoxUrHc7QJXANmEJO
         E+zfscz9uTzcc8H7MRWyX4+52bRJYCfroojLt2Bts98APIw7LKrJhHJ1RewmEnk8xe2E
         6mznfW9wrCMPdBnC7jlVF0Y5kqxc1kLwmrZPSXlhPkcdZ5Ys10KJ+eqh5S/3PSX2NQPB
         v9JU69tXkLRxek9ai4rg+bs+T5zm4MV/JB/g2VW/ABWy9Tz6RUsUB106ze/3b2Wptdix
         WkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778563324; x=1779168124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYgT6JkoWsOe0O7WVvYu/GZhovUNbtX9Qj6rCvjhBPw=;
        b=OY8VKmloZ8ozpwnamEfUHM0h1bDurj5coHtG1NYyGDLzNv11vC0oEGC/QEFNi3umsq
         yT/FVQbzGJQUKWH4bsvFpDDhsUICNbRVkj6ZGLaUkXwRlhQUke1lSmgU/9BjK63jVAsC
         CRUbwjz7Yl8QWcOblyTKG8HmRMjGzqQDTG+ngZ7ccjLIYQXRM6wtPA7AndKM97iZ9nNJ
         3+ZYKypQ7n2R0HxFsAseEgfXJrVwpl6lMWDXjp+blMSktVXv69lJGzzad4jK+4a8WXP4
         q7r7iMbW9TmwU9VJzXxx3gUaw4LrK7rgld9im8JzK4C9Y81a92XKRaBdp5rz/vlVoagG
         Dz3g==
X-Forwarded-Encrypted: i=1; AFNElJ/mlEnPQiE2AvGQlEfTmlc6ruhGySn2Sjdm8A2ssKw+7W2IUKlmIoCQ38hay+lW4C2IkmhpcgI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzB5ewyK19H3c3LUh3+wCUmLg30TS5BFgG0rak9oToKl6rzfOb1
	ugsXUH7Xm/EY9glv8czJLAi+2N9DVXq1P5V7rUHSdx7+EVe/5Xlf2mKuj2x177DYfZX7bRZUqWS
	wppFM0aQQ0cWyCj9mp3NsQV4yQtIOb44=
X-Gm-Gg: Acq92OG/nJkIGz2GfecQy5dKpUa2Id47WMps6n/t8nWqKNMCDuQW8g2Mfb5TE6kTmst
	M+UXY4bxGh0xUyA4dH78tUt5FmbX/Yib9yaIBOet+gHyldJJQnI4RJe5vF5Q+z0zwMSirRC4wgQ
	qNKN/6O4+iVe2GEQFxqMYPkJlEaO16w/MTm9O4WmgQHg+TsP/H/dVKf6k5pStRlybS0qwjBxHvq
	xLRiWWdUnJpJ8cZ2hSg4wMdhHUBpb2lUYUNg8HS3jtjdzf1OHlYNmYGacVyI3a44uXGayFHCdhQ
	WmPP9zTnQXZtDtNs0g==
X-Received: by 2002:a05:6102:38cb:b0:62e:63e8:427b with SMTP id
 ada2fe7eead31-631d5f7dd9emr5242022137.0.1778563323750; Mon, 11 May 2026
 22:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1778378864.git.zylzyl2333@gmail.com> <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
 <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org> <9263d4c1-0c57-4926-930b-1d701e1f17db@blackwall.org>
In-Reply-To: <9263d4c1-0c57-4926-930b-1d701e1f17db@blackwall.org>
From: Yilin Zhu <zylzyl2333@gmail.com>
Date: Mon, 11 May 2026 22:21:51 -0700
X-Gm-Features: AVHnY4K18FPt2uO6-1U5OqSUkqde66HFo9bX9_ajKrRzv_V_NgvX7_lhx7IXbhw
Message-ID: <CAAAOPT8mBxW9Fd9Sr=xWAb-fa4MUHCqKaQf86-DFNqaB9Xvgng@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: bridge: cfm: use a per-bridge frame type
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	idosch@nvidia.com, horatiu.vultur@microchip.com, kuba@kernel.org, 
	henrik.bjoernlund@microchip.com, yuantan098@gmail.com, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, bird@lzu.edu.cn, ronbogo@outlook.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 May 2026 at 04:40, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>
> On 10/05/2026 13:05, Nikolay Aleksandrov wrote:
> > On 10/05/2026 12:15, Ren Wei wrote:
> >> From: Yilin Zhu <zylzyl2333@gmail.com>
> >>
> >> CFM registers a bridge frame handler when the first MEP is created and
> >> unregisters it when the last MEP is deleted. The registered object also
> >> contains the hlist_node used by the bridge-local frame_type_list.
> >>
> >> The CFM frame type is currently global, so enabling CFM on multiple
> >> bridges links the same hlist_node into multiple bridge-local lists. A
> >> later unregister on one bridge can then operate on list state belonging
> >> to another bridge.
> >>
> >> Move the CFM frame type into struct net_bridge and register/unregister
> >> the bridge-owned object. This keeps frame handler list membership local
> >> to the bridge while preserving the existing first-MEP/last-MEP lifetime.
> >>
> >> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM
> >> frame RX added.")
> >> Cc: stable@kernel.org
> >> Reported-by: Yuan Tan <yuantan098@gmail.com>
> >> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> >> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> >> Reported-by: Xin Liu <bird@lzu.edu.cn>
> >> Co-developed-by: Peihan Liu <ronbogo@outlook.com>
> >> Signed-off-by: Peihan Liu <ronbogo@outlook.com>
> >> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
> >> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> >> ---
> >>   net/bridge/br_cfm.c     | 14 ++++++--------
> >>   net/bridge/br_private.h | 18 +++++++++++-------
> >>   2 files changed, 17 insertions(+), 15 deletions(-)
> >>
> >
> > I think MRP suffers from the same bug, but I also think we can contain the
> > fix within the packet type structure instead of making the already huge
> > struct net_bridge even bigger. Also, linking a struct within net_bridge
> > to a list within the same net_bridge looks weird.
> >
> > IMO br_add_frame should take a type & a frame_handler, allocate a br_frame_type
> > dynamically and link it, then br_del_frame should take a type instead of a ptr
> > and remove that frame type and free it with kfree_rcu. That would require
> > br_add_frame return value to be checked in the respective cfm/mrp functions.
> > Warnings for already existing types on add or missing types on del should be
> > added.
> >
>
> Actually I have a better idea since these handlers can be added only once per
> bridge, we can do away with a simple bitmask (e.g. use net_bridge's options
> which is in a Rx hot cache line) and even reduce net_bridge size while fixing
> these bugs, and also remove a conditional from the fast-path when CFM/MRP are
> not compiled in. Would you like me to prepare it or do you want to give it a go?
>

Hi Nik,

Thanks for the suggestion.

I'll give it a go. IIUC, the idea is to remove the shared
br_frame_type list entries for CFM/MRP, track their per-bridge enable
state with bridge option bits, and dispatch the CFM/MRP handlers directly
from the receive path when the corresponding EtherType and option bit
match.

I'll include MRP in v2.

Thanks,
Yilin

> > Would you please take care of MRP as well?
> >
> > Cheers,
> >   Nik
> >
> >> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> >> index 118c7ea48c35..547c7415c0ea 100644
> >> --- a/net/bridge/br_cfm.c
> >> +++ b/net/bridge/br_cfm.c
> >> @@ -489,11 +489,6 @@ static int br_cfm_frame_rx(struct net_bridge_port *port,
> >> struct sk_buff *skb)
> >>       return 1;
> >>   }
> >> -static struct br_frame_type cfm_frame_type __read_mostly = {
> >> -    .type = cpu_to_be16(ETH_P_CFM),
> >> -    .frame_handler = br_cfm_frame_rx,
> >> -};
> >> -
> >>   int br_cfm_mep_create(struct net_bridge *br,
> >>                 const u32 instance,
> >>                 struct br_cfm_mep_create *const create,
> >> @@ -558,8 +553,11 @@ int br_cfm_mep_create(struct net_bridge *br,
> >>       INIT_HLIST_HEAD(&mep->peer_mep_list);
> >>       INIT_DELAYED_WORK(&mep->ccm_tx_dwork, ccm_tx_work_expired);
> >> -    if (hlist_empty(&br->mep_list))
> >> -        br_add_frame(br, &cfm_frame_type);
> >> +    if (hlist_empty(&br->mep_list)) {
> >> +        br->cfm_frame_type.type = cpu_to_be16(ETH_P_CFM);
> >> +        br->cfm_frame_type.frame_handler = br_cfm_frame_rx;
> >> +        br_add_frame(br, &br->cfm_frame_type);
> >> +    }
> >>       hlist_add_tail_rcu(&mep->head, &br->mep_list);
> >> @@ -588,7 +586,7 @@ static void mep_delete_implementation(struct net_bridge *br,
> >>       kfree_rcu(mep, rcu);
> >>       if (hlist_empty(&br->mep_list))
> >> -        br_del_frame(br, &cfm_frame_type);
> >> +        br_del_frame(br, &br->cfm_frame_type);
> >>   }
> >>   int br_cfm_mep_delete(struct net_bridge *br,
> >> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> >> index bed1b1d9b282..a3ed9ee826f5 100644
> >> --- a/net/bridge/br_private.h
> >> +++ b/net/bridge/br_private.h
> >> @@ -61,6 +61,9 @@ typedef struct bridge_id bridge_id;
> >>   typedef struct mac_addr mac_addr;
> >>   typedef __u16 port_id;
> >> +struct net_bridge_port;
> >> +struct sk_buff;
> >> +
> >>   struct bridge_id {
> >>       unsigned char    prio[2];
> >>       unsigned char    addr[ETH_ALEN];
> >> @@ -70,6 +73,13 @@ struct mac_addr {
> >>       unsigned char    addr[ETH_ALEN];
> >>   };
> >> +struct br_frame_type {
> >> +    __be16            type;
> >> +    int            (*frame_handler)(struct net_bridge_port *port,
> >> +                         struct sk_buff *skb);
> >> +    struct hlist_node    list;
> >> +};
> >> +
> >>   #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
> >>   /* our own querier */
> >>   struct bridge_mcast_own_query {
> >> @@ -585,6 +595,7 @@ struct net_bridge {
> >>       struct hlist_head        mrp_list;
> >>   #endif
> >>   #if IS_ENABLED(CONFIG_BRIDGE_CFM)
> >> +    struct br_frame_type    cfm_frame_type;
> >>       struct hlist_head        mep_list;
> >>   #endif
> >>   };
> >> @@ -926,13 +937,6 @@ int nbp_backup_change(struct net_bridge_port *p, struct
> >> net_device *backup_dev);
> >>   int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff
> >> *skb);
> >>   rx_handler_func_t *br_get_rx_handler(const struct net_device *dev);
> >> -struct br_frame_type {
> >> -    __be16            type;
> >> -    int            (*frame_handler)(struct net_bridge_port *port,
> >> -                         struct sk_buff *skb);
> >> -    struct hlist_node    list;
> >> -};
> >> -
> >>   void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
> >>   void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
> >
>
