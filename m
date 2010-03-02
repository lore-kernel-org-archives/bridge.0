From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20100301161658.5a61143b@nehalam>
References: <20100301161658.5a61143b@nehalam>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 02 Mar 2010 07:01:30 +0100
Message-ID: <1267509690.2843.5.camel@edumazet-laptop>
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
> The shared packet statistics are a potential source of slow down
> on bridged traffic. Convert to per-cpu array, but only keep those
> statistics which change per-packet.
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
> 
> ---
> 
>  net/bridge/br_device.c  |   43 ++++++++++++++++++++++++++++++++++++++-----
>  net/bridge/br_if.c      |    6 ++++++
>  net/bridge/br_input.c   |    5 +++--
>  net/bridge/br_private.h |    8 ++++++++
>  4 files changed, 55 insertions(+), 7 deletions(-)
> 
> --- a/net/bridge/br_device.c	2010-03-01 08:22:23.476657998 -0800
> +++ b/net/bridge/br_device.c	2010-03-01 15:31:36.737227465 -0800
> @@ -26,11 +26,12 @@ netdev_tx_t br_dev_xmit(struct sk_buff *
>  	const unsigned char *dest = skb->data;
>  	struct net_bridge_fdb_entry *dst;
>  	struct net_bridge_mdb_entry *mdst;
> +	struct br_cpu_netstats *brstats = this_cpu_ptr(br->stats);
>  
> -	BR_INPUT_SKB_CB(skb)->brdev = dev;
> +	brstats->tx_packets++;
> +	brstats->tx_bytes += skb->len;


On TX path, this is not really necessary, since we already dirtied
txq->lock before calling br_dev_xmit(), we can use txq->tx_packets and
txq->tx_bytes for free ?

>  
> -	dev->stats.tx_packets++;
> -	dev->stats.tx_bytes += skb->len;
> +	BR_INPUT_SKB_CB(skb)->brdev = dev;
>  
>  	skb_reset_mac_header(skb);
>  	skb_pull(skb, ETH_HLEN);
> @@ -81,6 +82,28 @@ static int br_dev_stop(struct net_device
>  	return 0;
>  }
>  


