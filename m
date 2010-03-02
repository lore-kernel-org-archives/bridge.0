From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20100301161658.5a61143b@nehalam>
References: <20100301161658.5a61143b@nehalam>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 02 Mar 2010 08:43:52 +0100
Message-ID: <1267515832.2843.7.camel@edumazet-laptop>
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
> +static void br_dev_free(struct net_device *dev)
> +{
> +	struct net_bridge *br = netdev_priv(dev);
> +
> +	free_percpu(br->stats);
> +}
> +
>  void br_dev_setup(struct net_device *dev)
>  {
>  	random_ether_addr(dev->dev_addr);
>  	ether_setup(dev);
>  
>  	dev->netdev_ops = &br_netdev_ops;
> -	dev->destructor = free_netdev;
> +	dev->destructor = br_dev_free;
>  	SET_ETHTOOL_OPS(dev, &br_ethtool_ops);

Isnt free_netdev() missing after this change ?



