Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=3AGNg/GeKHToB/MDS7WxXteISH803hgikz8I3tH/pqs=;
	b=pt+FVe2VL/m308LgWrGaf5CXk6U7GW9xK6bDN2gATMqsgLTor2IIlDSRuqMEdeyeP79ImF8VyusNZuOV/Rk7DAeaplSDkK05g2/CpYIwoPilvQTaUeY2VTkNOlnK1gtODbzOz5U3xKiu+3nKQ0IHtl75fwmuDjBsBvPWn/llO10=
From: Ido Schimmel <idosch@mellanox.com>
Date: Tue, 12 Feb 2019 14:20:26 +0000
Message-ID: <20190212142022.GA18413@splinter>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
	<20190210175105.31629-7-f.fainelli@gmail.com>
	<20190210190501.GA26726@splinter>
	<73a10fbb-7689-74a7-3fbf-076f8dc9d76f@gmail.com>
In-Reply-To: <73a10fbb-7689-74a7-3fbf-076f8dc9d76f@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <30B436DADF936545A9B793667EE71C4E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v2 06/16] net: bridge: Stop calling
 switchdev_port_attr_get()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@mellanox.com>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>

On Sun, Feb 10, 2019 at 11:34:14AM -0800, Florian Fainelli wrote:
> Le 2/10/19 =E0 11:05 AM, Ido Schimmel a =E9crit=A0:
> > On Sun, Feb 10, 2019 at 09:50:55AM -0800, Florian Fainelli wrote:
> >> Now that all switchdev drivers have been converted to checking the
> >> bridge port flags during the prepare phase of the
> >> switchdev_port_attr_set(), we can move straight to trying to set the
> >> desired flag through SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS.
> >>
> >> Acked-by: Jiri Pirko <jiri@mellanox.com>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  net/bridge/br_switchdev.c | 20 +++-----------------
> >>  1 file changed, 3 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> >> index db9e8ab96d48..939f300522c5 100644
> >> --- a/net/bridge/br_switchdev.c
> >> +++ b/net/bridge/br_switchdev.c
> >> @@ -64,29 +64,15 @@ int br_switchdev_set_port_flag(struct net_bridge_p=
ort *p,
> >>  {
> >>  	struct switchdev_attr attr =3D {
> >>  		.orig_dev =3D p->dev,
> >> -		.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
> >> +		.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
> >> +		.flags =3D SWITCHDEV_F_DEFER,
> >=20
> > How does this work? You defer the operation, so the driver cannot veto
> > it. This is why we have SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
> > which is not deferred.
>=20
> I missed that indeed, how would you feel about splitting the attribute
> setting into different phases:
>=20
> - checking that the attribute setting is supported (caller context, so
> possibly atomic)
> - allocating and committing resources (deferred context)

Yes, this is what I suggested in the other thread. Lets continue
discussion there.

We are doing that when processing route notifications (for example), but
we are missing a check in caller context that resources can actually be
allocated. That's part of a bigger task to track resources in mlxsw.

>=20
> For pretty much any DSA driver, we will have to be in sleepable context
> anyway because of MDIO, SPI, I2C, whatever transport layer.
>=20
> Not sure how to best approach this now...
> --=20
> Florian
