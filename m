Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=swq/S8DcM57qPexRzKGchyQ5CBiRTzg6l93s6myU0D4=;
	b=WYYwd0xhJwpVKVqa58Mit2X0z981tpVGRDibJxXh1SVUGkfG0i32IUcK2BHIvXfKqF6WpPe8ZdogrA+7Qwh946XqHJ00cNxf+ywVzcCFKmsVo2RSrCRrlURU/y8QOQB7mk7cMvzAed/M7GJK37ajlkl93/6NwmLJuBpWWXO2gBU=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 27 Feb 2019 12:32:34 +0000
Message-ID: <20190227123232.GE13567@splinter>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
	<20190222235927.10295-8-f.fainelli@gmail.com>
	<20190223103207.GA13070@splinter>
	<daaa3bb6-78b1-7c19-e2fd-6ec03d56201d@gmail.com>
	<20190225094940.GA15128@splinter>
	<2e91b708-a092-3839-4979-2712145a9951@gmail.com>
In-Reply-To: <2e91b708-a092-3839-4979-2712145a9951@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <915DA04E3989804892AF568544A38635@eurprd05.prod.outlook.com>
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

On Mon, Feb 25, 2019 at 11:47:12AM -0800, Florian Fainelli wrote:
> On 2/25/19 1:49 AM, Ido Schimmel wrote:
> > On Sun, Feb 24, 2019 at 08:47:27AM -0800, Florian Fainelli wrote:
> >> Le 2/23/19 =E0 2:32 AM, Ido Schimmel a =E9crit=A0:
> >>> On Fri, Feb 22, 2019 at 03:59:25PM -0800, Florian Fainelli wrote:
> >>>> -	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
> >>>> +	if (attr & SWITCHDEV_F_DEFER)
> >>>> +		rc =3D call_switchdev_blocking_notifiers(nt, dev,
> >>>> +						       &attr_info.info, NULL);
> >>>> +	else
> >>>> +		rc =3D call_switchdev_notifiers(nt, dev, &attr_info.info, NULL);
> >>>
> >>> I don't believe this is needed. You're calling this function from
> >>> switchdev_port_attr_set_now() which is always called from process
> >>> context. switchdev_port_attr_set() takes care of that. Similar to
> >>> switchdev_port_obj_add().
> >>
> >> Except for net/bridge/br_switchdev.c when we check the bridge port's
> >> flags support with PRE_BRIDGE_FLAGS. In that case we are executing fro=
m
> >> the caller (atomic) context and we can't defer otherwise that trumps t=
he
> >> whole idea of being able to do a quick check and return that to the
> >> caller that we cannot support specific flags. How would you recommend
> >> approaching that?
> >=20
> > In this case you can invoke call_switchdev_notifiers() directly from
> > br_switchdev_set_port_flag(). Eventually switchdev_port_attr_set() will
> > be gone and bridge code will invoke the notifiers directly.
>=20
> That can be done, but it still requires the target driver (mlxsw,
> ocelot, dsa, etc.) to support attribute notification from blocking and
> non-blocking context. Are you fine with that?

Yes. Sorry for the latency. I was away yesterday. Reviewed your v2 and
only found one problem. Will run some tests now.

Thanks!
