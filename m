In-Reply-To: <m33aa5bykm.fsf@ursa.amorsen.dk>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>	<de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
	<m33aa5bykm.fsf@ursa.amorsen.dk>
Message-ID: <OFEA0D61B2.8B351FDC-ONC12575D3.0034AA26-C12575D3.00354697@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 12 Jun 2009 11:41:55 +0200
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
To: Benny Amorsen <benny+usenet@amorsen.dk>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

Benny Amorsen <benny+usenet@amorsen.dk> wrote on 12/06/2009 11:17:45:
>
> Daniel Robbins <drobbins@funtoo.org> writes:
>
> > In particular, I think this could be *very* useful for virtualization,
> > where you are adding/removing interfaces from the bridge often. Why?
> > Because it eliminates the need to dynamically create/remove ebtables
> > rules and keep them in sync with the interfaces on the bridge.
>
> If you had sets of interfaces, like you can have sets of ip addresses
> today, it would be trivial to keep the sets in sync.
>
> I don't find it particularly as it is, but with interface-sets you
> wouldn't even have to change any rules.

Yes, sets would be nice. However I wonder if this case isn't a bug
in any case:
Consider these VLANS:
 eth0.4042
 eth0.4043
 eth0.4044

Add them to a bridge and the bridge will pass pkgs between them, right?
However no real switch I know would do that because they are on
the same physical interface.
I think the bridge needs to check the physical interface too and don't
forward pkgs back on the same physical interface.

 Jocke

