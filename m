Return-Path: <mhocko@kernel.org>
Date: Thu, 10 Jan 2019 10:41:42 +0100
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20190110094142.GI31793@dhcp22.suse.cz>
References: <20190103031431.247970-1-shakeelb@google.com>
	<5cc8efad-9d3d-3136-3ddc-1f8a640cb1f8@virtuozzo.com>
	<2d8f28cb-8620-be05-21bc-dcf3009b2774@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8f28cb-8620-be05-21bc-dcf3009b2774@virtuozzo.com>
Subject: Re: [Bridge] [PATCH v2] netfilter: account ebt_table_info to kmemcg
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, coreteam@netfilter.org, Shakeel Butt <shakeelb@google.com>, syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, netfilter-devel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Pablo Neira Ayuso <pablo@netfilter.org>

On Thu 10-01-19 12:22:09, Kirill Tkhai wrote:
[...]
> >> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
> >> index 491828713e0b..5e55cef0cec3 100644
> >> --- a/net/bridge/netfilter/ebtables.c
> >> +++ b/net/bridge/netfilter/ebtables.c
> >> @@ -1137,14 +1137,16 @@ static int do_replace(struct net *net, const void __user *user,
> >>  	tmp.name[sizeof(tmp.name) - 1] = 0;
> >>  
> >>  	countersize = COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
> >> -	newinfo = vmalloc(sizeof(*newinfo) + countersize);
> >> +	newinfo = __vmalloc(sizeof(*newinfo) + countersize, GFP_KERNEL_ACCOUNT,
> >> +			    PAGE_KERNEL);
> 
> Do we need GFP_HIGHMEM here?

No. vmalloc adds __GPF_HIGHMEM implicitly (see __vmalloc_area_node).

-- 
Michal Hocko
SUSE Labs
