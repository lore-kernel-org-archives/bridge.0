From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 9 Aug 2009 20:42:24 +0000
References: <1249595428-21594-1-git-send-email-arnd@arndb.de>
	<20090809080215.GA17200@redhat.com>
In-Reply-To: <20090809080215.GA17200@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908092042.24686.arnd@arndb.de>
Subject: Re: [Bridge] [PATCH] macvlan: add tap device backend
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Fischer,
	Anna" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Or Gerlitz <ogerlitz@voltaire.com>, Edge Virtual Bridging <evb@yahoogroups.com>

On Sunday 09 August 2009 08:02:16 Michael S. Tsirkin wrote:
> On Thu, Aug 06, 2009 at 09:50:28PM +0000, Arnd Bergmann wrote:
> > * The same framework in macvlan can be used to add a third backend
> > into a future kernel based virtio-net implementation.
> 
> Could you split the patches up, to make this last easier?
> patch 1 - export framework
> patch 2 - code using it

Sure, will do.

> > +/* Get packet from user space buffer */
> > +static ssize_t macvtap_get_user(struct macvtap_dev *vtap,
> > +			       const struct iovec *iv, size_t count,
> > +			       int noblock)
> > +{
> > +	struct sk_buff *skb;
> > +	size_t len = count;
> > +
> > +	if (unlikely(len < ETH_HLEN))
> > +		return -EINVAL;
> > +
> > +	skb = alloc_skb(NET_IP_ALIGN + len, GFP_KERNEL);
> > +
> > +	if (!skb) {
> > +		vtap->m.dev->stats.rx_dropped++;
> > +		return -ENOMEM;
> > +	}
> > +
> > +	skb_reserve(skb, NET_IP_ALIGN);
> > +	skb_put(skb, count);
> > +
> > +	if (skb_copy_datagram_from_iovec(skb, 0, iv, 0, len)) {
> > +		vtap->m.dev->stats.rx_dropped++;
> > +		kfree_skb(skb);
> > +		return -EFAULT;
> > +	}
> > +
> > +	skb_set_network_header(skb, ETH_HLEN);
> > +	skb->dev = vtap->m.lowerdev;
> > +
> > +	macvlan_start_xmit(skb, vtap->m.dev);
> > +
> > +	return count;
> > +}
> 
> With tap, we discovered that not limiting the number of outstanding
> skbs hurts UDP performance. And the solution was to limit
> the number of outstanding packets - with hacks to work around
> the fact that userspace .

Something seems to be missing in your last sentence here.

My driver OTOH is also missing any sort of flow control in both
RX and TX direction ;) For RX, there should probably just be
a limit of frames that get buffered in the ring.

For TX, I guess there should be a way to let the packet
scheduler handle this and give us a chance to block and
unblock at the right time. I haven't found out yet how to
do that.

Would it be enough to check the dev_queue_xmit() return
code for NETDEV_TX_BUSY?

How would I get notified when it gets free again?

> > +	ret = skb_copy_datagram_iovec(skb, 0, iv, len);
> > +
> > +	vtap->m.dev->stats.rx_packets++;
> > +	vtap->m.dev->stats.rx_bytes += len;
> 
> where does atomicity guarantee for these counters come from?

AFAIK, we never do for any driver. They are statistics only and
need not be 100% correct, so the networking stack goes for
lower overhead and 99.9% correct.

> > +static ssize_t macvtap_aio_read(struct kiocb *iocb, const struct iovec *iv,
> > +			    unsigned long count, loff_t pos)
> > +{
> > +	struct file *file = iocb->ki_filp;
> > +	struct macvtap_dev *vtap = file->private_data;
> > +	DECLARE_WAITQUEUE(wait, current);
> > +	struct sk_buff *skb;
> > +	ssize_t len, ret = 0;
> > +
> > +	if (!vtap)
> > +		return -EBADFD;
> > +
> > +	len = iov_length(iv, count);
> > +	if (len < 0) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	add_wait_queue(&vtap->wait, &wait);
> > +	while (len) {
> > +		current->state = TASK_INTERRUPTIBLE;
> > +
> > +		/* Read frames from the queue */
> > +		if (!(skb=skb_dequeue(&vtap->readq))) {
> > +			if (file->f_flags & O_NONBLOCK) {
> > +				ret = -EAGAIN;
> > +				break;
> > +			}
> > +			if (signal_pending(current)) {
> > +				ret = -ERESTARTSYS;
> > +				break;
> > +			}
> > +			/* Nothing to read, let's sleep */
> > +			schedule();
> > +			continue;
> > +		}
> > +		ret = macvtap_put_user(vtap, skb, (struct iovec *) iv, len);
> 
> Don't cast away the constness. Instead, fix macvtap_put_user
> to used skb_copy_datagram_const_iovec which does not modify the iovec.

Ah, good catch. I had copied that from the tun driver before you
fixed it there and failed to fix it the right way when I adapted
it for the new interface.

Thanks for the review,

	Arnd <><
