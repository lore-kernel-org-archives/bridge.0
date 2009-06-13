In-Reply-To: <2e59e6970906130857t2441d0bap34e15fd2af12fe72@mail.gmail.com>
References: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<m3ab4dovgi.fsf@ursa.amorsen.dk>
	<OFCE5E72FE.D082AB78-ONC12575D4.005256D7-C12575D4.0052B193@transmode.se>
	<2e59e6970906130857t2441d0bap34e15fd2af12fe72@mail.gmail.com>
Message-ID: <OF4B3FF703.CC38E26C-ONC12575D4.0058F1ED-C12575D4.005AB7C4@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 13 Jun 2009 18:30:53 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] [PATCH] [bridge] Add split horizon
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org, Benny Amorsen <benny+usenet@amorsen.dk>

"richardvoigt@gmail.com" <richardvoigt@gmail.com> wrote on 13/06/2009 17:57:55:
>
> On Sat, Jun 13, 2009 at 10:03 AM, Joakim
> Tjernlund<joakim.tjernlund@transmode.se> wrote:
> > Benny Amorsen <benny+usenet@amorsen.dk> wrote on 13/06/2009 01:58:53:
> >>
> >> Joakim Tjernlund <Joakim.Tjernlund@transmode.se> writes:
> >>
> >> > Currently the bridge does not impl. split horizon which will easily
> >> > cause loops when 2 or more VLANs are added from the same physical interface.
> >>
> >> Why would they cause loops? If your topology isn't loop free, run
> >> spanning tree in the VLAN's. Yet another thing most hardware switches
> >> can't do, incidentally.
> >
> > ehh, connect two Linux bridges that have 2 VLANs in common on the interswitch connection.
>
> For example, here is a configuration that meets your problem
> description and has no loops:
>
> host A eth0 connected to hostB eth0
>
> host A:
> brctl add br0
> brctl addif br0 eth0.1
> brctl addif br0 eth1
> brctl add br1
> brctl addif br1 eth0.2
> brctl addif br1 eth2

Yes, but eth1 and eth2 don't talk.

>
> host B:
> brctl add br0
> brctl addif br0 eth0.1
> brctl addif br0 wlan0.1
> brctl add br1
> brctl addif br1 eth0.2
> brctl addif br1 wlan0.2
>
> Let's compare this to your complaint:
> Two Linux hosts.... check
> Two VLANs in common.... check
> Both VLANs on the inter-switch connection.... check
>
> Nope, there are no loops.

Of course not. You can always fix what you want somehow but that
doesn't mean that there may be better ways of doing things.

>
> You need to stop calling "a machine running bridging" a "Linux
> bridge".  A "bridge", in Linux, is a virtual interface inside a
> machine with the bridging module loaded.  There can be more than zero,
> one, or multiple bridges in a single Linux machine.  I think that when
> you understand that, all your problems will go away with a simpler
> configuration and no changes to the Linux kernel.

Aha, I had/have the impression that one bridge instance should mimic
a real bridge, if not you are making some sense.
But now I start asking myself what are the semantics for a Linux
bridge instance?

I would really like to know in what situation you would use
the current behavior to forward back VLAN pkgs over the same interface
it was received on?

Also, I am trying to find where it states that a VLAN is considered its own
physical port. Any pointers?

 Jocke

