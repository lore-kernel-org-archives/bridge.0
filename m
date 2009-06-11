From: Ross Vandegrift <ross@kallisti.us>
Date: Thu, 11 Jun 2009 10:22:51 -0400
Message-ID: <20090611142251.GB30941@kallisti.us>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
	<20090610162752.GB24563@kallisti.us>
	<OF4422F49E.33BDAF5C-ONC12575D1.005C802A-C12575D1.005E38A3@LocalDomain>
	<OF3035BFFB.A9837EFB-ONC12575D2.00451300-C12575D2.00468AB7@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3035BFFB.A9837EFB-ONC12575D2.00451300-C12575D2.00468AB7@transmode.se>
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

On Thu, Jun 11, 2009 at 02:50:30PM +0200, Joakim Tjernlund wrote:
> These are the rules i come up with when I have a bridge with four
> interfaces. Promisc, Isolated, Community and a Interswitch port.
> 
> The Interswitch port is modelled with 3 VLANs 4042, 4043 and 4044
> 
> #Static rules
> #.4042 = Promisc/primary VLAN
> #.4043 = Isolated VLAN
> #.4042 = Community VLAN
    ^^^^ I assume you mean 4044 here.

> #These VLANs represent the interswitch port
> 
> #Do not leak pkgs between the above VLANs
> ./ebtables -A FORWARD -i eth0.4042 -o eth0.4043 -j DROP
> ./ebtables -A FORWARD -i eth0.4042 -o eth0.4044 -j DROP
> ./ebtables -A FORWARD -i eth0.4043 -o eth0.4042 -j DROP
> ./ebtables -A FORWARD -i eth0.4043 -o eth0.4044 -j DROP
> ./ebtables -A FORWARD -i eth0.4044 -o eth0.4042 -j DROP
> ./ebtables -A FORWARD -i eth0.4044 -o eth0.4043 -j DROP
> 
> #Port rules
> 
> #Promisc Port, eth1.1
> ./ebtables -A FORWARD -i eth1.1 -o eth0.4043 -j DROP
> ./ebtables -A FORWARD -i eth1.1 -o eth0.4044 -j DROP

Makes sense.

> #Isolated Port, eth1.2
> ./ebtables -A FORWARD -i eth1.2 -o eth0.4043 -j ACCEPT

You may or may not mean this - depends on your goal.  You want to
support the case of an isolated port on bridge A talking to a
promiscuous port on bridge B?

> ./ebtables -A FORWARD -i eth1.2 -o eth1.1 -j ACCEPT
> ./ebtables -A FORWARD -i eth1.2 -j DROP
> ./ebtables -A FORWARD -o eth1.2 -i eth0.4042 -j ACCEPT
> ./ebtables -A FORWARD -o eth1.2 -i eth1.1 -j ACCEPT
> ./ebtables -A FORWARD -o eth1.2 -j DROP
> 
> #Community Port, eth1.3
> ./ebtables -A FORWARD -i eth1.3 -o eth0.4042 -j ACCEPT
> ./ebtables -A FORWARD -i eth1.3 -o eth0.4044 -j ACCEPT

You also want the community port to have access to the promiscuous
port locally:
./ebtables -A FORWARD -i eth1.3 -o eth1.1 -j ACCEPT

> ./ebtables -A FORWARD -i eth1.3 -j DROP
> ./ebtables -A FORWARD -o eth1.3 -i eth0.4042 -j ACCEPT
> ./ebtables -A FORWARD -o eth1.3 -i eth0.4044 -j ACCEPT
> ./ebtables -A FORWARD -o eth1.3 -i eth1.1 -j ACCEPT
> ./ebtables -A FORWARD -o eth1.3 -j DROP


> This is getting out of control. I was hoping there would be a simpler
> way to express the above. Adding ports or changing roles won't
> be funny.
> Anyone?

Not sure how you expected it to look.  To change the filtering
attributes of a bridge with n ports, you're going to need to have two
rules for each port-pair (one for each direction).  That's 2n^2 rules
in the worst case, and there isn't a way around that.

This is where the opportunity for some development and abstraction
comes in.  If I were you, I'd write a "port manager" script that let
me define port rules and roles in a much simpler language.  That
script would then output the required ebtables ruleset to acheive
that.

This is a central feature of netfilter stuff, by the way -
conceptually, it's very low-level.  It's kind of like an "assembly
language" for packet handling.  Search google and freahmeat for
iptables software - you'll find thousands of programs designed to make
the writing of large and complicated iptables rulesets easier.

I doubt such software exists for the creation of private VLANs via
ebtables.

-- 
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie
