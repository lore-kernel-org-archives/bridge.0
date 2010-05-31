Date: Mon, 31 May 2010 16:08:20 -0300
From: Flavio Leitner <fbl@sysclose.org>
Message-ID: <20100531190820.GA24569@sysclose.org>
References: <20100505081514.5157.83783.sendpatchset@localhost.localdomain>
	<20100527180545.GA2345@sysclose.org> <4BFF2EA5.9090008@redhat.com>
	<20100528194041.GC2345@sysclose.org> <4C034FA4.5000401@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C034FA4.5000401@redhat.com>
Subject: Re: [Bridge] [v5 Patch 1/3] netpoll: add generic support for bridge
 and bonding devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <amwang@redhat.com>
Cc: Jay Vosburgh <fubar@us.ibm.com>, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, Matt Mackall <mpm@selenic.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Jeff Moyer <jmoyer@redhat.com>, Andy Gospodarek <gospo@redhat.com>, bonding-devel@lists.sourceforge.net

On Mon, May 31, 2010 at 01:56:52PM +0800, Cong Wang wrote:
> Hi, Flavio,
> 
> Please use the attached patch instead, try to see if it solves
> all your problems.

I tried and it hangs. No backtraces this time.
The bond_change_active_slave() prints before NETDEV_BONDING_FAILOVER
notification, so I think it won't work. 

Please, correct if I'm wrong, but when a failover happens with your 
patch applied, the netconsole would be disabled forever even with
another healthy slave, right?

fbl


> 
> Thanks a lot!
> 

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index ca142c4..2d1d594 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -666,7 +666,8 @@ static int netconsole_netdev_event(struct notifier_block *this,
>  	struct net_device *dev = ptr;
>  
>  	if (!(event == NETDEV_CHANGENAME || event == NETDEV_UNREGISTER ||
> -	      event == NETDEV_BONDING_DESLAVE || event == NETDEV_GOING_DOWN))
> +	      event == NETDEV_BONDING_DESLAVE || event == NETDEV_GOING_DOWN ||
> +	      event == NETDEV_BONDING_FAILOVER))
>  		goto done;
>  
>  	spin_lock_irqsave(&target_list_lock, flags);
> @@ -682,6 +683,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
>  				/* Fall through */
>  			case NETDEV_GOING_DOWN:
>  			case NETDEV_BONDING_DESLAVE:
> +			case NETDEV_BONDING_FAILOVER:
>  				nt->enabled = 0;
>  				break;
>  			}


-- 
Flavio
