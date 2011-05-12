From: Ben Hutchings <bhutchings@solarflare.com>
In-Reply-To: <20110512160640.2A0B713A6B@rere.qmqm.pl>
References: <20110507114803.0D80A13A6B@rere.qmqm.pl>
	<20110512160640.2A0B713A6B@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 May 2011 17:29:07 +0100
Message-ID: <1305217747.5214.17.camel@bwh-desktop>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [RFC PATCH v2] net: fold dev_disable_lro() into
 netdev_fix_features()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: "Pekka Savola (ipv6)" <pekkas@netcore.fi>, Eric Dumazet <eric.dumazet@gmail.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S. Miller" <davem@davemloft.net>, Tom Herbert <therbert@google.com>

On Thu, 2011-05-12 at 18:06 +0200, Micha=C5=82 Miros=C5=82aw wrote:
> This implements checks for forwarding mode in netdev_fix_features() using
> dev->priv_flags bits. As a side effect, after device is no longer
> forwarding it gets LRO back. This also means that user is not allowed to
> enable LRO after device is put to forwarding mode.
>=20
> This patch depends on removal of discrete offload setting ethtool ops.

This is nice, but:

[...]
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -158,6 +158,8 @@ static void del_nbp(struct net_bridge_port *p)
>  	br_netpoll_disable(p);
> =20
>  	call_rcu(&p->rcu, destroy_nbp_rcu);
> +
> +	netdev_update_features(dev);
>  }
> =20
>  /* called with RTNL */
> @@ -368,11 +370,9 @@ int br_add_if(struct net_bridge *br, struct net_devi=
ce *dev)
> =20
>  	dev->priv_flags |=3D IFF_BRIDGE_PORT;
> =20
> -	dev_disable_lro(dev);
> -
>  	list_add_rcu(&p->list, &br->port_list);
> =20
> -	netdev_update_features(br->dev);
> +	netdev_change_features(dev);
> =20
>  	spin_lock_bh(&br->lock);
>  	changed_addr =3D br_stp_recalculate_bridge_id(br);

Why netdev_change_features() here?  I thought that was primarily for use
when vlan_features may have been changed.

[...]
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
[...]
> @@ -5241,6 +5221,11 @@ u32 netdev_fix_features(struct net_device *dev, u3=
2 features)
>  		}
>  	}
> =20
> +	if (features & NETIF_F_LRO && dev->priv_flags & IFF_LRO_FORBIDDEN) {
> +		netdev_info(dev, "Disabling LRO for forwarding interface.\n");
> +		features &=3D NETIF_F_LRO;
[...]

Mising '~'.

Ben.

--=20
Ben Hutchings, Senior Software Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

