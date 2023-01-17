Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6557F60E40
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85BCB60E29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wzoFsN2BtIwkV7J9p1OybyavGXclmQ9kcPW4uj8vI+4=;
 b=WHkz1zPwXkTNrAiIJUYxeLo3UGJReyuX52LQMNDjwPjA7k3W/kAYzvCsEzteUoEbu4
 yPAJWqnKYjN3T9Y0xfzCw8HsGJQdEZTqj4u0qMr0hYP9TSroZy6ZGbd1QX0+RpWNR5h/
 OigdrmABYXR+MFv/Ar3o2IjM9bOQZkEATabOuTvlr4F6PSGsFeKKtNt4P6DfO8grzL8a
 Wlt6QM8UkV7I4gD+iqf96i0VPn97OK4iwvJSA5WSIRl3e3GhvaJZFO4S+kKSuRBvmNOP
 8p7Mgj/QnaBU9sQdFLHhnetF3dMl9apL4Ry5w8QJZIcBcBEM2uC+DT6QDtQpH8K0QaS4
 1+vA==
Date: Wed, 18 Jan 2023 01:17:50 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230117231750.r5jr4hwvpadgopmf@skbuf>
References: <20230117185714.3058453-1-netdev@kapio-technology.com>
 <20230117185714.3058453-3-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117185714.3058453-3-netdev@kapio-technology.com>
Subject: Re: [Bridge] [RFC PATCH net-next 2/5] net: dsa: propagate flags
 down towards drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On Tue, Jan 17, 2023 at 07:57:11PM +0100, Hans J. Schultz wrote:
> Dynamic FDB flag needs to be propagated through the DSA layer to be
> added to drivers.
> Use a u16 for fdb flags for future use, so that other flags can also be
> sent the same way without having to change function interfaces.
> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> ---
> @@ -3364,6 +3368,7 @@ static int dsa_slave_fdb_event(struct net_device *dev,
>  	struct dsa_port *dp = dsa_slave_to_port(dev);
>  	bool host_addr = fdb_info->is_local;
>  	struct dsa_switch *ds = dp->ds;
> +	u16 fdb_flags = 0;
>  
>  	if (ctx && ctx != dp)
>  		return 0;
> @@ -3410,6 +3415,9 @@ static int dsa_slave_fdb_event(struct net_device *dev,
>  		   orig_dev->name, fdb_info->addr, fdb_info->vid,
>  		   host_addr ? " as host address" : "");
>  
> +	if (fdb_info->is_dyn)
> +		fdb_flags |= DSA_FDB_FLAG_DYNAMIC;
> +

Hmm, I don't think this is going to work with the assisted_learning_on_cpu_port
feature ("if (switchdev_fdb_is_dynamically_learned(fdb_info))"). The reason being
that a "dynamically learned" FDB entry (defined as this):

static inline bool
switchdev_fdb_is_dynamically_learned(const struct switchdev_notifier_fdb_info *fdb_info)
{
	return !fdb_info->added_by_user && !fdb_info->is_local;
}

is also dynamic in the DSA_FDB_FLAG_DYNAMIC sense. But we install a
static FDB entry for it on the CPU port.

And in your follow-up patch 3/5, you make all drivers except mv88e6xxx
ignore all DSA_FDB_FLAG_DYNAMIC entries (including the ones snooped from
address learning on software interfaces). So this breaks those drivers
which don't implement DSA_FDB_FLAG_DYNAMIC but do set ds->assisted_learning_on_cpu_port
to true.

I think you also want to look at the added_by_user flag to disambiguate
between a dynamic FDB entry added from learning (which it's ok to
offload as static, because software ageing will remove it) and one added
by the user.

>  	INIT_WORK(&switchdev_work->work, dsa_slave_switchdev_event_work);
>  	switchdev_work->event = event;
>  	switchdev_work->dev = dev;
> @@ -3418,6 +3426,7 @@ static int dsa_slave_fdb_event(struct net_device *dev,
>  	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
>  	switchdev_work->vid = fdb_info->vid;
>  	switchdev_work->host_addr = host_addr;
> +	switchdev_work->fdb_flags = fdb_flags;
>  
>  	dsa_schedule_work(&switchdev_work->work);
>  
