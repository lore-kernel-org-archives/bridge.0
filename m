Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=x7fr4J1FlDaFp7dzAz0WEJ1G0DzjrSKB+69zfgXRM50=;
	b=IMI03J9VQnEWd3fl0ZrTCTbvzVcS5vV+EzukpenUh9DqRy4xv6HoMN+vLPTZahNrlI
	ZV1QzmpPX/n4zKJMDvdzz/wut16gBqiRd/VYEvcJ72Z+EXOEHwhJk41cjQvwnGnFFKhb
	c/HIzilGvN1tKmCEGAEmguNs7XXV9Gd6x79bE=
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
In-Reply-To: <CAM_iQpXXoprcz48c-AYgOridkQWSv+5+7v4V5pT1rUu4_FoXMQ@mail.gmail.com>
Date: Fri, 15 Jul 2016 10:37:54 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE62FD91-E4D1-44B6-A4D7-66E86C09A5FA@cumulusnetworks.com>
References: <1468465802-4571-1-git-send-email-nikolay@cumulusnetworks.com>
	<1468465802-4571-3-git-send-email-nikolay@cumulusnetworks.com>
	<CAM_iQpXXoprcz48c-AYgOridkQWSv+5+7v4V5pT1rUu4_FoXMQ@mail.gmail.com>
Subject: Re: [Bridge] [PATCH net-next 2/4] net: bridge: rearrange flood vs
	unicast receive paths
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>


> On Jul 15, 2016, at 10:35 AM, Cong Wang <xiyou.wangcong@gmail.com> =
wrote:
>=20
> On Wed, Jul 13, 2016 at 8:10 PM, Nikolay Aleksandrov
> <nikolay@cumulusnetworks.com> wrote:
>> This patch removes one conditional from the unicast path by using the =
fact
>> that skb is NULL only when the packet is multicast or is local.
>>=20
>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>> ---
>> net/bridge/br_input.c | 29 ++++++++++++++---------------
>> 1 file changed, 14 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>> index 0b6d32619468..c20c5be6fc22 100644
>> --- a/net/bridge/br_input.c
>> +++ b/net/bridge/br_input.c
>> @@ -134,10 +134,10 @@ int br_handle_frame_finish(struct net *net, =
struct sock *sk, struct sk_buff *skb
>>        struct net_bridge_port *p =3D br_port_get_rcu(skb->dev);
>>        const unsigned char *dest =3D eth_hdr(skb)->h_dest;
>>        struct net_bridge_fdb_entry *dst =3D NULL;
>> +       bool mcast_hit =3D false, unicast =3D true;
>>        struct net_bridge_mdb_entry *mdst;
>>        struct net_bridge *br;
>>        struct sk_buff *skb2;
>> -       bool unicast =3D true;
>>        u16 vid =3D 0;
>>=20
>>        if (!p || p->state =3D=3D BR_STATE_DISABLED)
>> @@ -177,30 +177,29 @@ int br_handle_frame_finish(struct net *net, =
struct sock *sk, struct sk_buff *skb
>>                if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
>>                    br_multicast_querier_exists(br, eth_hdr(skb))) {
>>                        if ((mdst && mdst->mglist) ||
>> -                           br_multicast_is_router(br))
>> +                           br_multicast_is_router(br)) {
>>                                skb2 =3D skb;
>> -                       br_multicast_forward(mdst, skb, skb2);
>> -                       skb =3D NULL;
>> -                       if (!skb2)
>> -                               goto out;
>> +                               br->dev->stats.multicast++;
>> +                       }
>> +                       mcast_hit =3D true;
>>                } else {
>>                        skb2 =3D skb;
>> +                       br->dev->stats.multicast++;
>>                }
>>                unicast =3D false;
>> -               br->dev->stats.multicast++;
>=20
>=20
> Looks like you change the unconditional increment of this counter,
> is this intended?

Oops +CC all, mixed the reply list.

Yes, this counter must increment only when the packet is going to be =
locally received as you can see before
there was an unconditional jump if the packet was not going to be =
locally received (if !skb2, goto).
This is exactly one of the confusing cases trying to avoid with these =
skb0/skb2 variables..

Cheers,
Nik

