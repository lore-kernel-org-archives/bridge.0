Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=Dm0qTmtQ/pvhRjI4p1Lrq8NFg5VnRTeGtk7rmeTytwI=;
 b=11kZCEtxU2UYQXpmUmE5+iqDdHTzWhWjpYaRuZgkSKM49tHI1Lar+DIFIWoGEm7UmA
 fijwNhVz7+JogMVUKw+ZGCpi/UQrWa/UoMr1x9p2/aEfNpEjyGkn+kKlZrdU880FJqpv
 3Wsufin2uf9zyehYYRRWK0HKjgjJfceLh5wyAQGOHslgEFEhEisAf6LBknUDjQZxpg+k
 +Mgsx1DH06HyBRAwMAm6jRgSg5CQHJjG4q8bWOzwAgdubOK9GPJPSB24AEyFwuKZgiQC
 7D3v35c5pcew6mO4UIPb6b6qBKcvd9OJynQoxUTzHkmrudWIlLr2QFQdZBBHD7mlZV02
 bBhg==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20210504152106.oppawchuruapg4sb@skbuf>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-7-tobias@waldekranz.com>
 <20210427101747.n3y6w6o7thl5cz3r@skbuf> <878s4uo8xc.fsf@waldekranz.com>
 <20210504152106.oppawchuruapg4sb@skbuf>
Date: Tue, 04 May 2021 22:07:14 +0200
Message-ID: <874kfintzh.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [RFC net-next 6/9] net: dsa: Forward offloading
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, andrew@lunn.ch
Cc: f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Tue, May 04, 2021 at 18:21, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Tue, May 04, 2021 at 04:44:31PM +0200, Tobias Waldekranz wrote:
>> On Tue, Apr 27, 2021 at 13:17, Vladimir Oltean <olteanv@gmail.com> wrote:
>> > On Mon, Apr 26, 2021 at 07:04:08PM +0200, Tobias Waldekranz wrote:
>> >> Allow DSA drivers to support forward offloading from a bridge by:
>> >> 
>> >> - Passing calls to .ndo_dfwd_{add,del}_station to the drivers.
>> >> 
>> >> - Recording the subordinate device of offloaded skbs in the control
>> >>   buffer so that the tagger can take the appropriate action.
>> >> 
>> >> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> >> ---
>> >>  include/net/dsa.h |  7 +++++++
>> >>  net/dsa/slave.c   | 36 ++++++++++++++++++++++++++++++++++--
>> >>  2 files changed, 41 insertions(+), 2 deletions(-)
>> >> 
>> >> diff --git a/include/net/dsa.h b/include/net/dsa.h
>> >> index 1f9ba9889034..77d4df819299 100644
>> >> --- a/include/net/dsa.h
>> >> +++ b/include/net/dsa.h
>> >> @@ -119,6 +119,7 @@ struct dsa_netdevice_ops {
>> >>  
>> >>  struct dsa_skb_cb {
>> >>  	struct sk_buff *clone;
>> >> +	struct net_device *sb_dev;
>> >>  };
>> >>  
>> >>  struct __dsa_skb_cb {
>> >> @@ -828,6 +829,12 @@ struct dsa_switch_ops {
>> >>  					  const struct switchdev_obj_ring_role_mrp *mrp);
>> >>  	int	(*port_mrp_del_ring_role)(struct dsa_switch *ds, int port,
>> >>  					  const struct switchdev_obj_ring_role_mrp *mrp);
>> >> +
>> >> +	/* L2 forward offloading */
>> >> +	void *	(*dfwd_add_station)(struct dsa_switch *ds, int port,
>> >> +				    struct net_device *sb_dev);
>> >> +	void	(*dfwd_del_station)(struct dsa_switch *ds, int port,
>> >> +				    struct net_device *sb_dev);
>> >>  };
>> >>  
>> >>  #define DSA_DEVLINK_PARAM_DRIVER(_id, _name, _type, _cmodes)		\
>> >> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
>> >> index 77b33bd161b8..3689ffa2dbb8 100644
>> >> --- a/net/dsa/slave.c
>> >> +++ b/net/dsa/slave.c
>> >> @@ -657,6 +657,13 @@ static netdev_tx_t dsa_slave_xmit(struct sk_buff *skb, struct net_device *dev)
>> >>  	return dsa_enqueue_skb(nskb, dev);
>> >>  }
>> >>  
>> >> +static u16 dsa_slave_select_queue(struct net_device *dev, struct sk_buff *skb,
>> >> +				  struct net_device *sb_dev)
>> >> +{
>> >> +	DSA_SKB_CB(skb)->sb_dev = sb_dev;
>> >> +	return netdev_pick_tx(dev, skb, sb_dev);
>> >> +}
>> >> +
>> >
>> > DSA_SKB_CB is going away:
>> > https://patchwork.kernel.org/project/netdevbpf/patch/20210427042203.26258-5-yangbo.lu@nxp.com/
>> >
>> > Let's either negotiate with Yangbo on keeping it, or make
>> > .ndo_select_queue a bypass towards the tagger, where it can use its own
>> > SKB_CB structure and be more flexible in general (I think I'm leaning
>> > towards the latter).
>> 
>> Thus far, Yangbo is a tough negotiator, giving me the silent treatment:
>> 
>> https://lore.kernel.org/netdev/87y2d2noe5.fsf@waldekranz.com/
>> 
>> :)
>> 
>> That memset is giving me a hard time. I have just disabled it on my
>> branch at the moment. Any ideas on how to get rid of it without breaking
>> timestamping?
>
> :)
>
> Is there any guarantee written somewhere that the ownership of skb->cb
> belongs to the NIC driver at the time of the ndo_select_queue call?
>
> If there is, then the trivial solution is to just move the memset in
> ndo_select_queue.
>
> If there isn't, then we've got bigger issues (such as, for example, the
> qdisc layer being able to overwrite your DSA_SKB_CB(skb)->sb_dev).

The comment says:

   "This is owned by whoever has the skb queued ATM."

But qdisc_skb_cb is a thing as it turns out - so I think I can kiss the
idea of stashing the pointer in the CB goodbye.

Looking at some of the other users of .ndo_select_queue, I get the
feeling that we should really:

- Pre-generate a FROM_CPU tag template and store it under "TxQ 0"
- Pre-generate a FORWARD tag template and store it under "TxQ 1"
- Redfine tag_dsa's .ndo_select_queue to be: `return sb_dev ? 1 : 0;`
- Fetch the template using skb_queue_mapping, fill in the VID, and send
  it.

There is really no need to recompute the static parts of the tags on
each skb. It would mean moving some knowledge of the tagging format to
the driver. But that boundary is pretty artificial for
mv88e6xxx. tag_dsa has no use outside of mv88e6xxx, and mv88e6xxx does
not work with any other tagger. I suppose you could even move the whole
tagger to drivers/net/dsa/mv88e6xxx/?

What do you think?

Andrew?
