Return-Path: <davem@davemloft.net>
Date: Tue, 12 Feb 2019 09:50:30 -0800 (PST)
Message-Id: <20190212.095030.1445077555795164973.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190211211749.19847-1-f.fainelli@gmail.com>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/3] Remove getting
 SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: f.fainelli@gmail.com
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 11 Feb 2019 13:17:46 -0800

> AFAICT there is no code that attempts to get the value of the attribute
> SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS while it is used with
> switchdev_port_attr_set().
> 
> This is effectively no doing anything and it can slow down future work
> that tries to make modifications in these areas so remove that.

Series applied.

> David, there should be no dependency with previous patch series, but
> again, feedback from Ido and Jiri would be welcome in case this was
> added for a reason.

Ok, is there going to be another respin of that switchdev_ops removal
series?
