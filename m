Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4E1175AB
	for <bridge@lists.linux.dev>; Fri, 13 Dec 2024 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122031; cv=none; b=dgEbJgIbS8OHUny0zqpNE2kY3jUGdzVoCZZx5O7dAaVq/RYOsd2ex2HgqgJTFdMSoqczPWLxzHjdJ+9inuToc+DEVWcn2enH3BmLsSMZC8MU3muSWRka/5EkguoswNtRze8QqNSC0TqtZ7hmzW2Roz/7PpLHY10i7qVgex04Iik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122031; c=relaxed/simple;
	bh=myrCv2j9O0q/qyxKQCHxIAJI/52gpIPUg37wl/XMjzA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJOze7PA7K/vI50oUn+Wh2aGcXEIUOEk4BH75nDAl/AFgQpj8G3tnzPc8OzdBMGQGV3j0HYtIwnO35l1Q/rH4Maj9a9BbML7cijOzM0vHER39pSBMY+6FnUbaFaDandXuGtjDAxLT/Y0M9Y+CsjPfLiKNLUoXwqdfP6/Nqdw96g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcGc/POn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcGc/POn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734122028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myrCv2j9O0q/qyxKQCHxIAJI/52gpIPUg37wl/XMjzA=;
	b=QcGc/POnqdATDjbJQ3thAXOCzIYKjh2IcmYKdEU3pxF5SF0Igm6KUpACrREi9hUpvAnRDC
	ZqmIJ+OFYzaGHkY+qxUkvFaEhakWijhR7/zSFBdIErCMM8bTKT6kyfpIWCC9mHe6chgPgD
	pRNFRH/EOt1b937sNz8jlM18VN+z7WU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-Z524DAkyOyi99jLQwpLixw-1; Fri, 13 Dec 2024 15:33:47 -0500
X-MC-Unique: Z524DAkyOyi99jLQwpLixw-1
X-Mimecast-MFC-AGG-ID: Z524DAkyOyi99jLQwpLixw
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8844560e9so44846926d6.3
        for <bridge@lists.linux.dev>; Fri, 13 Dec 2024 12:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734122027; x=1734726827;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aba5BsXsQ7FqAiNGIDyNoYncM/5KyydK70Yz1i+dzmA=;
        b=XQ1EcGuHcCpGhBxym9ukW+8MBbgK+4wUlvBm5BA/mj3NXginBb+GtejIgpW4sBoCV3
         ioyfvvp8VQjfqypB2ujAUq3YHsiaGFcprCkcca5EYvhOt/28aoEEW1/6vvuTJJE1IfYg
         YbQ+mgq1VWVVkqwS2hYBQS9ym7WeEcnc/E0DDAyN3Nl/PtT+VzesDdJP/7h1qVvo+bhR
         jFkYo2jjnaxuaz1cH/afNUpN3LANv9g4OlFb6/7RQ/jYO3goOMaRPHCdi3vNeyN9pBDS
         +pTM682urlPoEczrto3vaYcyRIEqmZA3aqUCTLrqYgzmAdfWr7Py2SEavX1Xv8kNsNfP
         5xLA==
X-Gm-Message-State: AOJu0Yw7IVOwum4XaLnZYx7ZcYgZqg2vg/DCP+4O1gioNZuZ9AaXHJ5i
	dfs203Fa1L9aju+VKVyGe1BIDjS3Hapxwsjy8csUH5Bd6AUPBCtggPsokfQsDU+ZM6ItAhV0e14
	MZF3Fq08M6W3ZtNnJG6yqCs7irFflJSv2vnHUOfzvjB90F9fX31aOQ01vViGdHvoW
