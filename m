Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SrelFilWkNCqMWTtWTsaQER91a43bb9aDaGJrJzpx28=;
 b=fN29fuadLoIjoJ3lYh5AXU15YL6yc/VKSSAktaUFmlRyspIJlsbWh9Gjy1epdJoOk+
 n/VH4IoUunjmLRDhYjb1kiPuyk5gSafqSWPutjzyyKmP0SogfpYcz8fa0KTw8Filc7h6
 TaOec4GvTg21xAXB7wFWpmBECOs6J+A76jOcKvoQNA1QLZVsxp/m+AbGrB66Ny3iiFhC
 bQx8nU1hxqxwY8HB2jt7bBC9GvZOmJdAW3cLU8pQv8/Olv9nMCUQh0nKlKZe3KRYqzzJ
 HI78D2PAnNURewal18UFjgcLniNbDohTxCtXOKd1L6rm6Nfy9E8JnBk0AfJYDzHUH900
 8XPA==
Date: Fri, 6 May 2022 08:05:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20220506080540.5bc6094b@hermes.local>
In-Reply-To: <YnR3XikvI4tQy5IL@lunn.ch>
References: <20220505225904.342388-1-andrew@lunn.ch>
 <20220505160720.27358a55@hermes.local> <YnR3XikvI4tQy5IL@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH RFC] net: bridge: Clear offload_fwd_mark when
 passing frame up bridge interface.
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

On Fri, 6 May 2022 03:18:22 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, May 05, 2022 at 04:07:20PM -0700, Stephen Hemminger wrote:
> > On Fri,  6 May 2022 00:59:04 +0200
> > Andrew Lunn <andrew@lunn.ch> wrote:
> >   
> > > It is possible to stack bridges on top of each other. Consider the
> > > following which makes use of an Ethernet switch:
> > > 
> > >        br1
> > >      /    \
> > >     /      \
> > >    /        \
> > >  br0.11    wlan0
> > >    |
> > >    br0
> > >  /  |  \
> > > p1  p2  p3
> > > 
> > > br0 is offloaded to the switch. Above br0 is a vlan interface, for
> > > vlan 11. This vlan interface is then a slave of br1. br1 also has
> > > wireless interface as a slave. This setup trunks wireless lan traffic
> > > over the copper network inside a VLAN.
> > > 
> > > A frame received on p1 which is passed up to the bridge has the
> > > skb->offload_fwd_mark flag set to true, indicating it that the switch
> > > has dealt with forwarding the frame out ports p2 and p3 as
> > > needed. This flag instructs the software bridge it does not need to
> > > pass the frame back down again. However, the flag is not getting reset
> > > when the frame is passed upwards. As a result br1 sees the flag,
> > > wrongly interprets it, and fails to forward the frame to wlan0.
> > > 
> > > When passing a frame upwards, clear the flag.
> > > 
> > > RFC because i don't know the bridge code well enough if this is the
> > > correct place to do this, and if there are any side effects, could the
> > > skb be a clone, etc.
> > > 
> > > Fixes: f1c2eddf4cb6 ("bridge: switchdev: Use an helper to clear forward mark")
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>  
> > 
> > Bridging of bridges is not supposed to be allowed.
> > See:
> > 
> > bridge:br_if.c
> > 
> > 	/* No bridging of bridges */
> > 	if (dev->netdev_ops->ndo_start_xmit == br_dev_xmit) {
> > 		NL_SET_ERR_MSG(extack,
> > 			       "Can not enslave a bridge to a bridge");
> > 		return -ELOOP;
> > 	}  
> 
> This is not direct bridging of bridges. There is a vlan interface in
> the middle. And even if it is not supposed to work, it does work, it
> is being used, and it regressed. This fixes the regression.
> 
>    Andrew

The problem is that doing this kind of nested bridging screws up
Spanning Tree.
