In-Reply-To: <20090611161227.GC30941@kallisti.us>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
	<20090610162752.GB24563@kallisti.us>
	<OF4422F49E.33BDAF5C-ONC12575D1.005C802A-C12575D1.005E38A3@LocalDomain>
	<OF3035BFFB.A9837EFB-ONC12575D2.00451300-C12575D2.00468AB7@transmode.se>
	<20090611142251.GB30941@kallisti.us>
	<OF9ADC9060.0A5B1ABB-ONC12575D2.004F6D8C-C12575D2.0051564A@transmode.se>
	<20090611161227.GC30941@kallisti.us>
Message-ID: <OF869B6A59.6EC2390A-ONC12575D2.0066A320-C12575D2.006C5008@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 11 Jun 2009 21:43:04 +0200
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
To: Ross Vandegrift <ross@kallisti.us>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

Ross Vandegrift <ross@kallisti.us> wrote on 11/06/2009 18:12:27:
>
> On Thu, Jun 11, 2009 at 04:48:25PM +0200, Joakim Tjernlund wrote:
> > > This is where the opportunity for some development and abstraction
> > > comes in.  If I were you, I'd write a "port manager" script that let
> > > me define port rules and roles in a much simpler language.  That
> > > script would then output the required ebtables ruleset to acheive
> > > that.
> >
> > Yes, but still. I feel that there is a better way specify this. I was
> > thinking of adding some new chains, one for Promisc ports one for Isolated ports
> > and so on and use them to cut down the number of rules to easy management
> > and increase performance, but I haven't figured out how yet.
>
> This might be a good idea.  I used to do something similar with
> ipchains, way back when.  My ruleset was large and complicated, so I
> broke it up into many chains based on what was being accomplished.
>
> In your case, it would somewhat depend on the installation profile.
> If most of your ports are promiscuous, you probably want to change the
> policy to ACCEPT and then write rules that drop frames where you need
> isolation.  If most ports are isolated, then you want to keep the
> policy as DROP and write rules to permit frames.
>
> I might write a script like this (totally untested):

Thanks, I have added some crude additions, What do you think?
(I stink a shell programming, will play some more tomorrow)

>
> ebtables -P FORWARD DROP
>
> # This will take care of all communications to/from a promiscuous
> # interface, regardless of the role of the "other" interface
> for interface in $PROMISC_IFS; do
   ebtables -A FORWARD -o eth0.4043 -i $interface -j DROP
   ebtables -A FORWARD -o eth0.4044 -i $interface -j DROP
>    ebtables -A FORWARD -i $interface -j ACCEPT
>    ebtables -A FORWARD -o $interface -j ACCEPT
> done

ebtables -A FORWARD -i eth0.4042 -j ACCEPT

>
> # Interfaces in a community need a full mesh of connectivity in
> # addition to the above.

COMM_IFS += eth0.4044

> for comm in $COMM_IFS; do
>    for othercomm in $COMM_IFS; do
>       if [[ "$comm" != "$othercomm" ]]; then
>          ebtables -A COMMUNITY -i $comm -o $othercomm -j ACCEPT
>       fi
>    done
> done

hmm, may be split into a IN_COMMUNITY and a OUT_COMMUNITY?
for comm in $COMM_IFS; do
   ebtables -A IN_COMMUNITY  -i $comm -j ACCEPT
   ebtables -A OUT_COMMUNITY -o $comm -j ACCEPT
done
for comm in $COMM_IFS; do
 ebtables -A FORWARD -i $interface -j OUT_COMMUNITY
 ebtables -A FORWARD -o $interface -j IN_COMMUNITY

>
> for interface in $COMM_IFS; do
>    ebtables -A FORWARD -i $interface -j COMMUNITY
>    ebtables -A FORWARD -o $interface -j COMMUNITY
>
>

for iso in $ISOLATED_IFS; do
    ebtables -A FORWARD -i $iso -o eth0.4043 -j ACCEPT
 done
>
> You're only going to learn the best way to do it by playing with it -
> I don't actually have any installation like you want, so I can't offer
> any long-term advice.
>
> --
> Ross Vandegrift
> ross@kallisti.us
>
> "If the fight gets hot, the songs get hotter.  If the going gets tough,
> the songs get tougher."
>    --Woody Guthrie
>
>

