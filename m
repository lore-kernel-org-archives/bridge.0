Return-Path: <leon@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602664421;
 bh=/dGk88bZs3Ic6n91kz7PXwwQ+Cneh7yiXetXdzrM3Qg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J0FGzleLohyyZw/qGL9hzcktx4vPA2EWddr7acwRoTbMHX+8V06iva4bmTnmgabb3
 xglAFl+u2v7dUp7UPNuw0WjK0WCknlx3tSoBiZBEutnjeNZ3fmjzId0zkemPtgwMYC
 95Feopd2RItcnVSgVJrneWxst3xYmbg6Il2pH7P4=
Date: Wed, 14 Oct 2020 11:33:36 +0300
From: Leon Romanovsky <leon@kernel.org>
Message-ID: <20201014083336.GH6305@unreal>
References: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
 <20201013173951.25677bcc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201014054250.GB6305@unreal>
 <3be8fd19-1c7e-0e05-6039-e5404b2682b9@gmail.com>
 <20201014075310.GG6305@unreal>
 <cb02626b-71bd-360d-c864-5dac2a1a7603@gmail.com>
 <fde05983ff9bc6584ad7ee5136b9f9f17902e600.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde05983ff9bc6584ad7ee5136b9f9f17902e600.camel@sipsolutions.net>
Subject: Re: [Bridge] [PATCH net-next v2 00/12] net: add and use function
 dev_fetch_sw_netstats for fetching pcpu_sw_netstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Sergey Matyukevich <geomatsi@gmail.com>, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, Pravin B Shelar <pshelar@ovn.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Igor Mitsyanko <imitsyanko@quantenna.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Kalle Valo <kvalo@codeaurora.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, linux-wireless <linux-wireless@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, David Miller <davem@davemloft.net>, =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Heiner Kallweit <hkallweit1@gmail.com>

On Wed, Oct 14, 2020 at 10:01:20AM +0200, Johannes Berg wrote:
> On Wed, 2020-10-14 at 09:59 +0200, Heiner Kallweit wrote:
> >
> > > Do you have a link? What is the benefit and how can we use it?
> > >
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1873080.html

So why is it usable?
The combination of Link, b4 and git range-diff gives everything in much
more reliable way.

>
> There was also a long discussion a year or so back, starting at
>
> http://lore.kernel.org/r/7b73e1b7-cc34-982d-2a9c-acf62b88da16@linuxfoundation.org

I participated in that discussion too :)

Thanks

>
> johannes
>
