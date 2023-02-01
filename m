Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 679DE40A95
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 88E0B403EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1675275016; x=1675361416; bh=wZVarq9wJ5kZO9X2EgYSaB6n3mMF
 V5UjT+9T/Nr3jsU=; b=Td6xyFKYYh4elevf9+Mw/pA8go+44leCjtjeWZklrO1+
 4BrZXCstdlGJDdZu/SAeJh3nbzrXAnBKx0YT39lLJj2+L6yc5xAGQPpk+9idNTiv
 5Qw7hx1DILUzjA1W8Ei0jI3Ckam/V4Vua82q+qedXNCvYKRnKSMqLiaZmD+PkRp6
 5pCpGZJ55AzYnrCvwBdZsla4sekjsutMsCgCbpp97fXzImo9trUHzk2nHW8ejqjR
 XIiqWxpIFWSwhsjwi/a7XoOi3GItxG7x30lq8WRXm1sOeu//YH5nZOpzHmjm+ZTS
 EeNYIQ/3dvjqmEDln+fmhLFu+lpYH4nINVYayVzl4Q==
Date: Wed, 1 Feb 2023 20:10:10 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <Y9qrAup9Xt/ZDEG0@shredder>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <20230130173429.3577450-2-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130173429.3577450-2-netdev@kapio-technology.com>
Subject: Re: [Bridge] [PATCH net-next 1/5] net: bridge: add dynamic flag to
 switchdev notifier
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Mon, Jan 30, 2023 at 06:34:25PM +0100, Hans J. Schultz wrote:
> To be able to add dynamic FDB entries to drivers from userspace, the
> dynamic flag must be added when sending RTM_NEWNEIGH events down.
> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> ---
>  include/net/switchdev.h   | 1 +
>  net/bridge/br_switchdev.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index ca0312b78294..aaf918d4ba67 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -249,6 +249,7 @@ struct switchdev_notifier_fdb_info {
>  	u8 added_by_user:1,
>  	   is_local:1,
>  	   locked:1,
> +	   is_dyn:1,
>  	   offloaded:1;
>  };
>  
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 7eb6fd5bb917..4420fcbbfdb2 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -136,6 +136,8 @@ static void br_switchdev_fdb_populate(struct net_bridge *br,
>  	item->added_by_user = test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
>  	item->offloaded = test_bit(BR_FDB_OFFLOADED, &fdb->flags);
>  	item->is_local = test_bit(BR_FDB_LOCAL, &fdb->flags);
> +	item->is_dyn = !test_bit(BR_FDB_STATIC, &fdb->flags) &&

Why not 'is_static' and be consistent with the bridge flag like all the
other fields?

Regardless of how you name this field, it is irrelevant for
'SWITCHDEV_FDB_ADD_TO_BRIDGE' notifications that all add FDB entries
with the 'BR_FDB_ADDED_BY_EXT_LEARN' flag set, which makes
'BR_FDB_STATIC' irrelevant.

> +		item->added_by_user;

Unclear why this is needed...

>  	item->locked = false;
>  	item->info.dev = (!p || item->is_local) ? br->dev : p->dev;
>  	item->info.ctx = ctx;
> -- 
> 2.34.1
> 
