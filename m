Message-ID: <C0170D0AF1277849A4B4518034F855DD0CFBFD@aiexchange.ai.aiinet.com>
From: "Eble, Dan" <DanE@aiinet.com>
Subject: RE: [Bridge] MTU Question
Date: Wed, 30 Jun 2004 14:03:28 -0400
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Stephen Hemminger' <shemminger@osdl.org>, Chris Shaw <chriss@watertech.com>
Cc: bridge@osdl.org

What if someone (or something) attempts to change the MTU on the port after
it has been added to the bridge?  Perhaps SIOCSIFMTU should do something
special for bridge ports, such as return -EBUSY, or maybe ask the bridge
whether or not the new MTU is acceptable?  If a port's MTU changes, the
bridge may have to adjust its own MTU to maintain consistency.  It could get
hairy.

I faced this question recently when trying to implement bridging over Cisco
HDLC.  I finally decided not to try to maintain consistency of MTUs between
two devices, but rather to drop *all* transmitted packets when the MTU of
the lower-layer device was insufficient to handle the largest possible
packets from the upper-layer device.  I decided that would be enough to
prevent someone from wrongly thinking they had configured it properly, since
not even a cheap a 64-byte ping would work.

Regards,
-- 
Dan Eble <dane@aiinet.com>  _____  .
Software Engineer          |  _  |/|
Applied Innovation Inc.    | |_| | |
http://www.aiinet.com/     |__/|_|_|


> -----Original Message-----
> From: bridge-bounces@lists.osdl.org 
> [mailto:bridge-bounces@lists.osdl.org] On Behalf Of Stephen Hemminger
> Sent: Wednesday, June 30, 2004 1:32 PM
> To: Chris Shaw
> Cc: bridge@osdl.org
> Subject: Re: [Bridge] MTU Question
> 
> 
> 
> Try the following (2.4) patch to allow bridge to be MTU aware.
> 
> diff -Nru a/net/bridge/br_device.c b/net/bridge/br_device.c
> --- a/net/bridge/br_device.c	2004-06-30 10:30:31 -07:00
> +++ b/net/bridge/br_device.c	2004-06-30 10:30:31 -07:00
> @@ -121,6 +121,22 @@
>  	return -1;
>  }
>  
> +static int br_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct net_bridge *br = dev->priv;
> +	int max_mtu;
> +
> +	read_lock_bh(&br->lock);
> +	max_mtu = br_min_mtu(br);
> +	read_unlock_bh(&br->lock);
> +
> +	if (new_mtu < 68 || new_mtu > max_mtu)
> +		return -EINVAL;
> +
> +	dev->mtu = new_mtu;
> +	return 0;
> +}
> +
>  void br_dev_setup(struct net_device *dev)
>  {
>  	memset(dev->dev_addr, 0, ETH_ALEN);
> @@ -134,4 +150,5 @@
>  	dev->accept_fastpath = br_dev_accept_fastpath;
>  	dev->tx_queue_len = 0;
>  	dev->set_mac_address = NULL;
> +	dev->change_mtu = br_change_mtu;
>  }
> diff -Nru a/net/bridge/br_if.c b/net/bridge/br_if.c
> --- a/net/bridge/br_if.c	2004-06-30 10:30:31 -07:00
> +++ b/net/bridge/br_if.c	2004-06-30 10:30:31 -07:00
> @@ -220,6 +220,24 @@
>  	return 0;
>  }
>  
> +int br_min_mtu(struct net_bridge *br)
> +{
> +	struct net_bridge_port *p;
> +	int mtu;
> +
> +	p = br->port_list;
> +	if (!p)
> +		mtu = 1500;
> +	else {
> +		mtu = p->dev->mtu;
> +		while ((p = p->next) != NULL) {
> +			if (p->dev->mtu < mtu)
> +				mtu = p->dev->mtu;
> +		}
> +	}
> +	return mtu;
> +}
> +
>  int br_add_if(struct net_bridge *br, struct net_device *dev)
>  {
>  	struct net_bridge_port *p;
> @@ -250,6 +268,7 @@
>  	br_fdb_insert(br, p, dev->dev_addr, 1);
>  	if ((br->dev.flags & IFF_UP) && (dev->flags & IFF_UP))
>  		br_stp_enable_port(p);
> +	br->dev.mtu = br_min_mtu(dev->priv);
>  	write_unlock_bh(&br->lock);
>  
>  	return 0;
> diff -Nru a/net/bridge/br_private.h b/net/bridge/br_private.h
> --- a/net/bridge/br_private.h	2004-06-30 10:30:31 -07:00
> +++ b/net/bridge/br_private.h	2004-06-30 10:30:31 -07:00
> @@ -164,6 +164,7 @@
>  			    int num);
>  extern void br_get_port_ifindices(struct net_bridge *br,
>  			   int *ifindices);
> +extern int br_min_mtu(struct net_bridge *br);
>  
>  /* br_input.c */
>  extern void br_handle_frame(struct sk_buff *skb);
> 
