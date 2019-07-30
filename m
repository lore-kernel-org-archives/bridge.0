Return-Path: <Allan.Nielsen@microchip.com>
Date: Tue, 30 Jul 2019 08:27:22 +0200
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20190730062721.p4vrxo5sxbtulkrx@lx-anielsen.microsemi.net>
References: <20190726120214.c26oj5vks7g5ntwu@soft-dev3.microsemi.net>
	<b755f613-e6d8-a2e6-16cd-6f13ec0a6ddc@cumulusnetworks.com>
	<20190729121409.wa47uelw5f6l4vs4@lx-anielsen.microsemi.net>
	<95315f9e-0d31-2d34-ba50-11e1bbc1465c@cumulusnetworks.com>
	<20190729131420.tqukz55tz26jkg73@lx-anielsen.microsemi.net>
	<3cc69103-d194-2eca-e7dd-e2fa6a730223@cumulusnetworks.com>
	<20190729135205.oiuthcyesal4b4ct@lx-anielsen.microsemi.net>
	<e4cd0db9-695a-82a7-7dc0-623ded66a4e5@cumulusnetworks.com>
	<20190729143508.tcyebbvleppa242d@lx-anielsen.microsemi.net>
	<20190729175136.GA28572@splinter>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20190729175136.GA28572@splinter>
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
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, Horatiu Vultur <horatiu.vultur@microchip.com>

The 07/29/2019 20:51, Ido Schimmel wrote:
> Can you please clarify what you're trying to achieve? I just read the
> thread again and my impression is that you're trying to locally receive
> packets with a certain link layer multicast address.
Yes. The thread is also a bit confusing because we half way through realized
that we misunderstood how the multicast packets should be handled (sorry about
that). To begin with we had a driver where multicast packets was only copied to
the CPU if someone needed it. Andrew and Nikolay made us aware that this is not
how other drivers are doing it, so we changed the driver to include the CPU in
the default multicast flood-mask.

This changes the objective a bit. To begin with we needed to get more packets to
the CPU (which could have been done using tc ingress rules and a trap action).

Now after we changed the driver, we realized that we need something to limit the
flooding of certain L2 multicast packets. This is the new problem we are trying
to solve!

Example: Say we have a bridge with 4 slave interfaces, then we want to install a
forwarding rule saying that packets to a given L2-multicast MAC address, should
only be flooded to 2 of the 4 ports.

(instead of adding rules to get certain packets to the CPU, we are now adding
other rules to prevent other packets from going to the CPU and other ports where
they are not needed/wanted).

This is exactly the same thing as IGMP snooping does dynamically, but only for
IP multicast.

The "bridge mdb" allow users to manually/static add/del a port to a multicast
group, but still it operates on IP multicast address (not L2 multicast
addresses).

> Nik suggested SIOCADDMULTI.
It is not clear to me how this should be used to limit the flooding, maybe we
can make some hacks, but as far as I understand the intend of this is maintain
the list of addresses an interface should receive. I'm not sure this should
influence how for forwarding decisions are being made.

> and I suggested a tc filter to get the packet to the CPU.
The TC solution is a good solution to the original problem where wanted to copy
more frames to the CPU. But we were convinced that this is not the right
approach, and that the CPU by default should receive all multicast packets, and
we should instead try to find a way to limit the flooding of certain frames as
an optimization.

> If you now want to limit the ports to which this packet is flooded, then
> you can use tc filters in *software*:
> 
> # tc qdisc add dev eth2 clsact
> # tc filter add dev eth2 egress pref 1 flower skip_hw \
> 	dst_mac 01:21:6C:00:00:01 action drop
Yes. This can work in the SW bridge.

> If you want to forward the packet in hardware and locally receive it,
> you can chain several mirred action and then a trap action.
I'm not I fully understand how this should be done, but it does sound like it
becomes quite complicated. Also, as far as I understand it will mean that we
will be using TCAM/ACL resources to do something that could have been done with
a simple MAC entry.

> Both options avoid HW egress ACLs which your design does not support.
True, but what is wrong with expanding the functionality of the normal
forwarding/MAC operations to allow multiple destinations?

It is not an uncommon feature (I just browsed the manual of some common L2
switches and they all has this feature).

It seems to fit nicely into the existing user-interface:

bridge fdb add    01:21:6C:00:00:01 port eth0
bridge fdb append 01:21:6C:00:00:01 port eth1

It seems that it can be added to the existing implementation with out adding
significant complexity.

It will be easy to offload in HW.

I do not believe that it will be a performance issue, if this is a concern then
we may have to do a bit of benchmarking, or we can make it a configuration
option.

Long story short, we (Horatiu and I) learned a lot from the discussion here, and
I think we should try do a new patch with the learning we got. Then it is easier
to see what it actually means to the exiting code, complexity, exiting drivers,
performance, default behavioral, backwards compatibly, and other valid concerns.

If the patch is no good, and cannot be fixed, then we will go back and look
further into alternative solutions.

-- 
/Allan


