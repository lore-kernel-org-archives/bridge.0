From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20100301161658.5a61143b@nehalam>
References: <20100301161658.5a61143b@nehalam>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 02 Mar 2010 08:51:42 +0100
Message-ID: <1267516302.2843.12.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH]  bridge: per-cpu packet statistics
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

Le lundi 01 mars 2010 à 16:16 -0800, Stephen Hemminger a écrit :
> --- a/net/bridge/br_if.c	2010-03-01 08:22:23.476657998 -0800
> +++ b/net/bridge/br_if.c	2010-03-01 15:30:47.733227819 -0800
> @@ -185,6 +185,12 @@ static struct net_device *new_bridge_dev
>  	br = netdev_priv(dev);
>  	br->dev = dev;
>  
> +	br->stats = alloc_percpu(sizeof(struct br_cpu_netstats));
> +	if (!br->stats) {
> +		free_netdev(dev);
> +		return NULL;
> +	}
> +

Strange... this should be :

	nr->stats = alloc_percpu(struct br_cpu_netstats);

Or even better, ask percpu allocator an aligned chunk 
(2 or 4 longs) instead of (1 long)

	nr->stats = __alloc_percpu(sizeof(struct br_cpu_netstats),
				   4 * sizeof(long));


