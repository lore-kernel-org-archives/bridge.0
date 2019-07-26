Return-Path: <Allan.Nielsen@microchip.com>
Date: Fri, 26 Jul 2019 21:50:12 +0200
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20190726195010.7x75rr74v7ph3m6m@lx-anielsen.microsemi.net>
References: <1564055044-27593-1-git-send-email-horatiu.vultur@microchip.com>
	<7e7a7015-6072-d884-b2ba-0a51177245ab@cumulusnetworks.com>
	<eef063fe-fd3a-7e02-89c2-e40728a17578@cumulusnetworks.com>
	<20190725142101.65tusauc6fzxb2yp@soft-dev3.microsemi.net>
	<b9ce433a-3ef7-fe15-642a-659c5715d992@cumulusnetworks.com>
	<e6ad982f-4706-46f9-b8f0-1337b09de350@cumulusnetworks.com>
	<20190726120214.c26oj5vks7g5ntwu@soft-dev3.microsemi.net>
	<20190726134613.GD18223@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20190726134613.GD18223@lunn.ch>
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, Horatiu Vultur <horatiu.vultur@microchip.com>

Hi All,

I'm working on the same project as Horatiu.

The 07/26/2019 15:46, Andrew Lunn wrote:
> My default, multicast should be flooded, and that includes the CPU
> port for a DSA driver. Adding an MDB entry allows for optimisations,
> limiting which ports a multicast frame goes out of. But it is just an
> optimisation.

Do you do this for all VLANs, or is there a way to only do this for VLANs that
the CPU is suppose to take part of?

I assume we could limit the behavioral to only do this for VLANs which the
Bridge interface is part of - but I'm not sure if this is what you suggest.

As you properly guessed, this model is quite different from what we are used to.
Just for the context: The ethernet switches done by Vitesse, which was acquired
by Microsemi, and now become Microchip, has until now been supported by a MIT
licensed API (running in user-space) and a protocol stack running on top of the
API. In this model we have been used to explicitly configure what packets should
go to the CPU. Typically this would be the MAC addresses of the interface it
self, multicast addresses required by the IP stack (4 and 6), and the broadcast
address. In this model, will only do this on VLANs which is configured as L3
interfaces.

We may be able to make it work by flood all multicast traffic by default, and
use a low priority CPU queue. But I'm having a hard time getting used to this
model (maybe time will help).

Is it considered required to include the CPU in all multicast flood masks? Or do
you know if this is different from driver to driver?

Alternative would it make sense to make this behavioral configurable?

/Allan
