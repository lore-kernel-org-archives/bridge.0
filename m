Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=qC0FC1DHkFygybBFFoLGJXKoznqoL5SXk5r1GEBjanQ=;
	b=f1PW1w4Ud2RbEEUDTGk2LmtB+ASF/6ROd0Bie4gkFGUC1E56zYNj5ALVZSKYx059xktERIVG5TQvKA/V7O+s5UZtMvOe46SlbQI5b2OSPm9fXlfMzo8Rwf1Y02Dg734QsxJsm36cdpim7iNWQG7zYfgC+BHqR11GWOOPxBKsPDw=
From: Ido Schimmel <idosch@mellanox.com>
Date: Mon, 25 Feb 2019 09:49:42 +0000
Message-ID: <20190225094940.GA15128@splinter>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
	<20190222235927.10295-8-f.fainelli@gmail.com>
	<20190223103207.GA13070@splinter>
	<daaa3bb6-78b1-7c19-e2fd-6ec03d56201d@gmail.com>
In-Reply-To: <daaa3bb6-78b1-7c19-e2fd-6ec03d56201d@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6DF005F2CFAE0A438F5A632B515DC704@eurprd05.prod.outlook.com>
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

On Sun, Feb 24, 2019 at 08:47:27AM -0800, Florian Fainelli wrote:
> Le 2/23/19 =E0 2:32 AM, Ido Schimmel a =E9crit=A0:
> > On Fri, Feb 22, 2019 at 03:59:25PM -0800, Florian Fainelli wrote:
> >> -	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
> >> +	if (attr & SWITCHDEV_F_DEFER)
> >> +		rc =3D call_switchdev_blocking_notifiers(nt, dev,
> >> +						       &attr_info.info, NULL);
> >> +	else
> >> +		rc =3D call_switchdev_notifiers(nt, dev, &attr_info.info, NULL);
> >=20
> > I don't believe this is needed. You're calling this function from
> > switchdev_port_attr_set_now() which is always called from process
> > context. switchdev_port_attr_set() takes care of that. Similar to
> > switchdev_port_obj_add().
>=20
> Except for net/bridge/br_switchdev.c when we check the bridge port's
> flags support with PRE_BRIDGE_FLAGS. In that case we are executing from
> the caller (atomic) context and we can't defer otherwise that trumps the
> whole idea of being able to do a quick check and return that to the
> caller that we cannot support specific flags. How would you recommend
> approaching that?

In this case you can invoke call_switchdev_notifiers() directly from
br_switchdev_set_port_flag(). Eventually switchdev_port_attr_set() will
be gone and bridge code will invoke the notifiers directly.
