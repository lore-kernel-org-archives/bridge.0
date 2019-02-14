Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=qQXvtCS4f4SwLfqPzHcrX2Vq7NAG/Mu5tTTft1kSskk=;
	b=Fxp8RL5XnWx/mc+9AwjckRSgSnAjI6i2qLREEXvEFeDUvwv5YmYvo7mJ/x9sjBv2iKUQ1fJ4Ckk6T9qArql9ghKja4HNMracwfYjWPgshpCRvS7pNcD+WyGXFAE4OH0c0LEqejqKyufW5/eOtfjVF6Q8hULfOJT+4A4bHjxcaxc=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 14 Feb 2019 12:10:06 +0000
Message-ID: <20190214121004.GA10467@splinter>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
	<20190213220638.1552-10-f.fainelli@gmail.com>
In-Reply-To: <20190213220638.1552-10-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BD5E98B18EB1941AABCED862FF448CD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 9/9] net: Get rid of
	switchdev_port_attr_get()
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

On Wed, Feb 13, 2019 at 02:06:38PM -0800, Florian Fainelli wrote:
> With the bridge no longer calling switchdev_port_attr_get() to obtain
> the supported bridge port flags from a driver but instead trying to set
> the bridge port flags directly and relying on driver to reject
> unsupported configurations, we can effectively get rid of
> switchdev_port_attr_get() entirely since this was the only place where
> it was called.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/networking/switchdev.txt                   | 5 ++---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 7 -------
>  drivers/net/ethernet/rocker/rocker_main.c                | 7 -------
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c                  | 7 -------
>  include/net/switchdev.h                                  | 8 --------
>  net/dsa/slave.c                                          | 7 -------
>  6 files changed, 2 insertions(+), 39 deletions(-)
>=20
> diff --git a/Documentation/networking/switchdev.txt b/Documentation/netwo=
rking/switchdev.txt
> index ea90243340a9..327afe754230 100644
> --- a/Documentation/networking/switchdev.txt
> +++ b/Documentation/networking/switchdev.txt
> @@ -233,9 +233,8 @@ the bridge's FDB.  It's possible, but not optimal, to=
 enable learning on the
>  device port and on the bridge port, and disable learning_sync.
> =20
>  To support learning and learning_sync port attributes, the driver implem=
ents
> -switchdev op switchdev_port_attr_get/set for
> -SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS. The driver should initialize the at=
tributes
> -to the hardware defaults.
> +switchdev op switchdev_port_attr_set for SWITCHDEV_ATTR_PORT_ID_BRIDGE_F=
LAGS.
> +The driver should initialize the attributes to the hardware defaults.

Last sentence is not relevant anymore. learning_sync can also be dropped
