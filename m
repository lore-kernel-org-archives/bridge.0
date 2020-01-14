Return-Path: <Horatiu.Vultur@microchip.com>
Date: Tue, 14 Jan 2020 09:08:56 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200114080856.wa7ljxyzaf34u4xj@soft-dev3.microsemi.net>
References: <20200113124620.18657-1-horatiu.vultur@microchip.com>
 <20200113124620.18657-5-horatiu.vultur@microchip.com>
 <20200113140053.GE11788@lunn.ch>
 <20200113225751.jkkio4rztyuff4xj@soft-dev3.microsemi.net>
 <20200113233011.GF11788@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200113233011.GF11788@lunn.ch>
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

The 01/14/2020 00:30, Andrew Lunn wrote:
> 
> Hi Horatiu
> 
> It has been said a few times what the basic state machine should be in
> user space. A pure software solution can use raw sockets to send and
> receive MRP_Test test frames. When considering hardware acceleration,
> the switchdev API you have proposed here seems quite simple. It should
> not be too hard to map it to a set of netlink messages from userspace.

Yes and we will try to go with this approach, to have a user space
application that contains the state machines and then in the kernel to
extend the netlink messages to map to the switchdev API.
So we will create a new RFC once we will have the user space and the
definition of the netlink messages.

> 
> Yet your argument for kernel, not user space, is you are worried about
> the parameters which need to be passed to the hardware offload engine.
> In order to win the argument for a kernel solution, we are going to
> need a better idea what you think this problem is. The MRP_Test is TLV
> based. Are there other things which could be in this message? Is that
> what you are worried about?

> 
> Thanks
>      Andrew

-- 
/Horatiu
