Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=7odoPB98+DVtew9sr+XnnP6ZwpW1+cT3lA+x2ZZ0soQ=;
	b=U7obszufhfvtaUmMY6ZJyvh4j9gaUn0HCgy9C7bH9HFUnE/0Gk6tM+LMSsw2MCamr8
	yLBbHdpQHfiwcqhR3iblwYjIgtVSmSjXTyB+cepGAhg0nMQbOZyTR1yMsddtM9WxT28U
	uLSC0QQzc5wJEK3KojDDg0b3/DUhX0RX1e37JUTVQ/qHh4Io/v2nK7QnVnAWaRstZj1N
	Vy8hWkCSdd+hDEJ34Xvl2wVuxtcjxE2zMVoTRzefXBN9aGi/tHLA0gZXPy+Jvm06JkDD
	tM22C4fi30DFZd0VQDskwqs+PmpHzUDlFf9lLyULQpPFCkk+jMZw1FsCr4p+7iKowUW6
	JpTQ==
Date: Mon, 12 Mar 2018 16:01:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180312160103.1a043936@xeon-e3>
In-Reply-To: <a7a21b04-025f-19e1-ec09-69cc355b9215@gmail.com>
References: <CACna6rz9L09g9oeHhvt209Tg1E3gKgmhGnYF653AdkXfZf=4kw@mail.gmail.com>
	<a7a21b04-025f-19e1-ec09-69cc355b9215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Problem with bridge (mcast-to-ucast + hairpin) and
 Broadcom's 802.11f in their FullMAC fw
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, BROADCOM

On Mon, 12 Mar 2018 23:42:48 +0100
Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> wrote:

> 2) Blame bridge + mcast-to-ucast + hairpin for 802.11f incompatibility
>=20
> If we agree that 802.11f support in FullMAC firmware is acceptable, then
> we have to make sure Linux's bridge doesn't break it by passing 802.11f
> (broadcast) frames back to the source interface. That would require a
> check like in below diff + proper code for handling such packets. I'm
> afraid I'm not familiar with bridge code enough to complete that.
>=20
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index edae702..9e5d6ea 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -126,6 +126,27 @@ static void br_do_proxy_arp(struct sk_buff *skb, str=
uct net_bridge *br,
>   	}
>   }
>=20
> +static bool br_skb_is_iapp_add_packet(struct sk_buff *skb)
> +{
> +	const u8 iapp_add_packet[6] __aligned(2) =3D {
> +		0x00, 0x01, 0xaf, 0x81, 0x01, 0x00,
> +	};
> +#if !defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> +	const u16 *a =3D (const u16 *)skb->data;
> +	const u16 *b =3D (const u16 *)iapp_add_packet;
> +#endif
> +
> +	if (skb->len !=3D 6)
> +		return false;
> +
> +#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> +	return !(((*(const u32 *)skb->data) ^ (*(const u32 *)iapp_add_packet)) |
> +	         ((*(const u16 *)(skb->data + 4)) ^ (*(const u16 *)(iapp_add_pa=
cket + 4))));
> +#else
> +	return !((a[0] ^ b[0]) | (a[1] ^ b[1]) | (a[2] ^ b[2]));
> +#endif
> +}
> +
>   /* note: already called with rcu_read_lock */
>   int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_=
buff *skb)
>   {
> @@ -155,6 +176,8 @@ int br_handle_frame_finish(struct net *net, struct so=
ck *sk, struct sk_buff *skb
>   	if (is_multicast_ether_addr(dest)) {
>   		/* by definition the broadcast is also a multicast address */
>   		if (is_broadcast_ether_addr(dest)) {
> +			if (br_skb_is_iapp_add_packet(skb))
> +				pr_warn("This packet should not be passed back to the source interfa=
ce!\n");
>   			pkt_type =3D BR_PKT_BROADCAST;
>   			local_rcv =3D true;
>   		} else {


Don't like bridge doing special case code for magic received values directl=
y in input path.
Really needs to be generic which is why I suggested ebtables.
