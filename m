Date: Tue, 18 Mar 2008 04:38:32 +0000 (GMT)
From: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
In-Reply-To: <96CF49BD8B56384395D698BA99007FA32FA187@exchange.pacwire.local>
Message-ID: <alpine.DEB.1.00.0803180429340.21596@callisto.moose.malc.org.uk>
References: <96CF49BD8B56384395D698BA99007FA32FA187@exchange.pacwire.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Bridge] bridge, vlan and *no* stp/bpdu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jonathan Thibault <jonathan@navigue.com>, Leigh Sharpe <lsharpe@pacificwireless.com.au>
Cc: bridge@lists.osdl.org

At 13:38 today, Leigh Sharpe wrote:

> Brctl addbr br0
> Brctl addif br0 out
> Brctl addif br0 in.2
> ...
> Brctl addif br0 in.3

Another thing to bear in mind: many commodity VLAN-aware switches cannot 
cope with another device bridging frames between two VLANs, as their address 
databases store {MAC address, VLAN, port} and do not permit duplicate MAC 
addresses.  In my experience (of 3Com managed switches of various models) 
this manifests itself in all manner of bizaare and unexpected ways.  So if 
your "in" interface is connected to a managed switch, expect unpleasantness.

This is not (AFAICT) a bug with the Linux bridging driver, but a design 
limitation of such switches.

-- 
Malcolm Scott
Research Assistant
University of Cambridge Computer Laboratory

