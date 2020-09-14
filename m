Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <CAMuHMdUd4VtpOGr26KAmF22N32obNqQzq3tbcPxLJ7mxUtSyrg@mail.gmail.com>
 <20200911.174400.306709791543819081.davem@davemloft.net>
 <CAMuHMdW0agywTHr4bDO9f_xbQibCxDykdkcAmuRJQO90=E6-Zw@mail.gmail.com>
 <20200912.183437.1205152743307947529.davem@davemloft.net>
In-Reply-To: <20200912.183437.1205152743307947529.davem@davemloft.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Sep 2020 09:40:12 +0200
Message-ID: <CAMuHMdXGmKYKWtkFCV0WmYnY4Gn--Bbz-iSX76oc-UNNrzCMuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH] Revert "net: linkwatch: add check for
 netdevice being present to linkwatch_do_dev"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, netdev <netdev@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, bridge@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Gaku Inami <gaku.inami.xh@renesas.com>, Heiner Kallweit <hkallweit1@gmail.com>

Hi David,

CC bridge

On Sun, Sep 13, 2020 at 3:34 AM David Miller <davem@davemloft.net> wrote:
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Date: Sat, 12 Sep 2020 14:33:59 +0200
>
> > "dev" is not the bridge device, but the physical Ethernet interface, which
> > may already be suspended during s2ram.
>
> Hmmm, ok.
>
> Looking more deeply NETDEV_CHANGE causes br_port_carrier_check() to run which
> exits early if netif_running() is false, which is going to be true if
> netif_device_present() is false:
>
>         *notified = false;
>         if (!netif_running(br->dev))
>                 return;
>
> The only other work the bridge notifier does is:
>
>         if (event != NETDEV_UNREGISTER)
>                 br_vlan_port_event(p, event);
>
> and:
>
>         /* Events that may cause spanning tree to refresh */
>         if (!notified && (event == NETDEV_CHANGEADDR || event == NETDEV_UP ||
>                           event == NETDEV_CHANGE || event == NETDEV_DOWN))
>                 br_ifinfo_notify(RTM_NEWLINK, NULL, p);
>
> So some vlan stuff, and emitting a netlink message to any available
> listeners.
>
> Should we really do all of this for a device which is not even
> present?
>
> This whole situation seems completely illogical.  The device is
> useless, it logically has no link or other state that can be managed
> or used, while it is not present.
>
> So all of these bridge operations should only happen when the device
> transitions back to present again.

Thanks for your analysis!
I'd like to defer this to the bridge people (CC).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
