Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=z9Zxo8/04s5PWo0X5pqxgfblSWtMI6yu4jJeHLLMm6I=;
	b=Oi6Vp2dYQR4Y7qEIQOjkKii2moRT7za3Y4esvhbFUiIP+7a5FbDMjXBhT35x7eNNgx1E0hWfixY+g9oNbWIEsPWWxc6/mnu+pGfcMphhKLRjh46ahISmqV80dghcs5KAcKXKg7NpLGp1gt5aJAgWZ+BRDW84mMILsrDwm858IsU=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 21 Feb 2019 09:57:17 +0000
Message-ID: <20190221095715.GD26289@splinter>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
	<20190221005826.26317-9-f.fainelli@gmail.com>
In-Reply-To: <20190221005826.26317-9-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F024D7D78F736F4CAE7F412BF6094966@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v3 8/8] net: Get rid of
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

On Wed, Feb 20, 2019 at 04:58:26PM -0800, Florian Fainelli wrote:
> With the bridge no longer calling switchdev_port_attr_get() to obtain
> the supported bridge port flags from a driver but instead trying to set
> the bridge port flags directly and relying on driver to reject
> unsupported configurations, we can effectively get rid of
> switchdev_port_attr_get() entirely since this was the only place where
> it was called.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
