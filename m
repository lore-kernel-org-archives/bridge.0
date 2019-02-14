Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=2/CO/KIkZaTcRskSjIOhhlz6gceoT1YOiG0Bz84pdIQ=;
	b=VDQtMDW7pLVicW/Yv8rCOSbu/if5U1Q35VQ1KLZi8l1jEN8tePEG9ZZqPpRVdXlvTD5yOeNv+vRQddTZyPb9xxnHyEnVQGwJ0bTJPWPiIaOJT/5sF0uNejM8UayHTvb9O9Cnxa0aQ2qkYqIWAWi5O6pZES7KgwXMwlmpjn2XQ3g=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 14 Feb 2019 11:27:51 +0000
Message-ID: <20190214112749.GA9620@splinter>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
	<20190213220638.1552-9-f.fainelli@gmail.com>
In-Reply-To: <20190213220638.1552-9-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30D75F9BF9B6EB4EA0A9B623D0594868@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 8/9] net: Remove
 SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
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

On Wed, Feb 13, 2019 at 02:06:37PM -0800, Florian Fainelli wrote:
> Now that we have converted the bridge code and the drivers to check for
> bridge port(s) flags at the time we try to set them, there is no need
> for a get() -> set() sequence anymore and
> SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT therefore becomes unused.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
