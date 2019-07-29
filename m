Return-Path: <Allan.Nielsen@microchip.com>
Date: Mon, 29 Jul 2019 15:14:21 +0200
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20190729131420.tqukz55tz26jkg73@lx-anielsen.microsemi.net>
References: <1564055044-27593-1-git-send-email-horatiu.vultur@microchip.com>
	<7e7a7015-6072-d884-b2ba-0a51177245ab@cumulusnetworks.com>
	<eef063fe-fd3a-7e02-89c2-e40728a17578@cumulusnetworks.com>
	<20190725142101.65tusauc6fzxb2yp@soft-dev3.microsemi.net>
	<b9ce433a-3ef7-fe15-642a-659c5715d992@cumulusnetworks.com>
	<e6ad982f-4706-46f9-b8f0-1337b09de350@cumulusnetworks.com>
	<20190726120214.c26oj5vks7g5ntwu@soft-dev3.microsemi.net>
	<b755f613-e6d8-a2e6-16cd-6f13ec0a6ddc@cumulusnetworks.com>
	<20190729121409.wa47uelw5f6l4vs4@lx-anielsen.microsemi.net>
	<95315f9e-0d31-2d34-ba50-11e1bbc1465c@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <95315f9e-0d31-2d34-ba50-11e1bbc1465c@cumulusnetworks.com>
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
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, Horatiu Vultur <horatiu.vultur@microchip.com>

The 07/29/2019 15:22, Nikolay Aleksandrov wrote:
> Yes, all of the multicast code is handled differently, it doesn't go through the fdb
> lookup or code at all. I don't see how you'll do a lookup in the fdb table with a
> multicast mac address, take a look at br_handle_frame_finish() and you'll notice
> that when a multicast dmac is detected then we use the bridge mcast code for lookups
> and forwarding.

Here is my thinking (needs much more elaboration, which will come if we do a
patch to test it out):


In br_pkt_type

Rename BR_PKT_MULTICAST to BR_PKT_MULTICAST_IP
Add a new type called BR_PKT_MULTICAST_L2

In br_handle_frame_finish

	if (is_multicast_ether_addr(dest)) {
		/* by definition the broadcast is also a multicast address */
		if (is_broadcast_ether_addr(dest)) {
			pkt_type = BR_PKT_BROADCAST;
			local_rcv = true;
		} else {
			pkt_type = BR_PKT_MULTICAST;
			if (br_multicast_rcv(br, p, skb, vid))
				goto drop;
		}
	}

Change the code above to detect if it is a BR_PKT_MULTICAST_IP or a
BR_PKT_MULTICAST_L2


In this section:

switch (pkt_type) {
....
}

if (dst) {
} else {
}

Add awareness to the BR_PKT_MULTICAST_L2 type, and allow it do forwarding
according to the static entry if it is there.

> If you're trying to achieve Rx only on the bridge of these then
> why not just use Ido's tc suggestion or even the ip maddr add offload for each port ?
> 
> If you add a multicast mac in the fdb (currently allowed, but has no effect) and you
> use dev_mc_add() as suggested that'd just be a hack to pass it down and it is already
> possible to achieve via other methods, no need to go through the bridge.

Well, I wanted the SW bridge implementation to behave the same with an without
HW offload.

And also, I believe that is conceptually belongs to the MAC tables.

/Allan

