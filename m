Date: Mon, 23 Mar 2009 15:45:17 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090323154517.2146a357@nehalam>
In-Reply-To: <20090323.152028.205335400.davem@davemloft.net>
References: <1237539869-30721-1-git-send-email-leoli@freescale.com>
	<20090323085122.4c9d21f2@nehalam>
	<20090323.152028.205335400.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net/bridge: use the maximum hard_header_len of
 ports for bridging device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: bridge@lists.linux-foundation.org, leoli@freescale.com, netdev@vger.kernel.org

On Mon, 23 Mar 2009 15:20:28 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Stephen Hemminger <shemminger@linux-foundation.org>
> Date: Mon, 23 Mar 2009 08:51:22 -0700
> 
> > That ensures big enough header for locally generated packets, but
> > any drivers that need bigger headroom still must handle bridged packets
> > that come in with smaller space. When bridging packets, the skb comes
> > from the allocation by the receiving driver. Almost all drivers will
> > use dev_alloc_skb() which will allocate NET_SKB_PAD (16) bytes of
> > additional headroom. This is used to hold copy of ethernet header for
> > the bridge/netfilter code.
> > 
> > So your patch is fine as an optimization but a driver can not safely
> > depend on any additional headroom. The driver must check if there
> > is space, and if no space is available, reallocate and copy.
> 
> We had some plans to deal with this kind of issue for wireless
> too.  Let me see if I can find the RFC patch from that discussion...
> 
> Here it is, similar code would be added to the ipv4/ipv6 forwarding
> paths:
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 7c1d446..6c06fba 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -600,6 +600,7 @@ struct net_device
>   * Cache line mostly used on receive path (including eth_type_trans())
>   */
>  	unsigned long		last_rx;	/* Time of last Rx	*/
> +	unsigned int		rx_alloc_extra;
>  	/* Interface address info used in eth_type_trans() */
>  	unsigned char		dev_addr[MAX_ADDR_LEN];	/* hw address, (before bcast 
>  							because most packets are unicast) */
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index bdd7c35..531e483 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -42,6 +42,22 @@ int br_dev_queue_push_xmit(struct sk_buff *skb)
>  		if (nf_bridge_maybe_copy_header(skb))
>  			kfree_skb(skb);
>  		else {
> +			unsigned int headroom = skb_headroom(skb);
> +			unsigned int hh_len = LL_RESERVED_SPACE(skb->dev);
> +
> +			if (headroom < hh_len) {
> +				struct net_device *in_dev;
> +				unsigned int extra;
> +
> +				in_dev = __dev_get_by_index(dev_net(skb->dev),
> +							    skb->iif);
> +				BUG_ON(!in_dev);
> +
> +				extra = hh_len - headroom;
> +				if (extra >= in_dev->rx_alloc_extra)
> +					in_dev->rx_alloc_extra = extra;
> +			}

So you dynamically compute the additional space but if the space was
an awkward size, could it cause driver to breaks alignment assumptions?

And you didn't fixup the skb that is about to gag in the skb to make
more space, so transmitting device driver (gfar) is going to overwrite or die.

In summary, good idea, but may not solve the problem
