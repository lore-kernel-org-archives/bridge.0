Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5dWfQBlf5OfCEX63KNQKTMBrmuE9VEsWTKJ/CKEXQrc=;
 b=ZJMC377CEcG3jsRUzzY486AWcII4/CnqUc4avz8c/V9BImhMrKYjPuWS8H1/3yPFu0
 4jruOYgK/YW1tTACWYlmAuZj8ADXjyOvCaMQH+0ALt//OFIU+ajp4gVPhUEZt+y56AYy
 hDj/i43py82vHd/luggzigkGkH4mv4PAeX9+6uPttoyXQIh/3aSr9/nGVXYd87L9U4Us
 PKNIuEJgR6L1LwZZW9c6fypfZgluIxEnBPoEAUeLN6nMsiuBPEpWiqLU51yqmOzIl7zd
 dTZOA5PBiFceip5KejOW6Am/VGoTDc2gOPEeC5Thrgz7kZ8YE5rfv4egIgsQruWD7t+f
 Xhag==
Date: Thu, 6 May 2021 14:01:13 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210506110113.xeb6yzh6ycxr5nxi@skbuf>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-5-tobias@waldekranz.com>
 <YI6/li9hwHo8GfCm@shredder> <87eeeonqpb.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eeeonqpb.fsf@waldekranz.com>
Subject: Re: [Bridge] [RFC net-next 4/9] net: bridge: switchdev: Forward
	offloading
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, Ido Schimmel <idosch@idosch.org>, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Mon, May 03, 2021 at 10:53:36AM +0200, Tobias Waldekranz wrote:
> On Sun, May 02, 2021 at 18:04, Ido Schimmel <idosch@idosch.org> wrote:
> > On Mon, Apr 26, 2021 at 07:04:06PM +0200, Tobias Waldekranz wrote:
> >> +static void nbp_switchdev_fwd_offload_add(struct net_bridge_port *p)
> >> +{
> >> +	void *priv;
> >> +
> >> +	if (!(p->dev->features & NETIF_F_HW_L2FW_DOFFLOAD))
> >> +		return;
> >> +
> >> +	priv = p->dev->netdev_ops->ndo_dfwd_add_station(p->dev, p->br->dev);
> >
> > Some changes to team/bond/8021q will be needed in order to get this
> > optimization to work when they are enslaved to the bridge instead of the
> > front panel port itself?
> 
> Right you are. We should probably do something similar to the
> switchdev_handle_port_* family of helpers that could be reused in
> stacked devices. I will look at it for v1.

Makes sense, issuing a switchdev notifier of some sort will allow the
switchdev driver to act upon the bridge's request for a net device
belonging to a different driver.
