Date: Mon, 10 Jan 2005 17:18:56 +0100
From: Gergely Madarasz <gorgo@broadband.hu>
Message-ID: <20050110161855.GK7529@thunderchild.debian.net>
References: <20050110140638.GH7529@thunderchild.debian.net>
	<41E299D4.2010605@redhat.com>
	<20050110154506.GJ7529@thunderchild.debian.net>
	<41E2A7A7.3060109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E2A7A7.3060109@redhat.com>
Subject: [Bridge] Re: tg3 bridge problems
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Neil Horman <nhorman@redhat.com>
Cc: linux-net@vger.kernel.org, bridge@lists.osdl.org

On Mon, Jan 10, 2005 at 11:04:55AM -0500, Neil Horman wrote:
> Gergely Madarasz wrote:
> >On Mon, Jan 10, 2005 at 10:05:56AM -0500, Neil Horman wrote:
> >
> >>Gergely Madarasz wrote:
> >>
> >>>The bpdu's from the cisco switches simply cannot be seen on the server,
> >>>causing loops in l2 traffic. I've tested with sticking a hub between the
> >>>c3550 and the server, the switch sends out the bpdu's, but they are not
> >>>seen by linux (running tethereal). This happens only on eth0, on eth1
> >>>everything seems fine. Any IP traffic on eth0 goes through, no packet
> >>>loss, no errors.
> >>>
> >>>And something even more strange: if I do an 
> >>>ifconfig eth0 0 up; brctl addif br0 eth0; 
> >>>it seems to be working fine, if I do it the other way
> >>>round, then the bpdu's sent by the switches are lost somewhere.
> >>>
> >>>Considering all these, the problem seems to me a strange interaction
> >>>between the bridge driver, the tg3 driver and the hardware in question. 
> >>
> >>It looks to me like either order should work just fine, as long as the 
> >>IFF_PROMISC flag isn't cleared when you bring up the interface.  Is 
> >>IF_PROMISC clear in ifconfig after you issue your ifconfig eth0 up 
> >>command?
> >
> >
> >ifconfig has never showed PROMISC on either of my bridged servers. 
> >ip shows it though. I noticed this before but couldn't find the reason and
> >didn't seem important.
> >
> >This is on a machine with working bridge:
> >
> ># ifconfig eth0
> >eth0      Link encap:Ethernet  HWaddr 00:09:6B:49:89:80
> >          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
> >          ...
> ># ip link list eth0
> >2: eth0: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast qlen 
> >1000
> >    link/ether 00:09:6b:49:89:80 brd ff:ff:ff:ff:ff:ff
> >
> >And this is on the problematic machine:
> >
> ># ifconfig eth0
> >eth0      Link encap:Ethernet  HWaddr 00:0D:60:55:3B:02
> >          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
> >          ....
> ># ip addr list eth0
> >2: eth0: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast qlen 
> >1000
> >    link/ether 00:0d:60:55:3b:02 brd ff:ff:ff:ff:ff:ff
> >
> Strange.  My concern was that the tg3 interface has its hardware reset 
> whenever its set to be up, and part of that is a resetting of its 
> receive mode.  If for some reason IFF_PROMISC was cleared after you set 
> it using brctl, the interface might be taken out of promisc mode.  Do 
> you have any iptables rules running that might drop bpdus?

No iptables rules az all. Btw iptables wouldn't prevent tcpdump from
seeing the packets, would it?
Could it be that the driver perhaps has a problem setting promisc mode
when resetting the hardware?

> >And even if didn't get promisc, tcpdump or tethereal would have made it
> >so, when I was looking for the bpdu packets. Tethereal shows only this:
> >
> Thats not entirely true.  ethereal/tcpdump/etc use the PF_PACKET 
> interface, which talks directly to the driver to set the receive list, 
> and doesn't always go through the device layer, which is where 
> IFF_PROMISC gets asserted.  Agruably it should set promisc, but not 
> doing so doesn't prevent ethereal and friends from capturing in 
> promiscuous mode.

Well, my point was that not even ethereal or tcpdump show the packets,
not even in promisc mode... :)

Greg.
