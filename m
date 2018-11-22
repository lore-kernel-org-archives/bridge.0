Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=y2FhISjTs22znD6XNSVtxHHfByXLwjW+To87XQzg1gI=; 
	b=mDNxDm1FLLtqn7uBR0uC2sM1HpeE9jT/IY1d0PMmY2e5qvrEP8X3syOUlgJrC6A7F6AyptScFCWHSogAjOjANXX0sJVCbRUm9Inymdf4iWkSkRTJgx0U1Zoayl10W4Gh+GYqR7ZQ7bbJxaftEj+ORLMjElqxBgyPWyqFQ6S+pso=;
Date: Thu, 22 Nov 2018 16:35:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20181122153500.GF15403@lunn.ch>
References: <20181122042925.8878-1-nikolay@cumulusnetworks.com>
	<20181122042925.8878-2-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122042925.8878-2-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next 1/2] net: bridge: add support for
 user-controlled bool options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On Thu, Nov 22, 2018 at 06:29:24AM +0200, Nikolay Aleksandrov wrote:
> We have been adding many new bridge options, a big number of which are
> boolean but still take up netlink attribute ids and waste space in the skb.
> Recently we discussed learning from link-local packets[1] and decided
> yet another new boolean option will be needed, thus introducing this API
> to save some bridge nl space.
> The API supports changing the value of multiple boolean options at once
> via the br_boolopt_multi struct which has an optmask (which options to
> set, bit per opt) and optval (options' new values). Future boolean
> options will only be added to the br_boolopt_id enum and then will have
> to be handled in br_boolopt_toggle/get. The API will automatically
> add the ability to change and export them via netlink, sysfs can use the
> single boolopt function versions to do the same. The behaviour with
> failing/succeeding is the same as with normal netlink option changing.
> 
> If an option requires mapping to internal kernel flag or needs special
> configuration to be enabled then it should be handled in
> br_boolopt_toggle. It should also be able to retrieve an option's current
> state via br_boolopt_get.
> 
> [1] https://www.spinics.net/lists/netdev/msg532698.html
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
>  include/uapi/linux/if_bridge.h | 18 +++++++++
>  include/uapi/linux/if_link.h   |  1 +
>  net/bridge/br.c                | 68 ++++++++++++++++++++++++++++++++++
>  net/bridge/br_netlink.c        | 17 ++++++++-
>  net/bridge/br_private.h        |  6 +++
>  net/core/rtnetlink.c           |  2 +-
>  6 files changed, 110 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index e41eda3c71f1..6dc02c03bdf8 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -292,4 +292,22 @@ struct br_mcast_stats {
>  	__u64 mcast_bytes[BR_MCAST_DIR_SIZE];
>  	__u64 mcast_packets[BR_MCAST_DIR_SIZE];
>  };
> +
> +/* bridge boolean options
> + * IMPORTANT: if adding a new option do not forget to handle
> + *            it in br_boolopt_toggle/get and bridge sysfs
> + */
> +enum br_boolopt_id {
> +	BR_BOOLOPT_MAX
> +};
> +
> +/* struct br_boolopt_multi - change multiple bridge boolean options
> + *
> + * @optval: new option values (bit per option)
> + * @optmask: options to change (bit per option)
> + */
> +struct br_boolopt_multi {
> +	__u32 optval;
> +	__u32 optmask;
> +};

Hi Nikolay

Thanks for handling this.

How many boolean options do we already have? What it the likelihood a
u32 is going to be too small, in a couple of years time?

I recently went through the pain of converting the u32 for
representing link modes in the phylib API to a linux bitmap.  I'm just
wondering if in the long run, using a linux bitmap right from the
beginning would be better?

> +int br_boolopt_multi_toggle(struct net_bridge *br,
> +			    struct br_boolopt_multi *bm)
> +{
> +	unsigned long bitmap = bm->optmask;
> +	int err = 0;
> +	int opt_id;
> +
> +	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
> +		bool on = !!(bm->optval & BIT(opt_id));
> +
> +		err = br_boolopt_toggle(br, opt_id, on);
> +		if (err) {
> +			br_debug(br, "boolopt multi-toggle error: option: %d current: %d new: %d error: %d\n",
> +				 opt_id, br_boolopt_get(br, opt_id), on, err);

Would it be possible to return that to userspace using the extended
error infrastructure?

      Andrew
