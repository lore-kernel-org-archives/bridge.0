From: Ross Vandegrift <ross@kallisti.us>
Date: Wed, 10 Jun 2009 12:27:52 -0400
Message-ID: <20090610162752.GB24563@kallisti.us>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
Subject: Re: [Bridge] RFC: Simple Private VLAN impl.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

On Wed, Jun 10, 2009 at 05:32:06PM +0200, Joakim Tjernlund wrote:
> I am not sure this is so special anymore. I know that this
> adds "support burden" but so does a lot of stuff in the kernel.

Private VLANs are additional restrictions on a bridge's filtering
database.  No kernel support is required because Linux (via ebtables)
has a much more generic way to affect the filtering of frames.

> Have anybody managed to do Private VLAN with several switches by
> just using ebtables? Seems like most people here thinks that
> ebtables is the right tool but none has provided any examples
> on how to do it so I am starting to think that noone is so the
> claim to just use ebtables might be false.

I don't have a Linux machine with enough interfaces to build a
meaningful private VLAN config, but I can step you though a simple
conceptual explanation.

One very common installation I can think of - a single router
provides service to many clients in the same VLAN which must be
isolated.  Say the router is using eth0 and the clients are on
eth1-ethX.

Then what you want to do looks something like the following:

0) Deny all frames not explicitly permitted:
ebtables -P FORWARD DENY

1) Permit any frames with ingress eth0:
ebtables -A FORWARD -i eth0 -j ACCEPT
	
2) Permit any frames with egress interface eth0.
ebtables -A FORWARD -o eth0 -j ACCEPT


Think about ebtables as a low-level way to specify policy for the
handling of frames, much in the same way that iptables is a low-level
way to specify policy for IP packets.

In both cases, the tools operate only in very small ways, but the
advantage is that they are super-flexible in that they can handle very
complicated or bizarre scenarios.

For example, suppose that you want to permit eth1-ethX to participate
in the multicast group 01:02:03:04:05:06:
ebtables -A FORWARD -i ! eth0 -o ! eth0 -d 01:02:03:04:05:06 -j ACCEPT

Or now you want to permit eth1-ethX to have full access, but only for IPX:
ebtables -A FORWARD -i ! eth0 -o ! eth0 -p 8137 -j ACCEPT

Read the ebtables(8) manpage - you can do many more things than
private VLANs!

-- 
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie
