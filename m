Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Wx4BRCoQbKMbn1t9YHRuEytsxONyc7BqQmViBsLuiho=;
	b=Gdj4Hs6Io8qDf4fGJVpzIYR2byvZGz1Ch6PkLNJwi0e/VoLqr7mAc29uZbjzBcNV7AmoJxgjCEYm9ZvQZVrxzLaGciKEH10FyhW+UNz7+igjWvIetI6G2DrtaN4BCUu2oa1FkVXvnlFl5mVKVwaEEhPy/0npXZpP4q8SVIpmfZg=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sat, 23 Feb 2019 10:32:11 +0000
Message-ID: <20190223103207.GA13070@splinter>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
	<20190222235927.10295-8-f.fainelli@gmail.com>
In-Reply-To: <20190222235927.10295-8-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88304ED7E217AD4B8CDCB26BFD99FEC1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 7/8] net: switchdev: Replace port attr
 set SDO with a notification
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "moderated
	list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "David S. Miller" <davem@davemloft.net>

On Fri, Feb 22, 2019 at 03:59:25PM -0800, Florian Fainelli wrote:
> Drop switchdev_ops.switchdev_port_attr_set. Drop the uses of this field
> from all clients, which were migrated to use switchdev notification in
> the previous patches.
>=20
> Add a new function switchdev_port_attr_notify() that sends the switchdev
> notifications SWITCHDEV_PORT_ATTR_SET and takes care, depending on
> SWITCHDEV_F_DEFER to call the blocking (process) or non-blocking
> (atomic) notifier chain accordingly.
>=20
> Drop __switchdev_port_attr_set() and update switchdev_port_attr_set()
> likewise.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  net/switchdev/switchdev.c | 96 +++++++++++----------------------------
>  1 file changed, 26 insertions(+), 70 deletions(-)
>=20
> diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
> index 94400f5b8e07..a1f16836ef89 100644
> --- a/net/switchdev/switchdev.c
> +++ b/net/switchdev/switchdev.c
> @@ -174,81 +174,35 @@ static int switchdev_deferred_enqueue(struct net_de=
vice *dev,
>  	return 0;
>  }
> =20
> -/**
> - *	switchdev_port_attr_get - Get port attribute

Hmm, why do you remove it here? Can't you remove it in a separate patch?
I thought we already got rid of it :p

> - *
> - *	@dev: port device
> - *	@attr: attribute to get
> - */
> -int switchdev_port_attr_get(struct net_device *dev, struct switchdev_att=
r *attr)
> +static int switchdev_port_attr_notify(enum switchdev_notifier_type nt,
> +				      struct net_device *dev,
> +				      const struct switchdev_attr *attr,
> +				      struct switchdev_trans *trans)
>  {
> -	const struct switchdev_ops *ops =3D dev->switchdev_ops;
> -	struct net_device *lower_dev;
> -	struct list_head *iter;
> -	struct switchdev_attr first =3D {
> -		.id =3D SWITCHDEV_ATTR_ID_UNDEFINED
> -	};
> -	int err =3D -EOPNOTSUPP;
> +	int err;
> +	int rc;
> =20
> -	if (ops && ops->switchdev_port_attr_get)
> -		return ops->switchdev_port_attr_get(dev, attr);
> +	struct switchdev_notifier_port_attr_info attr_info =3D {
> +		.attr =3D attr,
> +		.trans =3D trans,
> +		.handled =3D false,
> +	};
> =20
> -	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
> +	if (attr & SWITCHDEV_F_DEFER)
> +		rc =3D call_switchdev_blocking_notifiers(nt, dev,
> +						       &attr_info.info, NULL);
> +	else
> +		rc =3D call_switchdev_notifiers(nt, dev, &attr_info.info, NULL);

I don't believe this is needed. You're calling this function from
switchdev_port_attr_set_now() which is always called from process
context. switchdev_port_attr_set() takes care of that. Similar to
switchdev_port_obj_add().

The event `SWITCHDEV_PORT_ATTR_SET` is therefore always blocking and
drivers only need to take care of it from their blocking notifier.

> +	err =3D notifier_to_errno(rc);
> +	if (err) {
> +		WARN_ON(!attr_info.handled);
>  		return err;
> -
> -	/* Switch device port(s) may be stacked under
> -	 * bond/team/vlan dev, so recurse down to get attr on
> -	 * each port.  Return -ENODATA if attr values don't
> -	 * compare across ports.
> -	 */
> -
> -	netdev_for_each_lower_dev(dev, lower_dev, iter) {
> -		err =3D switchdev_port_attr_get(lower_dev, attr);
> -		if (err)
> -			break;
> -		if (first.id =3D=3D SWITCHDEV_ATTR_ID_UNDEFINED)
> -			first =3D *attr;
> -		else if (memcmp(&first, attr, sizeof(*attr)))
> -			return -ENODATA;
>  	}
> =20
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(switchdev_port_attr_get);
> -
> -static int __switchdev_port_attr_set(struct net_device *dev,
> -				     const struct switchdev_attr *attr,
> -				     struct switchdev_trans *trans)
> -{
> -	const struct switchdev_ops *ops =3D dev->switchdev_ops;
> -	struct net_device *lower_dev;
> -	struct list_head *iter;
> -	int err =3D -EOPNOTSUPP;
> -
> -	if (ops && ops->switchdev_port_attr_set) {
> -		err =3D ops->switchdev_port_attr_set(dev, attr, trans);
> -		goto done;
> -	}
> -
> -	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
> -		goto done;
> -
> -	/* Switch device port(s) may be stacked under
> -	 * bond/team/vlan dev, so recurse down to set attr on
> -	 * each port.
> -	 */
> -
> -	netdev_for_each_lower_dev(dev, lower_dev, iter) {
> -		err =3D __switchdev_port_attr_set(lower_dev, attr, trans);
> -		if (err)
> -			break;
> -	}
> -
> -done:
> -	if (err =3D=3D -EOPNOTSUPP && attr->flags & SWITCHDEV_F_SKIP_EOPNOTSUPP=
)
> -		err =3D 0;
> +	if (!attr_info.handled)
> +		return -EOPNOTSUPP;
> =20
> -	return err;
> +	return 0;
>  }
> =20
>  static int switchdev_port_attr_set_now(struct net_device *dev,
> @@ -267,7 +221,8 @@ static int switchdev_port_attr_set_now(struct net_dev=
ice *dev,
>  	 */
> =20
>  	trans.ph_prepare =3D true;
> -	err =3D __switchdev_port_attr_set(dev, attr, &trans);
> +	err =3D switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
> +					 &trans);
>  	if (err) {
>  		/* Prepare phase failed: abort the transaction.  Any
>  		 * resources reserved in the prepare phase are
> @@ -286,7 +241,8 @@ static int switchdev_port_attr_set_now(struct net_dev=
ice *dev,
>  	 */
> =20
>  	trans.ph_prepare =3D false;
> -	err =3D __switchdev_port_attr_set(dev, attr, &trans);
> +	err =3D switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
> +					 &trans);
>  	WARN(err, "%s: Commit of attribute (id=3D%d) failed.\n",
>  	     dev->name, attr->id);
>  	switchdev_trans_items_warn_destroy(dev, &trans);
> --=20
> 2.17.1
>=20
