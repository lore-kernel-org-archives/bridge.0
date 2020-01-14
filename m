Return-Path: <Horatiu.Vultur@microchip.com>
Date: Tue, 14 Jan 2020 17:46:15 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200114164615.yvidcidrj24x4gcy@soft-dev3.microsemi.net>
References: <20200113124620.18657-1-horatiu.vultur@microchip.com>
 <20200113124620.18657-5-horatiu.vultur@microchip.com>
 <20200113140053.GE11788@lunn.ch>
 <20200113225751.jkkio4rztyuff4xj@soft-dev3.microsemi.net>
 <20200113233011.GF11788@lunn.ch>
 <20200114080856.wa7ljxyzaf34u4xj@soft-dev3.microsemi.net>
 <20200114132047.GG11788@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200114132047.GG11788@lunn.ch>
Subject: Re: [Bridge] [RFC net-next Patch v2 4/4] net: bridge: mrp:
 switchdev: Add HW offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: ivecera@redhat.com, jakub.kicinski@netronome.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vivien.didelot@gmail.com, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, dsahern@gmail.com, jiri@resnulli.us, olteanv@gmail.com, davem@davemloft.net

The 01/14/2020 14:20, Andrew Lunn wrote:
> 
> On Tue, Jan 14, 2020 at 09:08:56AM +0100, Horatiu Vultur wrote:
> > The 01/14/2020 00:30, Andrew Lunn wrote:
> > >
> > > Hi Horatiu
> > >
> > > It has been said a few times what the basic state machine should be in
> > > user space. A pure software solution can use raw sockets to send and
> > > receive MRP_Test test frames. When considering hardware acceleration,
> > > the switchdev API you have proposed here seems quite simple. It should
> > > not be too hard to map it to a set of netlink messages from userspace.
> >
> > Yes and we will try to go with this approach, to have a user space
> > application that contains the state machines and then in the kernel to
> > extend the netlink messages to map to the switchdev API.
> > So we will create a new RFC once we will have the user space and the
> > definition of the netlink messages.
> 
> Cool.
> 
> Before you get too far, we might want to discuss exactly how you pass
> these netlink messages. Do we want to make this part of the new
> ethtool Netlink implementation? Part of devlink? Extend the current
> bridge netlink interface used by userspae RSTP daemons? A new generic
> netlink socket?

We are not yet 100% sure. We were thinking to choose between extending
the bridge netlink interface or adding a new netlink socket.  I was
leaning to create a new netlink socket, because I think that would be
clearer and easier to understand. But I don't have much experience with
this, so in both cases I need to sit down and actually try to implement
it to see exactly.

> 
> Extending the bridge netlink interface might seem the most logical.
> The argument against it, is that the kernel bridge code probably does
> not need to know anything about this offloading. But it does allow you
> to make use of the switchdev API, so we have a uniform API between the
> network stack and drivers implementing offloading.
> 
>       Andrew

-- 
/Horatiu
