Return-Path: <pneira@us.es>
Date: Tue, 25 Apr 2017 11:10:22 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20170425091022.GB2930@salvia>
References: <20170419194733.19006-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170419194733.19006-1-linus.luessing@c0d3.blue>
Subject: Re: [Bridge] [PATCH net v3] bridge: ebtables: fix reception of
 frames DNAT-ed to bridge device/port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S . Miller" <davem@davemloft.net>

On Wed, Apr 19, 2017 at 09:47:33PM +0200, Linus L=FCssing wrote:
> When trying to redirect bridged frames to the bridge device itself or
> a bridge port (brouting) via the dnat target then this currently fails:
>=20
> The ethernet destination of the frame is dnat'ed to the MAC address of
> the bridge device or port just fine. However, the IP code drops it in
> the beginning of ip_input.c/ip_rcv() as the dnat target left
> the skb->pkt_type as PACKET_OTHERHOST.
>=20
> Fixing this by resetting skb->pkt_type to an appropriate type after
> dnat'ing.

Applied, thanks.

One comment below.
> @@ -18,11 +19,32 @@ static unsigned int
>  ebt_dnat_tg(struct sk_buff *skb, const struct xt_action_param *par)
>  {
>  	const struct ebt_nat_info *info =3D par->targinfo;
> +	struct net_device *dev;
> =20
>  	if (!skb_make_writable(skb, 0))
>  		return EBT_DROP;
> =20
>  	ether_addr_copy(eth_hdr(skb)->h_dest, info->mac);
> +
> +	if (is_multicast_ether_addr(info->mac)) {
> +		if (is_broadcast_ether_addr(info->mac))
> +			skb->pkt_type =3D PACKET_BROADCAST;
> +		else
> +			skb->pkt_type =3D PACKET_MULTICAST;
> +	} else {
> +		rcu_read_lock();

I'm going to manually remove this explicit rcu_read_lock() here, no
need to resend. We're guaranteed to run from packet path with read
side lock from netfilter hooks. So we just save some cycles from
running this unnecessary nesting.

Let me know if I'm missing anything. Thanks!
