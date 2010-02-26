Date: Fri, 26 Feb 2010 10:01:02 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100226100102.0d52c6e9@nehalam>
In-Reply-To: <4B88076F.8030302@openvz.org>
References: <20090511114639.440944109@openvz.org>
	<20090519152153.012d4814@nehalam> <20090520192726.GF4968@lenovo>
	<20090520131225.03b7715a@nehalam> <20090521180805.GC4932@lenovo>
	<20090521140504.1865883b@nehalam> <20090522201850.GF5354@lenovo>
	<20100226081843.07f37742@nehalam> <20100226165104.GB5364@lenovo>
	<4B88076F.8030302@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC 0/5] bridge - introduce via_phys_dev feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pavel Emelyanov <xemul@openvz.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, netdev@vger.kernel.org, bridge@linux-foundation.org, Denis Lunev <den@openvz.org>

On Fri, 26 Feb 2010 20:39:59 +0300
Pavel Emelyanov <xemul@openvz.org> wrote:

> Cyrill Gorcunov wrote:
> > On Fri, Feb 26, 2010 at 08:18:43AM -0800, Stephen Hemminger wrote:
> >> Looking back at this. What if the API was simpler:
> 
> Thanks for the reply, Stephen!
> 
> >> Why not:
> >>   1. Setup bridge (and any other interfaces except eth0); includes bringing br0 up
> >>   2. Add eth0 to bridge with new flag to inherit
> >>        a. brctl addif br0 eth0 inherit
> >>
> >> Inherit functionality would need to move address (Ether, IP, IPv6)
> >> and routes from eth0 to br0.
> >> I will see about doing it as much as possible in userspace.
> >>
> 
> Solution is good, but we'll have to reconfigure netfilter matches
> that check for device name/ifindex and restore all this back when
> deleting eth0 from br0.

Netfilter is outside of this, and can't really migrate easily.

> Maybe it's better to implement it on the kernel side by sending a 
> netdev notification and letting the subsystem reconfigure themselves?
> 
> And what can we do with existing TCP connections bound to a device?
> 

TCP connections are never really bound to device. TCP routing is
flexible; if packets can get through, it doesn't care.

-- 
