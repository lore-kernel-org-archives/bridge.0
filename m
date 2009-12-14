Message-ID: <4B26353A.9020005@trash.net>
Date: Mon, 14 Dec 2009 13:53:14 +0100
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <1259862720-28432-1-git-send-email-arnd@arndb.de>
	<1259862720-28432-3-git-send-email-arnd@arndb.de>
In-Reply-To: <1259862720-28432-3-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC] macvlan: add tap device backend
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Fischer,
	Anna" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Or Gerlitz <ogerlitz@voltaire.com>, Anthony Liguori <anthony@codemonkey.ws>, Edge Virtual Bridging <evb@yahoogroups.com>, davem@davemloft.net

Arnd Bergmann wrote:
> +static int macvtap_newlink(struct net *src_net,
> +			   struct net_device *dev,
> +			   struct nlattr *tb[],
> +			   struct nlattr *data[])
> +{
> +	struct device *classdev;
> +	dev_t devt;
> +	int err;
> +
> +	err = macvlan_common_newlink(src_net, dev, tb, data,
> +				     macvtap_receive, macvtap_forward);
> +	if (err)
> +		goto out;
> +
> +	devt = MKDEV(MAJOR(macvtap_major), dev->ifindex);
> +
> +	classdev = device_create(macvtap_class, &dev->dev, devt,
> +				 dev, "tap%d", dev->ifindex);
> +	if (IS_ERR(classdev)) {
> +		err = PTR_ERR(classdev);
> +		macvtap_del_queues(dev);
> +		macvlan_dellink(dev, NULL);

I think this may cause a double free since macvlan_dellink() will
free the device and rtnl_newlink() will free it again on error.

> +	}
> +
> +out:
> +	return err;
> +}
> +
> +static void macvtap_dellink(struct net_device *dev,
> +			    struct list_head *head)
> +{
> +	device_destroy(macvtap_class,
> +		       MKDEV(MAJOR(macvtap_major), dev->ifindex));
> +
> +	macvtap_del_queues(dev);
> +	macvlan_dellink(dev, head);
> +}
> +
> +static struct rtnl_link_ops macvtap_link_ops __read_mostly = {
> +	.kind		= "macvtap",
> +	.newlink	= macvtap_newlink,
> +	.dellink	= macvtap_dellink,
> +};
