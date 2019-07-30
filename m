Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hdNVC4
	8HSwrLeKagS8o1LvoZvG2m4JAu7E4slsc9mnQ=; b=Ksm1hmjJryH7wG44lWNn/t
	QG1EYxG+r2Xs9HfNAj8UOHoA9hvXLKaXnXMROP60tkrYhiuIMB0FhUPPj5/wPuzK
	+y3QfDqhnjp9MmXgKBLL+n9j1seSm22TzpGL0x3z7UfoT3pIA/P+rw0QSgH3nFGs
	MP4fwqdPgFYXFMNcAiueQgrdagZDEmy7j64wyp3FFMHHZ8pXRHkrspLkoq549X+V
	GiFjwuBQeP+/+jkoB42sYEH7HswPwx8fv7kJ6G/4uWUu3h64FtYIUvk6ITF9upgo
	MMGP1+DHXAixwTtVgyJL0d2fmTmtE9nruAwLfWc01zwjqTmUzbLmk6zxPwDognxQ
	==
Date: Tue, 30 Jul 2019 10:06:26 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20190730070626.GA508@splinter>
References: <b755f613-e6d8-a2e6-16cd-6f13ec0a6ddc@cumulusnetworks.com>
	<20190729121409.wa47uelw5f6l4vs4@lx-anielsen.microsemi.net>
	<95315f9e-0d31-2d34-ba50-11e1bbc1465c@cumulusnetworks.com>
	<20190729131420.tqukz55tz26jkg73@lx-anielsen.microsemi.net>
	<3cc69103-d194-2eca-e7dd-e2fa6a730223@cumulusnetworks.com>
	<20190729135205.oiuthcyesal4b4ct@lx-anielsen.microsemi.net>
	<e4cd0db9-695a-82a7-7dc0-623ded66a4e5@cumulusnetworks.com>
	<20190729143508.tcyebbvleppa242d@lx-anielsen.microsemi.net>
	<20190729175136.GA28572@splinter>
	<20190730062721.p4vrxo5sxbtulkrx@lx-anielsen.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730062721.p4vrxo5sxbtulkrx@lx-anielsen.microsemi.net>
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
To: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, Horatiu Vultur <horatiu.vultur@microchip.com>

On Tue, Jul 30, 2019 at 08:27:22AM +0200, Allan W. Nielsen wrote:
> The 07/29/2019 20:51, Ido Schimmel wrote:
> > Can you please clarify what you're trying to achieve? I just read the
> > thread again and my impression is that you're trying to locally receive
> > packets with a certain link layer multicast address.
> Yes. The thread is also a bit confusing because we half way through realized
> that we misunderstood how the multicast packets should be handled (sorry about
> that). To begin with we had a driver where multicast packets was only copied to
> the CPU if someone needed it. Andrew and Nikolay made us aware that this is not
> how other drivers are doing it, so we changed the driver to include the CPU in
> the default multicast flood-mask.

OK, so what prevents you from removing all other ports from the
flood-mask and letting the CPU handle the flooding? Then you can install
software tc filters to limit the flooding.

> This changes the objective a bit. To begin with we needed to get more packets to
> the CPU (which could have been done using tc ingress rules and a trap action).
> 
> Now after we changed the driver, we realized that we need something to limit the
> flooding of certain L2 multicast packets. This is the new problem we are trying
> to solve!
> 
> Example: Say we have a bridge with 4 slave interfaces, then we want to install a
> forwarding rule saying that packets to a given L2-multicast MAC address, should
> only be flooded to 2 of the 4 ports.
> 
> (instead of adding rules to get certain packets to the CPU, we are now adding
> other rules to prevent other packets from going to the CPU and other ports where
> they are not needed/wanted).
> 
> This is exactly the same thing as IGMP snooping does dynamically, but only for
> IP multicast.
> 
> The "bridge mdb" allow users to manually/static add/del a port to a multicast
> group, but still it operates on IP multicast address (not L2 multicast
> addresses).
> 
> > Nik suggested SIOCADDMULTI.
> It is not clear to me how this should be used to limit the flooding, maybe we
> can make some hacks, but as far as I understand the intend of this is maintain
> the list of addresses an interface should receive. I'm not sure this should
> influence how for forwarding decisions are being made.
> 
> > and I suggested a tc filter to get the packet to the CPU.
> The TC solution is a good solution to the original problem where wanted to copy
> more frames to the CPU. But we were convinced that this is not the right
> approach, and that the CPU by default should receive all multicast packets, and
> we should instead try to find a way to limit the flooding of certain frames as
> an optimization.

