Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=4ROmE+gPd7kZTop7sn7HvSN8xkg4m3mB+3z4099cZZQ=;
	b=Ewb5+6qjE6OA5DC9aneYLBjdzbF4kwfll5xC5EIX4zfd7/+tNBIKpJmAkr9WswriLYb7VQw4kE1VxRjCz+wglbGt/NAcISU3ZtAsTkD26m5dkudOY3nOLP+ZdQJbGEb6pHIbCF1SCrLO+J2EcGiCK8LR+T+K98bti+CUTEO2sUw=
From: Ido Schimmel <idosch@mellanox.com>
Date: Tue, 12 Feb 2019 13:14:47 +0000
Message-ID: <20190212131443.GA13819@splinter>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
In-Reply-To: <20190211191001.8623-1-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3987C19D0F710243BE2B3F07927F03AB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 0/9] net: Remove switchdev_ops
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

On Mon, Feb 11, 2019 at 11:09:52AM -0800, Florian Fainelli wrote:
> Hi all,
>=20
> This patch series finishes by the removal of switchdev_ops. To get there
> we convert the existing switchdev_port_attr_{set,get} switchdev_ops to
> use a blocking notifier, thus making it consistent with how the objects
> are pushed to the switchdev enabled devices.
>=20
> Please review and let me know what you think!
>=20
> David, I would like to get Ido's feedback on this to make sure I did not
> miss something, thank you!

Hi Florian,

Why do you still keep switchdev_port_attr_get()? I believe we can remove
it and simplify things.

After your recent patchset to remove 'PORT_BRIDGE_FLAGS', the only
remaining user of get() is 'PORT_BRIDGE_FLAGS_SUPPORT'. It can be
converted to a blocking set() with 'PORT_PRE_BRIDGE_FLAGS' (or a similar
name).

I would like to make sure we're in sync with regards to future changes.
After this patchset to get rid of switchdev_ops we can continue to
completely removing switchdev (I believe Jiri approves). The
prepare-commit model is not really needed and the two switchdev
notification chains can be split into bridge and vxlan specific chains.

Notifications sent in an atomic context can be handled by drivers
directly in this context. Similar to how FDB/route/neighbour are
handled. It will really simplify things. No need for the defer flag
anymore and tricks like 'PORT_BRIDGE_FLAGS_SUPPORT' and
'PORT_PRE_BRIDGE_FLAGS'. In the atomic context the driver can veto the
requested bridge flags, but program the device from a blocking context
(using a workqueue).
