In-Reply-To: <20090612125214.GA7461@kallisti.us>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
	<de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
	<m33aa5bykm.fsf@ursa.amorsen.dk>
	<OFEA0D61B2.8B351FDC-ONC12575D3.0034AA26-C12575D3.00354697@transmode.se>
	<20090612125214.GA7461@kallisti.us>
Message-ID: <OF0314F87C.B7A0780D-ONC12575D3.00476B7B-C12575D3.00484E73@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 12 Jun 2009 15:09:47 +0200
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
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, Benny Amorsen <benny+usenet@amorsen.dk>

Ross Vandegrift <ross@kallisti.us> wrote on 12/06/2009 14:52:14:
>
> On Fri, Jun 12, 2009 at 11:41:55AM +0200, Joakim Tjernlund wrote:
> > Yes, sets would be nice. However I wonder if this case isn't a bug
> > in any case:
> > Consider these VLANS:
> >  eth0.4042
> >  eth0.4043
> >  eth0.4044
> >
> > Add them to a bridge and the bridge will pass pkgs between them, right?
> > However no real switch I know would do that because they are on
> > the same physical interface.
>
> No, that's not a problem at all.  Any dot1q bridge would behave
> exactly as Linux does if it supports VLAN bridging (which at least
> Cisco, Nortel, and Juniper do in varying capcities).
>
> Moreover, any dot1q bridge that doesn't support VLAN bridging can
> (be careful!) have the feature added by adding one untagged port into
> each VLAN and cabling them to a dot1d bridge.  Linux just saves you
> cables.
>
> The split-horizon rule is for flooding into a broadcast domain.  For
> purposes of split-horizon flooding, each of your VLAN interfaces are
> physical interfaces - a broadcast frame arrived on one of the ports
> and needs to be flooded out all of the others.

hmm, then I don't understand how Private VLAN is supposed to work over
the interswitch port. If I understand you correctly, a Bcast pkg arriving
on VLAN 4042 will be forwarded back over 4043 and 4044 VLANs, then the
receiving switch will forward back these to pkgs once again and
it never stops?

I have updated the script you sent me, what do you think?

#.4042 = Promisc/Primary VLAN (P)
#.4043 = Isolated VLAN (I)
#.4044 = Community VLAN (C)
#These VLANs represent the interswitch port:
# Promisc ports only TX to P, but RX from P, C & I
# Community ports only TX to C VLAN, but RX from C & P
# Isolated ports only TX to I VLAN, but RX only P

#Note that pkgs must not be forwarded between the different uplinks.

P_UPLINK=eth0.4042
I_UPLINK=eth0.4043
C_UPLINK=eth0.4044

#PROMISC_IFS="eth1.1"
PROMISC_IFS=
ISOLATED_IFS="eth1.2"
COMM_IFS="eth1.3 eth1.4 eth1.5 eth1.6"

EB=/root/ebtables

"$EB" --init-table
#"$EB" --flush
"$EB" -P FORWARD DROP

# This will take care of all communications to/from a promiscuous
# interface, regardless of the role of the "other" interface
for interface in $PROMISC_IFS; do
  "$EB" -A FORWARD -o $I_UPLINK -i $interface -j DROP
  "$EB" -A FORWARD -o $C_UPLINK -i $interface -j DROP
  "$EB" -A FORWARD -i $interface -j ACCEPT
  "$EB" -A FORWARD -o $interface -j ACCEPT
done
"$EB" -A FORWARD -i $P_UPLINK -j ACCEPT

for iso in $ISOLATED_IFS; do
    "$EB" -A FORWARD -i $iso -o $I_UPLINK -j ACCEPT
done


# Interfaces in a community need a full mesh of connectivity in
# addition to the above.

"$EB" -N IN_COMMUNITY
"$EB" -P IN_COMMUNITY DROP

"$EB" -N OUT_COMMUNITY
"$EB" -P OUT_COMMUNITY DROP

for comm in $COMM_IFS; do
   "$EB" -A IN_COMMUNITY  -i $comm -j ACCEPT
   "$EB" -A OUT_COMMUNITY -o $comm -j ACCEPT
done

"$EB" -A OUT_COMMUNITY -o $C_UPLINK -j ACCEPT

for comm in $COMM_IFS; do
   "$EB" -A FORWARD -i $comm -j OUT_COMMUNITY
   "$EB" -A FORWARD -o $comm -j IN_COMMUNITY
done

