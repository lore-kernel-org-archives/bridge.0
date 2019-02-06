Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=3fjFmgiQHzS9dhgyCSYr//s52C+P0gZ6d6/CRuh1hcQ=;
	b=nyxoR4Mc/8uHGRZWiB2P9uevVRmTddY9bcmKRRKY3xE0YVOVU9s9nM86EtTpEzW+6zU2MBWoucnBzoRCJk8ZOrYK7vTtEOEMSCESdIrcRfDNzapiaGXNOTSn9JGXuRoSGCTgCYHPzxUrt7xgFhMuPrv3OOlCbqPHW7LxCDfIATo=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 6 Feb 2019 07:51:38 +0000
Message-ID: <20190206075136.GA2283@splinter>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
In-Reply-To: <20190205235326.14600-1-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <388E482218ED4E428D59B4AC8420E216@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v3 00/12] net: Introduce
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

On Tue, Feb 05, 2019 at 03:53:14PM -0800, Florian Fainelli wrote:
> Hi all,
>=20
> Based on discussion with Ido and feedback from Jakub there are clearly
> two classes of users that implement SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
>=20
> - PF/VF drivers which typically only implement return the port's parent
>   ID, yet have to implement switchdev_port_attr_get() just for that
>=20
> - Ethernet switch drivers: mlxsw, ocelot, DSA, etc. which implement more
>   attributes which we want to be able to eventually veto in the context
>   of the caller, thus making them candidates for using a blocking notifie=
r
>   chain

Florian, patches look good to me. I'm going to build a kernel with these
patches and run some tests. Will report later today.

Thanks
