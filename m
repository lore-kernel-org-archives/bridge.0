Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1611045163; x=1642581163;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=G/hEWC13mj/YXusXRb4k4j+VoxZpRlinQbs39jyecbo=;
 b=O6zwi4+8w6IztY5AbtOjQO/X5e/c3qXgcL5qKQ94JfwXiYCDm63Vr04N
 /Vu7N+8PGgszl5+y3MjocGiDXTYzHBRu5LW5UZURoJQy6cOWFUdeyys9e
 FG55TCrpNO8cI4JpnEqCr7i4kcZ3KPLkE73XtiHbSRz3jeuHln5ayl8Wa
 Gppmm+r1rDKlB/2s5aQLfYYIfMoU0IoU7elSCBsr0G2rOaUkYGWp96PMx
 Aq3cb8/v8GAEdxTJrKPPDaPnGoBWSCF6PVsBhljDSoC968GE7ZVQak9rG
 rNNZlavtT5vb7T+bSzlzzosfshqMNaCBp6H94thchiiFow6RkMb3IMGnb g==;
Date: Tue, 19 Jan 2021 09:32:40 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20210119083240.37cxv3lxi25hwduj@soft-dev3.localdomain>
References: <20210118181319.25419-1-rasmus.villemoes@prevas.dk>
 <20210118185618.75h45rjf6qqberic@soft-dev3.localdomain>
 <20210118194632.zn5yucjfibguemjq@skbuf>
 <20210118202036.wk2fuwa3hysg4dmj@soft-dev3.localdomain>
 <20210118212735.okoov5ndybszd6m5@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210118212735.okoov5ndybszd6m5@skbuf>
Subject: Re: [Bridge] [PATCH net] net: mrp: use stp state as substitute for
 unimplemented mrp state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

The 01/18/2021 21:27, Vladimir Oltean wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Mon, Jan 18, 2021 at 09:20:36PM +0100, Horatiu Vultur wrote:
> > The 01/18/2021 19:46, Vladimir Oltean wrote:
> > >
> > > On Mon, Jan 18, 2021 at 07:56:18PM +0100, Horatiu Vultur wrote:
> > > > The reason was to stay away from STP, because you can't run these two
> > > > protocols at the same time. Even though in SW, we reuse port's state.
> > > > In our driver(which is not upstreamed), we currently implement
> > > > SWITCHDEV_ATTR_ID_MRP_PORT_STATE and just call the
> > > > SWITCHDEV_ATTR_ID_PORT_STP_STATE.
> > >
> > > And isn't Rasmus's approach reasonable, in that it allows unmodified
> > > switchdev drivers to offload MRP port states without creating
> > > unnecessary code churn?
> >
> > I am sorry but I don't see this as the correct solution. In my opinion,
> > I would prefer to have 3 extra lines in the driver and have a better
> > view of what is happening. Than having 2 calls in the driver for
> > different protocols.
> 
> I think the question boils down to: is a MRP-unaware driver expected to
> work with the current bridge MRP code?

If the driver has switchdev support, then is not expected to work with
the current bridge MRP code.

For example, the Ocelot driver, it has switchdev support but no MRP
support so this is not expected to work.  The main reason is that MRP is
using as DMAC 01:15:4E:00:00:0x(where x is between 1-4) so then when
these frames will arrive to HW then they will just be flooded which is
the wrong behavior.

But, the Ocelot which is not MRP aware, it can behave as MRP node if the
callbacks are implemented. For example, in MRP you have a notion of MRC
(Client) which needs to forward MRP Test frames between 2 ports and copy
to CPU MRP TopologyChange frames and forward these frames between 2
ports. Then using some TCAM rules(match on DMAC and source port) you can
implement this because you can differentiate between Test and Topology
frames by using the last byte of the DMAC.

> 
> > If it is not a problem to have STP calls when you configure the MRP,
> > then why not just remove SWITCHDEV_ATTR_ID_MRP_PORT_STATE?
> 
> Good question, why not?

-- 
/Horatiu
