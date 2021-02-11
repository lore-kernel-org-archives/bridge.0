Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d6XXSm05yAYK7MxQIvnC5Li5SPel5Sylz9f4M9rMQbA=;
 b=OUpVDVStC18mNs0vHeJDSl9HhvfAaUXCjIMBhqAOBx/7YyyOhkZHLh0FvNoEIpIQPp
 q5mqfcwfXfWHy6u1lyayaQkL4hpnMlnbCwN+bm2WjpJB84rVzVFfiwZfp03pQpqJ7Mh5
 Zo5pJkfPKJxzv89/8m7f+eClZzRs7hpbwntEKuFECqZMe1voBfOfxlEOxPY+XGqTig4H
 QpMX59GSb1EV+H3F11emfCeFwYaqLBNjtpxXoxDE2iQl5BWaLcJpU6e7FVhusZ7iLsOo
 I33cVczpjAf9BYw298Dee57df69Lr0xNk51TRqQdD2H1nlt+V/ExxLzrrVizMRCjdoAa
 Dv0A==
References: <20210210091445.741269-1-olteanv@gmail.com>
 <20210210091445.741269-5-olteanv@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <90e52ca0-e068-9a9e-9310-51e4dcd4ab09@gmail.com>
Date: Wed, 10 Feb 2021 20:16:31 -0800
MIME-Version: 1.0
In-Reply-To: <20210210091445.741269-5-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 net-next 04/11] net: dsa: configure proper
 brport flags when ports leave the bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>



On 2/10/2021 1:14 AM, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> For a DSA switch port operating in standalone mode, address learning
> doesn't make much sense since that is a bridge function. In fact,
> address learning even breaks setups such as this one:
> 
>    +---------------------------------------------+
>    |                                             |
>    | +-------------------+                       |
>    | |        br0        |    send      receive  |
>    | +--------+-+--------+ +--------+ +--------+ |
>    | |        | |        | |        | |        | |
>    | |  swp0  | |  swp1  | |  swp2  | |  swp3  | |
>    | |        | |        | |        | |        | |
>    +-+--------+-+--------+-+--------+-+--------+-+
>           |         ^           |          ^
>           |         |           |          |
>           |         +-----------+          |
>           |                                |
>           +--------------------------------+
> 
> because if the switch has a single FDB (can offload a single bridge)
> then source address learning on swp3 can "steal" the source MAC address
> of swp2 from br0's FDB, because learning frames coming from swp2 will be
> done twice: first on the swp1 ingress port, second on the swp3 ingress
> port. So the hardware FDB will become out of sync with the software
> bridge, and when swp2 tries to send one more packet towards swp1, the
> ASIC will attempt to short-circuit the forwarding path and send it
> directly to swp3 (since that's the last port it learned that address on),
> which it obviously can't, because swp3 operates in standalone mode.
> 
> So DSA drivers operating in standalone mode should still configure a
> list of bridge port flags even when they are standalone. Currently DSA
> attempts to call dsa_port_bridge_flags with 0, which disables egress
> flooding of unknown unicast and multicast, something which doesn't make
> much sense. For the switches that implement .port_egress_floods - b53
> and mv88e6xxx, it probably doesn't matter too much either, since they
> can possibly inject traffic from the CPU into a standalone port,
> regardless of MAC DA, even if egress flooding is turned off for that
> port, but certainly not all DSA switches can do that - sja1105, for
> example, can't. So it makes sense to use a better common default there,
> such as "flood everything".
> 
> It should also be noted that what DSA calls "dsa_port_bridge_flags()"
> is a degenerate name for just calling .port_egress_floods(), since
> nothing else is implemented - not learning, in particular. But disabling
> address learning, something that this driver is also coding up for, will
> be supported by individual drivers once .port_egress_floods is replaced
> with a more generic .port_bridge_flags.
> 
> Previous attempts to code up this logic have been in the common bridge
> layer, but as pointed out by Ido Schimmel, there are corner cases that
> are missed when doing that:
> https://patchwork.kernel.org/project/netdevbpf/patch/20210209151936.97382-5-olteanv@gmail.com/
> 
> So, at least for now, let's leave DSA in charge of setting port flags
> before and after the bridge join and leave.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
