Date: Fri, 14 May 2004 09:43:30 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Static arp entries in showmacs?
Message-Id: <20040514094330.7d27aa36@dell_ss3.pdx.osdl.net>
In-Reply-To: <1084545329.3681.65.camel@miyazaki>
References: <1084545329.3681.65.camel@miyazaki>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: matt@ecsc.co.uk
Cc: bridge@lists.osdl.org

As you deduced, the way the MS load balancer works is to have a single
IP address mapped to a multicast address.  Then when a TCP connection starts
it responds with an ARP packet to redirect traffic from that host.

> When packets are dnatted to the internal ip, the kernel modifies the
> destination ip and ethernet address of the packet to send to 03:bf; it's
> then passed to the bridge, the bridge can't correlate the 03:bf hardware
> address with any particular interface, fails 'open' and sends the frame
> out of all the interfaces on the bridge (to the 03:bf ether address). 

Since it is a multicast address, it isn't bound to any particular interface.
The simplest fix would be to just add filtering rule to block that address
leaking back out other interfaces.
