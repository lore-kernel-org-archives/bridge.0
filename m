Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 29 Jul 2004 09:24:53 -0400
Message-ID: <C0170D0AF1277849A4B4518034F855DD0CFC39@aiexchange.ai.aiinet.com>
From: "Eble, Dan" <DanE@aiinet.com>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] RE: [PATCH] (3/4) bridge linkstate handling
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: hadi@cyberus.ca, Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@oss.sgi.com, bridge@osdl.org

> > This makes bridge port status reflect both the
> > state of the interface from software (up/down)
> > and the carrier.  It makes STP handle link failure
> > (cable breakage, etc).
> 
> nice. Does this entrench STP further in the kernel?
> Still planning to move it out to user space?
> 

Even if STP were implemented in user space, this part should be done in
the kernel to make sure that there is no window of time for a packet to
be received or transmitted after the link state changes.  Cable failure
is not the worst problem here.  Imagine some dunce pulling out a cable,
realizing he pulled the wrong one, and then plugging it back into the
wrong port.  If he has created a loop in the network, even a single
packet getting through can cause problems.

One could be really paranoid and flush the hardware transmit queue too.
Is there a way to do that for a port from the bridge driver?  (Or should
the device drivers do that anyway after a link change?)

Are there any ethernet controllers that can automatically disable tx/rx
after a link change, requiring the driver to reenable them?  That would
also be useful.

