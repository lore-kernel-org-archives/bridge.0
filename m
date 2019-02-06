Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=4WUrlRyTPx9ms/obiKo4Y3M+wr2OosRYgHONM+0vVlA=;
	b=cYoZ7GuN8Xg2/H+O0pJU+9G8QvSe9DKDHK4CZ8qatjZ6zC5Eggk8BdY7Hfs/r05Z688CZStiNjlKYQbMf+XMsf5ihRZy/1tVeR+05UO1KhSuwSa7UBDQY9IMiJ58ZKEzD9TkjiFpSJeZF+Hu61LQ1otJzP1HVivqImkzHsS8sO8=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 6 Feb 2019 19:10:56 +0000
Message-ID: <20190206191054.GC14340@splinter>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
	<20190206174546.23597-2-f.fainelli@gmail.com>
In-Reply-To: <20190206174546.23597-2-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9E0D70EE9EB1A47BA821502865FCAE1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 01/12] net: Introduce
	ndo_get_port_parent_id()
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

On Wed, Feb 06, 2019 at 09:45:35AM -0800, Florian Fainelli wrote:
> In preparation for getting rid of switchdev_ops, create a dedicated NDO
> operation for getting the port's parent identifier. There are
> essentially two classes of drivers that need to implement getting the
> port's parent ID which are VF/PF drivers with a built-in switch, and
> pure switchdev drivers such as mlxsw, ocelot, dsa etc.
>=20
> We introduce a helper function: dev_get_port_parent_id() which supports
> recursion into the lower devices to obtain the first port's parent ID.
>=20
> Convert the bridge, core and ipv4 multicast routing code to check for
> such ndo_get_port_parent_id() and call the helper function when valid
> before falling back to switchdev_port_attr_get(). This will allow us to
> convert all relevant drivers in one go instead of having to implement
> both switchdev_port_attr_get() and ndo_get_port_parent_id() operations,
> then get rid of switchdev_port_attr_get().
>=20
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
