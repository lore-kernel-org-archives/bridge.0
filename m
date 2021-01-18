Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1611001241; x=1642537241;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3vkIEGQPFf489pGA8tP/HOKmNsBhghNgESRdR43Dvi4=;
 b=ltm0b5hJJqB+jvaPJ4OyzJwQUn+eh0iA5om8R3+TeiWpAnyKLQl5vbIF
 ERw44p1qfD54+mHiqaxYz4tlzridoc6S3S8/6OurvKHYztTIKaVyzqZd2
 6OHTFjNkpuoCQn1H6KG6ooVTYn4dGiS3mwl+AtzO+4kl2fFQWlrPePYQx
 XsSag0we0kZ42BZSKsRCnvz0KFaOgOHCowHERBPGbm53FqRdxdjaDdRqa
 1rDxkNwtYvizlxdUfJE9qRa/7/mM/72O0Yba6fA+KR//O3VCZYK8pTIpu
 +SE1lAnnJr3rurj06YAcGf3NEWRqU/druF9yQavwXj+i0/ojAeRYTh/aH w==;
Date: Mon, 18 Jan 2021 21:20:36 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20210118202036.wk2fuwa3hysg4dmj@soft-dev3.localdomain>
References: <20210118181319.25419-1-rasmus.villemoes@prevas.dk>
 <20210118185618.75h45rjf6qqberic@soft-dev3.localdomain>
 <20210118194632.zn5yucjfibguemjq@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210118194632.zn5yucjfibguemjq@skbuf>
Subject: Re: [Bridge] [PATCH net] net: mrp: use stp state as substitute for
 unimplemented mrp state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

The 01/18/2021 19:46, Vladimir Oltean wrote:
> 
> On Mon, Jan 18, 2021 at 07:56:18PM +0100, Horatiu Vultur wrote:
> > The reason was to stay away from STP, because you can't run these two
> > protocols at the same time. Even though in SW, we reuse port's state.
> > In our driver(which is not upstreamed), we currently implement
> > SWITCHDEV_ATTR_ID_MRP_PORT_STATE and just call the
> > SWITCHDEV_ATTR_ID_PORT_STP_STATE.
> 
> And isn't Rasmus's approach reasonable, in that it allows unmodified
> switchdev drivers to offload MRP port states without creating
> unnecessary code churn?

I am sorry but I don't see this as the correct solution. In my opinion,
I would prefer to have 3 extra lines in the driver and have a better
view of what is happening. Than having 2 calls in the driver for
different protocols.
If it is not a problem to have STP calls when you configure the MRP,
then why not just remove SWITCHDEV_ATTR_ID_MRP_PORT_STATE?

> 
> Also, if it has no in-kernel users, why does it even exist as a
> switchdev attribute?

-- 
/Horatiu
