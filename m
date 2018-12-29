Return-Path: <mhocko@kernel.org>
Date: Sat, 29 Dec 2018 08:33:25 +0100
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20181229073325.GZ16738@dhcp22.suse.cz>
References: <20181229015524.222741-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229015524.222741-1-shakeelb@google.com>
Subject: Re: [Bridge] [PATCH] netfilter: account ebt_table_info to kmemcg
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Shakeel Butt <shakeelb@google.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Andrew Morton <akpm@linux-foundation.org>, Pablo Neira Ayuso <pablo@netfilter.org>

On Fri 28-12-18 17:55:24, Shakeel Butt wrote:
> The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
> memory is already accounted to kmemcg. Do the same for ebtables. The
> syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
> whole system from a restricted memcg, a potential DoS.

What is the lifetime of these objects? Are they bound to any process?

> Reported-by: syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  net/bridge/netfilter/ebtables.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
> index 491828713e0b..5e55cef0cec3 100644
> --- a/net/bridge/netfilter/ebtables.c
> +++ b/net/bridge/netfilter/ebtables.c
> @@ -1137,14 +1137,16 @@ static int do_replace(struct net *net, const void __user *user,
>  	tmp.name[sizeof(tmp.name) - 1] = 0;
>  
>  	countersize = COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
> -	newinfo = vmalloc(sizeof(*newinfo) + countersize);
> +	newinfo = __vmalloc(sizeof(*newinfo) + countersize, GFP_KERNEL_ACCOUNT,
> +			    PAGE_KERNEL);
>  	if (!newinfo)
>  		return -ENOMEM;
>  
>  	if (countersize)
>  		memset(newinfo->counters, 0, countersize);
>  
> -	newinfo->entries = vmalloc(tmp.entries_size);
> +	newinfo->entries = __vmalloc(tmp.entries_size, GFP_KERNEL_ACCOUNT,
> +				     PAGE_KERNEL);
>  	if (!newinfo->entries) {
>  		ret = -ENOMEM;
>  		goto free_newinfo;
> -- 
> 2.20.1.415.g653613c723-goog
> 

-- 
Michal Hocko
SUSE Labs
