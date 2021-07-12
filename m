Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi68UCk//tATx9kRXqunHnkORQeNS2cTaOQVCItiVL0=;
 b=JVU6pbgfh98WL+a6sDjIVeYAN+kGKzWq5ka+ro8km3PMdrJjBJNAzW5/YZKmxsNioYd2BjiHWjnUN1SFduasXVbyKawUQzlpVqn0brOR8r0jhwf6m2KZpXTVp7E9n3mjAXqkiPHOjrinFfAl5pRpxFI6nAzGnLnooYH8ThaR+M8=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 17:01:21 +0000
Message-ID: <20210712170120.xo34ztomimq5oqdg@skbuf>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
 <20210712174059.7916c0da@thinkpad>
In-Reply-To: <20210712174059.7916c0da@thinkpad>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1BB5E62C3DFF8548A3F571CCC8C557B5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH v3 net-next 00/24] Allow forwarding for the
 software bridge data path to be offloaded to capable devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Marek Behun <kabel@blackhole.sk>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

Hi Marek,

On Mon, Jul 12, 2021 at 05:40:59PM +0200, Marek Behun wrote:
> Vladimir, on what mv88e6xxx devices are you developing this stuff?
> Do you use Turris MOX for this?

I didn't develop the Marvell stuff nor did I come up with the idea
there, Tobias did. I also am not particularly interested in supporting
this for Marvell beyond making sure that the patches look simple and
okay, and pave the way for other drivers to do the same thing.

I did my testing using a different DSA driver and extra patches which
I did not post here yet. I just reposted/adapted Tobias' work because
mv88e6xxx needs less work to support the TX data plane offload, and this
framework does need a first user to get accepted, so why delay it any
further if mv88e6xxx needs 2 patches whereas other drivers need 30.

I did use the MOX for some minimal testing however, at least as far as
I could - there is this COMPHY SERDES bug in the bootloader which makes
the board fail to boot, and now the device tree workaround you gave me
does not appear to bypass the issue any longer or I didn't reaply it
properly. The point is that it isn't as easy as I would have liked to
use the MOX for testing. I was able to validate the "net: dsa: track the
number of switches in a tree" patch on MOX, though, since DSA probes
earlier than xhci, and even though the boot hung, I did put some prints
and got the expected results.=
