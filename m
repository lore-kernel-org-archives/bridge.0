Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CfDqyLnGO3R9/tU1jtuvsLPKqTHeoZerZQhn3YtIEsc=;
 b=E3fVlR4xZaBsMMv+21Fv5aZrG8FFOnIjWjgdf0ZmLsS5U3gV9ZaZrxuDp3xTBZ2T+K
 kuRT+/+NUWacStSYy42F9qqE+2Tyek3I8oy+GJCFJkC68gPBAdgzbGk7j+7w3Axnjzu1
 sxoX5Bu77e3pJv6Y0F3P3VFWzz7wLgsn2M48PyHWtRy/0Vf1/todm2dM5v5HZN1fHN08
 ebiihzg4kqsnWRD1KnKL+/Fv+ax1Zz0tiMS7STzT6HohSZ3zUMdxCanKjFxUR5tnZ/Dr
 jOVwzPE5XWzxs4Yk724Xf+p9uC7QCnj0EGFKRKru6R0DipSjlnY8F6w3JGilvsxzj2M8
 i3gQ==
Date: Tue, 9 Feb 2021 20:27:24 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210209182724.b4funpoqh6kgoj6z@skbuf>
References: <20210209151936.97382-1-olteanv@gmail.com>
 <20210209151936.97382-3-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209151936.97382-3-olteanv@gmail.com>
Subject: Re: [Bridge] [PATCH v2 net-next 02/11] net: bridge: offload all
 port flags at once in br_setport
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

On Tue, Feb 09, 2021 at 05:19:27PM +0200, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> The br_switchdev_set_port_flag function uses the atomic notifier call
> chain because br_setport runs in an atomic section (under br->lock).
> This is because port flag changes need to be synchronized with the data
> path. But actually the switchdev notifier doesn't need that, only
> br_set_port_flag does. So we can collect all the port flag changes and
> only emit the notification at the end, then revert the changes if the
> switchdev notification failed.
> 
> There's also the other aspect: if for example this command:
> 
> ip link set swp0 type bridge_slave flood off mcast_flood off learning off
> 
> succeeded at configuring BR_FLOOD and BR_MCAST_FLOOD but not at
> BR_LEARNING, there would be no attempt to revert the partial state in
> any way. Arguably, if the user changes more than one flag through the
> same netlink command, this one _should_ be all or nothing, which means
> it should be passed through switchdev as all or nothing.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
(...)
> +	spin_lock_bh(&p->br->lock);
> +
> +	old_flags = p->flags;
> +	br_vlan_tunnel_old = (old_flags & BR_VLAN_TUNNEL) ? true : false;
> +
> +	br_set_port_flag(p, tb, IFLA_BRPORT_MODE, BR_HAIRPIN_MODE);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_GUARD, BR_BPDU_GUARD);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_FAST_LEAVE,
> +			 BR_MULTICAST_FAST_LEAVE);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_PROTECT, BR_ROOT_BLOCK);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_LEARNING, BR_LEARNING);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_UNICAST_FLOOD, BR_FLOOD);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_MCAST_FLOOD, BR_MCAST_FLOOD);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_MCAST_TO_UCAST,
> +			 BR_MULTICAST_TO_UNICAST);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_BCAST_FLOOD, BR_BCAST_FLOOD);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_PROXYARP, BR_PROXYARP);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_PROXYARP_WIFI, BR_PROXYARP_WIFI);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_VLAN_TUNNEL, BR_VLAN_TUNNEL);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS, BR_NEIGH_SUPPRESS);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
> +
> +	changed_mask = old_flags ^ p->flags;
> +
> +	spin_unlock_bh(&p->br->lock);
> +
> +	err = br_switchdev_set_port_flag(p, p->flags, changed_mask);
> +	if (err) {
> +		spin_lock_bh(&p->br->lock);
> +		p->flags = old_flags;
> +		spin_unlock_bh(&p->br->lock);
>  		return err;
> +	}
>  

I know it's a bit strange to insert this in the middle of review, but
bear with me.

While I was reworking the patch series to also make sysfs non-atomic,
like this:

-----------------------------[cut here]-----------------------------
From 6ff6714b6686e4f9406425edf15db6c92e944954 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 9 Feb 2021 19:43:40 +0200
Subject: [PATCH] net: bridge: temporarily drop br->lock for
 br_switchdev_set_port_flag in sysfs

Since we would like br_switchdev_set_port_flag to not use an atomic
notifier, it should be called from outside spinlock context.

Dropping the lock creates some concurrency complications:
- There might be an "echo 1 > multicast_flood" simultaneous with an
  "echo 0 > multicast_flood". The result of this is nondeterministic
  either way, so I'm not too concerned as long as the result is
  consistent (no other flags have changed).
- There might be an "echo 1 > multicast_flood" simultaneous with an
  "echo 0 > learning". My expectation is that none of the two writes are
  "eaten", and the final flags contain BR_MCAST_FLOOD=1 and BR_LEARNING=0
  regardless of the order of execution. That is actually possible if, on
  the commit path, we don't do a trivial "p->flags = flags" which might
  overwrite bits outside of our mask, but instead we just change the
  flags corresponding to our mask.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/bridge/br_sysfs_if.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 62540b31e356..b419d9aad548 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -68,17 +68,23 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
 	else
 		flags &= ~mask;
 
-	if (flags != p->flags) {
-		err = br_switchdev_set_port_flag(p, flags, mask, &extack);
-		if (err) {
-			if (extack._msg)
-				netdev_err(p->dev, "%s\n", extack._msg);
-			return err;
-		}
+	if (flags == p->flags)
+		return 0;
 
-		p->flags = flags;
-		br_port_flags_change(p, mask);
+	spin_unlock_bh(&p->br->lock);
+	err = br_switchdev_set_port_flag(p, flags, mask, &extack);
+	spin_lock_bh(&p->br->lock);
+	if (err) {
+		if (extack._msg)
+			netdev_err(p->dev, "%s\n", extack._msg);
+		return err;
 	}
+
+	p->flags &= ~mask;
+	p->flags |= (flags & mask);
+
+	br_port_flags_change(p, mask);
+
 	return 0;
 }
 
-----------------------------[cut here]-----------------------------

I figured there's a similar problem in this patch, which I had missed.
The code now looks like this:

	changed_mask = old_flags ^ p->flags;
	flags = p->flags;

	spin_unlock_bh(&p->br->lock);

	err = br_switchdev_set_port_flag(p, flags, changed_mask, extack);
	if (err) {
		spin_lock_bh(&p->br->lock);
		p->flags &= ~changed_mask;
		p->flags |= (old_flags & changed_mask);
		spin_unlock_bh(&p->br->lock);
		return err;
	}

	spin_lock_bh(&p->br->lock);

where I no longer access p->flags directly when calling
br_switchdev_set_port_flag (because I'm not protected by br->lock) but a
copy of it saved on stack. Also, I restore just the mask portion of
p->flags.

But there's an interesting side effect of allowing
br_switchdev_set_port_flag to run concurrently (notifier call chains use
a rw_semaphore and only take the read side). Basically now drivers that
cache the brport flags in their entirety are broken, because there isn't
any guarantee that bits outside the mask are valid any longer (we can
even enforce that by masking the flags with the mask when notifying
them). They would need to do the same trick of updating just the masked
part of their cached flags. Except for the fact that they would need
some sort of spinlock too, I don't think that the basic bitwise
operations are atomic or anything like that. I'm a bit reluctant to add
a spinlock in prestera, rocker, mlxsw just for this purpose. What do you
think?
