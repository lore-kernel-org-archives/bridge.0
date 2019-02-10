Return-Path: <davem@davemloft.net>
Date: Sun, 10 Feb 2019 12:51:41 -0800 (PST)
Message-Id: <20190210.125141.566973237709654424.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <746bce08-5b5f-70c9-efb7-33b067929198@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
	<746bce08-5b5f-70c9-efb7-33b067929198@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 00/16] net: Remove switchdev_ops
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
Date: Sun, 10 Feb 2019 12:44:47 -0800

> I am going to submit a v3 which moves the port_attr_{get,set} to a
> switchdev notifier, but does not yet get rid of
> switchdev_port_attr_get() entirely since there is not a clear path yet
> to split the setting between non-sleeping and sleeping context.

Ok.
