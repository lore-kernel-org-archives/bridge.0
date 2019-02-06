Return-Path: <davem@davemloft.net>
Date: Wed, 06 Feb 2019 13:50:50 -0800 (PST)
Message-Id: <20190206.135050.939253959263316807.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190206174546.23597-1-f.fainelli@gmail.com>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 00/12] net: Introduce
 ndo_get_port_parent_id()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: f.fainelli@gmail.com
Cc: devel@driverdev.osuosl.org, oss-drivers@netronome.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, linux-rdma@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed,  6 Feb 2019 09:45:34 -0800

> Based on discussion with Ido and feedback from Jakub there are clearly
> two classes of users that implement SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
> 
> - PF/VF drivers which typically only implement return the port's parent
>   ID, yet have to implement switchdev_port_attr_get() just for that
> 
> - Ethernet switch drivers: mlxsw, ocelot, DSA, etc. which implement more
>   attributes which we want to be able to eventually veto in the context
>   of the caller, thus making them candidates for using a blocking notifier
>   chain
> 
> Changes in v4:
 ..

Series applied, thanks Florian.

I'll push this out to net-next after my build tests complete.
