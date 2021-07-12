Return-Path: <kabel@blackhole.sk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blackhole.sk;
 s=mail; t=1626110835;
 bh=1Z+7eKuQGefXsiLmO54SfAanWObwQV+Nmi5tV4R3u7o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=M1B/1GM91bA66bvkS5pB9vyTSJM2mE6+CKSdJq0ZKYfGSaXIWZxsg+Mf71uN6aUmq
 DorGBzhYUzlU/b8kw5102jFwR2MGv3BGVK+9ADN/zjEJgBWbZjGt/rV0XHcNB76QFe
 n+wqu3Ft2GrNYEzUTu1R/lD7ZkQVRmvSF0TJT9Co=
Date: Mon, 12 Jul 2021 19:27:11 +0200
From: Marek Behun <kabel@blackhole.sk>
Message-ID: <20210712192711.126f2b35@thinkpad>
In-Reply-To: <20210712170120.xo34ztomimq5oqdg@skbuf>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
 <20210712174059.7916c0da@thinkpad>
 <20210712170120.xo34ztomimq5oqdg@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

Hi Vladimir,

On Mon, 12 Jul 2021 17:01:21 +0000
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> Hi Marek,
> 
> On Mon, Jul 12, 2021 at 05:40:59PM +0200, Marek Behun wrote:
> > Vladimir, on what mv88e6xxx devices are you developing this stuff?
> > Do you use Turris MOX for this?  
> 
> I didn't develop the Marvell stuff nor did I come up with the idea
> there, Tobias did. I also am not particularly interested in supporting
> this for Marvell beyond making sure that the patches look simple and
> okay, and pave the way for other drivers to do the same thing.
> 
> I did my testing using a different DSA driver and extra patches which
> I did not post here yet. I just reposted/adapted Tobias' work because
> mv88e6xxx needs less work to support the TX data plane offload, and this
> framework does need a first user to get accepted, so why delay it any
> further if mv88e6xxx needs 2 patches whereas other drivers need 30.
> 
> I did use the MOX for some minimal testing however, at least as far as
> I could - there is this COMPHY SERDES bug in the bootloader which makes
> the board fail to boot, and now the device tree workaround you gave me
> does not appear to bypass the issue any longer or I didn't reaply it
> properly.

Sorry about that. Current upstream U-Boot solves this issue, but we did
not release official update yet because there are still some things that
need to be done. We have some RCs, though.

If you are interested, it is pretty easy to upgrade:
- MTD partition "secure-firmware" needs to be flashed with
    https://gitlab.nic.cz/turris/mox-boot-builder/uploads/8d5a17fae8f6e14ca11968ee5174c7ca/trusted-secure-firmware.bin
  (this file needs to be signed by CZ.NIC)
- MTD partition "a53-firmware" (or "u-boot" in older DTS) needs to be
  flashed with
    https://secure.nic.cz/files/mbehun/a53-firmware.bin
  (this file can be built by users themselves)

> The point is that it isn't as easy as I would have liked to
> use the MOX for testing. I was able to validate the "net: dsa: track the
> number of switches in a tree" patch on MOX, though, since DSA probes
> earlier than xhci, and even though the boot hung, I did put some prints
> and got the expected results.

I will try to do some tests with this patch series.

Marek
