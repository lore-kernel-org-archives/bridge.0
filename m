Date: Wed, 27 Aug 2008 08:17:32 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20080827081732.68fefb51@extreme>
In-Reply-To: <FB2A2D2F36FC264282887DD51732C0200160D2D8@magmsg03.ad.magnumsemi.com>
References: <FB2A2D2F36FC264282887DD51732C0200160D2D8@magmsg03.ad.magnumsemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Socket Buffer bridging of Ethernet frames
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Suresh Bhaskaran <Suresh.Bhaskaran@magnumsemi.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 26 Aug 2008 19:29:12 -0700
"Suresh Bhaskaran" <Suresh.Bhaskaran@magnumsemi.com> wrote:

> Hello,
> 
>  
> 
> I am requesting a sanity check on my "driver-level" bridging approach in
> this e-mail.  Please let me know if you see any "gotcha's" in this
> approach.
> 
>  
> 
> Problem:
> 
> *	I have a single physical ethernet device on my embedded linux
> target, and I want to bridge packets to/from a device across on the
> other side of a shared memory, that also processes ethernet data.
> *	For a variety of reasons, I can't use the "brctl addbr" utility
> (I've tried!), so I'm implementing the bridging functionality for this
> specific case, at the driver level.
> 
>  
> 
> My approach:
> 
> *	Modify the existing ethernet driver by adding some additional
> code:
> *	Whenever I receive a packet on the physical ethernet:
> 
> 	*	Just before sending the skb to the network interface
> (netif_rx(skb)), also push the packet to shmem.
> 
> *	Whenever I send a packet to the physical ethernet:
> 
> 	*	Before pushing the packet to the physical ethernet
> device, also push the packet to shared memory.
> 
> *	When I receive a packet from the "shared memory" device:
> 
> 	*	Build up two copies of an skb
> 	*	Get the handle to the network device by doing a
> dev_get_by_name("eth0")
> 	*	Push one up to the netif (netif_rx(skb))
> 	*	Push the other (identical) skb to the physical ethernet
> device.
> 	*	dev_put("eth0") when I'm done.
> 
> *	I use netif_stop_queue() and netif_wake_queue() for flow control
> to the network interface, but for shmem congestion, I just drop packets
> (for now), since I don't have "easy" queue api's for flow control
> handy..
> 
>  
> 
> Some questions/concerns I have:
> 
>  
> 
> *	is there something in the skb that has "directionality"?
> 
> 	*	That is, if I take and skb that is intended to go to the
> network interface (e.g. netif_rx(skb)), and "push" it down to physical
> device, will something get usynchronized?
> 	*	Or, if I get an skb from the system (from the
> hard_start_xmit()), can I "push" it up again to the netif, or will some
> "directionality" thing in the skb make things go out of whack?
> 	*	Also, if I push all these additional created skb's up to
> the interface, or down, is there some "count" between the system netif
> and the physical device that may get out of whack, and out of sync?
> 
> *	Also, is there something like a "man" pages for the above api's,
> and also skb questions? (other than the source code)?  I wasn't to find
> a good man page on the above by few minutes "google"
> 
>  
> 
> In any case, I'm already partially along this approach, but I sure could
> use any advance warning of potential issues and workarounds!
> 
>  
> 
> Thanks again.
> 
>  
> 
> Suresh Bhaskaran
> 
>  
> 

You just reinvented AF_PACKET with mmap. I don't see why you want to.
