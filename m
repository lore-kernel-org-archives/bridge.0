Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=SGSR5mGN+meGVq2pHYzBlLBhcWRF4FDb9ZnxN4ndLNk=;
	b=F9oHKJH+L+j8gBCRjmsTVi7ihjMW9YaIK+KLQH2umzC8GonqJqilMlaXiKIZOedldpKggax0izEwnR5Fc3cSZ/Z1IE3l+rxwc7Ko6Ms6kbUQ4Ua+eIU8JcGSA1wgaGJ8A2YNi6mJ7zJymxkq3VcTVW8BE7FYTdif2j5kQP/pd/Y=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 21 Feb 2019 09:55:53 +0000
Message-ID: <20190221095551.GA26289@splinter>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
	<20190221005826.26317-2-f.fainelli@gmail.com>
In-Reply-To: <20190221005826.26317-2-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F738F26E89F661458779B6074D46D068@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v3 1/8] net: switchdev: Add
	PORT_PRE_BRIDGE_FLAGS
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

On Wed, Feb 20, 2019 at 04:58:19PM -0800, Florian Fainelli wrote:
> In preparation for removing switchdev_port_attr_get(), introduce
> PORT_PRE_BRIDGE_FLAGS which will be called through
> switchdev_port_attr_set(), in the caller's context (possibly atomic) and
> which must be checked by the switchdev driver in order to return whether
> the operation is supported or not.
>=20
> This is entirely analoguous to how the BRIDGE_FLAGS_SUPPORT works,
> except it goes through a set() instead of get().
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
