Return-Path: <akong@redhat.com>
Date: Thu, 29 May 2014 11:51:31 +0800
From: Amos Kong <akong@redhat.com>
Message-ID: <20140529035131.GA12648@z.redhat.com>
References: <53869842.4060202@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53869842.4060202@huawei.com>
Subject: Re: [Bridge] [PATCH net-next] bridge: fix the unbalanced
 promiscuous count when add_if failed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Wang Weidong <wangweidong1@huawei.com>
Cc: stephen@networkplumber.org, netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, vyasevic@redhat.com, David Miller <davem@davemloft.net>

On Thu, May 29, 2014 at 10:15:30AM +0800, Wang Weidong wrote:
> As commit 2796d0c648c94("bridge: Automatically manage port
> promiscuous mode."), make the add_if use dev_set_allmulti
> instead of dev_set_promiscuous, so when add_if failed, we
> should do dev_set_allmulti(dev, -1).
> 
> Signed-off-by: Wang Weidong <wangweidong1@huawei.com>
> ---
>  net/bridge/br_if.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index 104a811..a08d2b8 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -528,7 +528,7 @@ err2:
>  	kobject_put(&p->kobj);
>  	p = NULL; /* kobject_put frees */
>  err1:
> -	dev_set_promiscuity(dev, -1);
> +	dev_set_allmulti(dev, -1);

Right fix.

Reviewed-by: Amos Kong <akong@redhat.com>

>  put_back:
>  	dev_put(dev);
>  	kfree(p);
> -- 
> 1.8.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
			Amos.
