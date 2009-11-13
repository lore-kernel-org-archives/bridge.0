Date: Thu, 12 Nov 2009 22:23:27 -0500
From: Andy Gospodarek <andy@greyhouse.net>
Message-ID: <20091113032326.GE1639@gospo.rdu.redhat.com>
References: <bug-14586-10286@http.bugzilla.kernel.org/>
	<20091112143913.3d89e4f4.akpm@linux-foundation.org>
	<20091112145529.303c2659@nehalam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091112145529.303c2659@nehalam>
Subject: Re: [Bridge] [Bugme-new] [Bug 14586] New: bridge on bonding
	interface: DHCP	replies don't get through
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bugzilla-daemon@bugzilla.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, harald.dunkel@t-online.de, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Thu, Nov 12, 2009 at 02:55:29PM -0800, Stephen Hemminger wrote:
> > 
> > I would like to run a bridge for kvm on a bonding interface (4 * 1Gbit, Intel
> > e1000e). Problem: The DHCPDISCOVER packets sent by the guest show up on my dhcp
> > server as expected, but the DHCPOFFER sent as a reply doesn't reach the guest
> > behind the bridge.
> > 
> > Using tcpdump on host and guest I can see the DHCPOFFER on the bond0 and br0
> > interface, but it never shows up on vnet0 or on the guest's eth0.
> > 
> > If I drop the bonding interface and use the host's eth2 for the bridge instead,
> > then there is no such problem.
> > 
> > Kernel on host and guest is 2.6.31.5. Attached you can find more information
> > about my setup. 
> > 
> 
> What is the configuration?
> # brctl showstp virbr0
> # brctl showmacs virbr0
> 

I'm quite sure this output will show us why this isn't working and it
won't be the first time I've seen this.

What happens with mode 0 is that the DHCPDISCOVER goes out and since the
MAC is unlearned by the switch connected to the host, the frame will
come back on all other members of the bond other than the one that sent
it.
 
Since the bond interface is receiving the frame, the bridge will relearn
the source address of the guest on the bonding interface and any
subsequent frames received on the bond interface that have the
destination MAC of the guest will be dropped by the bridge.  This is as
expected since a bridge should drop frames when the destination MAC of
the incoming frame matches an entry in the forwarding database that
indicates those frames are destined for the receiving port.

I would suggest switching to mode 5 (balance-tlb) if your switch cannot
handle bonding or mode 2 or 4 (balance-xor or 802.3ad, respectively) if
it can.  Both of those modes avoid this problem since mode 5 will drop
additional broadcast frames and modes 2 and 4 will not send broadcast
frames back to any of the bond member's interfaces.

There is a Red Hat kbase article that talks about this problem as well:

http://kbase.redhat.com/faq/docs/DOC-16051

When it was originally written mode 6 was thought to be a workaround
as well, but it has been recently proved to still be a problem and the
article needs to be updated.

