From: jamal <hadi@cyberus.ca>
In-Reply-To: <C0170D0AF1277849A4B4518034F855DD0CFC39@aiexchange.ai.aiinet.com>
References: <C0170D0AF1277849A4B4518034F855DD0CFC39@aiexchange.ai.aiinet.com>
Content-Type: text/plain
Message-Id: <1091111561.1021.17.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] RE: [PATCH] (3/4) bridge linkstate handling
Reply-To: hadi@cyberus.ca
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Thu, 29 Jul 2004 14:32:55 -0000
To: "Eble, Dan" <DanE@aiinet.com>
Cc: netdev@oss.sgi.com, bridge@osdl.org, Stephen Hemminger <shemminger@osdl.org>

On Thu, 2004-07-29 at 09:24, Eble, Dan wrote:
> > > This makes bridge port status reflect both the
> > > state of the interface from software (up/down)
> > > and the carrier.  It makes STP handle link failure
> > > (cable breakage, etc).
> > 
> > nice. Does this entrench STP further in the kernel?
> > Still planning to move it out to user space?
> > 
> 
> Even if STP were implemented in user space, this part should be done in
> the kernel to make sure that there is no window of time for a packet to
> be received or transmitted after the link state changes.  Cable failure
> is not the worst problem here.  Imagine some dunce pulling out a cable,
> realizing he pulled the wrong one, and then plugging it back into the
> wrong port.  If he has created a loop in the network, even a single
> packet getting through can cause problems.

Your main problem there would be STP convergence time. Transfering the
packet to user space and reacting should be several factors of magnitude
faster than it takes STP to converge.
The STP state should stay in the kernel. Control of it and BPDU handling
is what i am suggesting to take out.

> One could be really paranoid and flush the hardware transmit queue too.
> Is there a way to do that for a port from the bridge driver?  (Or should
> the device drivers do that anyway after a link change?)

A admin down/up should help via utilities like ifconfig. You are right
though, there should be an optional scheme to flush the s/ware queues as
well reset the device tx DMAs on link down. Note emphasis on optional.

> Are there any ethernet controllers that can automatically disable tx/rx
> after a link change, requiring the driver to reenable them?  That would
> also be useful.

Havent heard of any; if any exist it should be optional. There could be
use to continue a transmit right after pluging a cable back. Think of a
single port TCP server.

In general i think link management would be safer to decouple. As it is
right now for capable drivers we have a multicast netlink msg being
sent; should be able to listen to that and do something with result.

cheers,
jamal

