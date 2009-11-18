Message-ID: <4B03949D.4000908@gmail.com>
Date: Wed, 18 Nov 2009 07:30:53 +0100
From: Eric Dumazet <eric.dumazet@gmail.com>
MIME-Version: 1.0
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<1258497551-25959-2-git-send-email-arnd@arndb.de>
In-Reply-To: <1258497551-25959-2-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 1/3] macvlan: Reflect macvlan packets meant for
 other macvlan devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@linux-foundation.com, Herbert Xu <herbert@gondor.apana.org.au>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>

Arnd Bergmann a =E9crit :
> From: Eric Biederman <ebiederm@xmission.com>
>=20
> Switch ports do not send packets back out the same port they came
> in on.	This causes problems when using a macvlan device inside
> of a network namespace as it becomes impossible to talk to
> other macvlan devices.

This patch is very welcome. I review it and found one oddity.

>=20
> Signed-off-by: Eric Biederman <ebiederm@xmission.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> +static int macvlan_queue_xmit(struct sk_buff *skb, struct net_device *de=
v)
> +{
> +	const struct macvlan_dev *vlan =3D netdev_priv(dev);
> +	const struct macvlan_port *port =3D vlan->port;
> +	const struct macvlan_dev *dest;
> +	const struct ethhdr *eth;
> =20
> -	skb->dev =3D dev;
> -	skb->pkt_type =3D PACKET_HOST;
> +	skb->protocol =3D eth_type_trans(skb, dev);
> +	eth =3D eth_hdr(skb);
> =20
> -	netif_rx(skb);
> -	return NULL;
> +	skb_dst_drop(skb);

Why do you drop dst here ?

It seems strange, since this driver specifically masks out IFF_XMIT_DST_REL=
EASE
in its macvlan_setup() :

dev->priv_flags &=3D ~IFF_XMIT_DST_RELEASE;

If we really want to drop dst, it could be done by caller, if IFF_XMIT_DST_=
RELEASE
was not masked in macvlan_setup().


> +	skb->mark =3D 0;
> +	secpath_reset(skb);
> +	nf_reset(skb);
> +
> +	if (is_multicast_ether_addr(eth->h_dest)) {
> +		macvlan_broadcast(skb, port, dev);
> +		return macvlan_xmit_world(skb, dev);
> +	}
> +
> +	dest =3D macvlan_hash_lookup(port, eth->h_dest);
> +	if (dest)
> +		return macvlan_unicast(skb, dest);
> +
> +	return macvlan_xmit_world(skb, dev);
>  }


# find net drivers/net|xargs grep -n IFF_XMIT_DST_RELEASE
net/8021q/vlan_dev.c:837:       dev->priv_flags         &=3D ~IFF_XMIT_DST_=
RELEASE;
net/atm/clip.c:561:     dev->priv_flags &=3D ~IFF_XMIT_DST_RELEASE;
net/core/dev.c:1778:            if (dev->priv_flags & IFF_XMIT_DST_RELEASE)
net/core/dev.c:5287:    dev->priv_flags =3D IFF_XMIT_DST_RELEASE;
net/ipv4/ip_gre.c:1236: dev->priv_flags         &=3D ~IFF_XMIT_DST_RELEASE;
net/ipv4/ipip.c:717:    dev->priv_flags         &=3D ~IFF_XMIT_DST_RELEASE;
net/ipv6/sit.c:1104:    dev->priv_flags        &=3D ~IFF_XMIT_DST_RELEASE;
drivers/net/appletalk/ipddp.c:76:       dev->priv_flags &=3D ~IFF_XMIT_DST_=
RELEASE;
drivers/net/bonding/bond_main.c:4534:   bond_dev->priv_flags &=3D ~IFF_XMIT=
_DST_RELEASE;
drivers/net/eql.c:197:  dev->priv_flags        &=3D ~IFF_XMIT_DST_RELEASE;
drivers/net/ifb.c:162:  dev->priv_flags &=3D ~IFF_XMIT_DST_RELEASE;
drivers/net/loopback.c:174:     dev->priv_flags        &=3D ~IFF_XMIT_DST_R=
ELEASE;
drivers/net/macvlan.c:421:      dev->priv_flags        &=3D ~IFF_XMIT_DST_R=
ELEASE;
drivers/net/ppp_generic.c:1057: dev->priv_flags &=3D ~IFF_XMIT_DST_RELEASE;
drivers/net/wan/hdlc_fr.c:1057: dev->priv_flags &=3D ~IFF_XMIT_DST_RELEASE;
