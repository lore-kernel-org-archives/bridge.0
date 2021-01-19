Return-Path: <andrew@lunn.ch>
Date: Tue, 19 Jan 2021 16:52:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <YAcAIcwfp8za9JUo@lunn.ch>
References: <20210118181319.25419-1-rasmus.villemoes@prevas.dk>
 <20210118185618.75h45rjf6qqberic@soft-dev3.localdomain>
 <20210118194632.zn5yucjfibguemjq@skbuf>
 <20210118202036.wk2fuwa3hysg4dmj@soft-dev3.localdomain>
 <20210118212735.okoov5ndybszd6m5@skbuf>
 <20210119083240.37cxv3lxi25hwduj@soft-dev3.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119083240.37cxv3lxi25hwduj@soft-dev3.localdomain>
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
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Vladimir Oltean <vladimir.oltean@nxp.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Tue, Jan 19, 2021 at 09:32:40AM +0100, Horatiu Vultur wrote:
> The 01/18/2021 21:27, Vladimir Oltean wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Mon, Jan 18, 2021 at 09:20:36PM +0100, Horatiu Vultur wrote:
> > > The 01/18/2021 19:46, Vladimir Oltean wrote:
> > > >
> > > > On Mon, Jan 18, 2021 at 07:56:18PM +0100, Horatiu Vultur wrote:
> > > > > The reason was to stay away from STP, because you can't run these two
> > > > > protocols at the same time. Even though in SW, we reuse port's state.
> > > > > In our driver(which is not upstreamed), we currently implement
> > > > > SWITCHDEV_ATTR_ID_MRP_PORT_STATE and just call the
> > > > > SWITCHDEV_ATTR_ID_PORT_STP_STATE.
> > > >
> > > > And isn't Rasmus's approach reasonable, in that it allows unmodified
> > > > switchdev drivers to offload MRP port states without creating
> > > > unnecessary code churn?
> > >
> > > I am sorry but I don't see this as the correct solution. In my opinion,
> > > I would prefer to have 3 extra lines in the driver and have a better
> > > view of what is happening. Than having 2 calls in the driver for
> > > different protocols.
> > 
> > I think the question boils down to: is a MRP-unaware driver expected to
> > work with the current bridge MRP code?
> 
> If the driver has switchdev support, then is not expected to work with
> the current bridge MRP code.

> 
> For example, the Ocelot driver, it has switchdev support but no MRP
> support so this is not expected to work.

Then ideally, we need switchdev core to be testing for the needed ops
and returning an error which prevents MRP being configured when it
cannot work.

       Andrew
