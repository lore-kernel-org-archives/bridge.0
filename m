References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
	<20090610162752.GB24563@kallisti.us>
	<OF4422F49E.33BDAF5C-ONC12575D1.005C802A-C12575D1.005E38A3@LocalDomain>
	<OF3035BFFB.A9837EFB-ONC12575D2.00451300-C12575D2.00468AB7@transmode.se>
From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Thu, 11 Jun 2009 23:04:48 +0200
In-Reply-To: <OF3035BFFB.A9837EFB-ONC12575D2.00451300-C12575D2.00468AB7@transmode.se>
	(Joakim Tjernlund's message of "Thu\,
	11 Jun 2009 14\:50\:30 +0200")
Message-ID: <m3fxe6trbj.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:

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

Ok, I thought this would be really easy, but I must admit I don't get
how an interswitch link port works. Apparently the different VLAN's are
allowed to go to the same ports, but you can't send a packet back out
the physical interface it came in on.

I ignored the community rules, exercise for the reader...

Anyway, this is buggy, but it should give you an idea:

ebtables -A FORWARD -i eth0.4042 -j frominterswitchporteth0
ebtables -A FORWARD -i eth0.4043 -j frominterswitchporteth0
ebtables -A FORWARD -i eth0.4044 -j frominterswitchporteth0

ebtables -A FORWARD -i eth1.1 -j frompromiscuous
ebtables -A FORWARD -i eth1.2 -j fromisolated
ebtables -A FORWARD -i eth0.4042 -j frominterswitch
ebtables -A FORWARD -i eth0.4043 -j frominterswitch
ebtables -A FORWARD -i eth0.4044 -j frominterswitch
ebtables -A FORWARD -j DROP

ebtables -A frominterswitchporteth0 -o eth0.4042 -j DROP
ebtables -A frominterswitchporteth0 -o eth0.4043 -j DROP
ebtables -A frominterswitchporteth0 -o eth0.4044 -j DROP
ebtables -A frominterswitchporteth0 -j RETURN

#ebtables -A fromisolated -j denyisolated
ebtables -A fromisolated -j permitpromiscuous
ebtables -A fromisolated -j permitinterswitch
ebtables -A fromisolated -j DROP

ebtables -A frompromiscuous -j permitisolated
ebtables -A frompromiscuous -j permitpromiscuous
ebtables -A frompromiscuous -j permitinterswitch
ebtables -A frompromiscuous -j DROP

#ebtables -A frominterswitch -j denyisolated
ebtables -A frominterswitch -j permitpromiscuous
ebtables -A frominterswitch -j permitinterswitch
ebtables -A frominterswitch -j DROP

ebtables -A permitisolated -o eth1.2 -j ACCEPT
ebtables -A permitisolated -j RETURN

ebtables -A permitpromiscuous -o eth1.1 -j ACCEPT
ebtables -A permitpromiscuous -j RETURN

ebtables -A permitinterswitch -o eth0.4042 -j ACCEPT
ebtables -A permitinterswitch -o eth0.4043 -j ACCEPT
ebtables -A permitinterswitch -o eth0.4044 -j ACCEPT
ebtables -A permitpromiscuous -j RETURN

Now, to implement an extra interface, just add it to FORWARD with -j
from<type> and add it to permit<type>. Just two rules. If it's an
interswitch interface, you need to make a new rule set and add the
appropriate VLAN's in there as well, so 4 rules per VLAN for those.

It would be handy if ebtables supported interface sets, like netfilter
supports ipsets.


/Benny

