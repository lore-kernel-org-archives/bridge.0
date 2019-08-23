Return-Path: <Horatiu.Vultur@microchip.com>
Date: Fri, 23 Aug 2019 14:39:30 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20190823123929.ta4ikozz7jwkwbo2@soft-dev3.microsemi.net>
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
	<1566500850-6247-2-git-send-email-horatiu.vultur@microchip.com>
	<20190822200817.GD21295@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20190822200817.GD21295@lunn.ch>
Subject: Re: [Bridge] [PATCH 1/3] net: Add HW_BRIDGE offload feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: alexandre.belloni@bootlin.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, allan.nielsen@microchip.com, davem@davemloft.net

The 08/22/2019 22:08, Andrew Lunn wrote:
> External E-Mail
> 
> 
> > +/* Determin if the SW bridge can be offloaded to HW. Return true if all
> > + * the interfaces of the bridge have the feature NETIF_F_HW_SWITCHDEV set
> > + * and have the same netdev_ops.
> > + */
> 
> Hi Horatiu
> 
> Why do you need these restrictions. The HW bridge should be able to
> learn that a destination MAC address can be reached via the SW
> bridge. The software bridge can then forward it out the correct
> interface.
> 
> Or are you saying your hardware cannot learn from frames which come
> from the CPU?
> 
> 	Andrew
> 
Hi Andrew,

I do not believe that our HW can learn from frames which comes from the
CPU, at least not in the way they are injected today. But in case of Ocelot
(and the next chip we are working on), we have other issues in mixing with
foreign interfaces which is why we have the check in
ocelot_netdevice_dev_check.

More important, as we responded to Nikolay, we properly introduced this
restriction for the wrong reasons.

In SW bridge I will remove all these restrictions and only set ports in
promisc mode only if NETIF_F_HW_BRIDGE is not set.
Then in the network driver I can see if a foreign interface is added to
the bridge, and when that happens I can set the port in promisc mode.
Then the frames will be flooded to the SW bridge which eventually will
send to the foreign interface.
-- 
/Horatiu
