Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=KeHlHNNrzNPV3mCygDTWlC1E79Iod/vReO19jFONyj4=;
	b=Am1rDWzZMtt1nxSV+I9ec5gSJr3+hQpF3mV7DqdPWd9YHGThUAWr8OZ3Z+oRyxk0zSV6mXmLkKX8pXozuQNkFz2a/H4qFqBWOOYsOTGw2Rp8z540GhSpEI8pMAut06IoXtEJDyD1hpYahlY1G062uYKQcURsVgjjyRPiaE1v3LI=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 21 Feb 2019 09:56:51 +0000
Message-ID: <20190221095648.GC26289@splinter>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
	<20190221005826.26317-7-f.fainelli@gmail.com>
In-Reply-To: <20190221005826.26317-7-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6987CB80C7D91F4FA3DCDAC03AA8EC37@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v3 6/8] net: bridge: Stop calling
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
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "moderated
	list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "David S. Miller" <davem@davemloft.net>

On Wed, Feb 20, 2019 at 04:58:24PM -0800, Florian Fainelli wrote:
> Now that all switchdev drivers have been converted to check the
> SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS flags and report flags that they
> do not support accordingly, we can migrate the bridge code to try to set
> that attribute first, check the results and then do the actual setting.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
