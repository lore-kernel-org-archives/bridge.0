From: jamal <hadi@cyberus.ca>
In-Reply-To: <C0170D0AF1277849A4B4518034F855DD0CFC3A@aiexchange.ai.aiinet.com>
References: <C0170D0AF1277849A4B4518034F855DD0CFC3A@aiexchange.ai.aiinet.com>
Content-Type: text/plain
Message-Id: <1091116989.1033.53.camel@jzny.localdomain>
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
Date: Thu, 29 Jul 2004 16:03:20 -0000
To: "Eble, Dan" <DanE@aiinet.com>
Cc: netdev@oss.sgi.com, bridge@osdl.org, Stephen Hemminger <shemminger@osdl.org>

On Thu, 2004-07-29 at 11:11, Eble, Dan wrote:
> > -----Original Message-----
> > From: jamal [mailto:hadi@cyberus.ca] 

> > Your main problem there would be STP convergence time. Transfering the
> > packet to user space and reacting should be several factors 
> > of magnitude faster than it takes STP to converge.
> > The STP state should stay in the kernel. Control of it and 
> > BPDU handling is what i am suggesting to take out.
> 
> Is the time it takes STP to converge really the issue in this case?
> When a port loses and then regains carrier, it needs to enter the
> Blocking state without delay. 

I must have misunderstood Stevens patch then. Are you saying it opens a
port that was previously blocked because a link was reinserted?
Or the other way round: it would put a port that was previously blocked
into forwarding state because a previously forwarding link had a link
going down?
I think all this needs to be policy driven.

> If the carrier state change were handled
> by a daemon, the bridge driver would have some time to transmit or
> receive packets via that port before the daemon could tell it to block
> the port, wouldn't it?

Refer to my note above; opening or closing ports should be serialized
via user space. Let me clarify.

I think there are two issues at stake:
1) STP state - derived from the BPDUs. The state transition machinery
should run in kernel. The inteligence to transition the state machine
should reside in user space (call it control plane if it makes it more
palatable).

2) Other inputs like Links going up or down or VRRP state changes for HA
or somebody farting (pardon my language, just trying to drive a point)
also need to feed to the same policy decision making engine. The result
of the policy engine is a STP state transition for a port.

For the policy decision you need to make certain assumptions
about the STP topology i.e you need to have some knowledge of what
connects to you. Or you need to compute such things. 
All such decisions in my opinion belong to some policy decision engine
which should reside in user space.
CISCOs UplinkFast, portFast (assumes a end host connected to port),
RSTP, dynamic 802.1w or whatever new "innovation" comes up ends being
very easy to add.

cheers,
jamal

