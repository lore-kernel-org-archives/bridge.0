Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NZFWy5C/cLP0yScKVt0E73oPievWM8F0hNc0HEWYSA=;
 b=Xb2oHDslRXZCGux2n+qhNlXicC+X5bCBv2H4Hvxw8XkKn5Z4qitso6Zo2OWUExh61Hf+5KQSq/o4zpEUu43Pl4uOkCJD7kxP6uSU3zcFDELCapS2unk4k5X3RXwknDfM58PN0JXlr2cKl6XJxk4JNyXyRoO/fZxRFJzDYbKrgCo=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 17 Feb 2021 16:09:23 +0000
Message-ID: <20210217160923.fimumxafloc6276i@skbuf>
References: <20210216214205.32385-1-horatiu.vultur@microchip.com>
 <20210216214205.32385-3-horatiu.vultur@microchip.com>
 <20210217103433.bilnuo2tfvgvjmxy@skbuf>
 <20210217155845.oegbmsnxykkqc6um@soft-dev3.localdomain>
In-Reply-To: <20210217155845.oegbmsnxykkqc6um@soft-dev3.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <722080CF38BD8340897DAF4CA059A370@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 2/8] switchdev: mrp: Extend
 ring_role_mrp and in_role_mrp
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "nikolay@nvidia.com" <nikolay@nvidia.com>, "roopa@nvidia.com" <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

On Wed, Feb 17, 2021 at 04:58:45PM +0100, Horatiu Vultur wrote:
> > If a driver implements full MRP offload for a ring/interconnect
> > manager/automanager, should it return -EOPNOTSUPP when sw_backup=3Dfals=
e?
>=20
> In that case it should return 0.
> So if the driver can:
> - fully support MRP, when sw_backup =3D false, return 0. Then end of stor=
y.
> - partially support MRP, when sw_backup =3D false, return -EOPNOTSUPP,
>                          when sw_backup =3D true, return 0.
> - no support at all, return -EOPNOTSUPP.

Damn, I asked the wrong question.
I meant to ask about what it should return when sw_backup=3Dtrue.
But you answered anyway that if it returns 0 when sw_backup=3Dfalse, it
can simply not deal with the case where sw_backup=3Dtrue, because that is
never supposed to happen.=
