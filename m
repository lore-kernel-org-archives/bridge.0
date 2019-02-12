Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ktt0uq+qJWs3fnLXZAd4ICa5yDhWQBM56n6poc80XTM=;
	b=N4vXk5n7bZPWMndHxtTWAy16WLzIv5Z2dVFDjXDomSPWSI+s69qohsb2Lpbxazw0OmOnwpEAmL0VEPcYccKee8KQvZYeCI4KlHRum4enwEMihX59A3BnMMDEQvuS7dC2a69cjFYImEScUJbnDAT9/AU9Xa0qyOSA7PVtzXc/xhs=
From: Ido Schimmel <idosch@mellanox.com>
Date: Tue, 12 Feb 2019 12:18:00 +0000
Message-ID: <20190212121758.GA12774@splinter>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
	<20190211211749.19847-2-f.fainelli@gmail.com>
In-Reply-To: <20190211211749.19847-2-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C44DEB3C518E4049AE6A045E639E28F5@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 1/3] mlxsw: spectrum_switchdev: Remove
 getting PORT_BRIDGE_FLAGS
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

On Mon, Feb 11, 2019 at 01:17:47PM -0800, Florian Fainelli wrote:
> There is no code that will query the SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
> attribute remove support for that.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
