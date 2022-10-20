Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4807401E1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF96640198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fdvrcAZE1EPFKfjlz9uiWm6tLrgoi3e11AtXEZMwK1w=;
 b=IWGLeBFGsZqMWZu8NBa/5dv5ja5/cw8FaXj7wp6edzJDwcLJj6NIDrLC+M4WHRna9D
 W/HVQMcSF6esNg0rdN16No22xc3RXNXtqC+d9MIwWWH6OraR3CEpdZlZkXd0vUfIPJmc
 r76gdPx5puJhBChIud7soYMaAJ0xDETQQUIVLRMeRctA0r9t2d7V5VzVBTljkqjwVwzN
 xk+sjzPjB9NuQXcw43TV0QX8WHVLExkPruQp0pob9BJFWnTMsxqoV6Lp9yXB/rKr+P2X
 2pqwPSREhVfXotOpf0+Nbs64TnnBegLM9Dc0G+er8ZPI55mGP3UBqvZXxq5cUyuqaNJQ
 NTRQ==
Date: Thu, 20 Oct 2022 15:55:49 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221020125549.v6kls2lk7etvay7c@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-4-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018165619.134535-4-netdev@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v8 net-next 03/12] net: bridge: enable bridge
 to install locked fdb entries from drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florent Fourcot <florent.fourcot@wifirst.fr>, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Tue, Oct 18, 2022 at 06:56:10PM +0200, Hans J. Schultz wrote:
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 8f3d76c751dd..c6b938c01a74 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -136,6 +136,7 @@ static void br_switchdev_fdb_populate(struct net_bridge *br,
>  	item->added_by_user = test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
>  	item->offloaded = test_bit(BR_FDB_OFFLOADED, &fdb->flags);
>  	item->is_local = test_bit(BR_FDB_LOCAL, &fdb->flags);
> +	item->locked = test_bit(BR_FDB_LOCKED, &fdb->flags);

Shouldn't this be set to 0 here, since it is the bridge->driver
direction?

>  	item->info.dev = (!p || item->is_local) ? br->dev : p->dev;
>  	item->info.ctx = ctx;
>  }
> -- 
> 2.34.1
> 
