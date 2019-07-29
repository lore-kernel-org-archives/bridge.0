Return-Path: <Allan.Nielsen@microchip.com>
Date: Mon, 29 Jul 2019 16:35:09 +0200
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20190729143508.tcyebbvleppa242d@lx-anielsen.microsemi.net>
References: <b9ce433a-3ef7-fe15-642a-659c5715d992@cumulusnetworks.com>
	<e6ad982f-4706-46f9-b8f0-1337b09de350@cumulusnetworks.com>
	<20190726120214.c26oj5vks7g5ntwu@soft-dev3.microsemi.net>
	<b755f613-e6d8-a2e6-16cd-6f13ec0a6ddc@cumulusnetworks.com>
	<20190729121409.wa47uelw5f6l4vs4@lx-anielsen.microsemi.net>
	<95315f9e-0d31-2d34-ba50-11e1bbc1465c@cumulusnetworks.com>
	<20190729131420.tqukz55tz26jkg73@lx-anielsen.microsemi.net>
	<3cc69103-d194-2eca-e7dd-e2fa6a730223@cumulusnetworks.com>
	<20190729135205.oiuthcyesal4b4ct@lx-anielsen.microsemi.net>
	<e4cd0db9-695a-82a7-7dc0-623ded66a4e5@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <e4cd0db9-695a-82a7-7dc0-623ded66a4e5@cumulusnetworks.com>
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

The 07/29/2019 17:21, Nikolay Aleksandrov wrote:
> On 29/07/2019 16:52, Allan W. Nielsen wrote:
> > The 07/29/2019 15:50, Nikolay Aleksandrov wrote:
> >> On 29/07/2019 15:22, Nikolay Aleksandrov wrote:
> >>> Hi Allan,
> >>> On 29/07/2019 15:14, Allan W. Nielsen wrote:
> >>>> First of all, as mentioned further down in this thread, I realized that our
> >>>> implementation of the multicast floodmasks does not align with the existing SW
> >>>> implementation. We will change this, such that all multicast packets goes to the
> >>>> SW bridge.
> >>>>
> >>>> This changes things a bit, not that much.
> >>>>
> >>>> I actually think you summarized the issue we have (after changing to multicast
> >>>> flood-masks) right here:
> >>>>
> >>>> The 07/26/2019 12:26, Nikolay Aleksandrov wrote:
> >>>>>>> Actually you mentioned non-IP traffic, so the querier stuff is not a problem. This
> >>>>>>> traffic will always be flooded by the bridge (and also a copy will be locally sent up).
> >>>>>>> Thus only the flooding may need to be controlled.
> >>>>
> >>>> This seems to be exactly what we need.
> >>>>
> >>>> Assuming we have a SW bridge (br0) with 4 slave interfaces (eth0-3). We use this
> >>>> on a network where we want to limit the flooding of frames with dmac
> >>>> 01:21:6C:00:00:01 (which is non IP traffic) to eth0 and eth1.
> >>>>
> >>>> One way of doing this could potentially be to support the following command:
> >>>>
> >>>> bridge fdb add    01:21:6C:00:00:01 port eth0
> >>>> bridge fdb append 01:21:6C:00:00:01 port eth1
> >> And the fdbs become linked lists?
> > Yes, it will most likely become a linked list
> > 
> >> So we'll increase the complexity for something that is already supported by
> >> ACLs (e.g. tc) and also bridge per-port multicast flood flag ?
> > I do not think it can be supported with the facilities we have today in tc.
> > 
> > We can do half of it (copy more fraems to the CPU) with tc, but we can not limit
> > the floodmask of a frame with tc (say we want it to flood to 2 out of 4 slave
> > ports).
> Why not ? You attach an egress filter for the ports and allow that dmac on only
> 2 of the ports.
Because we want a solution which we eventually can offload in HW. And the HW
facilities we have is doing ingress processing (we have no egress ACLs in this
design), and if we try to offload an egress rule, with an ingress HW facility,
then we will run into other issues.

/Allan
