Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86BBC812CC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 763CF8128D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FLHkdMq7pEvkj2fUEtN1bupHXbyWuGn9/sFQ5VEpi0=;
 b=ARWO3tFzNynp9L6HqTy4Cce9qrJKBjwrawVi45utpgtX6/z5ClWOHQtqMKd2u/X0i5DReMapXji7Uwn49GfdkgFBoIhI8iRgpKmYRwesojWZItU2nTfcR68IeJGQ15UZq7e7tPZpjjfYC7+TbgYr3wg7wIpFPMYDzoM5+04sjFQ=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 27 Oct 2022 23:27:48 +0000
Message-ID: <20221027232748.cpvpw53pcx7dx2mp@skbuf>
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-5-idosch@nvidia.com>
 <20221025100024.1287157-5-idosch@nvidia.com>
In-Reply-To: <20221025100024.1287157-5-idosch@nvidia.com>
 <20221025100024.1287157-5-idosch@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F31C387F451F4C458FABECC9FCFCF909@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH net-next 04/16] bridge: switchdev: Allow
 device drivers to install locked FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: "petrm@nvidia.com" <petrm@nvidia.com>, "ivecera@redhat.com" <ivecera@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "razor@blackwall.org" <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "roopa@nvidia.com" <roopa@nvidia.com>, "netdev@kapio-technology.com" <netdev@kapio-technology.com>, "edumazet@google.com" <edumazet@google.com>, "mlxsw@nvidia.com" <mlxsw@nvidia.com>, "jiri@nvidia.com" <jiri@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>

On Tue, Oct 25, 2022 at 01:00:12PM +0300, Ido Schimmel wrote:
> From: "Hans J. Schultz" <netdev@kapio-technology.com>
>=20
> When the bridge is offloaded to hardware, FDB entries are learned and
> aged-out by the hardware. Some device drivers synchronize the hardware
> and software FDBs by generating switchdev events towards the bridge.
>=20
> When a port is locked, the hardware must not learn autonomously, as
> otherwise any host will blindly gain authorization. Instead, the
> hardware should generate events regarding hosts that are trying to gain
> authorization and their MAC addresses should be notified by the device
> driver as locked FDB entries towards the bridge driver.
>=20
> Allow device drivers to notify the bridge driver about such entries by
> extending the 'switchdev_notifier_fdb_info' structure with the 'locked'
> bit. The bit can only be set by device drivers and not by the bridge
> driver.

What prevents a BR_FDB_LOCKED entry learned by the software bridge in
br_handle_frame_finish() from being notified to switchdev (as non-BR_FDB_LO=
CKED,
since this is what br_switchdev_fdb_notify() currently hardcodes)?

I think it would be good to reinstate some of the checks in
br_switchdev_fdb_notify() like the one removed in commit 2c4eca3ef716
("net: bridge: switchdev: include local flag in FDB notifications"):

	if (test_bit(BR_FDB_LOCKED, &fdb->flags))
		return;

at least until we need something more complex and somebody on the
switchdev chain wants to snoop these addresses for some incredibly odd
reason.

> Prevent a locked entry from being installed if MAB is not enabled on the
> bridge port. By placing this check in the bridge driver we avoid the
> need to reflect the 'BR_PORT_MAB' flag to device drivers.

So how does the device driver know whether to emit the SWITCHDEV_FDB_ADD_TO=
_BRIDGE
or not, if we don't pass the BR_PORT_MAB bit to it?

> If an entry already exists in the bridge driver, reject the locked entry
> if the current entry does not have the "locked" flag set or if it points
> to a different port. The same semantics are implemented in the software
> data path.
>=20
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 4ce8b8e5ae0b..4c4fda930068 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -811,7 +811,7 @@ int br_fdb_sync_static(struct net_bridge *br, struct =
net_bridge_port *p);
>  void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port =
*p);
>  int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_p=
ort *p,
>  			      const unsigned char *addr, u16 vid,
> -			      bool swdev_notify);
> +			      bool locked, bool swdev_notify);
>  int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_p=
ort *p,
>  			      const unsigned char *addr, u16 vid,
>  			      bool swdev_notify);
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 8f3d76c751dd..6afd4f241474 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -136,6 +136,7 @@ static void br_switchdev_fdb_populate(struct net_brid=
ge *br,
>  	item->added_by_user =3D test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
>  	item->offloaded =3D test_bit(BR_FDB_OFFLOADED, &fdb->flags);
>  	item->is_local =3D test_bit(BR_FDB_LOCAL, &fdb->flags);
> +	item->locked =3D 0;

0 or false? A matter of preference, I presume. Anyway, this will only be
correct with the extra check mentioned above. Otherwise, a LOCKED entry
may be presented as non-LOCKED to switchdev, with potentially unforeseen
consequences.

>  	item->info.dev =3D (!p || item->is_local) ? br->dev : p->dev;
>  	item->info.ctx =3D ctx;
>  }
> --=20
> 2.37.3
>=
