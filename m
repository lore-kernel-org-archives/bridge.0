Date: Sun, 27 Apr 2008 22:35:37 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080427223537.74cd0f7f@extreme>
In-Reply-To: <96CF49BD8B56384395D698BA99007FA32FA1E7@exchange.pacwire.local>
References: <96CF49BD8B56384395D698BA99007FA32FA1E7@exchange.pacwire.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Preventing packet reassembly
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leigh Sharpe <lsharpe@pacificwireless.com.au>
Cc: bridge@lists.linux-foundation.org

On Mon, 28 Apr 2008 09:56:49 +1000
"Leigh Sharpe" <lsharpe@pacificwireless.com.au> wrote:

> Hi All, 
> I'm having some issues with my bridge reassembling fragmented packets,
> with disastrous results.
> I have a simple bridge set up:
>  
> brctl addbr br0
> brctl addif br0 eth0 
> brctl addif br0 eth1
>  
> Simple enough. The MTU on each interface is 1500, and so is the MTU on
> the bridge itself. 
> I have the bridge connected something like this:
>  
> PC A----Switch A---eth0 (bridge) eth1---Switch B---PC B.
>  
> The Switches are adding VLAN headers and the like, but this seems to be
> irrelevant to the problem.
> If i ping from PC A to PC B, all is OK. But, when I ping using a
> 1500-byte payload (or larger), the ping doesn't get through. Removing
> the linux bridge and just going switch-switch works OK.
>  
> Watching the ethernet ports on the bridge indicate that the ping is
> entering the bridge on eth0, but not coming out of eth1. A packet
> sniffer shows that the ping is being fragmented by PC A, and two packets
> enter eth0. I then increased the MTU on eth0, eth1 and br0 to 1600, to
> see if this was an MTU issue. I then see packets coming out of eth1, but
> my switch is dropping them, because they are oversized.
> Connecting eth1 straight to a packet sniffer shows that when two packets
> enter eth0, the bridge is reassembling them into a single, larger
> packet, which it then either drops because it is larget than the MTU of
> eth1, or it passes a large packet (in this case, 1560 bytes or so).
> Obviously, this packet is then dropped by other equipment in the
> network, because it is too large for a proper ethernet packet.
>  
> I am seeing this behaviour with any IP packets, not just ICMP. The
> result is that anything which has a large-ish payload is being dropped
> after it leaves the bridge.
>  
> The question is, then: How do I stop the bridge from reassembling
> fragmented packets?
>  
>  

Are you using hardware that does Large Receive Offload (LRO)? Most
hardware doesn't. The other possible problem would be ebtables/iptables
rules.  The bridge itself doesn't reassemble packets, but firewall
rules might.
