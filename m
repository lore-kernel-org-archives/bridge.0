Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=yzXltSBfV14hJNRUm2MwRcMR04TZ2GhQV+gjuGqmuAQ=;
	b=W99B4j1aG8T7EqswKL2ciKCs6iwI+P73dOVX1kCa0bKxfi/ZpYHUY2df5YrZyW1XRZCV+ju7BX+oknd5QDdFrsyk5++XhgYb9P2klmzyVyVfefaigyCcoXIKU9VwCt9Scc0Pq+9AQFyrOcNZ2YltF49q6a9ZbJIT/G8U+Oefpe0=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 21 Feb 2019 09:56:15 +0000
Message-ID: <20190221095613.GB26289@splinter>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
	<20190221005826.26317-3-f.fainelli@gmail.com>
In-Reply-To: <20190221005826.26317-3-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <906D3CC0BAD2974C9A5603E6B0454184@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v3 2/8] mlxsw: spectrum: Handle
 PORT_PRE_BRIDGE_FLAGS
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

On Wed, Feb 20, 2019 at 04:58:20PM -0800, Florian Fainelli wrote:
> In preparation for getting rid of switchdev_port_attr_get(), have mlxsw
> check for the bridge flags being set through switchdev_port_attr_set()
> when the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier is
> used.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
