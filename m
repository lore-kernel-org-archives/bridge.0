Return-Path: <fw@strlen.de>
Date: Wed, 15 Mar 2017 11:26:08 +0100
From: Florian Westphal <fw@strlen.de>
Message-ID: <20170315102608.GB24366@breakpoint.cc>
References: <20170315031811.22714-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170315031811.22714-1-linus.luessing@c0d3.blue>
Subject: Re: [Bridge] [PATCH net] bridge: ebtables: fix reception of frames
 DNAT-ed to bridge device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?iso-8859-15?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S . Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

Linus L=FCssing <linus.luessing@c0d3.blue> wrote:
> When trying to redirect bridged frames to the bridge device itself
> via the ebtables nat-prerouting chain and the dnat target then this
> currently fails:
>=20
> The ethernet destination of the frame is dnat'ed to the MAC address of
> the bridge itself just fine and the correctly altered frame can even
> be captured via a tcpdump on br0 (with or without promisc mode).
>
> However, the IP code drops it in the beginning of ip_input.c/ip_rcv()
> as the dnat target did not update the skb->pkt_type.

Right, thats the reason why ebtables also has ebt_redirect target
which does this pkt_type fixup.

> -		if (dst->is_local)
> +		if (dst->is_local) {
> +			/* fix up potential DNAT mess */
> +			skb->pkt_type =3D PACKET_HOST;
> +
>  			return br_pass_frame_up(skb);
> +		}

I don't mind this change though (i.e. I don't see how this would
bite us later).
