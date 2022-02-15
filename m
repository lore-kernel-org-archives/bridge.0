Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=bmWs7vtYOdjuvvwPg
 cD4aK6GMKdAvyGQEW7yX9afD9o=; b=YaUAy0qmrRlAlVwxIfaMFCMJbOzuRyekE
 9i5CLlSU371jzIUMvM1Vlu2AdwGGBaUGzM/jLdnJ8a9k2wyfaRxnHp1txJwdBqnh
 ztv4lbGgc7vV+WqcAprik4l4TO1mlK8SgnZvA6iKSa8ZEQJQMYOzP9ugf/dp4TSB
 sKvbyy8AKcUwuANrarSjtvGeUziNv8SsHgch6Pb6C8KJ+irSMxBCSnEuRfIh7PLg
 3BaWOpiLol1tehmajD/98VFw9Oe1efcMN1430dzGbeXJRmgF6X+OIMPk8vz4U79z
 5zcf3gZnMBpJjZIMlQsNeuNSUvCJ1W/A9nwi3veP+us/UqL/q+j1w==
Date: Tue, 15 Feb 2022 15:42:36 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YgutzPtNjTIbovHM@shredder>
References: <20220211131426.5433-1-oleksandr.mazur@plvision.eu>
 <20220214211309.261bd9d6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <9429cc71-1b0f-7fe3-c9dc-12246a397e96@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9429cc71-1b0f-7fe3-c9dc-12246a397e96@nvidia.com>
Subject: Re: [Bridge] [PATCH] net: bridge: multicast: notify switchdev
 driver whenever MC processing gets disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Oleksandr Mazur <oleksandr.mazur@plvision.eu>, Vladimir Oltean <vladimir.oltean@nxp.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Tue, Feb 15, 2022 at 10:31:41AM +0200, Nikolay Aleksandrov wrote:
> (+CC Ido)
> On 15/02/2022 07:13, Jakub Kicinski wrote:
> > On Fri, 11 Feb 2022 15:14:26 +0200 Oleksandr Mazur wrote:
> >> Whenever bridge driver hits the max capacity of MDBs, it disables
> >> the MC processing (by setting corresponding bridge option), but never
> >> notifies switchdev about such change (the notifiers are called only upon
> >> explicit setting of this option, through the registered netlink interface).
> >>
> >> This could lead to situation when Software MDB processing gets disabled,
> >> but this event never gets offloaded to the underlying Hardware.
> >>
> >> Fix this by adding a notify message in such case.
> > 
> > Any comments on this one?
> > 
> > We have drivers offloading mdb so presumably this should have a Fixes
> > tag and go to net, right?
> 
> The change looks ok, but it'd be nice to get switchdev folks comment as well.
> About the tree, -net should be targeted. I think the issue has existed
> since mdb disabled could be offloaded, so the tag should be:
> 
> Fixes: 147c1e9b902c ("switchdev: bridge: Offload multicast disabled")

LGTM

Oleksandr, please mark future patches as net/net-next:
https://docs.kernel.org/networking/netdev-FAQ.html#how-do-i-indicate-which-tree-net-vs-net-next-my-patch-should-be-in
