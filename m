Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=HbDMpepYnesllhsIW//oNX57QiUUur6Q/GuACT7KuHA=;
	b=CnVjt8Ce15YkrVwm81j7Ek1cZ+uvXLNCY+NdPLlWNsFOSxN+lGfhkgXurYXZje4yZN
	CiLEj1sFTNkWWTAaAQDjqUz89PYXeoilYSsanr0RT58ygYWIptx2nrnGMH/Vx1gPHey8
	/EsWiKK1QeTL4cIc9sVyZriq2hE9+RVYAThu8=
References: <20181125160851.6919-1-colin.king@canonical.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <074d65f8-d6e8-078e-9365-a2d8f74b0c5e@cumulusnetworks.com>
Date: Sun, 25 Nov 2018 19:06:40 +0200
MIME-Version: 1.0
In-Reply-To: <20181125160851.6919-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH][V2] net: bridge: remove redundant checks for
 null p->dev and p->br
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

On 25/11/2018 18:08, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A recent change added a null check on p->dev after p->dev was being
> dereferenced by the ns_capable check on p->dev. It turns out that
> neither the p->dev and p->br null checks are necessary, and can be
> removed, which cleans up a static analyis warning.
> 
> As Nikolay Aleksandrov noted, these checks can be removed because:
> 
> "My reasoning of why it shouldn't be possible:
> - On port add new_nbp() sets both p->dev and p->br before creating
>   kobj/sysfs
> 
> - On port del (trickier) del_nbp() calls kobject_del() before call_rcu()
>   to destroy the port which in turn calls sysfs_remove_dir() which uses
>   kernfs_remove() which deactivates (shouldn't be able to open new
>   files) and calls kernfs_drain() to drain current open/mmaped files in
>   the respective dir before continuing, thus making it impossible to
>   open a bridge port sysfs file with p->dev and p->br equal to NULL.
> 
> So I think it's safe to remove those checks altogether. It'd be nice to
> get a second look over my reasoning as I might be missing something in
> sysfs/kernfs call path."
> 
> Thanks to Nikolay Aleksandrov's suggestion to remove the check and
> David Miller for sanity checking this.
> 
> Detected by CoverityScan, CID#751490 ("Dereference before null check")
> 
> Fixes: a5f3ea54f3cc ("net: bridge: add support for raw sysfs port options")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> ---
> 
> V2: remove checks instead of moving them before the dereference of
> p->dev.
> ---
>  net/bridge/br_sysfs_if.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 7c87a2fe5248..88715edb119a 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -320,9 +320,6 @@ static ssize_t brport_store(struct kobject *kobj,
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

Thanks,
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

