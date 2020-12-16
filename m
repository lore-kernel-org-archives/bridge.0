Return-Path: <andrew@lunn.ch>
Date: Wed, 16 Dec 2020 16:42:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20201216154235.GE2901580@lunn.ch>
References: <20201213140710.1198050-1-vladimir.oltean@nxp.com>
 <20201213140710.1198050-7-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213140710.1198050-7-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH v3 net-next 6/7] net: dsa: listen for
 SWITCHDEV_{FDB, DEL}_ADD_TO_DEVICE on foreign bridge neighbors
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

On Sun, Dec 13, 2020 at 04:07:09PM +0200, Vladimir Oltean wrote:
> Some DSA switches (and not only) cannot learn source MAC addresses from
> packets injected from the CPU. They only perform hardware address
> learning from inbound traffic.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
