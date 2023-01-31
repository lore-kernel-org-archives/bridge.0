Return-Path: <simon.horman@corigine.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28F8060D5F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E2C4960D5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j58njQuoQwqmh6mKcmxIbKhNgIQ6/3Cj24dZVcX2u9Y=;
 b=ksv702ckHVR/g+jfPAitT8rjjewWgtRiuY6GU9eqHwPGEL84Z13gSPQEhl5Zkbx1PJAthEWf1OnFiMyksvQFM+GKHw599XDFoy67v6If6fRmctMnZ65Wii+N4SKb18IJQIIvxRiq76AIn5FeENXSeYi+cz9jKNVi0h43+u6cPhI=
Date: Tue, 31 Jan 2023 19:54:37 +0100
From: Simon Horman <simon.horman@corigine.com>
Message-ID: <Y9lj7RJgyMJfjtGp@corigine.com>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <20230130173429.3577450-4-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130173429.3577450-4-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 3/5] drivers: net: dsa: add fdb entry
 flags incoming to switchcore drivers
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

On Mon, Jan 30, 2023 at 06:34:27PM +0100, Hans J. Schultz wrote:
> Ignore FDB entries with set flags coming in on all switchcore drivers.
> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> ---
>  drivers/net/dsa/b53/b53_common.c       | 12 ++++++++++--
>  drivers/net/dsa/b53/b53_priv.h         |  4 ++--
>  drivers/net/dsa/hirschmann/hellcreek.c | 12 ++++++++++--
>  drivers/net/dsa/lan9303-core.c         | 12 ++++++++++--
>  drivers/net/dsa/lantiq_gswip.c         | 12 ++++++++++--
>  drivers/net/dsa/microchip/ksz9477.c    |  8 ++++----
>  drivers/net/dsa/microchip/ksz9477.h    |  8 ++++----
>  drivers/net/dsa/microchip/ksz_common.c | 14 +++++++++++---
>  drivers/net/dsa/mt7530.c               | 12 ++++++++++--
>  drivers/net/dsa/mv88e6xxx/chip.c       | 12 ++++++++++--
>  drivers/net/dsa/ocelot/felix.c         | 12 ++++++++++--
>  drivers/net/dsa/qca/qca8k-common.c     | 12 ++++++++++--
>  drivers/net/dsa/qca/qca8k.h            |  4 ++--
>  drivers/net/dsa/rzn1_a5psw.c           | 12 ++++++++++--
>  drivers/net/dsa/sja1105/sja1105_main.c | 19 ++++++++++++++-----
>  include/net/dsa.h                      |  4 ++--
>  net/dsa/switch.c                       | 12 ++++++++----
>  17 files changed, 137 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 59cdfc51ce06..cec60af6dfdc 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -1684,11 +1684,15 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
>  
>  int b53_fdb_add(struct dsa_switch *ds, int port,
>  		const unsigned char *addr, u16 vid,
> -		struct dsa_db db)
> +		u16 fdb_flags, struct dsa_db db)
>  {
>  	struct b53_device *priv = ds->priv;
>  	int ret;
>  
> +	/* Ignore entries with set flags */
> +	if (fdb_flags)
> +		return 0;


	Would returning -EOPNOTSUPP be more appropriate?

...
