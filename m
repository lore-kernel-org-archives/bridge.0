Return-Path: <bhutchings@solarflare.com>
Message-ID: <1344878131.2733.28.camel@bwh-desktop.uk.solarflarecom.com>
From: Ben Hutchings <bhutchings@solarflare.com>
Date: Mon, 13 Aug 2012 18:15:31 +0100
In-Reply-To: <1344871635-1052-16-git-send-email-jiri@resnulli.us>
References: <1344871635-1052-1-git-send-email-jiri@resnulli.us>
	<1344871635-1052-16-git-send-email-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [patch net-next 15/16] net: remove usage of dev->master
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, fbl@redhat.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, linux-driver@qlogic.com, blaschka@linux.vnet.ibm.com, sony.chacko@qlogic.com, gregory.v.rose@intel.com, xiyou.wangcong@gmail.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

On Mon, 2012-08-13 at 17:27 +0200, Jiri Pirko wrote:
> Signed-off-by: Jiri Pirko <jiri@resnulli.us>
> ---
>  net/core/dev.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c0f9adb..8977404 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5461,8 +5461,8 @@ static void rollback_registered_many(struct list_head *head)
>  		if (dev->netdev_ops->ndo_uninit)
>  			dev->netdev_ops->ndo_uninit(dev);
>  
> -		/* Notifier chain MUST detach us from master device. */
> -		WARN_ON(dev->master);
> +		/* Notifier chain MUST detach us all upper devices. */
> +		WARN_ON(netdev_has_any_upper_dev(dev));
>  
>  		/* Remove entries from kobject tree */
>  		netdev_unregister_kobject(dev);

I think this should be folded into patch 1, since that already ensures
that any master device is included in the upper device list.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

