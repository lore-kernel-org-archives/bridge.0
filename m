Date: Wed, 25 Feb 2004 08:40:32 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040225084032.6918124d@dell_ss3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.44.0402251012130.31127-200000@dane-linux.aiinet.priv>
References: <Pine.LNX.4.44.0402251012130.31127-200000@dane-linux.aiinet.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re:BCP protocol
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: dane@aiinet.com
Cc: bridge@osdl.org, jwise03@harris.com

Could you work with 2.6 rather than 2.4?  It is highly unlikely that this will
ever be added to the now frozen 2.4 mainline. But new features will be added to 2.6.

Also, make it a configuration option to PPP.


> diff -wbBurN linux-2.4.21-pre4/drivers/net/ppp_generic.c linux-ai/drivers/net/ppp_generic.c
> --- linux-2.4.21-pre4/drivers/net/ppp_generic.c	2004-02-25 08:26:18.000000000 -0500
> +++ linux-ai/drivers/net/ppp_generic.c	2004-02-25 08:35:08.000000000 -0500

Could you put the bcp stuff in a separate file (ppp_bcp.c?) so that that would
make configuration easier and reduce ifdef's.


> +struct bcp_device {
> +	struct net_device dev;		/* ->priv points to struct ppp */
> +	struct net_device_stats stats;	/* statistics */
> +};
> +
> +/* this looks better than a cast in the code */
> +static __inline__ struct bcp_device* dev_to_bcp(struct net_device* dev)
> +{
> +	return (struct bcp_device*)dev;
> +}
> +
> +/* this looks better than a cast in the code */
> +static __inline__ struct net_device* bcp_to_dev(struct bcp_device* bcp)
> +{
> +	return (struct net_device*)bcp;
> +}
> +
> +static __inline__ struct ppp* bcp_to_ppp(struct bcp_device* bcp)
> +{
> +	return bcp ? (struct ppp *)bcp_to_dev(bcp)->priv : NULL;
> +}
> +

...

>  
> +/* Decapsulate a packet from BCP. */
> +static __inline__ struct sk_buff* bcp_decap(struct sk_buff *skb)
> +{
>
Don't use "__inline__" use "inline" except in rare cases where the code
breaks if it is not in line.

...
 
> +/*
> + * Create interface for bridging.
> + */
> +static int
> +ppp_create_bcp(struct ppp *ppp)
> +{
> +	struct bcp_device *bcp;
> +	struct net_device *dev;
> +	int ret;
> +
> +	/* If it already exists, ignore the request. */
> +	if (ppp->bcp)
> +		return 0;
> +
> +	/* create a new BCP dev */
> +	ret = -ENOMEM;
> +	bcp = kmalloc(sizeof(struct bcp_device), GFP_KERNEL);
> +	if (!bcp)
> +		goto err;
> +	memset(bcp, 0, sizeof(struct bcp_device));
> +	dev = bcp_to_dev(bcp);
> +
> +	ether_setup(dev);
> +
> +	dev->hard_header_len = ppp->dev->hard_header_len
> +		+ BCP_802_3_HDRLEN + ETH_HLEN;
> +
> +	/* ETH_FCS_LEN is not subtracted from the PPP MTU here because
> +	 * bcp_start_xmit() never adds the FCS. */
> +	dev->mtu = ppp->dev->mtu - (BCP_802_3_HDRLEN + ETH_HLEN);
> +
> +	if (dev->mtu > ETH_DATA_LEN)
> +		dev->mtu = ETH_DATA_LEN;
> +
> +	dev->hard_start_xmit = bcp_start_xmit;
> +	dev->get_stats = bcp_net_stats;
> +	dev->do_ioctl = bcp_net_ioctl;
> +	dev->change_mtu = bcp_net_change_mtu;
> +	dev->tx_queue_len = 0; /* let PPP device queue packets */
> +	dev->features |= NETIF_F_DYNALLOC;
> +	sprintf(dev->name, "bcp%d", ppp->file.index);
> +
> +	rtnl_lock();
> +	ret = register_netdevice(dev);
> +	rtnl_unlock();
> +	if (ret != 0) {
> +		printk(KERN_ERR "PPP: couldn't register device %s (%d)\n",
> +		       dev->name, ret);
> +		goto err;
>

On  2.6 this needs changing.
Don't use a kmalloc and let the network subsystem choose the device name!

	dev = alloc_netdev(sizeof(*bcp), "bcp%d", ether_setup);
	if (!dev)
		...
	bcp = netdev_priv(dev);

	...

	ret = register_netdev(dev);

	
