Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=JtehfmoOGxk3oXEMPjG37A+9LNQdGQWyqzyj4MGy2S0=;
	b=Nkc9/A76ziwpLt7s2yQMcgtmX42SscdMWQditxqXXn/r+yOUbBR0Dl1D0j1JWt/Ks79Z7oTiN94VmaSdMxIrzk406mJCYpXixwfIr/RjAqW0ypBBZ+vn5OzaWhqzmHNk1j1FYaU0EjqmCnYDAB0IO65InFfnfcngr+KW1+q0d8c=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 6 Feb 2019 19:10:09 +0000
Message-ID: <20190206191001.GB14340@splinter>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
	<20190206174546.23597-13-f.fainelli@gmail.com>
In-Reply-To: <20190206174546.23597-13-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45077B349C70DE4D981148D775C01A65@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 12/12] net: Get rid of
 SWITCHDEV_ATTR_ID_PORT_PARENT_ID
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "open
	list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "moderated
	list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, "open
	list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>, "David S. Miller" <davem@davemloft.net>

On Wed, Feb 06, 2019 at 09:45:46AM -0800, Florian Fainelli wrote:
> Now that we have a dedicated NDO for getting a port's parent ID, get rid
> of SWITCHDEV_ATTR_ID_PORT_PARENT_ID and convert all callers to use the
> NDO exclusively. This is a preliminary change to getting rid of
> switchdev_ops eventually.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
