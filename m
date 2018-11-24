Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=N2E7Pc0zVRLDUB1guUe+9JXVVdfIHz7GBFvgDy5DPmU=;
	b=Li6zqp3rQrkyICn3wxg8DJFy9wU2sWBHQrdJMyB6Kd0MqrfT2LE1ucZKXrxrePHQsh
	FAH29GyELydROpt+zt006J6ZrtBE3A5qauLfXwgsh+tjnfbkXJ1+vaf02cRiQUhh6En6
	uzAoBaXeUzVKn5+n6QOnsw5kgp4a/i5X+duGs=
References: <20181124121551.6942-1-colin.king@canonical.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <85963d6a-3411-9461-67aa-42e1fd02e663@cumulusnetworks.com>
Date: Sat, 24 Nov 2018 14:21:07 +0200
MIME-Version: 1.0
In-Reply-To: <20181124121551.6942-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: check for a null p->dev before
 dereferencing it
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Colin King <colin.king@canonical.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, "David S . Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On 24/11/2018 14:15, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A recent change added a null check on p->dev after p->dev was being
> dereferenced by the ns_capable check on p->dev.  Fix this by performing
> the p->dev sanity check before it is dereferenced.
> 
> Detected by CoverityScan, CID#751490 ("Dereference before null check")
> 
> Fixes: a5f3ea54f3cc ("net: bridge: add support for raw sysfs port options")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/bridge/br_sysfs_if.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 7c87a2fe5248..aab8aa17cccf 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -314,15 +314,15 @@ static ssize_t brport_store(struct kobject *kobj,
>  	unsigned long val;
>  	char *endp;
>  
> +	if (!p->dev || !p->br)
> +		return -EINVAL;
> +
>  	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
>  		return -EPERM;
>  
>  	if (!rtnl_trylock())
>  		return restart_syscall();
>  
> -	if (!p->dev || !p->br)
> -		goto out_unlock;
> -
>  	if (brport_attr->store_raw) {
>  		char *buf_copy;
>  
> 

Hi,
I was contacted recently about this privately and this was my reply:
"Checking new_nbp() and del_nbp() it should not be possible to reach that code
with p->dev or p->br as NULL. The cap check code has always been there, I just
shuffled the rest of the function to obtain rtnl lock and kept it as close to
the original as possible, thus the checks remained.
In order to avoid future reports like this I'll send a cleanup once net-next
opens up.

My reasoning of why it shouldn't be possible:
- On port add new_nbp() sets both p->dev and p->br before creating kobj/sysfs

- On port del (trickier) del_nbp() calls kobject_del() before call_rcu() to destroy
  the port which in turn calls sysfs_remove_dir() which uses kernfs_remove() which
  deactivates (shouldn't be able to open new files) and calls kernfs_drain() to drain
  current open/mmaped files in the respective dir before continuing, thus making it
  impossible to open a bridge port sysfs file with p->dev and p->br equal to NULL.
"

So I think it's safe to remove those checks altogether. It'd be nice to get a second
look over my reasoning as I might be missing something in sysfs/kernfs call path.

Thanks,
 Nik



