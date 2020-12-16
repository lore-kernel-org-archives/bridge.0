Return-Path: <andrew@lunn.ch>
Date: Wed, 16 Dec 2020 16:32:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20201216153248.GB2901580@lunn.ch>
References: <20201213140710.1198050-1-vladimir.oltean@nxp.com>
 <20201213140710.1198050-3-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213140710.1198050-3-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH v3 net-next 2/7] net: dsa: be louder when a
 non-legacy FDB operation fails
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

On Sun, Dec 13, 2020 at 04:07:05PM +0200, Vladimir Oltean wrote:
> The dev_close() call was added in commit c9eb3e0f8701 ("net: dsa: Add
> support for learning FDB through notification") "to indicate inconsistent
> situation" when we could not delete an FDB entry from the port.
> 
> bridge fdb del d8:58:d7:00:ca:6d dev swp0 self master
> 
> It is a bit drastic and at the same time not helpful if the above fails
> to only print with netdev_dbg log level, but on the other hand to bring
> the interface down.
> 
> So increase the verbosity of the error message, and drop dev_close().
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
