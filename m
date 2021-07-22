Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=afOvuUyBtr0TcfV4r0srwkaU5LgoOmO/9k1OVhh31NA=;
 b=IKJeTWz7Vmxsx1FNzDXy6kpE4AcTEd5Av3k4N9Baj2+zCCAggYkTbG3sn2SDSDNk89
 SIAlVBH1nEznIXWHIudE1+lGEexleYp+l7VAkdep+SVBvfS1GMRvw0xmsdFB59honDoD
 7Hli0D20PwabYnP+SiT4ri7UJd/5I26cT+ZYc0B4/kWy3LRYo/mwixHogiNE4GJQrgy5
 jEabIpz5wMq5Mx4QrLEJXp42HnOZ+N31yfYYq5b6aDk8ncLCWT5DMvJo2qSifxA/1Wq9
 HmdB0Uq5M7+j8IzW36alw3+/0uhbmSwOplVd2UQa0pSxdTN1fO83Uet/4SuKmAT2Wg2A
 J6GA==
Date: Thu, 22 Jul 2021 12:50:49 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210722095049.pym33fyuyu5b4gfs@skbuf>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
 <20210712174059.7916c0da@thinkpad>
 <20210712170120.xo34ztomimq5oqdg@skbuf>
 <20210712192711.126f2b35@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712192711.126f2b35@thinkpad>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Jul 12, 2021 at 07:27:11PM +0200, Marek Behun wrote:
> Hi Vladimir,
> 
> On Mon, 12 Jul 2021 17:01:21 +0000
> Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> 
> > Hi Marek,
> > 
> > On Mon, Jul 12, 2021 at 05:40:59PM +0200, Marek Behun wrote:
> > > Vladimir, on what mv88e6xxx devices are you developing this stuff?
> > > Do you use Turris MOX for this?  
> > 
> > I didn't develop the Marvell stuff nor did I come up with the idea
> > there, Tobias did. I also am not particularly interested in supporting
> > this for Marvell beyond making sure that the patches look simple and
> > okay, and pave the way for other drivers to do the same thing.
> > 
> > I did my testing using a different DSA driver and extra patches which
> > I did not post here yet. I just reposted/adapted Tobias' work because
> > mv88e6xxx needs less work to support the TX data plane offload, and this
> > framework does need a first user to get accepted, so why delay it any
> > further if mv88e6xxx needs 2 patches whereas other drivers need 30.
> > 
> > I did use the MOX for some minimal testing however, at least as far as
> > I could - there is this COMPHY SERDES bug in the bootloader which makes
> > the board fail to boot, and now the device tree workaround you gave me
> > does not appear to bypass the issue any longer or I didn't reaply it
> > properly.
> 
> Sorry about that. Current upstream U-Boot solves this issue, but we did
> not release official update yet because there are still some things that
> need to be done. We have some RCs, though.
> 
> If you are interested, it is pretty easy to upgrade:
> - MTD partition "secure-firmware" needs to be flashed with
>     https://gitlab.nic.cz/turris/mox-boot-builder/uploads/8d5a17fae8f6e14ca11968ee5174c7ca/trusted-secure-firmware.bin
>   (this file needs to be signed by CZ.NIC)
> - MTD partition "a53-firmware" (or "u-boot" in older DTS) needs to be
>   flashed with
>     https://secure.nic.cz/files/mbehun/a53-firmware.bin
>   (this file can be built by users themselves)

Thanks. This worked in the sense that I could flash the trust zone
firmware and U-Boot, and net-next will boot without hanging, but now the
board is in a boot loop, due to what appears to be watchdog timer
expiration. This happens regardless of whether CONFIG_ARMADA_37XX_WATCHDOG
is set to y or n in the booted kernel.