X-Gm-Gg: ASbGncuQ2GMXQaoOhKWiKUzBktRX6qHv17aBnIHlQoKLRB7tnaUaRI/LiRPGVUqjeOk
	9U/ONsfTRjzmIlwmoid0DkgBMfIHFnJRhveFjH/XUjNpYnMMr1p+4zQVYjZeGivSISu3KJyaeBE
	jWZr8kFQQA9TAz0blemv25LgnQt+m+J29ruAPF9iHzi3rugdFWQ451oP7hsgLBYg1lBkekz9CPM
	s+PkTPQvU+7Q1fOf5KD9YauqUoXMeXb8Y2viQg5BmvY+6c3sa3CD+nDAfPmAGwCa+anFFhv1wIG
	ilop/PEkeA6r9FbBukVJcpjm6UZSOhlK9i6hNTobOOI+VW0W
X-Received: by 2002:a05:6214:2388:b0:6d8:8f14:2f5d with SMTP id 6a1803df08f44-6dc8ca84f7fmr77246076d6.28.1734122026834;
        Fri, 13 Dec 2024 12:33:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI59cbLihxqo6dRtJ9/I263Qa7r2Dauau6XnHrvUGdnT2sw703rf6gpaHmUVH/f2YnaGfNEQ==
X-Received: by 2002:a05:6214:2388:b0:6d8:8f14:2f5d with SMTP id 6a1803df08f44-6dc8ca84f7fmr77245636d6.28.1734122026416;
        Fri, 13 Dec 2024 12:33:46 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd363142sm845396d6.81.2024.12.13.12.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 12:33:45 -0800 (PST)
Message-ID: <c8ab80bb8e3735d301104f29d7f04275ad054214.camel@redhat.com>
Subject: Re: [PATCH net-next] net/bridge: Add skb drop reasons to the most
 common drop points
From: Radu Rendec <rrendec@redhat.com>
To: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu
 <roopa@nvidia.com>,  Ido Schimmel <idosch@idosch.org>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, Simon Horman
	 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
	 <davem@davemloft.net>
Date: Fri, 13 Dec 2024 15:33:44 -0500
In-Reply-To: <2283799b-e1fe-42c2-aecc-50c4ae1f9afa@blackwall.org>
References: <20241208221805.1543107-1-rrendec@redhat.com>
	 <2283799b-e1fe-42c2-aecc-50c4ae1f9afa@blackwall.org>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0WCmNzdzYejT68FIIqVzBRJ7sZRy3PVEx2pgPo4KiaY_1734122027
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-12-10 at 11:18 +0200, Nikolay Aleksandrov wrote:
> On 12/9/24 00:18, Radu Rendec wrote:
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
>=20
> Hi,
> Thanks for working on this, a few comments below.

Sure, thanks for reviewing! Please see my comments below.

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
> > +=09SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL,
> > +=09/**
> > +=09 * @SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD: the STP state of the
> > +=09 * ingress bridge port does not allow frames to be forwarded.
> > +=09 */
> > +=09SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD,
>=20
> Since this is used only when the port state causes the packet to drop, wh=
y not
> rename it to something that suggests it was the state?

Yes, Ido had a similar suggestion [1], so it's clear that it must be
renamed. I will go with SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE in the
next version, unless you have a better idea.

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
>=20
> This is not entirely correct, we can get here if we had an error forwardi=
ng
> the packet to some port, but it may already have been forwarded to others=
.
> The reason should distinguish between those two cases.

I will follow Ido's suggestion [2] and rename SKB_DROP_REASON_VXLAN_NO_REMO=
TE
to SKB_DROP_REASON_NO_TX_TARGET, and then use that.

But it will only cover the case when there are no errors, so I still
need a different reason for the error case. I looked, and I couldn't
find an existing one that's close enough, so I think I should create a
new one. How about SKB_DROP_REASON_TX_ERROR? I would not use "BRIDGE"
in the name because I'm thinking it may be reused elsewhere, outside
the bridge module.

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
>=20
> Same comment as above (br_flood).
>=20
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
> > +=09}>=C2=A0=20
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

[1] https://lore.kernel.org/bridge/Z1sLyqZQCjbcCOde@shredder/
[2] https://lore.kernel.org/bridge/Z1sUsSFfBC9GoiIA@shredder/

--
Best regards,
Radu

