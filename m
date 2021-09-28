Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIwQ9/TafDLoAJVWfcXzWWen5B7h2Hct5LhSIUHQr6k=;
 b=JkKc9vjHHdZVm8pD/5ifrBkh/CqjbXC+grcCraYtGzXrPSDyyqhwyxjAb0f+2me6o/sy5QqrcQs4LlBva/xfnjcTKQ01XPENPcDdvGSdpMAWrTeIXhxyBAJSDg6TVtImfQmuS5FKSqKqXbg9t7Uy8ni2dlHQ+f/wgnAUPV5TS02soCOdpfPWVRdWuSj/1bMMWTVu0XeWC16LjWSCCTgxsHiVlljqDGXHSv7v6g0ljb4CYk0yobyuFO7F7iper/0bsMsrYfSckj4/AE8MDjX/V7gOkRQ9BDLUiKXCL1gYwRVR1mBNRVHYNQeaD1GcSNfSBlaafSdhxKbuGFM0IGkfdg==
References: <20210928141049.593833-1-bigeasy@linutronix.de>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <b98edd1b-2ec0-2b3c-5205-f2f0eaefe868@nvidia.com>
Date: Tue, 28 Sep 2021 17:41:26 +0300
In-Reply-To: <20210928141049.593833-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net] net: bridge: mcast: Associate the seqcount
 with its protecting lock.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>, "David S. Miller" <davem@davemloft.net>, Roopa Prabhu <roopa@nvidia.com>

On 28/09/2021 17:10, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The sequence count bridge_mcast_querier::seq is protected by
> net_bridge::multicast_lock but seqcount_init() does not associate the
> seqcount with the lock. This leads to a warning on PREEMPT_RT because
> preemption is still enabled.
> 
> Let seqcount_init() associate the seqcount with lock that protects the
> write section. Remove lockdep_assert_held_once() because lockdep already checks
> whether the associated lock is held.
> 	
> Fixes: 67b746f94ff39 ("net: bridge: mcast: make sure querier port/address updates are consistent")
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Tested-by: Mike Galbraith <efault@gmx.de>
> ---
>  net/bridge/br_multicast.c |    6 ++----
>  net/bridge/br_private.h   |    2 +-
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1677,8 +1677,6 @@ static void br_multicast_update_querier(
>  					int ifindex,
>  					struct br_ip *saddr)
>  {
> -	lockdep_assert_held_once(&brmctx->br->multicast_lock);
> -
>  	write_seqcount_begin(&querier->seq);
>  	querier->port_ifidx = ifindex;
>  	memcpy(&querier->addr, saddr, sizeof(*saddr));
> @@ -3867,13 +3865,13 @@ void br_multicast_ctx_init(struct net_br
>  
>  	brmctx->ip4_other_query.delay_time = 0;
>  	brmctx->ip4_querier.port_ifidx = 0;
> -	seqcount_init(&brmctx->ip4_querier.seq);
> +	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
>  	brmctx->multicast_igmp_version = 2;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	brmctx->multicast_mld_version = 1;
>  	brmctx->ip6_other_query.delay_time = 0;
>  	brmctx->ip6_querier.port_ifidx = 0;
> -	seqcount_init(&brmctx->ip6_querier.seq);
> +	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
>  #endif
>  
>  	timer_setup(&brmctx->ip4_mc_router_timer,
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -82,7 +82,7 @@ struct bridge_mcast_other_query {
>  struct bridge_mcast_querier {
>  	struct br_ip addr;
>  	int port_ifidx;
> -	seqcount_t seq;
> +	seqcount_spinlock_t seq;
>  };
>  
>  /* IGMP/MLD statistics */
> 

Thanks for fixing it,
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

