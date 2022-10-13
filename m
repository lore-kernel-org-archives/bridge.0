Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 210DB611A0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B4069606C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTOb6aZuMNrXGoFL+bY/yASFEjXcUko4NcXLXmZb7Qs=;
 b=aRHYCHQP8fbcbDi3lqpuj9Fb4gE9ffWyzE3CSAiPjKYHusPD2H6F0SpJIX+3Qi3aPy7b09jNL5tiPUYdfBl7qFnJmyOAnrmeAM2h9Jji+F8Aa75GfSzufRcIzY5RCUJphpEbmEQJ3hvad8HqZkitTlnE3GT4b4n3bnIH5qOEpQHoOjyfBW9EKprfmrn2eMXQjkIBGO8ThFummdndMxkU1NZobOI9ZBAFqU83peHYjcfnoP3Un3jHmlWNKusc9rbKiqmo6+XbHoOC4BwGVf9Jx/un11RhDKYAJPK+Qxp4I/eLhR5IfGqjksJgFRGhtVdGxS0awXtdtiY35k6aJXPUlg==
Date: Thu, 13 Oct 2022 15:41:15 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y0gHa99Z70TkKtR5@shredder>
References: <20221009174052.1927483-1-netdev@kapio-technology.com>
 <20221009174052.1927483-2-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009174052.1927483-2-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v7 net-next 1/9] net: bridge: add locked entry
 fdb flag to extend locked port feature
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

On Sun, Oct 09, 2022 at 07:40:44PM +0200, Hans J. Schultz wrote:
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 74864dc46a7e..8008ceb45605 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4035,6 +4035,7 @@ int ndo_dflt_fdb_add(struct ndmsg *ndm,
>  		     const unsigned char *addr, u16 vid,
>  		     u16 flags)
>  {
> +	__u32 ext_flags = 0;
>  	int err = -EINVAL;
>  
>  	/* If aging addresses are supported device will need to
> @@ -4050,6 +4051,14 @@ int ndo_dflt_fdb_add(struct ndmsg *ndm,
>  		return err;
>  	}
>  
> +	if (tb[NDA_FLAGS_EXT])
> +		ext_flags = nla_get_u32(tb[NDA_FLAGS_EXT]);
> +
> +	if (ext_flags & NTF_EXT_LOCKED) {
> +		netdev_info(dev, "invalid flags given to default FDB implementation\n");
> +		return err;
> +	}

I'm not sure it makes sense to deny specific flags in this case. It
might be better to just error out if NDA_FLAGS_EXT was specified.

> +
>  	if (is_unicast_ether_addr(addr) || is_link_local_ether_addr(addr))
>  		err = dev_uc_add_excl(dev, addr);
>  	else if (is_multicast_ether_addr(addr))
> -- 
> 2.34.1
> 
