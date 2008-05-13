From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Tue, 13 May 2008 10:41:24 +0200
Message-ID: <m3abiua957.fsf@ursa.amorsen.dk>
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>
	<2e59e6970805071916r701987fdx49bab341420ba2d@mail.gmail.com>
	<1210233718.32216.121.camel@gentoo-jocke.transmode.se>
	<2e59e6970805122010v50dcd5al101ae3466b897ad6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
Subject: Re: [Bridge] STP bug, loop not detetcted
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

"richardvoigt@gmail.com" <richardvoigt@gmail.com> writes:

> For example, this topology:
>
> br0 - br1 - br2 - br3 - br1
>
> There is a loop in br1-br2-br3-br1, so br0 sees its packet come back
> on the same interface.  If br0 shuts down the interface, it breaks
> connectivity.  The br0-br1 link is part of a minimal spanning tree so
> STP cannot shut it down.

Since the alternative is to melt due to traffic overload, the switch
sure can shut it down. That breaks connectivity, but only for the
broken segment. Not shutting the interface means everyone gets hurt.


/Benny


