Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=IHnjX7Zu9JhmFCi1CiJcp4wiH8pXYYXHBrJn9ioQEzU=;
	b=iLxtpj78X8PxqlZALF6Ry/WAG4BH8FSR883I/vlxqMfOB0DcgzPr8/FCgoNlhgXQFRsqFQ6cQ4k83E05EqfiqkEUG6TUMDrui5fot4XJLmG4lRokPxq5FhRQJoUoFaYvpE3ad/VFMpkLq/8FOzk3gKjYc79BYXNCBcwD36+/VXQ=
From: Ido Schimmel <idosch@mellanox.com>
Date: Tue, 12 Feb 2019 12:19:51 +0000
Message-ID: <20190212121949.GA13138@splinter>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
	<20190211191001.8623-2-f.fainelli@gmail.com>
In-Reply-To: <20190211191001.8623-2-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14994EC13F27AD4B937AB755CEE199C3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 1/9] Documentation: networking:
 switchdev: Update port parent ID section
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

On Mon, Feb 11, 2019 at 11:09:53AM -0800, Florian Fainelli wrote:
> Update the section about switchdev drivers having to implement a
> switchdev_port_attr_get() function to return
> SWITCHDEV_ATTR_ID_PORT_PARENT_ID since that is no longer valid after
> commit bccb30254a4a ("net: Get rid of
> SWITCHDEV_ATTR_ID_PORT_PARENT_ID").
>=20
> Fixes: bccb30254a4a ("net: Get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID")
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
