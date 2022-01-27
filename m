Return-Path: <greg@kroah.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
 :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm2; bh=WaIfKB6L73BlPeNtlmOZwTQbsqShiIjBr2J2vT
 exb+o=; b=kjxYAXUPvgtxdi3q7a5Uu7t9LhZ1vnb6czWe6Cr4hHD5TegHDG1Gor
 GrspqmoX3jRcFlFZwBfcbh/Gp7I29ACZWMweu+DHoT2klDGURHr5gdLcUGwrTfQB
 Ih5kmBc+DDWRbHO4ANUxga1LbAkU1xYTF/xc1632sgCrCj5qKafP1+wPp6gC6dSq
 9f3R8z+enlhWkpe3ibSjZzyWo6vRzrQZdg/AeBefZ20quHUH+jyO+qWl9oBj4SwZ
 qGbBCc4KCswhs/uBw+YX65lwFm7sxYFDF33hHu1SK06lsBK7ekKv7aFi8HTGdCF+
 chVPF+n+ti/6OkGByQtr99T/sC/aQs2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=WaIfKB6L73BlPeNtl
 mOZwTQbsqShiIjBr2J2vTexb+o=; b=iOhqajQZ1Rche6XXQ1tGBzf2007JAojWc
 3dO+f+Vpj8zAxhPM0r63LPqNXs5DKV5XG9NJFe2xM+R8cJltbHSDpIxiD7OMvXL+
 PDk3Taykm2iIOAdu4Qgtoo88myMUNShlh/vLBjpQ9QsCw2vsdrcQtXdjnF9YAhJs
 gacSk9PaWUfhvWofnU7FjXWhJCA59T+JG1U4E2/wI587ad+BGkLU3u2xmcGmirqD
 mtowlkNdDypNvogW2y07LyjD5icANqBw0tRJ6zrsEDBSMq9+2hZdUFZBQvxc49Ke
 EWdrO6QiWiCj1Ot7mzNz41wEZ6EaoSVtmqRLwm7UDiLpaXXqiHJJw==
Date: Thu, 27 Jan 2022 16:39:41 +0100
From: Greg KH <greg@kroah.com>
Message-ID: <YfK8vTvSJAT8i6F4@kroah.com>
References: <20220126033639.909340-1-huangguobin4@huawei.com>
 <20220126033639.909340-2-huangguobin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126033639.909340-2-huangguobin4@huawei.com>
Subject: Re: [Bridge] [PATCH 4.19 1/1] net: bridge: clear bridge's private
 skb space on xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Huang Guobin <huangguobin4@huawei.com>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, stable@vger.kernel.org, davem@davemloft.net

On Wed, Jan 26, 2022 at 11:36:39AM +0800, Huang Guobin wrote:
> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> [ Upstream commit fd65e5a95d08389444e8591a20538b3edece0e15 ]
> 
> We need to clear all of the bridge private skb variables as they can be
> stale due to the packet being recirculated through the stack and then
> transmitted through the bridge device. Similar memset is already done on
> bridge's input. We've seen cases where proxyarp_replied was 1 on routed
> multicast packets transmitted through the bridge to ports with neigh
> suppress which were getting dropped. Same thing can in theory happen with
> the port isolation bit as well.
> 
> Fixes: 821f1b21cabb ("bridge: add new BR_NEIGH_SUPPRESS port flag to suppress arp and nd flood")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Huang Guobin <huangguobin4@huawei.com>
> ---
>  net/bridge/br_device.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index a350c05b7ff5..7c6b1024dd4b 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -42,6 +42,8 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct ethhdr *eth;
>  	u16 vid = 0;
>  
> +	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
> +
>  	rcu_read_lock();
>  	nf_ops = rcu_dereference(nf_br_ops);
>  	if (nf_ops && nf_ops->br_dev_xmit_hook(skb)) {
> -- 
> 2.25.1
> 

Now queued up, thanks.

greg k-h
