Return-Path: <Horatiu.Vultur@microchip.com>
Date: Sun, 25 Aug 2019 18:30:25 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20190825163023.hkc23lv7b5vvphdb@soft-dev3.microsemi.net>
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
	<e47a318c-6446-71cd-660c-8592037d8166@gmail.com>
	<20190824074204.GA15041@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20190824074204.GA15041@nanopsycho.orion>
Subject: Re: [Bridge] [PATCH 0/3] Add NETIF_F_HW_BRIDGE feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: alexandre.belloni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, allan.nielsen@microchip.com, davem@davemloft.net

The 08/24/2019 09:42, Jiri Pirko wrote:
> External E-Mail
> 
> 
> Sat, Aug 24, 2019 at 01:25:02AM CEST, f.fainelli@gmail.com wrote:
> >On 8/22/19 12:07 PM, Horatiu Vultur wrote:
> >> Current implementation of the SW bridge is setting the interfaces in
> >> promisc mode when they are added to bridge if learning of the frames is
> >> enabled.
> >> In case of Ocelot which has HW capabilities to switch frames, it is not
> >> needed to set the ports in promisc mode because the HW already capable of
> >> doing that. Therefore add NETIF_F_HW_BRIDGE feature to indicate that the
> >> HW has bridge capabilities. Therefore the SW bridge doesn't need to set
> >> the ports in promisc mode to do the switching.
> >
> >Then do not do anything when the ndo_set_rx_mode() for the ocelot
> >network device is called and indicates that IFF_PROMISC is set and that
> >your network port is a bridge port member. That is what mlxsw does AFAICT.

Yes, but then if you want to monitor all the traffic on a bridge port
you will not be able to do that. And this seems to be a limitation.
This is the case for mlxsw and ocelot(it doesn't implement at all
promisc mode) and might be others.

> 
> Correct.
> 
> >
> >As other pointed out, the Linux bridge implements a software bridge by
> >default, and because it needs to operate on a wide variety of network
> >devices, all with different capabilities, the easiest way to make sure
> >that all management (IGMP, BPDU, etc. ) as well as non-management
> >traffic can make it to the bridge ports, is to put the network devices
> >in promiscuous mode.

What if the HW can copy all the management traffic to the SW bridge and
HW knows to learn and flood frames. Then there is no point to set a
network port in promisc mode just because it is a bridge port member.
> >If this is suboptimal for you, you can take
> >shortcuts in your driver that do not hinder the overall functionality.

If I add this check, I don't see how any other network drivers will be
affected by this. If a network driver will start to use this then it
needs to know that the HW should be configure to include CPU in the
flood mask and to know which addresses can be reached through SW bridge.

> >
> >> This optimization takes places only if all the interfaces that are part
> >> of the bridge have this flag and have the same network driver.
> >> 
> >> If the bridge interfaces is added in promisc mode then also the ports part
> >> of the bridge are set in promisc mode.
> >> 
> >> Horatiu Vultur (3):
> >>   net: Add HW_BRIDGE offload feature
> >>   net: mscc: Use NETIF_F_HW_BRIDGE
> >>   net: mscc: Implement promisc mode.
> >> 
> >>  drivers/net/ethernet/mscc/ocelot.c | 26 ++++++++++++++++++++++++--
> >>  include/linux/netdev_features.h    |  3 +++
> >>  net/bridge/br_if.c                 | 29 ++++++++++++++++++++++++++++-
> >>  net/core/ethtool.c                 |  1 +
> >>  4 files changed, 56 insertions(+), 3 deletions(-)
> >> 
> >
> >
> >-- 
> >Florian
> 

-- 
/Horatiu
