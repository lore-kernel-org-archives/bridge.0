Date: Mon, 24 Oct 2005 09:42:35 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Some Questions
Message-ID: <20051024094235.3961886f@dxpl.pdx.osdl.net>
In-Reply-To: <1129859108.2987.21.camel@pluto.linsolutions.com>
References: <1129859108.2987.21.camel@pluto.linsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ted Kaczmarek <tedkaz@optonline.net>
Cc: bridge@lists.osdl.org

On Thu, 20 Oct 2005 21:45:08 -0400
Ted Kaczmarek <tedkaz@optonline.net> wrote:

> I am battling an issue with use of bridging with xen.
> For some yet undetermined reason supposedly relating to stp, they assign
> a mac address of fe:ff:ff:ff:ff:ff  to the bridge.
> 
> Was hoping someone here may be able to elaborate on that.

Well it is a legal address (albeit odd). The LSB of the first byte
must be 0 (otherwise it is broadcast/multicast) and the MSB should be
one (assigned by software). They should really use the kernel function
random_ether_addr because the address may leak to the outside world when
used in other protocols.

But it's Xen's problem.

> 
> If I enslave a bridge to an ethernet, and than restart that network
> interface, should the bridge operation behave the same after the ip
> interface is restarted?

Yes, but you have to wait for the bridge to go into the forwarding
state, it is receive only during the learning period.

> Is their any arp functionality in the bridge itself?

ARP is for resolving IP to Ethernet; and the bridge doesn't know
what IP is?

> Am thinking like arp snooping, or anything else for that matter.
The forwarding table maybe what you are thinking of. It maps ethernet
address to device. It keeps track of which interfaces packets arrived
on and sends out the same path. If it doesn't know where to send a packet
it has to do flooding on all interfaces.


> In general I have been seeing a lot of odd behavior with the xen bridge
> in their unstable code base. Am hoping for some insight.

Xen is using bridging in non-standard ways. IMHO they need to either use
it exactly as intended or better yet invent their own virtual ethernet device.


> Regards,
> Ted
> 


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
