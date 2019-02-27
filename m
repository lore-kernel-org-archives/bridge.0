Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=oV7+2Us5MX0jWcHBUmnmyOktFkmTrCCo80oKhp9NNxU=;
	b=v26y3mWmNFUlQM7cQD4LfRUiHlgjDN5On3xrZ5/WqEU6rqxf+VqDJNQRdpAq1lW/sFxGnNfbCxs2lbuqEyfD6yNeaMeHuwxDuBPNm3KLylT02vSLqeViqst3Q7QKuaMW7jk0wad5329sFhAjaImPLheWHp9QfcFDkUvgY24XDgk=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 27 Feb 2019 20:18:37 +0000
Message-ID: <20190227201834.GC7022@splinter>
References: <20190227194432.725-1-f.fainelli@gmail.com>
In-Reply-To: <20190227194432.725-1-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79D9B29DFDC8E74EB688890A300AC9A3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v3 0/8] net: Remove switchdev_ops
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

On Wed, Feb 27, 2019 at 11:44:24AM -0800, Florian Fainelli wrote:
> Hi all,
>=20
> This patch series completes the removal of the switchdev_ops by
> converting switchdev_port_attr_set() to use either the blocking
> (process) or non-blocking (atomic) notifier since we typically need to
> deal with both depending on where in the bridge code we get called from.
>=20
> This was tested with the forwarding selftests and DSA hardware.

I ran some basic tests and nothing exploded :) Thanks, Florian!
