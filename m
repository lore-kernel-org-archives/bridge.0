Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=dLTIyUEjqCv52rT0cLC0y8mSKIdm1H8zAxPeuHxp5SM=;
	b=PUgJQkRLYOcP71dD9W9zSmXLO9EZ+0zj4l1o4kL30IJ5RGXfBGObBUXkUMYtuL5IkNdXDMfHWLasBWdvXCHt9y1yTju+cmEll009Rp+/JYYSb2G7pFFkVkFADEz6+OP3KTOdYZ5PwQedL/auL18EcadEQSNi23VVL/hPiTl8xbk=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 14 Feb 2019 10:58:14 +0000
Message-ID: <20190214105811.GA8066@splinter>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
	<20190213220638.1552-2-f.fainelli@gmail.com>
In-Reply-To: <20190213220638.1552-2-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BED6534E47F51428BF58087B290D845@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 1/9] Documentation: networking:
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

On Wed, Feb 13, 2019 at 02:06:30PM -0800, Florian Fainelli wrote:
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
