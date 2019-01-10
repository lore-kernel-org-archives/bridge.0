Return-Path: <pablo@netfilter.org>
Date: Fri, 11 Jan 2019 00:57:46 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190110235746.65mp4kgyscgjhktl@salvia>
References: <20190103031431.247970-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103031431.247970-1-shakeelb@google.com>
Subject: Re: [Bridge] [PATCH v2] netfilter: account ebt_table_info to kmemcg
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Shakeel Butt <shakeelb@google.com>
Cc: coreteam@netfilter.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Kirill Tkhai <ktkhai@virtuozzo.com>, netfilter-devel@vger.kernel.org, syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Jan 02, 2019 at 07:14:31PM -0800, Shakeel Butt wrote:
> The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
> memory is already accounted to kmemcg. Do the same for ebtables. The
> syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
> whole system from a restricted memcg, a potential DoS.
> 
> By accounting the ebt_table_info, the memory used for ebt_table_info can
> be contained within the memcg of the allocating process. However the
> lifetime of ebt_table_info is independent of the allocating process and
> is tied to the network namespace. So, the oom-killer will not be able to
> relieve the memory pressure due to ebt_table_info memory. The memory for
> ebt_table_info is allocated through vmalloc. Currently vmalloc does not
> handle the oom-killed allocating process correctly and one large
> allocation can bypass memcg limit enforcement. So, with this patch,
> at least the small allocations will be contained. For large allocations,
> we need to fix vmalloc.

OK, patch is applied, thanks.
