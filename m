Return-Path: <nhorman@tuxdriver.com>
From: Neil Horman <nhorman@tuxdriver.com>
Message-ID: <20120727184031.GB20938@hmsreliant.think-freely.org>
References: <1343403484-29347-1-git-send-email-amwang@redhat.com>
	<1343403484-29347-3-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1343403484-29347-3-git-send-email-amwang@redhat.com>
Subject: Re: [Bridge] [PATCH 2/7] netpoll: make __netpoll_cleanup non-block
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 27 Jul 2012 18:40:58 -0000
To: Cong Wang <amwang@redhat.com>
Cc: bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Jay Vosburgh <fubar@us.ibm.com>, linux-kernel@vger.kernel.org, Patrick McHardy <kaber@trash.net>, Eric Dumazet <edumazet@google.com>, Joe Perches <joe@perches.com>, Cong Wang <xiyou.wangcong@gmail.com>, Stephen Hemminger <shemminger@vyatta.com>, "David S. Miller" <davem@davemloft.net>

On Fri, Jul 27, 2012 at 11:37:59PM +0800, Cong Wang wrote:
> Like the previous patch, slave_disable_netpoll() and __netpoll_cleanup()
> may be called with read_lock() held too, so we should make them
> non-block, by moving the cleanup and kfree() to call_rcu_bh() callbacks.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Cong Wang <amwang@redhat.com>
> ---
>  drivers/net/bonding/bond_main.c |    4 +--
>  include/linux/netpoll.h         |    3 ++
>  net/8021q/vlan_dev.c            |    6 +----
>  net/bridge/br_device.c          |    6 +----
>  net/core/netpoll.c              |   42 +++++++++++++++++++++++++++++---------
>  5 files changed, 38 insertions(+), 23 deletions(-)
><snip>

>  	struct netpoll_info *npinfo;
> @@ -903,20 +921,24 @@ void __netpoll_cleanup(struct netpoll *np)
>  			ops->ndo_netpoll_cleanup(np->dev);
>  
>  		RCU_INIT_POINTER(np->dev->npinfo, NULL);
> +		call_rcu_bh(&npinfo->rcu, rcu_cleanup_netpoll_info);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(__netpoll_cleanup);
>  
> -		/* avoid racing with NAPI reading npinfo */
> -		synchronize_rcu_bh();
> +static void rcu_cleanup_netpoll(struct rcu_head *rcu_head)
> +{
> +	struct netpoll *np = container_of(rcu_head, struct netpoll, rcu);
>  
> -		skb_queue_purge(&npinfo->arp_tx);
> -		skb_queue_purge(&npinfo->txq);
> -		cancel_delayed_work_sync(&npinfo->tx_work);
> +	__netpoll_cleanup(np);
> +	kfree(np);
> +}
>  
> -		/* clean after last, unfinished work */
> -		__skb_queue_purge(&npinfo->txq);
> -		kfree(npinfo);
> -	}
> +void __netpoll_free_rcu(struct netpoll *np)
> +{
> +	call_rcu_bh(&np->rcu, rcu_cleanup_netpoll);
Here, and above I see you using an rcu_head to defer cleanup, until after all
pointer uses are dropped, but I don't see any modification of code points that
dereference any struct netpoll pointers to include
rcu_read_lock()/rcu_read_unlock().  Without those using rcu to defer cleanup is
pointless, as the rcu code won't know when its safe to run.  You're no better
off that you would be just calling __netpoll_cleanup directly.
Neil

>  }
> -EXPORT_SYMBOL_GPL(__netpoll_cleanup);
> +EXPORT_SYMBOL_GPL(__netpoll_free_rcu);
>  
>  void netpoll_cleanup(struct netpoll *np)
>  {
> -- 
> 1.7.7.6
> 
> 
