Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 29 Jul 2004 11:11:02 -0400
Message-ID: <C0170D0AF1277849A4B4518034F855DD0CFC3A@aiexchange.ai.aiinet.com>
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
To: hadi@cyberus.ca
Cc: netdev@oss.sgi.com, bridge@osdl.org, Stephen Hemminger <shemminger@osdl.org>

> -----Original Message-----
> From: jamal [mailto:hadi@cyberus.ca] 
> 
> On Thu, 2004-07-29 at 09:24, Eble, Dan wrote:
> > Even if STP were implemented in user space, this part 
> should be done in
> > the kernel to make sure that there is no window of time for 
> a packet to
> > be received or transmitted after the link state changes.  
> 
> Your main problem there would be STP convergence time. Transfering the
> packet to user space and reacting should be several factors 
> of magnitude
> faster than it takes STP to converge.
> The STP state should stay in the kernel. Control of it and 
> BPDU handling
> is what i am suggesting to take out.

Is the time it takes STP to converge really the issue in this case?
When a port loses and then regains carrier, it needs to enter the
Blocking state without delay.  If the carrier state change were handled
by a daemon, the bridge driver would have some time to transmit or
receive packets via that port before the daemon could tell it to block
the port, wouldn't it?

