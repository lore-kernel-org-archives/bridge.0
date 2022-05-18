Return-Path: <idosch@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpSb/21qjkovoW1tb8tzZzoiExteozu+k8+mwyWw6wo=;
 b=X6MDut2yFWxVz8/yDmCBmmyn8ODTH9bRwBmqoIGTa5TK0mzDqlvf4ufRlJwggE0moNdmaHO63NsD8m5dvat98QMhrONfhcH9G34klokF441m0D5H+DzAbBCifhXlbb6duI0OY5JRB/wU4c6a5Ki88Ly1Du8oSvkaIVxECMY1N0cIBGbTLAhQaOPRU3y6WW7fbr1LgF8tvmwD6u9rkY5e4MChhZ0dVoDrg+1yMKsPsnDc8eJrwPD/Bmd0cE7oVHW3eYBgt+l+nLLXLrxq2KFNZv4jawfZbwdRTBjyOOJTeOJ+7BLYnXkkPLQ2Bxs5R7s8wAH98OPGREEY5iivLmVahw==
Date: Wed, 18 May 2022 10:08:59 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YoSbi3EXYUwaBs1a@shredder>
References: <20220518005840.771575-1-andrew@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518005840.771575-1-andrew@lunn.ch>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v2 net] net: bridge: Clear offload_fwd_mark
 when passing frame up bridge interface.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ido Schimmel <idosch@mellanox.com>, netdev <netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>

On Wed, May 18, 2022 at 02:58:40AM +0200, Andrew Lunn wrote:
> It is possible to stack bridges on top of each other. Consider the
> following which makes use of an Ethernet switch:
> 
>        br1
>      /    \
>     /      \
>    /        \
>  br0.11    wlan0
>    |
>    br0
>  /  |  \
> p1  p2  p3
> 
> br0 is offloaded to the switch. Above br0 is a vlan interface, for
> vlan 11. This vlan interface is then a slave of br1. br1 also has a
> wireless interface as a slave. This setup trunks wireless lan traffic
> over the copper network inside a VLAN.
> 
> A frame received on p1 which is passed up to the bridge has the
> skb->offload_fwd_mark flag set to true, indicating that the switch has
> dealt with forwarding the frame out ports p2 and p3 as needed. This
> flag instructs the software bridge it does not need to pass the frame
> back down again. However, the flag is not getting reset when the frame
> is passed upwards. As a result br1 sees the flag, wrongly interprets
> it, and fails to forward the frame to wlan0.
> 
> When passing a frame upwards, clear the flag. This is the Rx
> equivalent of br_switchdev_frame_unmark() in br_dev_xmit().
> 
> Fixes: f1c2eddf4cb6 ("bridge: switchdev: Use an helper to clear forward mark")
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>
