Date: Mon, 5 Jan 2009 23:35:20 +0000 (GMT)
From: Simon Detheridge <simon@widgit.com>
Message-ID: <508029074.82151231198520512.JavaMail.root@ken>
In-Reply-To: <504349474.82131231198409158.JavaMail.root@ken>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridging without forwarding? (not bonding)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I wrote:
> What I'm trying to do is use a combination of vtun tap tunnels and
> bridging, to make my servers feel like they're on a LAN together.

... snip ...

> Really what I want to do is forget about stp and just have each
> bridge interface send out packets over the correct tap interface based
> on what mac address is at the other end, but not bother to forward
> anything on, as it should never be necessary.

"Ross Vandegrift" <ross@kallisti.us> wrote:
> Based on your description, what you really want is broadcast GRE.
> Check out http://linux-ip.net/gl/ip-tunnels/node9.html for a basic
> description.

Unfortunately, Amazon will only route tcp/udp. Other protocols don't work, and as such it's not even possible to set up an ipsec-based VPN... VTun and OpenVPN seem to be the only solutions.

richardvoigt@gmail.com wrote:
> Leave the master-slave server tunnel separate from the bridges?  That
> connection is different from the others anyway, and making it
> independent of the bridges will break the loop.

That doesn't work. I set up a standard ptp tunnel between the master/slave, leaving the bridges just for the connections to the clients. When connecting a bunch of clients, I still wind up with a box that routes all packets over one tunnel. showstp tells me that one tunnel is blocked and the other is forwarding. Suprising. I thought stp would find the shortest route, but this takes three hops as packets can go client->master->different client->slave.

> Alternatively, you could use ebtables to drop all packets in the
> FORWARD chain.

Bingo. Switching off stp on all nodes, and saying "ebtables -P FORWARD DROP" makes everything work exactly how I want. I hadn't found ebtables until now. :-)

Thanks for the help... :-)
Simon

-- 
Simon Detheridge - CTO, Widgit Software
26 Queen Street, Cubbington, CV32 7NA - Tel: +44 (0)1926 333680