This can still work. In Linux, ingress tc filters are executed before the
bridge's Rx handler. The same happens in every sane HW. Ingress ACL is
performed before L2 forwarding. Assuming you have eth0-eth3 bridged and
you want to prevent packets with DMAC 01:21:6C:00:00:01 from egressing
eth2:

# tc filter add dev eth0 ingress pref 1 flower skip_sw \
	dst_mac 01:21:6C:00:00:01 action trap
# tc filter add dev eth2 egress pref 1 flower skip_hw \
	dst_mac 01:21:6C:00:00:01 action drop

The first filter is only present in HW ('skip_sw') and should result in
your HW passing you the sole copy of the packet.

The second filter is only present in SW ('skip_hw', not using HW egress
ACL that you don't have) and drops the packet after it was flooded by
the SW bridge.

As I mentioned earlier, you can install the filter once in your HW and
share it between different ports using a shared block. This means you
only consume one TCAM entry.

Note that this allows you to keep flooding all other multicast packets
in HW.

> > If you now want to limit the ports to which this packet is flooded, then
> > you can use tc filters in *software*:
> > 
> > # tc qdisc add dev eth2 clsact
> > # tc filter add dev eth2 egress pref 1 flower skip_hw \
> > 	dst_mac 01:21:6C:00:00:01 action drop
> Yes. This can work in the SW bridge.
> 
> > If you want to forward the packet in hardware and locally receive it,
> > you can chain several mirred action and then a trap action.
> I'm not I fully understand how this should be done, but it does sound like it
> becomes quite complicated. Also, as far as I understand it will mean that we
> will be using TCAM/ACL resources to do something that could have been done with
> a simple MAC entry.
> 
> > Both options avoid HW egress ACLs which your design does not support.
> True, but what is wrong with expanding the functionality of the normal
> forwarding/MAC operations to allow multiple destinations?
> 
> It is not an uncommon feature (I just browsed the manual of some common L2
> switches and they all has this feature).
> 
> It seems to fit nicely into the existing user-interface:
> 
> bridge fdb add    01:21:6C:00:00:01 port eth0
> bridge fdb append 01:21:6C:00:00:01 port eth1

Wouldn't it be better to instead extend the MDB entries so that they are
either keyed by IP or MAC? I believe FDB should remain as unicast-only.
As a bonus, existing drivers could benefit from it, as MDB entries are
already notified by MAC.

> 
> It seems that it can be added to the existing implementation with out adding
> significant complexity.
> 
> It will be easy to offload in HW.
> 
> I do not believe that it will be a performance issue, if this is a concern then
> we may have to do a bit of benchmarking, or we can make it a configuration
> option.
> 
> Long story short, we (Horatiu and I) learned a lot from the discussion here, and
> I think we should try do a new patch with the learning we got. Then it is easier
> to see what it actually means to the exiting code, complexity, exiting drivers,
> performance, default behavioral, backwards compatibly, and other valid concerns.
> 
> If the patch is no good, and cannot be fixed, then we will go back and look
> further into alternative solutions.

Overall, I tend to agree with Nik. I think your use case is too specific
to justify the amount of changes you want to make in the bridge driver.
We also provided other alternatives. That being said, you're more than
welcome to send the patches and we can continue the discussion then.
