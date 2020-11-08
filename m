Return-Path: <arnd@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604824049;
 bh=T9rK7jzM4Uo8lISDVLvutAoFUbM+bhC60Dfzze4KpJ0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=HjG6ii8k7TFQjX7JNqHv2lOviskc+54D1iF0wnjynFrjUOv74BY09q9iKn9AiZ298
 OVL3Hn7g6gEiqpY3r32Y3Tf/SG+Z/yEIilaYUVAqwNSzoK28HX/cx5Yl23vSoreGLF
 ix9qGQ+vvFIMcSktEa4OIhiHn2alhbh3rIC5R02E=
MIME-Version: 1.0
References: <20201106221743.3271965-1-arnd@kernel.org>
 <20201107160612.2909063a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201107160612.2909063a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Sun, 8 Nov 2020 09:27:12 +0100
Message-ID: <CAK8P3a3ROYs1FADZw8he0sZwfuM=XCvkOpzK=GHO+URf4opeDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [RFC net-next 00/28] ndo_ioctl rework
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Networking <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, linux-wireless <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-hams@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Christoph Hellwig <hch@lst.de>, Heiner Kallweit <hkallweit1@gmail.com>

On Sun, Nov 8, 2020 at 1:06 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri,  6 Nov 2020 23:17:15 +0100 Arnd Bergmann wrote:
> > Any suggestions on how to proceed? I think the ndo_siocdevprivate
> > change is the most interesting here, and I would like to get
> > that merged.
>
> Splitting out / eliminating ioctl pass-thry in general seems like
> a nice clean up. How did you get the ndo_eth_ioctl patch done, was
> it manual work?

I had done a fairly detailed manual search through all drivers
with a .ndo_do_ioctl function to find the SIOCDEVPRIVATE users,
based on a simple shell script. After I had converted all of those,
I realized that 80% of the remaining ndo_do_ioctl users were
in drivers/net/ethernet, implementing the same five commands,
so I did a 'git grep -wl ndo_do_ioctl drivers/net/ethernet/ |
sed -i "s:ndo_do_ioctl:ndo_eth_ioctl"' and converted the rest
by hand.

FWIW, this is what remains afterwards:

$ git grep -w ndo_do_ioctl
Documentation/networking/netdevices.rst:ndo_do_ioctl:
drivers/char/pcmcia/synclink_cs.c:      .ndo_do_ioctl   = hdlcdev_ioctl,
drivers/net/appletalk/cops.c:        .ndo_do_ioctl           = cops_ioctl,
drivers/net/appletalk/ltpc.c:   .ndo_do_ioctl           = ltpc_ioctl,
drivers/net/bonding/bond_main.c:        .ndo_do_ioctl           = bond_do_ioctl,
drivers/net/wan/c101.c: .ndo_do_ioctl   = c101_ioctl,
drivers/net/wan/cosa.c: .ndo_do_ioctl   = cosa_net_ioctl,
drivers/net/wan/farsync.c:      .ndo_do_ioctl   = fst_ioctl,
drivers/net/wan/fsl_ucc_hdlc.c: .ndo_do_ioctl   = uhdlc_ioctl,
drivers/net/wan/hdlc_fr.c:      .ndo_do_ioctl   = pvc_ioctl,
drivers/net/wan/hostess_sv11.c: .ndo_do_ioctl   = hostess_ioctl,
drivers/net/wan/ixp4xx_hss.c:   .ndo_do_ioctl   = hss_hdlc_ioctl,
drivers/net/wan/lmc/lmc_main.c: .ndo_do_ioctl   = lmc_ioctl,
drivers/net/wan/n2.c:   .ndo_do_ioctl   = n2_ioctl,
drivers/net/wan/pc300too.c:     .ndo_do_ioctl   = pc300_ioctl,
drivers/net/wan/pci200syn.c:    .ndo_do_ioctl   = pci200_ioctl,
drivers/net/wan/sealevel.c:     .ndo_do_ioctl   = sealevel_ioctl,
drivers/net/wan/wanxl.c:        .ndo_do_ioctl   = wanxl_ioctl,
drivers/tty/synclink.c: .ndo_do_ioctl   = hdlcdev_ioctl,
drivers/tty/synclink_gt.c:      .ndo_do_ioctl   = hdlcdev_ioctl,
drivers/tty/synclinkmp.c:       .ndo_do_ioctl   = hdlcdev_ioctl,
include/linux/netdevice.h: * int (*ndo_do_ioctl)(struct net_device
*dev, struct ifreq *ifr, int cmd);
include/linux/netdevice.h:      int
(*ndo_do_ioctl)(struct net_device *dev,
net/appletalk/aarp.c:   if (!(ops->ndo_do_ioctl(iface->dev, &atreq,
SIOCSIFADDR))) {
net/appletalk/aarp.c:           ops->ndo_do_ioctl(iface->dev, &atreq,
SIOCGIFADDR);
net/bridge/br_device.c: .ndo_do_ioctl            = br_dev_ioctl,
net/core/dev_ioctl.c:   if (ops->ndo_do_ioctl) {
net/core/dev_ioctl.c:                   return ops->ndo_do_ioctl(dev, ifr, cmd);
net/ieee802154/socket.c:        if (dev->type == ARPHRD_IEEE802154 &&
dev->netdev_ops->ndo_do_ioctl)
net/ieee802154/socket.c:                ret =
dev->netdev_ops->ndo_do_ioctl(dev, &ifr, cmd);
net/mac802154/iface.c:  .ndo_do_ioctl           = mac802154_wpan_ioctl,

> > For the wireless drivers, removing the old drivers
> > instead of just the dead code might be an alternative, depending
> > on whether anyone thinks there might still be users.
>
> Dunno if you want to dig into removal with a series like this,
> anything using ioctls will be pretty old (with the exception
> of what you separated into ndo_eth_ioctl). You may get bogged
> down.

Ok

      Arnd
