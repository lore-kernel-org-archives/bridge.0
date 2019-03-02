Return-Path: <davem@davemloft.net>
Date: Fri, 01 Mar 2019 21:35:34 -0800 (PST)
Message-Id: <20190301.213534.1377083051741273069.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190228002916.24904-1-f.fainelli@gmail.com>
References: <20190228002916.24904-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] switchdev: Remove unused transaction
 item queue
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
Date: Wed, 27 Feb 2019 16:29:16 -0800

> There are no more in tree users of the
> switchdev_trans_item_{dequeue,enqueue} or switchdev_trans_item structure
> in the kernel since commit 00fc0c51e35b ("rocker: Change world_ops API
> and implementation to be switchdev independant").
> 
> Remove this unused code and update the documentation accordingly since.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks Florian.
