Return-Path: <Allan.Nielsen@microchip.com>
Date: Mon, 29 Jul 2019 14:14:10 +0200
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20190729121409.wa47uelw5f6l4vs4@lx-anielsen.microsemi.net>
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

Hi Nikolay,

First of all, as mentioned further down in this thread, I realized that our
implementation of the multicast floodmasks does not align with the existing SW
implementation. We will change this, such that all multicast packets goes to the
SW bridge.

This changes things a bit, not that much.

I actually think you summarized the issue we have (after changing to multicast
flood-masks) right here:

The 07/26/2019 12:26, Nikolay Aleksandrov wrote:
> >> Actually you mentioned non-IP traffic, so the querier stuff is not a problem. This
> >> traffic will always be flooded by the bridge (and also a copy will be locally sent up).
> >> Thus only the flooding may need to be controlled.

This seems to be exactly what we need.

Assuming we have a SW bridge (br0) with 4 slave interfaces (eth0-3). We use this
on a network where we want to limit the flooding of frames with dmac
01:21:6C:00:00:01 (which is non IP traffic) to eth0 and eth1.

One way of doing this could potentially be to support the following command:

bridge fdb add    01:21:6C:00:00:01 port eth0
bridge fdb append 01:21:6C:00:00:01 port eth1

On 25/07/2019 16:06, Nikolay Aleksandrov wrote:
> >>>>>>  In general NLM_F_APPEND is only used in vxlan, the bridge does not
> >>>>>>  handle that flag at all.  FDB is only for *unicast*, nothing is joined
> >>>>>>  and no multicast should be used with fdbs. MDB is used for multicast
> >>>>>>  handling, but both of these are used for forwarding.
This is true, and this should have been addressed in the patch, we were too
focused on setting up the offload patch in the driver, and forgot to do the SW
implementation.

Do you see any issues in supporting this flag, and updating the SW
forwarding in br_handle_frame_finish such that it can support/allow a FDB entry
to be a multicast?

/Allan

