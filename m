Return-Path: <Allan.Nielsen@microchip.com>
Date: Thu, 1 Aug 2019 16:22:53 +0200
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20190801142252.pdzd6knl2ytuty7h@lx-anielsen.microsemi.net>
References: <1564055044-27593-1-git-send-email-horatiu.vultur@microchip.com>
	<7e7a7015-6072-d884-b2ba-0a51177245ab@cumulusnetworks.com>
	<eef063fe-fd3a-7e02-89c2-e40728a17578@cumulusnetworks.com>
	<20190725142101.65tusauc6fzxb2yp@soft-dev3.microsemi.net>
	<b9ce433a-3ef7-fe15-642a-659c5715d992@cumulusnetworks.com>
	<e6ad982f-4706-46f9-b8f0-1337b09de350@cumulusnetworks.com>
	<20190726120214.c26oj5vks7g5ntwu@soft-dev3.microsemi.net>
	<b755f613-e6d8-a2e6-16cd-6f13ec0a6ddc@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <b755f613-e6d8-a2e6-16cd-6f13ec0a6ddc@cumulusnetworks.com>
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

The 07/26/2019 15:31, Nikolay Aleksandrov wrote:
...

> You know that in order to not run in promisc mode you'll have to disable
> port flooding and port learning, right ? Otherwise they're always put in promisc.
Yes, we have spend some time looking at nbp_update_port_count and trying to
understand the reasoning behind it.

Our understanding is that this is to make it work with a pure SW bridge
implementation, and this is actually an optimization to allow disable promisc
mode if all forwarding is static (no flooding and no learning).

We also noticed that the Ocelot and the Rocker drivers avoids this "issue" by
not implementing promisc mode.

But promisc mode is a really nice feature for debugging, and we would actually
like to have it, and when HW that can do learning/flooding it does not seem to
be necessary.

I tried to understand how this is handled in the Mellanox drivers, but gave up.
Too big, and we lack the insight in their design.

Do you know if there are better ways to prevent switchdev-offloaded-slave
interfaces to go to promisc mode?

/Allan

