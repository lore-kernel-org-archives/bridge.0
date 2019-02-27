Return-Path: <davem@davemloft.net>
Date: Wed, 27 Feb 2019 12:40:19 -0800 (PST)
Message-Id: <20190227.124019.281722845670775310.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190227194432.725-1-f.fainelli@gmail.com>
References: <20190227194432.725-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 0/8] net: Remove switchdev_ops
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
Date: Wed, 27 Feb 2019 11:44:24 -0800

> This patch series completes the removal of the switchdev_ops by
> converting switchdev_port_attr_set() to use either the blocking
> (process) or non-blocking (atomic) notifier since we typically need to
> deal with both depending on where in the bridge code we get called from.
> 
> This was tested with the forwarding selftests and DSA hardware.
> 
> Ido, hopefully this captures your comments done on v1, if not, can you
> illustrate with some pseudo-code what you had in mind if that's okay?
> 
> Changes in v3:
> 
> - added Reviewed-by tags from Ido where relevant
> - added missing notifier_to_errno() in net/bridge/br_switchdev.c when
>   calling the atomic notifier for PRE_BRIDGE_FLAGS
> - kept mlxsw_sp_switchdev_init() in mlxsw/
> 
> Changes in v2:
> 
> - do not check for SWITCHDEV_F_DEFER when calling the blocking notifier
>   and instead directly call the atomic notifier from the single location
>   where this is required

Series applied, thanks Florian.

I'll push this out after my build tests complete.
