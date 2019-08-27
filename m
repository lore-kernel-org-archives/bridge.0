Return-Path: <Horatiu.Vultur@microchip.com>
Date: Tue, 27 Aug 2019 12:10:34 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20190827101033.g2cb6j2j4kuyzh2a@soft-dev3.microsemi.net>
References: <1566807075-775-1-git-send-email-horatiu.vultur@microchip.com>
	<20190826123811.GA13411@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20190826123811.GA13411@lunn.ch>
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

The 08/26/2019 14:38, Andrew Lunn wrote:
> External E-Mail
> 
> 
> On Mon, Aug 26, 2019 at 10:11:12AM +0200, Horatiu Vultur wrote:
> > When a network port is added to a bridge then the port is added in
> > promisc mode. Some HW that has bridge capabilities(can learn, forward,
> > flood etc the frames) they are disabling promisc mode in the network
> > driver when the port is added to the SW bridge.
> > 
> > This patch adds the feature NETIF_F_HW_BR_CAP so that the network ports
> > that have this feature will not be set in promisc mode when they are
> > added to a SW bridge.
> > 
> > In this way the HW that has bridge capabilities don't need to send all the
> > traffic to the CPU and can also implement the promisc mode and toggle it
> > using the command 'ip link set dev swp promisc on'
> 
> Hi Horatiu

Hi Andrew,
> 
> I'm still not convinced this is needed. The model is, the hardware is
> there to accelerate what Linux can do in software. Any peculiarities
> of the accelerator should be hidden in the driver.  If the accelerator
> can do its job without needing promisc mode, do that in the driver.
Thanks for the model description. I will keep in my mind for the next
patches that I will do.
> 
> So you are trying to differentiate between promisc mode because the
> interface is a member of a bridge, and promisc mode because some
> application, like pcap, has asked for promisc mode.
> 
> dev->promiscuity is a counter. So what you can do it look at its
> value, and how the interface is being used. If the interface is not a
> member of a bridge, and the count > 0, enable promisc mode in the
> accelerator. If the interface is a member of a bridge, and the count >
> 1, enable promisc mode in the accelerator.
That sounds like a great idea. I was expecting to add this logic in the
set_rx_mode function of the driver. But unfortunetly, I got the calls to
this function before the dev->promiscuity is updated or not to get the
call at all. For example in case the port is member of a bridge and I try
to enable the promisc mode.

> 
>    Andrew
> 
> 

-- 
/Horatiu
