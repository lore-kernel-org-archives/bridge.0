Return-Path: <Allan.Nielsen@microchip.com>
Date: Mon, 29 Jul 2019 14:43:43 +0200
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20190729124343.rynm5qjdsueonlno@lx-anielsen.microsemi.net>
References: <eef063fe-fd3a-7e02-89c2-e40728a17578@cumulusnetworks.com>
	<20190725142101.65tusauc6fzxb2yp@soft-dev3.microsemi.net>
	<b9ce433a-3ef7-fe15-642a-659c5715d992@cumulusnetworks.com>
	<e6ad982f-4706-46f9-b8f0-1337b09de350@cumulusnetworks.com>
	<20190726120214.c26oj5vks7g5ntwu@soft-dev3.microsemi.net>
	<20190726134613.GD18223@lunn.ch>
	<20190726195010.7x75rr74v7ph3m6m@lx-anielsen.microsemi.net>
	<20190727030223.GA29731@lunn.ch>
	<20190728191558.zuopgfqza2iz5d5b@lx-anielsen.microsemi.net>
	<20190729060923.GA16938@splinter>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20190729060923.GA16938@splinter>
Subject: Re: [Bridge] [PATCH] net: bridge: Allow bridge to joing multicast
	groups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, Horatiu Vultur <horatiu.vultur@microchip.com>

Hi Ido,

The 07/29/2019 09:09, Ido Schimmel wrote:
> External E-Mail
> 
> 
> On Sun, Jul 28, 2019 at 09:15:59PM +0200, Allan W. Nielsen wrote:
> > If we assume that the SwitchDev driver implemented such that all multicast
> > traffic goes to the CPU, then we should really have a way to install a HW
> > offload path in the silicon, such that these packets does not go to the CPU (as
> > they are known not to be use full, and a frame every 3 us is a significant load
> > on small DMA connections and CPU resources).
> > 
> > If we assume that the SwitchDev driver implemented such that only "needed"
> > multicast packets goes to the CPU, then we need a way to get these packets in
> > case we want to implement the DLR protocol.
> 
> I'm not familiar with the HW you're working with, so the below might not
> be relevant.
> 
> In case you don't want to send all multicast traffic to the CPU (I'll
> refer to it later), you can install an ingress tc filter that traps to
> the CPU the packets you do want to receive. Something like:
> 
> # tc qdisc add dev swp1 clsact
> # tc filter add dev swp1 pref 1 ingress flower skip_sw dst_mac \
> 	01:21:6C:00:00:01 action trap
I have actually been looking at this, and it may an idea to go down this road.
But so far we have chosen not to for the following reasons:
- It is not only about trapping traffic to the CPU, we also needs to capability
  to limit the flooding on the front ports.
- In our case (the silicon), this feature really belongs to the MAC-table, which
  is why we did prefer to do it via the FDB entries.
  - But the HW does have TCAM resources, and we are planning on exposing these
    resources via the tc-flower interface. It is just that we have more MAC
    table resoruces than TCAM resources, which is another argument for using the
    MAC table.

> If your HW supports sharing the same filter among multiple ports, then
> you can install your filter in a tc shared block and bind multiple ports
> to it.
It does, thanks for making us aware of this optimization option.

> Another option is to always send a *copy* of multicast packets to the
> CPU, but make sure the HW uses a policer that prevents the CPU from
> being overwhelmed. To avoid packets being forwarded twice (by HW and
> SW), you will need to mark such packets in your driver with
> 'skb->offload_fwd_mark = 1'.
Understood

> Now, in case user wants to allow the CPU to receive certain packets at a
> higher rate, a tc filter can be used. It will be identical to the filter
> I mentioned earlier, but with a 'police' action chained before 'trap'.
I see.

> I don't think this is currently supported by any driver, but I believe
> it's the right way to go: By default the CPU receives all the traffic it
> should receive and user can fine-tune it using ACLs.
If all the frames goes to the CPU, then how can I fine-tune frames not to go to
the CPU?? I can do a TRAP (to get it to the CPU) a DROP (to drop it before
forwarding), but how can I forward a multicast packet, but prevent it from going
to the CPU?

I have seen that the mirror command can do re-direction, but not to a list of
ports...

All in all, thanks a lot for the suggestions, but to begin with I think we will
explore the MAC table option a bit more. But we will get back to TC to support
the ACL functions.

/Allan


