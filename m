Subject: Re: [Bridge] Bridge and PACKET-socket
References: <lhznd2do0m.fsf@dodo.bluetail.com>
	<slrnbvr1kp.gtv.lunz@absolut.localnet>
	<lh8ykczxqr.fsf@dodo.bluetail.com>
	<200401122247.11045.bdschuym@pandora.be>
From: Luke Gorrie <luke@member.fsf.org>
In-Reply-To: <200401122247.11045.bdschuym@pandora.be>
Message-ID: <lhwu7wyful.fsf@dodo.bluetail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Luke Gorrie <lgorrie@nortelnetworks.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Mon, 12 Jan 2004 22:14:32 -0000
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: bridge@osdl.org, Jason Lunz <lunz@falooley.org>

Bart De Schuymer <bdschuym@pandora.be> writes:

> On Monday 12 January 2004 22:02, Luke Gorrie wrote:
> > Still, I find the current semantics of packet sockets on bridged ports
> > pretty confusing. It took me a full day to figure out why I wasn't
> > receiving the packets I wanted, even though tcpdump did.
> 
> Well, that list for protocol-specific functions contains functions to deal 
> with the packet, e.g. route it. Obviously we don't want these functions to be 
> executed before the bridge code can have a look at it, so that's not very 
> confusing.

I agree that dev.c is not confusing, but the PACKET(7) interface
is. If you bind to ETH_P_ALL you will receive every packet, but if you
bind to any other protocol you will only receive packets the bridge
doesn't take. The manpage doesn't say anything about this, and one
might actually want different semantics (as in my case). IMO it would
be nicer to have an interface that treats "what protocol do I want to
see" and "do I want bridged packets" as orthogonal.

> If you really want to use the protocol-specific list for packets entering on a 
> bridge port, you can. Just use the ebtables brouting chain to "broute" the 
> packet, see the website. I guess you lose a little performance there, but you 
> shouldn't really feel it.

I love ebtables and I'm using it extensively. But there is a limit to
how much more logic I can push into it (not to mention iptables)
before the whole thing becomes incomprehensible :-)

In this case I have a simple program that wants to receive and send
802.3 packets on every physical port on the machine, irrespective of
bridging, etc. The modified packet socket interface is a great match.

.. but come to think of it, I'd better see what happens with packet
sockets and the bonding driver too. Maybe it will spoil my fun.

Cheers,
Luke

