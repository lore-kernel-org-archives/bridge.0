Return-Path: <jakub.kicinski@netronome.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=netronome-com.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=1clrz93YICumgnFLXBRE1bqurwnpYnatEWZiKqd/KFU=;
	b=qG5kxvZfjxt9Hy3zw57qPaHEVpKrIrG7LX3JvNc9Y5/+Ct4FoA72aep2bMTDSlIeHi
	O2tnv5FsGo1om8u93GW1R5p4+9mKjzlP9Z4ZVK2VgIcIpyA1lz/J4SgP/XQrcTgGygcV
	JYkF4bmimqYc3sjtngxVOmQfGLUBe/DUSExYYQzmTdDY0d3kOYUCDK2hGhSCxHC+rLR5
	/rbwtpSTh5BoNEhUxtUdE/6EDzA9j4YgEgIvwGfeePyPY8VtJt9WOx6oiY9HH0zIzlcS
	0siMBRYH3nCJ1BvGoLWd79m81yMVBMf1ygYqBPfC+ZUDEnqWLn1gz6yXulBCNk82FJPq
	p/xQ==
Date: Mon, 4 Feb 2019 19:51:26 -0800
From: Jakub Kicinski <jakub.kicinski@netronome.com>
Message-ID: <20190204195126.7749ebaa@cakuba.netronome.com>
In-Reply-To: <20190204233633.20421-10-f.fainelli@gmail.com>
References: <20190204233633.20421-1-f.fainelli@gmail.com>
	<20190204233633.20421-10-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 09/12] netdevsim: Implement
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
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, John Hurley <john.hurley@netronome.com>, "open
	list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>, Eric Dumazet <edumazet@google.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Tyler Hicks <tyhicks@canonical.com>, Ivan Vecera <ivecera@redhat.com>, David Ahern <dsahern@gmail.com>, Ioana Radulescu <ruxandra.radulescu@nxp.com>, "open
	list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Amritha Nambiar <amritha.nambiar@intel.com>, Saeed Mahameed <saeedm@mellanox.com>, Dirk van der Merwe <dirk.vandermerwe@netronome.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Vivien Didelot <vivien.didelot@gmail.com>, Alexander Duyck <alexander.h.duyck@intel.com>, "open
	list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Simon Horman <simon.horman@netronome.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, Satanand Burla <sburla@marvell.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Kirill Tkhai <ktkhai@virtuozzo.com>, Edwin Peer <edwin.peer@netronome.com>, Michael Chan <michael.chan@broadcom.com>, Christian Brauner <christian@brauner.io>, Felix Manlunas <fmanlunas@marvell.com>, Leon Romanovsky <leon@kernel.org>, Nic Viljoen <nick.viljoen@netronome.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, open list <linux-kernel@vger.kernel.org>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, netdev@vger.kernel.org, Joe Perches <joe@perches.com>, Derek Chickles <dchickles@marvell.com>, "David
	S. Miller" <davem@davemloft.net>

On Mon,  4 Feb 2019 15:36:30 -0800, Florian Fainelli wrote:
> netdevsim only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it a
> great candidate to be converted to use the ndo_get_port_parent_id() NDO
> instead of implementing switchdev_port_attr_get().
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
