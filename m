Date: Wed, 25 Feb 2009 18:19:24 -0500
From: "L. Gabriel Somlo" <gsomlo@gmail.com>
Message-ID: <20090225231923.GA10931@hedwig.net.cmu.edu>
References: <20090224023129.GA17642@hedwig.net.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090224023129.GA17642@hedwig.net.cmu.edu>
Subject: Re: [Bridge] PVSTP+ support ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Thanks to all who responded. To sum it up, if X and Y are separate
physical ports on the Cisco, configured in access mode, things seem to
work and the loop is detected. What does not work is having X and Y be
trunked over the same physical port. That is when the Cisco will shut
down the trunked port due to "inconsistent BPDUs". The trunked vlans
scenario only works when spanning-tree is disabled on the Cisco, and
that is mutually exclusive with STP-based failover between two boxes.

Thanks again,
--Gabriel

On Mon, Feb 23, 2009 at 09:31:31PM -0500, L. Gabriel Somlo wrote:
> Hi,
> 
> Is there any support at all for Cisco's PVST+ in Linux (kernel and 
> brctl) ? Please read on for what I'm trying to accomplish:
> 
> I'm trying to set up a redundant pair of filtering bridges connected 
> to two cisco 6500 hybrid L2/L3 switch/routers. At the edge of the 
> network I have a bunch of untrusted devices on a layer-2 subnet, and
> the idea is to offer selective access to the subnet's default router 
> on the trusted side of the network. Here's a quick picture:
> 
> 
>             +---------------+                 +---------------+
>             |      .2       |   .1 (HSRP)     |      .3       |
>     +-------+ - - - - - - - +-----------------+ - - - - - - - +-------+
>     |   X   |               | vlanX (trusted) |               |   X   |
>   Linux     |     Cisco     |                 |     Cisco     |     Linux
>   Bridge    |      6500     |                 |      6500     |     Bridge
>     |   Y   |               |      vlan Y     |               |   Y   |
>     +-------+ - + - + - + - +-----------------+ - + - + - + - +-------+
>             |   |   |   |   |   (untrusted)   |   |   |   |   |
>             +---+---+---+---+                 +---+---+---+---+
>                 |   |   |                         |   |   |
>                 |   |   |     +-------------+     |   |   |
>                 |   |   +-----+ edge switch +-----+   |   |
>                 |   |         +-------------+         |   |
>                 |   |                                 |   |
>                 |   |         +-------------+         |   |
>                 |   +---------+ edge switch +---------+   |
>                 |             +-------------+             |
>                 |                                         |
>                 |             +-------------+             |
>                 +-------------+ edge switch +-------------+
>                               +-------------+
> 
> The ciscos use pvstp+, and the problem is that when a Vlan-X BPDU is received
> on a Vlan-Y (sub)interface, that subinterface is shut down due to a perceived
> misconfiguration.
> 
> Is Linux equipped to handle this (by, e.g., translating the BPDUs received
> over vlan X into BPDUs that would be appropriate to forward into vlan Y, and
> vice versa) ?
> 
> If not, any other ideas on how to accomplish redundancy would be much
> appreciated. The topology prevents me from inserting the linux bridge in
> a way that would allow bridging between the same vlan on two different
> physical interfaces.
> 
> Thanks much,
> --Gabriel
