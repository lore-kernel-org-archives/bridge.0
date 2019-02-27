Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=YWLeYgTHudf+ScxMoFpk/HLtra/5XwgLmJImF8CMfik=;
	b=P8xnpHma8QDUTaIzGAki8HNzwatW9jm/BEwgdWItyTRdsrPzROSm9w2/9H08QIiiSD+dwu7kFiG24LPtVKPK3lXEXxJ3CEtyvrKP6PxL5zmjfbKxc4tXrMAUn/XUYk8GrLY3s6nQcmB51Z3Rd7IyHJe1A8YMDhYG+fHUZYRiswU=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 27 Feb 2019 20:16:58 +0000
Message-ID: <20190227201655.GB7022@splinter>
References: <20190227194432.725-1-f.fainelli@gmail.com>
	<20190227194432.725-9-f.fainelli@gmail.com>
In-Reply-To: <20190227194432.725-9-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8399D3744EF47478B9BC47D3C34E2CF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v3 8/8] net: Remove switchdev_ops
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

On Wed, Feb 27, 2019 at 11:44:32AM -0800, Florian Fainelli wrote:
> Now that we have converted all possible callers to using a switchdev
> notifier for attributes we do not have a need for implementing
> switchdev_ops anymore, and this can be removed from all drivers the
> net_device structure.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
