Date: Mon, 23 Aug 2004 10:11:46 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040823101146.4597eb53@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040819114604.GQ3921@sunbeam.de.gnumonks.org>
References: <W5101410375481091705422@asteria.telenet-ops.be>
	<Pine.LNX.4.61.0408051507530.405@filer.marasystems.com>
	<20040819114604.GQ3921@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Any way of knowing a packet's been defragmented
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Harald Welte <laforge@netfilter.org>
Cc: bridge <bridge@osdl.org>, netfilter-devel <netfilter-devel@lists.netfilter.org>, Bart De Schuymer <bdschuym@pandora.be>, Henrik Nordstrom <hno@marasystems.com>

On Thu, 19 Aug 2004 13:46:04 +0200
Harald Welte <laforge@netfilter.org> wrote:

> On Thu, Aug 05, 2004 at 03:10:42PM +0200, Henrik Nordstrom wrote:
> > On Thu, 5 Aug 2004 bdschuym@pandora.be wrote:
> > 
> > >As Stephen explained, bridge ports of the same bridge device no longer 
> > >need to have the same mtu. So the bridge code needs to drop packets 
> > >(ARP, IP, whatever) that will be too long for the output port.
> > 
> > Eh.. I do not claim to be a bridge guru, but won't such bridge cause 
> > serious havoc on the network much like PMTU blackholes does?
> 
> Nobody ever replied to that question.
> 
> Bart, Stephen, what is your take on this?   How was this resolved?

Yes, it would create PMTU black holes, so it shouldn't be recommended
but it is allowed by the standard and might be useful in some specialized
environments. In other words, I can't think why anyone would want to do
it but maybe they will so why stop them?
