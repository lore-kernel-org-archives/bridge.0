Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=8JcylOc1PrbrvW0pRPoXxMBtiYFEbeheosmI20DLP6g=;
	b=ycxlXRoSD8YzzGW8KHYr60jO0JXNj/UYyW08DGW9RYQ/LUfuzfynSib6LNyE7J88z9aIvx2mJYSiRNy6FOD4MYufMyII9gxdbG+3M+xhzhbIY6pJeRr20Qtc+eVakKISRjV+THtRR5bCy3vjcQ2bZ/TNH+LmORTlXHfVo6hfB0Y=
From: Ido Schimmel <idosch@mellanox.com>
Date: Tue, 12 Feb 2019 14:10:50 +0000
Message-ID: <20190212141048.GC16850@splinter>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
	<20190211191001.8623-10-f.fainelli@gmail.com>
In-Reply-To: <20190211191001.8623-10-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4168D19CAE06654188B5C3B6607D2D85@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 9/9] net: Remove switchdev_ops
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

On Mon, Feb 11, 2019 at 11:10:01AM -0800, Florian Fainelli wrote:
> Now that we have converted all possible callers to using a switchdev
> notifier for attributes we do not have a need for implementing
> switchdev_ops anymore, and this can be removed from all drivers the
> net_device structure.
>=20
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 12 ------------
>  drivers/net/ethernet/mellanox/mlxsw/spectrum.h |  2 --
>  .../mellanox/mlxsw/spectrum_switchdev.c        | 13 -------------
>  drivers/net/ethernet/mscc/ocelot.c             |  5 -----
>  drivers/net/ethernet/rocker/rocker_main.c      |  6 ------
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c        |  6 ------
>  include/linux/netdevice.h                      |  3 ---
>  include/net/switchdev.h                        | 18 ------------------
>  net/dsa/slave.c                                |  6 ------

There's also this line that can be removed from the 8021q driver:

net/8021q/vlan_dev.c:34:#include <net/switchdev.h>
