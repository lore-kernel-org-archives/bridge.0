Return-Path: <Horatiu.Vultur@microchip.com>
Date: Fri, 10 Jan 2020 17:04:56 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200110160456.enzomhfsce7bptu3@soft-dev3.microsemi.net>
References: <20200109150640.532-1-horatiu.vultur@microchip.com>
 <6f1936e9-97e5-9502-f062-f2925c9652c9@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <6f1936e9-97e5-9502-f062-f2925c9652c9@cumulusnetworks.com>
Subject: Re: [Bridge] [RFC net-next Patch 0/3] net: bridge: mrp: Add support
 for Media Redundancy Protocol(MRP)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: andrew@lunn.ch, jakub.kicinski@netronome.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vivien.didelot@gmail.com, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jiri@mellanox.com, jeffrey.t.kirsher@intel.com, dsahern@gmail.com, olteanv@gmail.com, davem@davemloft.net

Hi Nik,

> I agree with Stephen here, IMO you have to take note of how STP has progressed
> and that bringing it in the kernel was a mistake, these days mstpd has an active
> community and much better support which is being extended. This looks best implemented
> in user-space in my opinion with minimal kernel changes to support it. You could simply
> open a packet socket with a filter and work through that, you don't need new netlink
> sockets. I'm not familiar with the protocol so can't really be the judge of that, if
> you present a good argument for needing a new netlink socket for these packets - then
> sure, ok.

We are aware of the STP story, and in case of STP I do agree, it is much
better to have this in user-space. But while MRP has much in common with
STP, it also differs in some important areas.

Most importantly, MRP requires sending and receiving thousands of frames
per second. To achieve the 10ms recovery time, the tx period per
interface is 500us, on two interfaces, adding up to 4000 frames per
second to RX and 4000 to TX(if the ring is closed). And this is per
ring...

The CPU systems in the kind of switches we are working on can not handle
this load, and it was not meant to handle this. Instead the switch core
can do the periodic injection of frames and automatic terminate them.

In patch posted, we have not added this HW offload (we have this in our
internal repos, where we also have implemented the remaining part of the
protocol). The reason for this is that we wanted to do a proper SW
implementation and then HW offload it.

Looking back, I can see that what we have presented here could be done
equally good in user-space (roughly), but that is because the HW offload
is not part of this patch.

The problem in putting it in user-space is that we do not have a nice a
clean API where it is just putting a port in forwarding/blocking state
(like we have with STP). To do an abstraction that actually allow us to
utilize the HW to offload a protocol like MRP will very easy become too
specific for our SoC and rejected with that argument.

> 
> If you do decide to continue with the kernel version (which I would again discourage)
> a few general points (from a quick scan):
>  - the single 1.6+k line patch is just hard to review, please break it into more digestable
>    and logical pieces
We will work in this.

>  - the locking is wrong, also there're a few use-after-free bugs
Oops, that is not good - happy that you caught it. A hint on where,
would be great.

>  - please re-work the bridge integration code, it can be simplified and tests can be eliminated
We will have a second look at that.

>  - your netlink helpers usage is generally wrong and needs more work
Ok - some hints on what we did wrong would be great.

>  - use the already existing port states instead of adding new ones and you can avoid some tests in fast-path
I assume you want us to re-use the STP concept of forwarding/blocking
and relay on the checks it already has.

>  - perhaps look into using br_afspec() for configuration/retrieval initially ? I don't think you need the new rtm messages yet.
Is that a good example on how to do the netlink interface, and you want
us to use that as a reference?

>  - I'm sure I can go on, but I really think all of this should be put in user-space -
>    in-kernel STP is a great example of how _not_ to do it. :) As a bonus you'll avoid 90% of the
>    problems above just by making your own abstractions and using them for it.
Please continue.

We do not see any good paths for getting user-space based solutions
which actually does use the HW offloading accepted upstream. If this
path exists then we would like to understand it and evaluate it
properly.

-- 
/Horatiu
