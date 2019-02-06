Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Ua9OYuKaqBv59B7FaQeIa2i2qm/guFe03LFjWKpL8uw=;
	b=mDqFTmDNJ3DF4qluHHR5EGjceaRUHkq5BXKERDKTpuLPMtza422AbuGm+kkyqbi3aECv2toQxWSp3WuuJhQTj7TYKfJWuCNuOg4V8h/ndY0U7GVHqqtnyJg6209TS1X6YTWzKo3Eode3pT3JQVHdvRz/mCAscnxHFBcxQlRQRUM=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 6 Feb 2019 19:04:41 +0000
Message-ID: <20190206190434.GA14340@splinter>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
	<20190206174546.23597-6-f.fainelli@gmail.com>
In-Reply-To: <20190206174546.23597-6-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4EC5A764CE1EA4D9DF8CA9C5BBB1C95@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 05/12] mlxsw: Implement
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

On Wed, Feb 06, 2019 at 09:45:39AM -0800, Florian Fainelli wrote:
> mlxsw implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
> of switchdev_ops eventually, ease that migration by implementing a
> ndo_get_port_parent_id() function which returns what
> switchdev_port_attr_get() would do.
>=20
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
