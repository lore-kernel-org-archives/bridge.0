Return-Path: <simon.horman@corigine.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A59E81002
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 958E881000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHk3pMR+0Uj/ZMILRMhFD+mriNUTFOk1hGqQBC4zbQ0=;
 b=qafPc18dlr39oXm7P0pr1VDY2sX3trHfcDsKcXyWuWyj4Pu3kB7O1n0/cGCtsbx84sp1LjfN4Z+6/PsvktQifayK7EOgfGQBcOdn77UNpynXWWBCR0fk9v5f1d8F6KEwriZlRA47k7V+tOIfZ3rKDBV2+AGaXj57NjYilRZaa0E=
Date: Tue, 31 Jan 2023 19:56:30 +0100
From: Simon Horman <simon.horman@corigine.com>
Message-ID: <Y9lkXlyXg1d1D0j3@corigine.com>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <20230130173429.3577450-6-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130173429.3577450-6-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 5/5] net: dsa: mv88e6xxx:
 implementation of dynamic ATU entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Mon, Jan 30, 2023 at 06:34:29PM +0100, Hans J. Schultz wrote:
> For 802.1X or MAB security authed hosts we want to have these hosts authed
> by adding dynamic FDB entries, so that if an authed host goes silent for
> a time period it's FDB entry will be removed and it must reauth when
> wanting to communicate again.
> In the mv88e6xxx offloaded case, we can use the HoldAt1 feature, that
> gives an age out interrupt when the FDB entry is about to age out, so
> that userspace can be notified of the entry being deleted with the help
> of an SWITCHDEV_FDB_DEL_TO_BRIDGE event.
> When adding a dynamic entry the bridge must be informed that the driver
> takes care of the ageing be sending an SWITCHDEV_FDB_OFFLOADED event,
> telling the bridge that this added FDB entry will be handled by the
> driver.
> With this implementation, trace events for age out interrupts are also
> added.
> 
> note: A special case arises with the age out interrupt, as the entry
> state/spid (source port id) value read from the registers will be zero.
> Thus we need to extract the source port from the port vector instead.
> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c        | 18 ++++++--
>  drivers/net/dsa/mv88e6xxx/global1_atu.c | 21 +++++++++
>  drivers/net/dsa/mv88e6xxx/port.c        |  6 ++-
>  drivers/net/dsa/mv88e6xxx/switchdev.c   | 61 +++++++++++++++++++++++++
>  drivers/net/dsa/mv88e6xxx/switchdev.h   |  5 ++
>  drivers/net/dsa/mv88e6xxx/trace.h       |  5 ++
>  6 files changed, 110 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 61d5dc4680e3..a0007d96b2a3 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -42,6 +42,7 @@
>  #include "ptp.h"
>  #include "serdes.h"
>  #include "smi.h"
> +#include "switchdev.h"
>  
>  static void assert_reg_lock(struct mv88e6xxx_chip *chip)
>  {
> @@ -2726,18 +2727,25 @@ static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
>  				  const unsigned char *addr, u16 vid,
>  				  u16 fdb_flags, struct dsa_db db)
>  {
> +	bool is_dynamic = !!(fdb_flags & DSA_FDB_FLAG_DYNAMIC);
>  	struct mv88e6xxx_chip *chip = ds->priv;
> +	u8 state;
>  	int err;
>  
> -	/* Ignore entries with flags set */
> -	if (fdb_flags)
> -		return 0;
> +	state = MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC;
> +	if (is_dynamic)
> +		state = MV88E6XXX_G1_ATU_DATA_STATE_UC_AGE_7_NEWEST;

What if flags other than DSA_FDB_FLAG_DYNAMIC are set (in future)?

> +	else
> +		if (fdb_flags)

nit: else if (fdb_flags)

> +			return 0;
>  

...
