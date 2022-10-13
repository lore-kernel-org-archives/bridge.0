Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C5E360B10
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BADD260B03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POSAfKjE6zvEwR6cQjzhYazJSFGO2KOXOP0fthXCztI=;
 b=SpEq/wM7GtG+vnE+fphKp/Q8i6x0+MjbvL9EC7LF67abwXgXO6VNi5lK1Dqv1icpwy0Jesj7F48rlmvcT/uAN8Cg3ZAK3TuCDG7wlRY0KGWEKU2heYbi2SlQqbrRXuJjJxOu7CHaF+OULmEL30DDhNWlGhAFlfMaxRM+nUItLZ3erP4OlemkrrkGcH/9Sur8yeH8N/Q4V7e07vTW6E2YaH06AzdlBta4a60QwzD36xUPZCmgR4jr7/QecMqT6XA6i/je4WvRvkhZLx49cmCP2opocDO4sIZJHF42THpHTknmKfj8lb/iWxNWVMGlbAH0xN+Bj1GmO455P3MWsdJ1DA==
Date: Thu, 13 Oct 2022 17:06:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y0gbVoeV/e6wzlbM@shredder>
References: <20221009174052.1927483-1-netdev@kapio-technology.com>
 <20221009174052.1927483-4-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009174052.1927483-4-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v7 net-next 3/9] net: switchdev: add support
 for offloading of the FDB locked flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Sun, Oct 09, 2022 at 07:40:46PM +0200, Hans J. Schultz wrote:
> Add support for offloading of the MAB/MacAuth feature flag and the FDB
> locked flag which is used by the Mac-Auth/MAB feature.
> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> ---
>  include/net/dsa.h         |  2 ++
>  include/net/switchdev.h   |  1 +
>  net/bridge/br.c           |  4 ++--
>  net/bridge/br_fdb.c       | 12 ++++++++++--
>  net/bridge/br_private.h   |  2 +-
>  net/bridge/br_switchdev.c |  3 ++-
>  net/dsa/dsa_priv.h        |  6 ++++--
>  net/dsa/port.c            | 10 ++++++----
>  net/dsa/slave.c           | 10 ++++++++--
>  net/dsa/switch.c          | 16 ++++++++--------
>  10 files changed, 44 insertions(+), 22 deletions(-)

There is more than one logical change here. I suggest splitting it to
make review easier:

1. A patch allowing the bridge driver to install locked entries notified
from device drivers. These changes:

include/net/switchdev.h   |  1 +
net/bridge/br.c           |  4 ++--
net/bridge/br_fdb.c       | 12 ++++++++++--
net/bridge/br_private.h   |  2 +-

And the br_switchdev_fdb_populate() hunk

2. A patch allowing DSA core to report locked entries to the bridge
driver

3. A patch adding the new MAB flag to BR_PORT_FLAGS_HW_OFFLOAD

4. A patch allowing DSA core to propagate the MAB flag to device drivers

[...]

> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index e4a0513816bb..eab32b7a945a 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@ -304,7 +304,7 @@ static int dsa_port_inherit_brport_flags(struct dsa_port *dp,
>  					 struct netlink_ext_ack *extack)
>  {
>  	const unsigned long mask = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
> -				   BR_BCAST_FLOOD | BR_PORT_LOCKED;
> +				   BR_BCAST_FLOOD;

Not sure how this is related to the patchset.

>  	struct net_device *brport_dev = dsa_port_to_bridge_port(dp);
>  	int flag, err;
