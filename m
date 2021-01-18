Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1610996181; x=1642532181;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8xW+Ib1Q2UKnK0aGyXk2bqJxeinADOf0EJFfNV6Zz5k=;
 b=oIBun8mzbJNgcejTsG+VJY8WnDkmApMmJZbq+8iuZihzKnaed0dTXqG2
 Hr/Kk4F7p2AZb6IJYG1g4un7xIwzUaLaDlpEqOM6vEVfoUcnDMMoVzJ3p
 4o1H6JFTpk3fOCrda1PvJWNu2gCWdQBDkXhRFHR6NfdQZrYFATvZY1czg
 laW7Tr3TIuWUQGlYvzbGav6Yz6oHUtmNcQciE1b1i9278JjEDONoWDnmw
 6DhG2zAqsQkkGs8ECRIUji9nTWMTOPtfOPcpX7Rk1AH8tjpFFwhPGnb1E
 VFZLaTiccUw2fhHAO/IbX4Ep/tW2d+xWxpOF5utZEWuOaab9c+FMoZjJ7 g==;
Date: Mon, 18 Jan 2021 19:56:18 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20210118185618.75h45rjf6qqberic@soft-dev3.localdomain>
References: <20210118181319.25419-1-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210118181319.25419-1-rasmus.villemoes@prevas.dk>
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
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

The 01/18/2021 19:13, Rasmus Villemoes wrote:
> 

Hi Rasmus,

> When using MRP with hardware that does understand the concept of
> blocked or forwarding ports, but not the full MRP offload, we
> currently fail to tell the hardware what state it should put the port
> in when the ring is closed - resulting in a ring of forwarding ports
> and all the trouble that comes with that.

But why don't you implement the SWITCHDEV_ATTR_ID_MRP_PORT_STATE in your
driver? if already the HW understands the concept of block or forwarding?

> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> 
> I don't really understand why SWITCHDEV_ATTR_ID_MRP_PORT_STATE even
> has to exist seperately from SWITCHDEV_ATTR_ID_PORT_STP_STATE, and
> it's hard to tell what the difference might be since no kernel code
> implements the former.

The reason was to stay away from STP, because you can't run these two
protocols at the same time. Even though in SW, we reuse port's state.
In our driver(which is not upstreamed), we currently implement
SWITCHDEV_ATTR_ID_MRP_PORT_STATE and just call the
SWITCHDEV_ATTR_ID_PORT_STP_STATE.

> 
>  net/bridge/br_mrp_switchdev.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/net/bridge/br_mrp_switchdev.c b/net/bridge/br_mrp_switchdev.c
> index ed547e03ace1..8a1c7953e57a 100644
> --- a/net/bridge/br_mrp_switchdev.c
> +++ b/net/bridge/br_mrp_switchdev.c
> @@ -180,6 +180,24 @@ int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
>         int err;
> 
>         err = switchdev_port_attr_set(p->dev, &attr);
> +       if (err == -EOPNOTSUPP) {
> +               attr.id = SWITCHDEV_ATTR_ID_PORT_STP_STATE;
> +               switch (state) {
> +               case BR_MRP_PORT_STATE_DISABLED:
> +               case BR_MRP_PORT_STATE_NOT_CONNECTED:
> +                       attr.u.stp_state = BR_STATE_DISABLED;
> +                       break;
> +               case BR_MRP_PORT_STATE_BLOCKED:
> +                       attr.u.stp_state = BR_STATE_BLOCKING;
> +                       break;
> +               case BR_MRP_PORT_STATE_FORWARDING:
> +                       attr.u.stp_state = BR_STATE_FORWARDING;
> +                       break;
> +               default:
> +                       return err;
> +               };
> +               err = switchdev_port_attr_set(p->dev, &attr);
> +       }
>         if (err && err != -EOPNOTSUPP)
>                 br_warn(p->br, "error setting offload MRP state on port %u(%s)\n",
>                         (unsigned int)p->port_no, p->dev->name);
> --
> 2.23.0
> 

-- 
/Horatiu
