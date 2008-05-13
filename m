Message-ID: <2e59e6970805122010v50dcd5al101ae3466b897ad6@mail.gmail.com>
Date: Tue, 13 May 2008 03:10:09 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <1210233718.32216.121.camel@gentoo-jocke.transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>
	<2e59e6970805071916r701987fdx49bab341420ba2d@mail.gmail.com>
	<1210233718.32216.121.camel@gentoo-jocke.transmode.se>
Subject: Re: [Bridge] STP bug, loop not detetcted
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: joakim.tjernlund@transmode.se
Cc: Bridge@lists.linux-foundation.org

On Thu, May 8, 2008 at 8:01 AM, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
>
>  On Thu, 2008-05-08 at 02:16 +0000, richardvoigt@gmail.com wrote:
>  > On Wed, May 7, 2008 at 9:22 AM, Joakim Tjernlund
>  > <joakim.tjernlund@transmode.se> wrote:
>  > > Got a bridge with 4 optical VLAN interfaces, eth1.1, eth1.2, eth1.3 and
>  > >  eth1.4, attached and the builtin STP enabled. eth1 is connected to
>  > >  a "switch" with 4 real interfaces, each real interface maps to one of
>  > >  the above mentioned VLANs.
>  > >
>  > >  If I loop two or more interfaces by connecting each interface's output
>  > >  to its own input, I get a loop that STP doesn't detect.
>  > >  Looping by connecting an output from one interface to another interface
>  > >  input works fine.
>  > >
>  > >  Bug or limitation in STP? If limitation, would RSTP help here?
>  >
>  > Limitation in STP.
>  >
>  > If a bridge receives one of its own STP packets on the same interface
>  > from which it was sent, that indicates a loop elsewhere in the network
>  > that disabling an interface locally will not fix, therefore STP takes
>  > no action.
>
>  I see, would it hurt something else if STP did turn off it interface in
>  this case? Optical i/f's is getting more common so these types of loops
>  will increase so I think this needs to be addressed.

Yes, it would hurt.

For example, this topology:

br0 - br1 - br2 - br3 - br1

There is a loop in br1-br2-br3-br1, so br0 sees its packet come back
on the same interface.  If br0 shuts down the interface, it breaks
connectivity.  The br0-br1 link is part of a minimal spanning tree so
STP cannot shut it down.  There is no way for STP to distinguish your
case, which is misconfigured, from this example, which is a valid use
of redundant links.
