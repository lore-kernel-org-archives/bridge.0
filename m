Message-ID: <4A7FC27F.1090904@trash.net>
Date: Mon, 10 Aug 2009 08:47:27 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <1249595428-21594-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1249595428-21594-1-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] macvlan: add tap device backend
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
	Anna" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Or Gerlitz <ogerlitz@voltaire.com>, Edge Virtual Bridging <evb@yahoogroups.com>, davem@davemloft.net

Arnd Bergmann wrote:
> diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
> new file mode 100644
> index 0000000..d99bfc0
> --- /dev/null
> +++ b/drivers/net/macvtap.c
> +static int macvtap_open(struct inode *inode, struct file *file)
> +{
> +	struct net *net = current->nsproxy->net_ns;
> +	int ifindex = iminor(inode);
> +	struct net_device *dev = dev_get_by_index(net, ifindex);
> +	int err;
> +
> +	err = -ENODEV;
> +	if (!dev)
> +		goto out1;
> +
> +	file->private_data = netdev_priv(dev);
> +	err = 0;
> +out1:
> +	return err;
> +}

macvlan will remove all macvlan/vtap devices when the underlying
device in unregistered, at which time you need to release the
device references you're holding. I'd suggest to change the
macvlan_device_event() handler to use

vlan->dev->rtnl_link_ops->dellink(vlan->dev)

instead of macvlan_dellink() so the macvtap_dellink callback
is invoked.
