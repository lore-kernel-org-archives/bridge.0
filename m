Return-Path: <andrew@lunn.ch>
Date: Wed, 16 Dec 2020 16:43:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20201216154300.GF2901580@lunn.ch>
References: <20201213140710.1198050-1-vladimir.oltean@nxp.com>
 <20201213140710.1198050-8-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213140710.1198050-8-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH v3 net-next 7/7] net: dsa: ocelot: request DSA
 to fix up lack of address learning on CPU port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Marek Behun <marek.behun@nic.cz>, Vivien Didelot <vivien.didelot@gmail.com>, UNGLinuxDriver@microchip.com, Tobias Waldekranz <tobias@waldekranz.com>

On Sun, Dec 13, 2020 at 04:07:10PM +0200, Vladimir Oltean wrote:
> Given the following setup:
> 
> ip link add br0 type bridge
> ip link set eno0 master br0
> ip link set swp0 master br0
> ip link set swp1 master br0
> ip link set swp2 master br0
> ip link set swp3 master br0
> 
> Currently, packets received on a DSA slave interface (such as swp0)
> which should be routed by the software bridge towards a non-switch port
> (such as eno0) are also flooded towards the other switch ports (swp1,
> swp2, swp3) because the destination is unknown to the hardware switch.
> 
> This patch addresses the issue by monitoring the addresses learnt by the
> software bridge on eno0, and adding/deleting them as static FDB entries
> on the CPU port accordingly.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
