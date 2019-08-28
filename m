Return-Path: <Horatiu.Vultur@microchip.com>
Date: Wed, 28 Aug 2019 23:53:04 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20190828215302.6i5mezmtnv57m2vy@soft-dev3.microsemi.net>
References: <1566807075-775-1-git-send-email-horatiu.vultur@microchip.com>
	<20190826123811.GA13411@lunn.ch>
	<20190827101033.g2cb6j2j4kuyzh2a@soft-dev3.microsemi.net>
	<20190827131824.GC11471@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20190827131824.GC11471@lunn.ch>
Subject: Re: [Bridge] [PATCH v2 0/3] Add NETIF_F_HW_BR_CAP feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: alexandre.belloni@bootlin.com, f.fainelli@gmail.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, allan.nielsen@microchip.com, davem@davemloft.net

The 08/27/2019 15:18, Andrew Lunn wrote:
> External E-Mail
> 
> 
> > That sounds like a great idea. I was expecting to add this logic in the
> > set_rx_mode function of the driver. But unfortunetly, I got the calls to
> > this function before the dev->promiscuity is updated or not to get the
> > call at all. For example in case the port is member of a bridge and I try
> > to enable the promisc mode.
> 
> Hi Horatiu

Hi Andrew,
> 
> What about the notifier? Is it called in all the conditions you need
> to know about?

I had a look also over this but without any luck. I can get good
information from this, like knowing when a port is added or removed from
the bridge(NETDEV_CHANGEUPPER). But not in case the promisc is change by
an application(eg. tcpdump). In this case if port is part of the bridge
and then promisc is enable, then there is no callback to the driver or
any notifications.
> 
> Or, you could consider adding a new switchdev call to pass this
> information to any switchdev driver which is interested in the
> information.

Having this new switchdev call and listening for NETDEV_CHANGEUPPER
seems to be enough to know when a port needs to go in promisc mode.
> 
> At the moment, the DSA driver core does not pass onto the driver it
> should put a port into promisc mode. So pcap etc, will only see
> traffic directed to the CPU, not all the traffic ingressing the
> interface. If you put the needed core infrastructure into place, we
> could plumb it down from the DSA core to DSA drivers.
> 
> Having said that, i don't actually know if the Marvell switches
> support this. Forward using the ATU and send a copy to the CPU?  What
> switches tend to support is port mirroring, sending all the traffic
> out another port. A couple of DSA drivers support that, via TC.
> 
> 	Andrew
> 

-- 
/Horatiu
