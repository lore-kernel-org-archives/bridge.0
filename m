Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E901A1FC10E
	for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734558913; cv=none; b=ZOY32OY5+N6pM5pILoyQvETwZYWD/ur+N/hPBVCS4v3MhBHNPlPvr0Wg3JdYA78U5OjjvjDp6e9vldqDowL7+leB+f8YVUUQGn67RIP2bEEKT8n0Wi3dKbDpxuGRffZeEdI+3MjzPCTxwK/98wb9aePg7enbw8Do3uY8aVh2fFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734558913; c=relaxed/simple;
	bh=5ZEZ+TI1oQvwqyi+qfTdq+f7UdxeUiqMzkx0SjK4wjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJrE2bfe8xygo1oef3QLlvu9eLCmdIz/oIMWwNI5zQORAhKkcNeGh3z0bC220FNaeJUQDksU60ekj5hRzWOFWVqDZUc70dyoJekMV/kab0PY5RlKw2xaUjySJUgycQLxnvikpdLBxUF0YGXMxQaLDC9RL47gt/kpfj+z64/eb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGrBe5L6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGrBe5L6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734558910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZEZ+TI1oQvwqyi+qfTdq+f7UdxeUiqMzkx0SjK4wjc=;
	b=RGrBe5L6nZJzVIFTcCcy/YO5t8bYpQRLBL8SbrrORJM4V78AzcZNR5Hq2cMLOhJyHQXl0Z
	k/nrsmA+brDnYuXRAs2LgthZiKypJ67vlkQ39VyrXQosNvd+zulxKfG53qS0nTMLNXBi76
	wU8+vxmMLkK6LA/4IM2MXeriipuqT1A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-42wcjGauPf-zu4sWcYnrPQ-1; Wed, 18 Dec 2024 16:55:08 -0500
X-MC-Unique: 42wcjGauPf-zu4sWcYnrPQ-1
X-Mimecast-MFC-AGG-ID: 42wcjGauPf-zu4sWcYnrPQ
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b864496708so19140085a.2
        for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 13:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734558908; x=1735163708;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47mqpRn+BePFgYtH9uYNUOpjcGsj0s5njP7zbQmLNSM=;
        b=xMpTUoxUOpLWAxsFpWmWy2jPnFhcOeu3rQD8c3bKvti5onYHu1lpxl4pE0GLhjVO/e
         J9xGDE9Xgc0V+efaz3JOnKHqn0OmisAhnkPuwYt2dUaXVYLETfiNL+v+V3DBFy+NZPYl
         KABP+2kfxi1X8mBHrBC9OLB9jlAk56v6EioO9nQy3Gznohxz6zW1g7TS0aQV9CqjmGsX
         q0coiAarKRvwA3w5LOIrWVooZTJzQLiDdgUJFfcU3ES9knLVqcs5SjBxzg59fPxrW7Hr
         sCmF3Y0hYXoXWxPEDk8nVdijyXiwM+VyqQxuhypbmQe/ZMWvw+1tXb0SPcLZCqyMB3bN
         It+g==
X-Forwarded-Encrypted: i=1; AJvYcCVcIohq7IZbfbKA0FqChwNCjbkqlLdodITuC4UJQ7/GKFqT0alDa7yYJ9LkMjr9ecI7q/dD+84=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6swHMKWLQSPB/wMvDdUqnG/eNJCEMzbWDcvYcby5LaJqVK9F7
	sNKa6TQDAEveRz8EAFgd9E6kgcI/EgDvOrmkWExG3yv7gAxUGSkjah9/41aycHOhZcI5dCUpgsV
	BeIzQliZewmRuXKqjScfrCU6dNEbFFgW8zBHMidvRbSmWj22CX3etHQ==
