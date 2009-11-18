Message-ID: <4B03974D.3010708@gmail.com>
Date: Wed, 18 Nov 2009 07:42:21 +0100
From: Eric Dumazet <eric.dumazet@gmail.com>
MIME-Version: 1.0
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<1258497551-25959-3-git-send-email-arnd@arndb.de>
In-Reply-To: <1258497551-25959-3-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 2/3] macvlan: implement VEPA and private mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, virtualization@lists.linux-foundation.com, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>

Arnd Bergmann a =E9crit :
> This allows each macvlan slave device to be in one
> of three modes, depending on the use case:
>=20
> MACVLAN_MODE_PRIVATE:
>   The device never communicates with any other device
>   on the same upper_dev. This even includes frames
>   coming back from a reflective relay, where supported
>   by the adjacent bridge.
>=20
> MACVLAN_MODE_VEPA:
>   The new Virtual Ethernet Port Aggregator (VEPA) mode,
>   we assume that the adjacent bridge returns all frames
>   where both source and destination are local to the
>   macvlan port, i.e. the bridge is set up as a reflective
>   relay.
>   Broadcast frames coming in from the upper_dev get
>   flooded to all macvlan interfaces in VEPA mode.
>   We never deliver any frames locally.
>=20
> MACVLAN_MODE_BRIDGE:
>   We provide the behavior of a simple bridge between
>   different macvlan interfaces on the same port. Frames
>   from one interface to another one get delivered directly
>   and are not sent out externally. Broadcast frames get
>   flooded to all other bridge ports and to the external
>   interface, but when they come back from a reflective
>   relay, we don't deliver them again.
>   Since we know all the MAC addresses, the macvlan bridge
>   mode does not require learning or STP like the bridge
>   module does.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---


>  	if (is_multicast_ether_addr(eth->h_dest)) {
> -		macvlan_broadcast(skb, port, NULL);
> +		src =3D macvlan_hash_lookup(port, eth->h_source);
> +		if (!src)
> +			/* frame comes from an external address */


> +			macvlan_broadcast(skb, port, NULL, MACVLAN_MODE_VEPA
> +				| MACVLAN_MODE_VEPA | MACVLAN_MODE_BRIDGE);

typo here, you probably meant MACVLAN_PRIVATE | MACVLAN_VEPA | MACVLAN_BRID=
GE=20

> +		else if (src->mode =3D=3D MACVLAN_MODE_VEPA)
> +			/* flood to everyone except source */
> +			macvlan_broadcast(skb, port, src->dev,
> +				MACVLAN_MODE_VEPA | MACVLAN_MODE_BRIDGE);
> +		else if (src->mode =3D=3D MACVLAN_MODE_BRIDGE)
> +			/* flood only to VEPA ports, bridge ports
> +			   already saw the frame */
> +			macvlan_broadcast(skb, port, src->dev,
> +				MACVLAN_MODE_VEPA);
>  		return skb;
>  	}
> =20

