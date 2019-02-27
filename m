Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=bF2DPQM/h2pAHkWfftAEy8gv9951yq5x75hNP4aoJQ8=;
	b=TdO7mDAiWMLFLBYDP+j+mKEro7alyc7Ur3KQO3Rxgj1Jfs4h/3N1rWtgMpfWj9nYPs1uZ+l2KggnX6wng0xYJWRvDM+Z5d1WtNrNIfrCs6PFDXwNyZnw7cIOERMc8C26C+2w/rTYrGUHjvg3lrGyylClXzyruYVdCx5h4mkENZQ=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 27 Feb 2019 12:30:55 +0000
Message-ID: <20190227123053.GD13567@splinter>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
	<20190227011427.16487-9-f.fainelli@gmail.com>
In-Reply-To: <20190227011427.16487-9-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5718EFEE89C03B4B9B1CF1AD45E048DD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v2 8/8] net: Remove switchdev_ops
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

On Tue, Feb 26, 2019 at 05:14:27PM -0800, Florian Fainelli wrote:
> Now that we have converted all possible callers to using a switchdev
> notifier for attributes we do not have a need for implementing
> switchdev_ops anymore, and this can be removed from all drivers the
> net_device structure.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
