Message-ID: <2e59e6970805131609q4e93a278gfd1fb094264519d0@mail.gmail.com>
Date: Tue, 13 May 2008 23:09:09 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <1210717793.5774.10.camel@collymore.citylink.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>
	<2e59e6970805071916r701987fdx49bab341420ba2d@mail.gmail.com>
	<1210233718.32216.121.camel@gentoo-jocke.transmode.se>
	<2e59e6970805122010v50dcd5al101ae3466b897ad6@mail.gmail.com>
	<m3abiua957.fsf@ursa.amorsen.dk>
	<1210717793.5774.10.camel@collymore.citylink.co.nz>
Subject: Re: [Bridge] STP bug, loop not detetcted
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dylan Hall <dylan@citylink.co.nz>
Cc: bridge@osdl.org

On Tue, May 13, 2008 at 10:29 PM, Dylan Hall <dylan@citylink.co.nz> wrote:
>
>  I've only been half following this thread, but is sounds a lot like you're
> discussing a problem that has already been solved by Cisco (and I assume
> others).
>
>  Most Cisco switches will generate a loopback packet (ethertype 0x9000) at
> fairly regular intervals.  Both the src and dst mac addresses are set to the
> interface mac of the port emitting the packets.  In the event a loop exists
> in the network that hasn't been dealt with by (R)STP the switch will receive
> the packet back on another of it's interfaces.  In the event one of the

That's the difference, in the case described in this thread the packet
comes back to the same interface, not another one.


> loopback packets does make it back to the switch the port is error-disabled
> (I can't remember if it's the sending or receiving port that is disabled).
> This mechanism is independent of STP.
>
>  UDLD also seems to have a mechanism to detect a port that is looped back on
> itself.  Again, independent of STP.
>
>  Rather than modifying STP would it not be better to implement something
> like the above as a standalone daemon?
>
>  Dylan
>
>
>
>
>  On Tue, 2008-05-13 at 10:41 +0200, Benny Amorsen wrote:
>  "richardvoigt@gmail.com" <richardvoigt@gmail.com> writes:
>
> > For example, this topology:
> >
> > br0 - br1 - br2 - br3 - br1
> >
> > There is a loop in br1-br2-br3-br1, so br0 sees its packet come back
> > on the same interface. If br0 shuts down the interface, it breaks
> > connectivity. The br0-br1 link is part of a minimal spanning tree so
> > STP cannot shut it down.
>
> Since the alternative is to melt due to traffic overload, the switch
> sure can shut it down. That breaks connectivity, but only for the
> broken segment. Not shutting the interface means everyone gets hurt.
>
>
> /Benny
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
>
> _______________________________________________
>  Bridge mailing list
>  Bridge@lists.linux-foundation.org
>  https://lists.linux-foundation.org/mailman/listinfo/bridge
>