X-Gm-Gg: ASbGnctsHHbdjQ5U246KbjUFgjIvEoK78QVvP4Dk2wGIT1JZvta8xdOv0eh/fX0dSW0
	d1fYjKd12OwN0vOFwCB3sWGponF959fBFcWZfjf47EA/ZU3ueIUfre6jjuy8J9IyS48acS/VLUE
	wzkg25Dc2LvOQJ06jQLZLOEboUhKSdQDhQuvLQIXIOrzIo/yRW2LeiIYAaPWmKtnqcG4hxhLEMh
	XCsPPdbEibnCiU9KLb1JPXd++NSfEzDZO1OQyTn8tF2iGG1vbuBEAwCmHkO0tPdA+fN10ah4a5g
	1Cd+uQcMsbD7wM3SSO/Klf+/P97dWrNc1d+z9Hax0ED8r6/B
X-Received: by 2002:a05:620a:1a94:b0:7b7:25d:d7c9 with SMTP id af79cd13be357-7b9aa8d5861mr190203285a.19.1734558908370;
        Wed, 18 Dec 2024 13:55:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN0nV7r1Aq8rsr9PRc5HhqjMf11OPyLoniGp8EXIXKnhfyQAVUE5qtwUD0N2KZFrTisIGbsg==
X-Received: by 2002:a05:620a:1a94:b0:7b7:25d:d7c9 with SMTP id af79cd13be357-7b9aa8d5861mr190200185a.19.1734558908055;
        Wed, 18 Dec 2024 13:55:08 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2f8fe6sm1111285a.51.2024.12.18.13.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 13:55:07 -0800 (PST)
Message-ID: <d3533bbaa4c91d228dceb449a24eb7cba969c345.camel@redhat.com>
Subject: Re: [PATCH net-next v2 2/2] net: bridge: add skb drop reasons to
 the most common drop points
From: Radu Rendec <rrendec@redhat.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu
 <roopa@nvidia.com>,  bridge@lists.linux.dev, netdev@vger.kernel.org, Simon
 Horman <horms@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,  "David S. Miller"
 <davem@davemloft.net>
Date: Wed, 18 Dec 2024 16:55:05 -0500
In-Reply-To: <Z2MEOvn4dNToq5Fq@shredder>
References: <20241217230711.192781-1-rrendec@redhat.com>
	 <20241217230711.192781-3-rrendec@redhat.com> <Z2MEOvn4dNToq5Fq@shredder>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6olymWuoleNE-d3Sc8UsHKbbBER9rfgAsriKA-Zmkxs_1734558908
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-12-18 at 19:19 +0200, Ido Schimmel wrote:
> On Tue, Dec 17, 2024 at 06:07:11PM -0500, Radu Rendec wrote:
> > @@ -520,6 +522,16 @@ enum skb_drop_reason {
> > =C2=A0=09 * enabled.
> > =C2=A0=09 */
> > =C2=A0=09SKB_DROP_REASON_ARP_PVLAN_DISABLE,
> > +=09/**
> > +=09 * @SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL: the destination MAC addre=
ss
> > +=09 * is an IEEE MAC Control address.
> > +=09 */
> > +=09SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL,
> > +=09/**
> > +=09 * @SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD: the STP state of the
>=20
> s/SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD/SKB_DROP_REASON_BRIDGE_INGRESS=
_STP_STATE/

Oops :) Good catch!

> > +=09 * ingress bridge port does not allow frames to be forwarded.
> > +=09 */
> > +=09SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
> > =C2=A0=09/**
> > =C2=A0=09 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, whi=
ch
> > =C2=A0=09 * shouldn't be used as a real 'reason' - only for tracing cod=
e gen
> > diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> > index e19b583ff2c6d..3e9b462809b0e 100644
> > --- a/net/bridge/br_forward.c
> > +++ b/net/bridge/br_forward.c
> > @@ -201,6 +201,7 @@ void br_flood(struct net_bridge *br, struct sk_buff=
 *skb,
> > =C2=A0=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum br_pkt_type pkt_type, bool=
 local_rcv, bool local_orig,
> > =C2=A0=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 vid)
> > =C2=A0{
> > +=09enum skb_drop_reason reason =3D SKB_DROP_REASON_NO_TX_TARGET;
> > =C2=A0=09struct net_bridge_port *prev =3D NULL;
> > =C2=A0=09struct net_bridge_port *p;
> > =C2=A0
> > @@ -234,8 +235,11 @@ void br_flood(struct net_bridge *br, struct sk_buf=
f *skb,
> > =C2=A0=09=09=09continue;
> > =C2=A0
> > =C2=A0=09=09prev =3D maybe_deliver(prev, p, skb, local_orig);
> > -=09=09if (IS_ERR(prev))
> > +=09=09if (IS_ERR(prev)) {
> > +=09=09=09WARN_ON_ONCE(PTR_ERR(prev) !=3D -ENOMEM);
>=20
> I don't think we want to see a stack trace just because someone forgot
> to adjust the drop reason to the error code. Maybe just set it to
> 'NOMEM' if error code is '-ENOMEM', otherwise to 'NOT_SPECIFIED'.

Sure, that was my first choice too, but then I changed my mind. I don't
think there's a 100% clean way of doing this because maybe_deliver()
can return only -ENOMEM today, but that may change in the future. I
will change it back to what I had initially, which is essentially the
same as you suggested.

> > +=09=09=09reason =3D SKB_DROP_REASON_NOMEM;
> > =C2=A0=09=09=09goto out;
> > +=09=09}
> > =C2=A0=09}
> > =C2=A0
> > =C2=A0=09if (!prev)
> > @@ -249,7 +253,7 @@ void br_flood(struct net_bridge *br, struct sk_buff=
 *skb,
> > =C2=A0
> > =C2=A0out:
> > =C2=A0=09if (!local_rcv)
> > -=09=09kfree_skb(skb);
> > +=09=09kfree_skb_reason(skb, reason);
> > =C2=A0}
> > =C2=A0
> > =C2=A0#ifdef CONFIG_BRIDGE_IGMP_SNOOPING
> > @@ -289,6 +293,7 @@ void br_multicast_flood(struct net_bridge_mdb_entry=
 *mdst,
> > =C2=A0=09=09=09struct net_bridge_mcast *brmctx,
> > =C2=A0=09=09=09bool local_rcv, bool local_orig)
> > =C2=A0{
> > +=09enum skb_drop_reason reason =3D SKB_DROP_REASON_NO_TX_TARGET;
> > =C2=A0=09struct net_bridge_port *prev =3D NULL;
> > =C2=A0=09struct net_bridge_port_group *p;
> > =C2=A0=09bool allow_mode_include =3D true;
> > @@ -329,8 +334,11 @@ void br_multicast_flood(struct net_bridge_mdb_entr=
y *mdst,
> > =C2=A0=09=09}
> > =C2=A0
> > =C2=A0=09=09prev =3D maybe_deliver(prev, port, skb, local_orig);
> > -=09=09if (IS_ERR(prev))
> > +=09=09if (IS_ERR(prev)) {
> > +=09=09=09WARN_ON_ONCE(PTR_ERR(prev) !=3D -ENOMEM);
>=20
> Likewise
>=20
> > +=09=09=09reason =3D SKB_DROP_REASON_NOMEM;
> > =C2=A0=09=09=09goto out;
> > +=09=09}
> > =C2=A0delivered:
> > =C2=A0=09=09if ((unsigned long)lport >=3D (unsigned long)port)
> > =C2=A0=09=09=09p =3D rcu_dereference(p->next);
> > @@ -349,6 +357,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry=
 *mdst,
> > =C2=A0
> > =C2=A0out:
> > =C2=A0=09if (!local_rcv)
> > -=09=09kfree_skb(skb);
> > +=09=09kfree_skb_reason(skb, reason);
> > =C2=A0}
> > =C2=A0#endif
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index ceaa5a89b947f..0adad3986c77d 100644
> > --- a/net/bridge/br_input.c
> > +++ b/net/bridge/br_input.c
> > @@ -96,8 +96,10 @@ int br_handle_frame_finish(struct net *net, struct s=
ock *sk, struct sk_buff *skb
> > =C2=A0=09if (br_mst_is_enabled(br)) {
> > =C2=A0=09=09state =3D BR_STATE_FORWARDING;
> > =C2=A0=09} else {
> > -=09=09if (p->state =3D=3D BR_STATE_DISABLED)
> > -=09=09=09goto drop;
> > +=09=09if (p->state =3D=3D BR_STATE_DISABLED) {
> > +=09=09=09kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_STP_STAT=
E);
> > +=09=09=09return 0;
> > +=09=09}
>=20
> It would be good to keep the error path consolidated with 'goto drop' in
> case we ever want to increment a drop counter or do something else that
> is common to all the drops.
>=20
> Did you consider adding a 'reason' variable that is initialized to
> 'SKB_DROP_REASON_NOT_SPECIFIED' and setting it to the appropriate reason
> before 'goto drop'? Seems like a common pattern.

I did not consider it because I didn't realize there was an intention
to keep the error path consolidated. I did that for the two "flood"
functions though. And now that you explained it, I can see why you'd
want to do it here. I will refactor it and post v3 soon if I don't see
any new comments on v2.

> Same in br_handle_frame().
>=20
> > =C2=A0
> > =C2=A0=09=09state =3D p->state;
> > =C2=A0=09}
> > @@ -155,8 +157,10 @@ int br_handle_frame_finish(struct net *net,
> > struct sock *sk, struct sk_buff *skb
> > =C2=A0=09=09}
> > =C2=A0=09}
> > =C2=A0
> > -=09if (state =3D=3D BR_STATE_LEARNING)
> > -=09=09goto drop;
> > +=09if (state =3D=3D BR_STATE_LEARNING) {
> > +=09=09kfree_skb_reason(skb,
> > SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE);
> > +=09=09return 0;
> > +=09}
> > =C2=A0
> > =C2=A0=09BR_INPUT_SKB_CB(skb)->brdev =3D br->dev;
> > =C2=A0=09BR_INPUT_SKB_CB(skb)->src_port_isolated =3D !!(p->flags &
> > BR_ISOLATED);
> > @@ -331,8 +335,10 @@ static rx_handler_result_t
> > br_handle_frame(struct sk_buff **pskb)
> > =C2=A0=09if (unlikely(skb->pkt_type =3D=3D PACKET_LOOPBACK))
> > =C2=A0=09=09return RX_HANDLER_PASS;
> > =C2=A0
> > -=09if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
> > -=09=09goto drop;
> > +=09if (!is_valid_ether_addr(eth_hdr(skb)->h_source)) {
> > +=09=09kfree_skb_reason(skb,
> > SKB_DROP_REASON_MAC_INVALID_SOURCE);
> > +=09=09return RX_HANDLER_CONSUMED;
> > +=09}
> > =C2=A0
> > =C2=A0=09skb =3D skb_share_check(skb, GFP_ATOMIC);
> > =C2=A0=09if (!skb)
> > @@ -374,7 +380,8 @@ static rx_handler_result_t
> > br_handle_frame(struct sk_buff **pskb)
> > =C2=A0=09=09=09return RX_HANDLER_PASS;
> > =C2=A0
> > =C2=A0=09=09case 0x01:=09/* IEEE MAC (Pause) */
> > -=09=09=09goto drop;
> > +=09=09=09kfree_skb_reason(skb,
> > SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL);
> > +=09=09=09return RX_HANDLER_CONSUMED;
> > =C2=A0
> > =C2=A0=09=09case 0x0E:=09/* 802.1AB LLDP */
> > =C2=A0=09=09=09fwd_mask |=3D p->br->group_fwd_mask;
> > @@ -423,8 +430,7 @@ static rx_handler_result_t
> > br_handle_frame(struct sk_buff **pskb)
> > =C2=A0
> > =C2=A0=09=09return nf_hook_bridge_pre(skb, pskb);
> > =C2=A0=09default:
> > -drop:
> > -=09=09kfree_skb(skb);
> > +=09=09kfree_skb_reason(skb,
> > SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE);
> > =C2=A0=09}
> > =C2=A0=09return RX_HANDLER_CONSUMED;
> > =C2=A0}
> > --=20
> > 2.47.1
> >=20
>=20

