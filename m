Message-ID: <2e59e6970901050701j6aa4bc2bi47350cb295d3459f@mail.gmail.com>
Date: Mon, 5 Jan 2009 15:01:38 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <1604972349.79441231165919715.JavaMail.root@ken>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1789230353.79391231165863451.JavaMail.root@ken>
	<1604972349.79441231165919715.JavaMail.root@ken>
Subject: Re: [Bridge] Bridging without forwarding? (not bonding)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Simon Detheridge <simon@widgit.com>
Cc: bridge@lists.linux-foundation.org

Leave the master-slave server tunnel separate from the bridges?  That
connection is different from the others anyway, and making it
independent of the bridges will break the loop.

Alternatively, you could use ebtables to drop all packets in the FORWARD chain.

On Mon, Jan 5, 2009 at 2:31 PM, Simon Detheridge <simon@widgit.com> wrote:
> Hello,
>
> It's entirely possible that I'm going about this all the wrong way... I'm new here. :-)
>
> I'm trying to set up an environment that works a bit like a private LAN within Amazon's EC2 cloud. EC2 allows me to provision a bunch of servers on demand, but they don't have predictable internal IP addresses for communicating with one another, which makes things a little complicated.
>
> What I'm trying to do is use a combination of vtun tap tunnels and bridging, to make my servers feel like they're on a LAN together.
>
> The topology I've been experimenting with for now is one where I have a "master" server, a "slave" server, and many "client" servers. I'd like the "master" and "slave" servers to have static IPs, and the "client" servers to get their addresses via DHCP. I have it so that the master and slave have a tap tunnel between them, and every client has a tap tunnel to both the master and the slave (but not to the other clients). Each client should be able to ping both the master and slave. I don't care if they can ping the other clients or not.
>
> I've got it set up so that the master and slave each have a bridge interface that aggregates all of the tunnels from each client (and the one to each other). Each client has a bridge interface that aggregates the two tunnels to the master and slave. All are called br0.
>
> I'm not adding any eth interfaces to the bridge, just the tap interfaces.
>
> I'm running a DHCP server on the master and slave in failover mode and listening on br0, and on each client I'm attempting to obtain an IP address for the br0 interface using a DHCP client.
>
> I have stp switched on everywhere. If I disable stp all hell breaks loose and I get duplicate packets all over the place.
>
> I basically want each server to appear to have one interface, despite the fact that there are multiple tunnels. I also want the system to work if either the master or the slave server goes away.
>
> What I was hoping would happen is that packets would take the shortest route to where they want to go. They should only ever have to go over one tunnel, except for clients attempting to contact each other (this never happens) or broadcast packets (which only really need to go to the master/slave for DHCP anyway)
>
> In practice, it seems that packets sent from a client server to a master or slave are always going over the same tap interface, even if it is not the shortest route. (Pings sent to both the master and slave are going out over tap0, all that I can see on tap1 is stp traffic).
>
> Really what I want to do is forget about stp and just have each bridge interface send out packets over the correct tap interface based on what mac address is at the other end, but not bother to forward anything on, as it should never be necessary.
>
> What am I missing?
>
> Thanks,
> Simon
>
> --
> Simon Detheridge - CTO, Widgit Software
> 26 Queen Street, Cubbington, CV32 7NA - Tel: +44 (0)1926 333680
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
