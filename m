Return-Path: <Allan.Nielsen@microchip.com>
Date: Tue, 30 Jul 2019 21:00:01 +0200
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20190730190000.diacyjw6owqkf7uf@lx-anielsen.microsemi.net>
References: <20190729121409.wa47uelw5f6l4vs4@lx-anielsen.microsemi.net>
	<95315f9e-0d31-2d34-ba50-11e1bbc1465c@cumulusnetworks.com>
	<20190729131420.tqukz55tz26jkg73@lx-anielsen.microsemi.net>
	<3cc69103-d194-2eca-e7dd-e2fa6a730223@cumulusnetworks.com>
	<20190729135205.oiuthcyesal4b4ct@lx-anielsen.microsemi.net>
	<e4cd0db9-695a-82a7-7dc0-623ded66a4e5@cumulusnetworks.com>
	<20190729143508.tcyebbvleppa242d@lx-anielsen.microsemi.net>
	<20190729175136.GA28572@splinter>
	<20190730062721.p4vrxo5sxbtulkrx@lx-anielsen.microsemi.net>
	<20190730143400.GO28552@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20190730143400.GO28552@lunn.ch>
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
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, Ido Schimmel <idosch@idosch.org>, Horatiu Vultur <horatiu.vultur@microchip.com>

The 07/30/2019 16:34, Andrew Lunn wrote:
> The whole offloading story has been you use the hardware to accelerate
> what the Linux stack can already do.
It is true, I have been quite keen on finding a way to control the forwarding of
L2-multicast which will work in the same way with and without HW acceleration
(and which we can HW offlaod with the HW I'm working on).

> In this case, you want to accelerate Device Level Ring, DLR.
It is actually not only for DLR, there are other ring protocols which has the
same needs the same MRP (media redundancy protocol) is an other example.

I just used DLR as an example because this is the one we expect to implement the
protocol for first. There are other just as important use-cases.

> But i've not yet seen a software implementation of DLR. Should we really be
> considering first adding DLR to the SW bridge?
We have actually (slowly) stared to work on a DLR SW implementation. We want to
do this as a Linux driver instead of a user-space implementation, because there
are other HW facilities we would like to offload (the HW has a automatic frame
generator, which can generate the beacon frames, and a unit which can terminate
the beacon frames, and generate an interrupt if the beacon frames are not
received).

Our plan was to implement this in pure SW, and then look at how to HW offload
it.

But this will take some time before we have anything meaning full to show.

> Make it an alternative to the STP code?
I'm still working on learning the details of DLR, but I actually believe that it
in some situations may co-exists with STP ;-)

DLR only works on ring topologies, but it is possible to connect a ring to a
classic STP network. If doing so, then you are suppose to run DLR on the two
ring ports, and (M)STP on the ports connecting to the remaining part of the
network.

As far as I recall, this is called a gateway node. But supporting this is
optional, and will properly not be supported in the first implementation.

> Once we have a generic implementation we can then look at how it can
> be accelerated using switchdev.
I agree with you that we need a SW implementation of DLR because we can offload
the DLR protocol to HW.

But what we are looking at here, is to offload a
non-aware-(DLR|MRP)-switch which happens to be placed in a network with
these protocols running.

It is not really DLR specific, which is why it seems reasonable to implement
this without a DLR SW implementation up front.

-- 
/Allan
