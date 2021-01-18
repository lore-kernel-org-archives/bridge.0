Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=momAPEAeuzNBaNbFbzPT5l6PxnX+1Nj23GHXpiPAnqk=;
 b=bhkr+8SKAstd2FyFDndhiYuyAtccmA4p/9gT2FUto/irJsqbLXln8mBEYF6eWd5Ihfa3M0NqtuwxJ0y9RJqOKuSUrzrPFCELB/QCHZuOfLujlL9Bzw1300odvUoc9I8qg8DltDZ9XRLrJxhDdLiWeL6WFWco8sWGjfO5GpzlS7w=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 18 Jan 2021 21:27:36 +0000
Message-ID: <20210118212735.okoov5ndybszd6m5@skbuf>
References: <20210118181319.25419-1-rasmus.villemoes@prevas.dk>
 <20210118185618.75h45rjf6qqberic@soft-dev3.localdomain>
 <20210118194632.zn5yucjfibguemjq@skbuf>
 <20210118202036.wk2fuwa3hysg4dmj@soft-dev3.localdomain>
In-Reply-To: <20210118202036.wk2fuwa3hysg4dmj@soft-dev3.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2795B068D924114B9909A29669B28AC3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Jan 18, 2021 at 09:20:36PM +0100, Horatiu Vultur wrote:
> The 01/18/2021 19:46, Vladimir Oltean wrote:
> >
> > On Mon, Jan 18, 2021 at 07:56:18PM +0100, Horatiu Vultur wrote:
> > > The reason was to stay away from STP, because you can't run these two
> > > protocols at the same time. Even though in SW, we reuse port's state.
> > > In our driver(which is not upstreamed), we currently implement
> > > SWITCHDEV_ATTR_ID_MRP_PORT_STATE and just call the
> > > SWITCHDEV_ATTR_ID_PORT_STP_STATE.
> >
> > And isn't Rasmus's approach reasonable, in that it allows unmodified
> > switchdev drivers to offload MRP port states without creating
> > unnecessary code churn?
>
> I am sorry but I don't see this as the correct solution. In my opinion,
> I would prefer to have 3 extra lines in the driver and have a better
> view of what is happening. Than having 2 calls in the driver for
> different protocols.

I think the question boils down to: is a MRP-unaware driver expected to
work with the current bridge MRP code?

> If it is not a problem to have STP calls when you configure the MRP,
> then why not just remove SWITCHDEV_ATTR_ID_MRP_PORT_STATE?

Good question, why not?=
