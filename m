Return-Path: <Horatiu.Vultur@microchip.com>
Date: Fri, 23 Aug 2019 14:26:58 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20190823122657.njk2tcgur2zu74i7@soft-dev3.microsemi.net>
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
	<1e16da88-08c5-abd5-0a3e-b8e6c3db134a@cumulusnetworks.com>
	<b2c52206-82d1-ef28-aeec-a5dcdbe9df6c@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <b2c52206-82d1-ef28-aeec-a5dcdbe9df6c@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH 0/3] Add NETIF_F_HW_BRIDGE feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: alexandre.belloni@bootlin.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, allan.nielsen@microchip.com, davem@davemloft.net

The 08/23/2019 01:26, Nikolay Aleksandrov wrote:
> External E-Mail
> 
> 
> On 8/23/19 1:09 AM, Nikolay Aleksandrov wrote:
> > On 22/08/2019 22:07, Horatiu Vultur wrote:
> >> Current implementation of the SW bridge is setting the interfaces in
> >> promisc mode when they are added to bridge if learning of the frames is
> >> enabled.
> >> In case of Ocelot which has HW capabilities to switch frames, it is not
> >> needed to set the ports in promisc mode because the HW already capable of
> >> doing that. Therefore add NETIF_F_HW_BRIDGE feature to indicate that the
> >> HW has bridge capabilities. Therefore the SW bridge doesn't need to set
> >> the ports in promisc mode to do the switching.
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
> 

Hi Nikolay,

> Just to clarify:
> > IMO the name is misleading.
> - that's not mandatory or anything, just saying people might get confused when they see it

Naming is hard, I properly need to go back and find a better name once
the patch is more mature and the problem/purpose is better understood.

But you are right, this is a bad name, I will find a better one.
> 
> > Why do the devices have to be from the same driver ?
After seeing yours and Andrews comments I realize that I try to do two
things, but I have only explained one of them.

Here is what I was trying to do:
A. Prevent ports from going into promisc mode, if it is not needed.
B. Prevent adding the CPU to the flood-mask (in Ocelot we have a
flood-mask controlling who should be included when flooding due to
destination unknown).

We have been thinking of these two as the same thing, but they are in
fact quite different. It is because of "B" we had to require all the
devices to be controlled by the same Switch.

For item "A" I do not think we need this restriction. In this patch we
will continue only focusing on item "A".

Sorry for the confusion. I will do a new patch that does not have this
restriction (which will also make it simpler).

It just needs to check for the flag NETIF_F_HW_BRIDGE and if it is not
set then set the port in promisc mode.

To solve item "B", the network driver needs to detect if there is a
foreign interfaces added to the bridge. If that is the case then to add
the CPU port to the flooding mask otherwise no. But this part will be in
a different patch series.

> > This is too specific targeting some devices.
Maybe I was wrong to mention specific HW in the commit message. The
purpose of the patch was to add an optimization (not to copy all the
frames to the CPU) for HW that is capable of learning and flooding the
frames.

I would expect that most switching HW would benefit from this.

> > The bridge should not care what's the port device, it should be the other way
Not sure I understand how that could be done. Are you suggesting that
the flag belongs to another structure? If you have something specific in
mind, then please let us know.

> That was mostly a rhetorical question, it's obvious why but please add an explanation
> at least in the commit message and please fix the typos in the comment. Also HW
> is capable of doing switching, this needs some clarification that the whole process
> stays in HW IIUC. More details here would be great.

Yes, I will add more details in the commit message and in code.
> > around, so adding device-specific code to the bridge is not ok. Isn't there a solution
> > where you can use NETDEV_JOIN and handle it all from your driver ?
> > Would all HW-learned entries be hidden from user-space in this case ?

Yes, they would. But if the network driver will call
'call_switchdev_notifiers' with SWITCHDEV_FDB_ADD_TO_BRIDGE and
SWITCHDEV_FDB_DEL_TO_BRIDGE then the SW will see these entries.
> > 
> I.e. isn't there a way to do this without introducing a new feature flag ?
I do not have any better ideas.
>  
> 

-- 
/Horatiu
