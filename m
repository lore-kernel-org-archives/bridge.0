Return-Path: <davem@davemloft.net>
Date: Wed, 10 Feb 2021 15:34:06 -0800 (PST)
Message-Id: <20210210.153406.1774734837784815987.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20210210091445.741269-8-olteanv@gmail.com>
References: <20210210091445.741269-1-olteanv@gmail.com>
 <20210210091445.741269-8-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 net-next 07/11] net: prep switchdev drivers
 for concurrent SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: olteanv@gmail.com
Cc: ivecera@redhat.com, andrew@lunn.ch, alexandre.belloni@bootlin.com, f.fainelli@gmail.com, jiri@resnulli.us, vkochan@marvell.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, ioana.ciornei@nxp.com, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, tchornyi@marvell.com, idosch@idosch.org, claudiu.manoil@nxp.com, grygorii.strashko@ti.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, linux-omap@vger.kernel.org, vivien.didelot@gmail.com

From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed, 10 Feb 2021 11:14:41 +0200

> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Because the bridge will start offloading SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
> while not serialized by any lock such as the br->lock spinlock, existing
> drivers that treat that attribute and cache the brport flags might no
> longer work correctly.
> 
> The issue is that the brport flags are a single unsigned long bitmask,
> and the bridge only guarantees the validity of the changed bits, not the
> full state. So when offloading two concurrent switchdev attributes, such
> as one for BR_LEARNING and another for BR_FLOOD, it might happen that
> the flags having BR_FLOOD are written into the cached value, and this in
> turn disables the BR_LEARNING bit which was set previously.
> 
> We can fix this across the board by keeping individual boolean variables
> for each brport flag. Note that mlxsw and prestera were setting the
> BR_LEARNING_SYNC flag too, but that appears to be just dead code, so I
> removed it.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>


This needs updating because, as discussed, there is no race.
