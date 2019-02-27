Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=nefKtGd1lTx7FGEQHTFoenGmZJG4TN1iB7Skq9dqYME=;
	b=jyS5wJAof7icuGGSK2AJFfh0g8mRP6Xsf+9/wAK7pZ9Ymh/TgLozxw+RfQhUxCKS1GUWZlp94iwRYZ3lM21o4xKSXOuL4t7eKDPONAqhda7T2af+RACrVCg9Wm8ncH+QrzzcG1VRmNybHdh5PrhTor8o++crVAzr6CP+A1BhsTE=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 27 Feb 2019 12:30:32 +0000
Message-ID: <20190227123030.GC13567@splinter>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
	<20190227011427.16487-5-f.fainelli@gmail.com>
In-Reply-To: <20190227011427.16487-5-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C72971248486524A8025347723E5D21F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v2 4/8] mlxsw: spectrum_switchdev:
 Handle SWITCHDEV_PORT_ATTR_SET
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

On Tue, Feb 26, 2019 at 05:14:23PM -0800, Florian Fainelli wrote:
> Following patches will change the way we communicate setting a port's
> attribute and use a notifier to perform those tasks.
>=20
> Prepare mlxsw to support receiving notifier events targeting
> SWITCHDEV_PORT_ATTR_SET and utilize the switchdev_handle_port_attr_set()
> to handle stacking of devices.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
