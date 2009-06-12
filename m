From: Ross Vandegrift <ross@kallisti.us>
Date: Thu, 11 Jun 2009 23:56:26 -0400
Message-ID: <20090612035626.GA4402@kallisti.us>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
	<de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
	<20090611235845.GB3432@kallisti.us>
	<de7adc5e0906111715s56f13ad0o760840dfadba797@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de7adc5e0906111715s56f13ad0o760840dfadba797@mail.gmail.com>
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

On Thu, Jun 11, 2009 at 06:15:46PM -0600, Daniel Robbins wrote:
> In my particular configuration, there are no communities - each VE is an
> island, and will only be able to communicate with the network gateway (which
> is non-local, ie. not on the linux bridge itself.) That should lock down
> layer 2. With OpenVZ, each VE's MAC will have a common SWSoft 00:18:51
> prefix.
> 
> After I get that working, I need to lock down layer 3 with iptables, so the
> PVLAN functionality can't be bypassed.
> 
> If you have any configuration examples for ebtables, especially simple ones,
> I would welcome them :)

Couldn't be simpler in that case.  Say you've bridged veth1.0 through
venet10.0 and venet1.0 is the interface of the gateway.  Then, all you
need is:

ebtables -A FORWARD -i veth1.0 -j ACCEPT
ebtables -A FORWARD -o veth1.0 -j ACCEPT

If you spin up VEID 11, give it a virtual ethernet NIC, and add the
associated veth device on the hardware node to the bridge - you're
good to go.

Of course veth1.0 could just as easily be a physical interface
connected to another device.

-- 
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie
