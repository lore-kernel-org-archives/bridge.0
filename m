From: Ross Vandegrift <ross@kallisti.us>
Date: Thu, 11 Jun 2009 19:58:45 -0400
Message-ID: <20090611235845.GB3432@kallisti.us>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
	<de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
Subject: Re: [Bridge] RFC: Simple Private VLAN impl.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Daniel Robbins <drobbins@funtoo.org>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, Joakim Tjernlund <joakim.tjernlund@transmode.se>

On Thu, Jun 11, 2009 at 01:51:06PM -0600, Daniel Robbins wrote:
> I do think that having the bridge code do PVLANs could end up being better.
> In particular, I think this could be *very* useful for virtualization, where
> you are adding/removing interfaces from the bridge often. Why? Because it
> eliminates the need to dynamically create/remove ebtables rules and keep
> them in sync with the interfaces on the bridge.

In the virtualization case, I think it's actually easier: do it via
MAC addresses instead of interfaces.  In this case, since you're
creating the virtual environments, you'll know the MAC address that
gets generated for each VE.

1) Set your policy to deny.
2) Permit all frames destined to/from the promiscuous MACs.
3) Permit all broadcast frames to the promiscuous MACs.

That takes care of the "isolated" use case.  If you need to support
the "community" case:
4) Add pairwise bidirectional rules to permit communications between
each MAC in a community. 

Why is this easier?  Since you know the MACs of the VEs, you have a
trivial way of identifying the rules associated with a VE.  This way,
you know what rules to spin up and remove during the turnup or
disabling of a VE.  Moreover, since all of the rules permit specific
traffic, the order doesn't even matter.

There's two obvious cases where this won't scale:

1) Many VEs on a single host where the VEs form a complicated routing
heirarchy.  In this case, you'll have a rat's nest of MAC rules.  But
I'd say in this case a private VLAN solution was a bad design choice.

2) Many VEs in many communities spread across many hosts.  For
example, it might get bad if you had 5 communities across 100 hosts,
with each community having 100 VEs.  This would mean each host needs
a full set of 10000 MAC rules for each community - 50000 ebtables
rules.  In this case, I'd again prefer a routed design (well, any case
actually...) and if a common "community" LAN was a software
requirement, I'd use multipoint GRE or L2TP.

But for one node with a bunch of unrelated VEs, this is very little
work to maintain.

Ross

-- 
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie
