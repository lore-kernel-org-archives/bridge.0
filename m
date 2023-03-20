Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CF53402F3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D45BF402F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsCixfMvDvtbjXK/kO1X/b/nCoYkaVxteCqzE2UcyKY=;
 b=tOnjUMSTHZDd3C9zm+601LiTuk6gIc45DHkHLhRS8r0ZE9dCQeKjnHErihVyQUkF6vHgc1duQVaXffNCAcbm83f5Vq6S1LnU8esejZ2mYC/I3+8R8g4tfAuRuiReui/rewZ/tOcR5FtiU7r7a64YrFVyzhYWvXGX7afNp395GnGGfwk1WEj4pKmrUBWZ1x6gd1lHHDKBGi85EW8twOZT6IWTsEvlqjPKXF++OBWBTUv85xSU3WL6/w0EbajBXoAK3rgq2xycIbp7zh2PNKVR7KyJGM+ZJyreQo5txvOG+gvCWs2KwSwia+DRHaSDoqGCbQ7jFkof4nsBDaOZvrCgug==
Date: Mon, 20 Mar 2023 10:48:22 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZBgd1mgO36umXqoj@shredder>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-2-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318141010.513424-2-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v2 net-next 1/6] net: bridge: add dynamic flag
 to switchdev notifier
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Sat, Mar 18, 2023 at 03:10:05PM +0100, Hans J. Schultz wrote:
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
> index de18e9c1d7a7..9707d3fdb396 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -134,6 +134,7 @@ static void br_switchdev_fdb_populate(struct net_bridge *br,
>  	item->added_by_user = test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
>  	item->offloaded = test_bit(BR_FDB_OFFLOADED, &fdb->flags);
>  	item->is_local = test_bit(BR_FDB_LOCAL, &fdb->flags);
> +	item->is_dyn = !test_bit(BR_FDB_STATIC, &fdb->flags);

I was under the impression that the consensus was to rename this to
'is_static' so that it is consistent with other flags.

>  	item->locked = false;
>  	item->info.dev = (!p || item->is_local) ? br->dev : p->dev;
>  	item->info.ctx = ctx;
> -- 
> 2.34.1
> 
