From: Paul Schulz <pschulz@foursticks.com>
In-Reply-To: <20050110194914.GN7529@thunderchild.debian.net>
References: <20050110140638.GH7529@thunderchild.debian.net>
	<41E299D4.2010605@redhat.com>
	<20050110154506.GJ7529@thunderchild.debian.net>
	<41E2A7A7.3060109@redhat.com>
	<20050110161855.GK7529@thunderchild.debian.net>
	<41E2BE29.8090800@redhat.com>
	<20050110191133.GM7529@thunderchild.debian.net>
	<41E2DA6E.8090703@redhat.com>
	<20050110194914.GN7529@thunderchild.debian.net>
Date: Tue, 11 Jan 2005 14:36:46 +1030
Message-Id: <1105416406.4923.8.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: Re: [Bridge] Re: tg3 bridge problems
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Reply-To: pschulz@foursticks.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Gergely Madarasz <gorgo@broadband.hu>
Cc: linux-net@vger.kernel.org, Neil Horman <nhorman@redhat.com>, bridge@lists.osdl.org

Greetings,

This may be the problem that I have seen (and reported) previously...
http://oss.sgi.com/projects/netdev/archive/2004-02/msg00442.html

One suggestion.. do a packet dump on an outgoing bridge port, and a 
dump from a transmitting machine connected to the bridge. Compare the
MD5 checksums.

Regards,
Paul

On Mon, 2005-01-10 at 20:49 +0100, Gergely Madarasz wrote:
> On Mon, Jan 10, 2005 at 02:41:34PM -0500, Neil Horman wrote:
> > Gergely Madarasz wrote:
> > >On Mon, Jan 10, 2005 at 12:40:57PM -0500, Neil Horman wrote:
> > >
> > >>Gergely Madarasz wrote:
> > >>
> > >>>On Mon, Jan 10, 2005 at 11:04:55AM -0500, Neil Horman wrote:
> > >>>
> > >>>
> > >>>>Strange.  My concern was that the tg3 interface has its hardware reset 
> > >>>>whenever its set to be up, and part of that is a resetting of its 
> > >>>>receive mode.  If for some reason IFF_PROMISC was cleared after you set 
> > >>>>it using brctl, the interface might be taken out of promisc mode.  Do 
> > >>>>you have any iptables rules running that might drop bpdus?

> > >And it is probably not a driver-only issue. I've got older machines with
> > >tg3 running fine with bridge (with an older tg3 driver), and eth1 on the
> > >same machine also runs fine. On another machine I tested today, an IBM
> > >x326, the same thing happens - eth0 broken, eth1 fine. Would access to one
> > >of these machines help? :)
> > >
> > >Greg
> > I've got a tg3 card here.  I'll try re-create it as soon as I have time. 
> 
> Sounds great, but I expect it will not occur with a random tg3 card,
> explained above... 

