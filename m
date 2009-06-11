In-Reply-To: <OF4422F49E.33BDAF5C-ONC12575D1.005C802A-C12575D1.005E38A3@LocalDomain>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
	<20090610162752.GB24563@kallisti.us>
	<OF4422F49E.33BDAF5C-ONC12575D1.005C802A-C12575D1.005E38A3@LocalDomain>
Message-ID: <OF3035BFFB.A9837EFB-ONC12575D2.00451300-C12575D2.00468AB7@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 11 Jun 2009 14:50:30 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] RFC: Simple Private VLAN impl.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

Joakim Tjernlund/Transmode wrote on 10/06/2009 19:09:09:
>
> Ross Vandegrift <ross@kallisti.us> wrote on 10/06/2009 18:27:52:
> >
> > On Wed, Jun 10, 2009 at 05:32:06PM +0200, Joakim Tjernlund wrote:
> > > I am not sure this is so special anymore. I know that this
> > > adds "support burden" but so does a lot of stuff in the kernel.
> >
> > Private VLANs are additional restrictions on a bridge's filtering
> > database.  No kernel support is required because Linux (via ebtables)
> > has a much more generic way to affect the filtering of frames.
>
> hmm, yes I am starting to get a grip on this now.
> >
> > > Have anybody managed to do Private VLAN with several switches by
> > > just using ebtables? Seems like most people here thinks that
> > > ebtables is the right tool but none has provided any examples
> > > on how to do it so I am starting to think that noone is so the
> > > claim to just use ebtables might be false.
> >
> > I don't have a Linux machine with enough interfaces to build a
> > meaningful private VLAN config, but I can step you though a simple
> > conceptual explanation.
> >
> > One very common installation I can think of - a single router
> > provides service to many clients in the same VLAN which must be
> > isolated.  Say the router is using eth0 and the clients are on
> > eth1-ethX.
> >
> > Then what you want to do looks something like the following:
> >
> > 0) Deny all frames not explicitly permitted:
> > ebtables -P FORWARD DENY
> >
> > 1) Permit any frames with ingress eth0:
> > ebtables -A FORWARD -i eth0 -j ACCEPT
> >
> > 2) Permit any frames with egress interface eth0.
> > ebtables -A FORWARD -o eth0 -j ACCEPT
> >
> >
> > Think about ebtables as a low-level way to specify policy for the
> > handling of frames, much in the same way that iptables is a low-level
> > way to specify policy for IP packets.
>
> I have managed to convince myself that I can do Private VLAN with ebtables,
> even between bridges :)
> I do need some help to figure out how to setup the ebtable rules in an simple
> manner that allows me to add/remove ports and also flip between Isolated and
> Promiscuous port mode.
>
> Check out http://www.rfc-editor.org/internet-drafts/draft-sanjib-private-vlan-10.txt ,
> Table 1 and ignore community ports for now:
>    ---------------------------------------------------------------
>    |             | isolat-| promis-| commu-| commu-| interswitch |
>    |             | ted    | cuous  | nity1 | nity2 | link port   |
>    ---------------------------------------------------------------
>    | isolated    | deny   | permit | deny  | deny  | permit      |
>    ---------------------------------------------------------------
>    | promiscuous | permit | permit | permit| permit| permit      |
>    ---------------------------------------------------------------
>    | community1  | deny   | permit | permit| deny  | permit      |
>    ---------------------------------------------------------------
>    | community2  | deny   | permit | deny  | permit| permit      |
>    ---------------------------------------------------------------
>    | interswitch |        |        |       |       |             |
>    | link port   | deny(*)| permit | permit| permit| permit      |
>    ---------------------------------------------------------------
>
>  (*) Please note that this asymmetric behavior is for traffic
>    traversing inter-switch link ports over an isolated VLAN only.
>    Traffic from an inter-switch link port to an isolated port will be
>    denied if it is in the isolated VLAN.  Traffic from an inter-switch
>    link port to an isolated port will be permitted if it is in the
>    primary VLAN (see below for the different VLAN characteristics).
>
>    N.B.: An interswitch link port is simply a regular port that
>    connects two switches (and that happens to carry two or more VLANs).

These are the rules i come up with when I have a bridge with four
interfaces. Promisc, Isolated, Community and a Interswitch port.

The Interswitch port is modelled with 3 VLANs 4042, 4043 and 4044

#Static rules
#.4042 = Promisc/primary VLAN
#.4043 = Isolated VLAN
#.4042 = Community VLAN
#These VLANs represent the interswitch port

#Do not leak pkgs between the above VLANs
./ebtables -A FORWARD -i eth0.4042 -o eth0.4043 -j DROP
./ebtables -A FORWARD -i eth0.4042 -o eth0.4044 -j DROP
./ebtables -A FORWARD -i eth0.4043 -o eth0.4042 -j DROP
./ebtables -A FORWARD -i eth0.4043 -o eth0.4044 -j DROP
./ebtables -A FORWARD -i eth0.4044 -o eth0.4042 -j DROP
./ebtables -A FORWARD -i eth0.4044 -o eth0.4043 -j DROP

#Port rules

#Promisc Port, eth1.1
./ebtables -A FORWARD -i eth1.1 -o eth0.4043 -j DROP
./ebtables -A FORWARD -i eth1.1 -o eth0.4044 -j DROP

#Isolated Port, eth1.2
./ebtables -A FORWARD -i eth1.2 -o eth0.4043 -j ACCEPT
./ebtables -A FORWARD -i eth1.2 -o eth1.1 -j ACCEPT
./ebtables -A FORWARD -i eth1.2 -j DROP
./ebtables -A FORWARD -o eth1.2 -i eth0.4042 -j ACCEPT
./ebtables -A FORWARD -o eth1.2 -i eth1.1 -j ACCEPT
./ebtables -A FORWARD -o eth1.2 -j DROP

#Community Port, eth1.3
./ebtables -A FORWARD -i eth1.3 -o eth0.4042 -j ACCEPT
./ebtables -A FORWARD -i eth1.3 -o eth0.4044 -j ACCEPT
./ebtables -A FORWARD -i eth1.3 -j DROP
./ebtables -A FORWARD -o eth1.3 -i eth0.4042 -j ACCEPT
./ebtables -A FORWARD -o eth1.3 -i eth0.4044 -j ACCEPT
./ebtables -A FORWARD -o eth1.3 -i eth1.1 -j ACCEPT
./ebtables -A FORWARD -o eth1.3 -j DROP

This is getting out of control. I was hoping there would be a simpler
way to express the above. Adding ports or changing roles won't
be funny.
Anyone?

 Jocke

