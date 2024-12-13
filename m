Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96541922DC
	for <bridge@lists.linux.dev>; Fri, 13 Dec 2024 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122698; cv=none; b=KGApaR47VrK3wjJ3/YLrbSxHl+PcxQ4Neh2cad37sXJc52ZDyq0UABTnZ+mtsiudZ0IioqIAvuu1shbbdIAcVHzSKLz52vfPRwF9rfTtf9JzhFGr/niM/cpNZDg9lfepo6NWI46IReppINuMZFUwSKg/pnKRe/wqGryYKHqg84U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122698; c=relaxed/simple;
	bh=X/3P83wnRDNLzeKB7ymIk3Q6qM2FT9qEWx8/WNlQlW4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKOPDqAFO9SNg7qVYGglIFoI18Cv4jr2/VFN1XFHraQ6A/p850F8iP+1M84LnI2gUtHgQ1mdnShxRsUJaxQ3F84mqyaqC+FsslST1dan28kV3BUVQVzJ/Be145xh5O1V59aFXEgDAcyxD575wdCfj/FGQB4y80ghQf/VZvjGKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYQelDJP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYQelDJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734122693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/3P83wnRDNLzeKB7ymIk3Q6qM2FT9qEWx8/WNlQlW4=;
	b=VYQelDJPwwJLscS7wfLQ8spjXaMiKT+8Wnw1CigIPbdyw8wPmIy0VPpqxfgEvbSUz0KRIH
	zx0u+P1ioCup140nY9DGoDD1by3QBh95We+hu7rQNk43huaFgXLOkn84qPZMLxMThhGUP3
	hqqz59B3NOk1MF9ifQVVUwYF0dMxEZk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-8xVAgWT1M3O85UJyk7If_Q-1; Fri, 13 Dec 2024 15:44:52 -0500
X-MC-Unique: 8xVAgWT1M3O85UJyk7If_Q-1
X-Mimecast-MFC-AGG-ID: 8xVAgWT1M3O85UJyk7If_Q
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e23e2b8fso192911985a.2
        for <bridge@lists.linux.dev>; Fri, 13 Dec 2024 12:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734122691; x=1734727491;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTF1gVQdFWBwy6Q3LPxWOLONRVmdA/eRNrvwR4+gyAY=;
        b=kBHbc2NO9SD2BN+DhxXQRAGYXqbsksHM3Bk66ROMzrR+h98UgovsFEmhSkGkwMmCDz
         jtG+X/L1GKul5xXERjIghWbLi1NPOyexgwIV9uGbdzC3cH3t1DHZtq7UQU++W2TuGzvs
         vqcIas4gK15oExcT/9XUdotefZ2eAU3pUnF1oje/fiHiQ407Xt48neupi1PHPPi43O7q
         ga09Wzpr2mMQemq0lc7WnBxPJbqr0UCeRLq75j3xAxc+K4ARSFWEDhmCcl2RCme0RAzb
         f0GsQA13TR+yqpgcj5VhhOZ4rikIetnVmQIxPPLilqm9Smx9hHZSIkJtr8X/yZRCVqsB
         IKLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMBgpPQ5QeOyet4fkoa9grFCg3BrXn6D0hzqfYY9sc7Q/9oq2MWmyBVSWxTvxuTPFsIRVVQt4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1IyVFoI1ZARp0K9ZmGV2u3PfZcGo0Mkx3FI171z0pMD6fNdvB
	lo1pS63foYOAXrNyDpT2pYo+XmTrl0IFk4r8NQR7iysz1col/ncheB3VeQzme17ADMYhEvd1IQt
	oFcA/367AjAaQp0LddJV9FAUTAhLetfIU+8oBonDLbaMDCfXbE5wkzA==
X-Gm-Gg: ASbGnct/4Cye0q4dO29YGWK2dE0v62QypeRE9lUH+q/A5XTKzGbEGfxmZo8hrrtSNjv
	dGcyzoqe2ShdhMKVGlPHl2mAdOaG+/U1Ez4hqkA92thGmJs3OzH18dgopiGMuWGfw5nqZGd0wUy
	KTWNdlq19cMjxADWWmEd1UxlZLzIYXUQ2r+rF/9uPobkmqqnQXSK5fcnrmQxFRv7PBk3dZvFR/2
	tpaqxM2fyeEGLrbh7ziIvHkudtB8KrnnQLmGz6p3ikG1DTKziYpxy9lWf54EQkNHynNpufEgd9L
	9DlH0jIB6XQvKdmCx1qB2j3r8Z+LIxOfOA3QhiEJOSijkYlq
X-Received: by 2002:a05:620a:4882:b0:7b6:d5b2:e6d with SMTP id af79cd13be357-7b6fbf17b58mr595602985a.35.1734122691514;
        Fri, 13 Dec 2024 12:44:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0uolEOXymN5WV0ZUnXHMN+TRmyOizKeSVecI47gbXLuJww4t78opCPP3mIhmQWs+Ptl3PyQ==
X-Received: by 2002:a05:620a:4882:b0:7b6:d5b2:e6d with SMTP id af79cd13be357-7b6fbf17b58mr595599385a.35.1734122691162;
        Fri, 13 Dec 2024 12:44:51 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e81810sm1337551cf.55.2024.12.13.12.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 12:44:50 -0800 (PST)
Message-ID: <84e3d3e998f1a02dd742727c2e18b7c364c36389.camel@redhat.com>
Subject: Re: [PATCH net-next] net/bridge: Add skb drop reasons to the most
 common drop points
From: Radu Rendec <rrendec@redhat.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu
 <roopa@nvidia.com>,  bridge@lists.linux.dev, netdev@vger.kernel.org, Simon
 Horman <horms@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,  "David S. Miller"
 <davem@davemloft.net>
Date: Fri, 13 Dec 2024 15:44:49 -0500
In-Reply-To: <Z1sLyqZQCjbcCOde@shredder>
References: <20241208221805.1543107-1-rrendec@redhat.com>
	 <Z1sLyqZQCjbcCOde@shredder>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zsR92_DBgySn3kA0m2vP3c0oRhp5iDQs8ql_rG8WMls_1734122691
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-12-12 at 18:14 +0200, Ido Schimmel wrote:
> On Sun, Dec 08, 2024 at 05:18:05PM -0500, Radu Rendec wrote:
> > The bridge input code may drop frames for various reasons and at variou=
s
> > points in the ingress handling logic. Currently kfree_skb() is used
> > everywhere, and therefore no drop reason is specified. Add drop reasons
> > to the most common drop points.
> >=20
> > The purpose of this patch is to address the most common drop points on
> > the bridge ingress path. It does not exhaustively add drop reasons to
> > the entire bridge code. The intention here is to incrementally add drop
> > reasons to the rest of the bridge code in follow up patches.
> >=20
> > Most of the skb drop points that are addressed in this patch can be
> > easily tested by sending crafted packets. The diagram below shows a
> > simple test configuration, and some examples using `packit`(*) are
> > also included. The bridge is set up with STP disabled.
> > (*) https://github.com/resurrecting-open-source-projects/packit
> >=20
> > The following changes were *not* tested:
> > * SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT in br_multicast_flood(). I coul=
d
> > =C2=A0 not find an easy way to make a crafted packet get there.
> > * SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD in br_handle_frame_finish()
> > =C2=A0 when the port state is BR_STATE_DISABLED, because in that case t=
he
> > =C2=A0 frame is already dropped in the switch/case block at the end of
> > =C2=A0 br_handle_frame().
> >=20
> > =C2=A0=C2=A0=C2=A0 +---+---+
> > =C2=A0=C2=A0=C2=A0 |=C2=A0 br0=C2=A0 |
> > =C2=A0=C2=A0=C2=A0 +---+---+
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0=C2=A0=C2=A0 +---+---+=C2=A0 veth pair=C2=A0 +-------+
> > =C2=A0=C2=A0=C2=A0 | veth0 +-------------+ xeth0 |
> > =C2=A0=C2=A0=C2=A0 +-------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------+
> >=20
> > SKB_DROP_REASON_MAC_INVALID_SOURCE - br_handle_frame()
> > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > =C2=A0 -e 01:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
> > =C2=A0 -p '0x de ad be ef' -i xeth0
> >=20
> > SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL - br_handle_frame()
> > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > =C2=A0 -e 02:22:33:44:55:66 -E 01:80:c2:00:00:01 -c 1 \
> > =C2=A0 -p '0x de ad be ef' -i xeth0
> >=20
> > SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD - br_handle_frame()
> > bridge link set dev veth0 state 0 # disabled
> > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > =C2=A0 -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
> > =C2=A0 -p '0x de ad be ef' -i xeth0
> >=20
> > SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD - br_handle_frame_finish()
> > bridge link set dev veth0 state 2 # learning
> > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > =C2=A0 -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
> > =C2=A0 -p '0x de ad be ef' -i xeth0
> >=20
> > SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT - br_flood()
> > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > =C2=A0 -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
> > =C2=A0 -p '0x de ad be ef' -i xeth0
> >=20
> > Signed-off-by: Radu Rendec <rrendec@redhat.com>
> > ---
> > =C2=A0include/net/dropreason-core.h | 18 ++++++++++++++++++
> > =C2=A0net/bridge/br_forward.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 ++--
> > =C2=A0net/bridge/br_input.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 24 +++++++++++++++---------
> > =C2=A03 files changed, 35 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
> > index c29282fabae6..1f2ae5b387c1 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -108,6 +108,9 @@
> > =C2=A0=09FN(TUNNEL_TXINFO)=09=09\
> > =C2=A0=09FN(LOCAL_MAC)=09=09=09\
> > =C2=A0=09FN(ARP_PVLAN_DISABLE)=09=09\
> > +=09FN(MAC_IEEE_MAC_CONTROL)=09\
> > +=09FN(BRIDGE_INGRESS_PORT_NFWD)=09\
> > +=09FN(BRIDGE_NO_EGRESS_PORT)=09\
> > =C2=A0=09FNe(MAX)
> > =C2=A0
> > =C2=A0/**
> > @@ -502,6 +505,21 @@ enum skb_drop_reason {
> > =C2=A0=09 * enabled.
> > =C2=A0=09 */
> > =C2=A0=09SKB_DROP_REASON_ARP_PVLAN_DISABLE,
> > +=09/**
> > +=09 * @SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL: the destination MAC addre=
ss
> > +=09 * is an IEEE MAC Control address.
> > +=09 */
>=20
> IMO, dropping pause frames is not among "the most common drop points".
> Are you planning on reusing this reason in other modules? If not, then I
> prefer removing it. My understanding is that we should not try to
> document every obscure drop with these reasons.

Fair enough. I don't have an immediate plan to reuse this reason, and
to be honest, I'm not that familiar with the networking stack to be
able to tell off hand if it's likely to be useful elsewhere.

Would you prefer to stick to not specifying a drop reason at all at
that particular drop point, or to reuse an existing reason? Two
existing reasons that could be used (although they are not entirely
accurate) are:
SKB_DROP_REASON_UNHANDLED_PROTO
SKB_DROP_REASON_MAC_INVALID_SOURCE

> > +=09SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL,
> > +=09/**
> > +=09 * @SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD: the STP state of the
> > +=09 * ingress bridge port does not allow frames to be forwarded.
> > +=09 */
> > +=09SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD,
>=20
> Are you intending on reusing this for other ingress drops (e.g., VLAN,
> locked port) or is this specific to ingress STP filtering? I think it
> will be useful to distinguish between the different cases, so I suggest
> renaming this reason to make it clear it is about ingress STP.

No, it's specific to ingress STP filtering. I will rename it to
SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE as I said in the other thread.

> > +=09/**
> > +=09 * SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT: no eligible egress port w=
as
> > +=09 * found while attempting to flood the frame.
> > +=09 */
> > +=09SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT,
> > =C2=A0=09/**
> > =C2=A0=09 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, whi=
ch
> > =C2=A0=09 * shouldn't be used as a real 'reason' - only for tracing cod=
e gen
> > diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> > index e19b583ff2c6..e33e2f4fc3d9 100644
> > --- a/net/bridge/br_forward.c
> > +++ b/net/bridge/br_forward.c
> > @@ -249,7 +249,7 @@ void br_flood(struct net_bridge *br, struct sk_buff=
 *skb,
> > =C2=A0
> > =C2=A0out:
> > =C2=A0=09if (!local_rcv)
> > -=09=09kfree_skb(skb);
> > +=09=09kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT);
> > =C2=A0}
> > =C2=A0
> > =C2=A0#ifdef CONFIG_BRIDGE_IGMP_SNOOPING
> > @@ -349,6 +349,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry=
 *mdst,
> > =C2=A0
> > =C2=A0out:
> > =C2=A0=09if (!local_rcv)
> > -=09=09kfree_skb(skb);
> > +=09=09kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT);
> > =C2=A0}
> > =C2=A0#endif
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index ceaa5a89b947..fc00e172e1e1 100644
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
> > +=09=09=09kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFW=
D);
> > +=09=09=09return 0;
> > +=09=09}
> > =C2=A0
> > =C2=A0=09=09state =3D p->state;
> > =C2=A0=09}
> > @@ -155,8 +157,10 @@ int br_handle_frame_finish(struct net *net, struct=
 sock *sk, struct sk_buff *skb
> > =C2=A0=09=09}
> > =C2=A0=09}
> > =C2=A0
> > -=09if (state =3D=3D BR_STATE_LEARNING)
> > -=09=09goto drop;
> > +=09if (state =3D=3D BR_STATE_LEARNING) {
> > +=09=09kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> > +=09=09return 0;
> > +=09}
> > =C2=A0
> > =C2=A0=09BR_INPUT_SKB_CB(skb)->brdev =3D br->dev;
> > =C2=A0=09BR_INPUT_SKB_CB(skb)->src_port_isolated =3D !!(p->flags & BR_I=
SOLATED);
> > @@ -331,8 +335,10 @@ static rx_handler_result_t br_handle_frame(struct =
sk_buff **pskb)
> > =C2=A0=09if (unlikely(skb->pkt_type =3D=3D PACKET_LOOPBACK))
> > =C2=A0=09=09return RX_HANDLER_PASS;
> > =C2=A0
> > -=09if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
> > -=09=09goto drop;
> > +=09if (!is_valid_ether_addr(eth_hdr(skb)->h_source)) {
> > +=09=09kfree_skb_reason(skb, SKB_DROP_REASON_MAC_INVALID_SOURCE);
> > +=09=09return RX_HANDLER_CONSUMED;
> > +=09}
> > =C2=A0
> > =C2=A0=09skb =3D skb_share_check(skb, GFP_ATOMIC);
> > =C2=A0=09if (!skb)
> > @@ -374,7 +380,8 @@ static rx_handler_result_t br_handle_frame(struct s=
k_buff **pskb)
> > =C2=A0=09=09=09return RX_HANDLER_PASS;
> > =C2=A0
> > =C2=A0=09=09case 0x01:=09/* IEEE MAC (Pause) */
> > -=09=09=09goto drop;
> > +=09=09=09kfree_skb_reason(skb, SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL);
> > +=09=09=09return RX_HANDLER_CONSUMED;
> > =C2=A0
> > =C2=A0=09=09case 0x0E:=09/* 802.1AB LLDP */
> > =C2=A0=09=09=09fwd_mask |=3D p->br->group_fwd_mask;
> > @@ -423,8 +430,7 @@ static rx_handler_result_t br_handle_frame(struct s=
k_buff **pskb)
> > =C2=A0
> > =C2=A0=09=09return nf_hook_bridge_pre(skb, pskb);
> > =C2=A0=09default:
> > -drop:
> > -=09=09kfree_skb(skb);
> > +=09=09kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> > =C2=A0=09}
> > =C2=A0=09return RX_HANDLER_CONSUMED;
> > =C2=A0}
> > --=20
> > 2.47.1
>=20

Thanks for reviewing!

--=20
Best regards,
Radu

