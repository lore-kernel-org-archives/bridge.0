Return-Path: <ktkhai@virtuozzo.com>
References: <20181229015524.222741-1-shakeelb@google.com>
	<20181229073325.GZ16738@dhcp22.suse.cz>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <7c0fa75f-df2f-668e-ebc2-3d3e9831030f@virtuozzo.com>
Date: Sat, 29 Dec 2018 12:52:19 +0300
MIME-Version: 1.0
In-Reply-To: <20181229073325.GZ16738@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] netfilter: account ebt_table_info to kmemcg
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Andrew Morton <akpm@linux-foundation.org>, Pablo Neira Ayuso <pablo@netfilter.org>

Hi, Michal!

On 29.12.2018 10:33, Michal Hocko wrote:
> On Fri 28-12-18 17:55:24, Shakeel Butt wrote:
>> The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
>> memory is already accounted to kmemcg. Do the same for ebtables. The
>> syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
>> whole system from a restricted memcg, a potential DoS.
> 
> What is the lifetime of these objects? Are they bound to any process?

These are list of ebtables rules, which may be displayed with $ebtables-save command.
In case of we do not account them, a low priority container may eat all the memory
and OOM killer in berserk mode will kill all the processes on machine. They are not bound
to any process, but they are bound to network namespace.

OOM killer does not analyze such the memory cgroup-related allocations, since it
is task-aware only. Maybe we should do it namespace-aware too...

Kirill

>> Reported-by: syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
>> Signed-off-by: Shakeel Butt <shakeelb@google.com>
>> ---
>>  net/bridge/netfilter/ebtables.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
>> index 491828713e0b..5e55cef0cec3 100644
>> --- a/net/bridge/netfilter/ebtables.c
>> +++ b/net/bridge/netfilter/ebtables.c
>> @@ -1137,14 +1137,16 @@ static int do_replace(struct net *net, const void __user *user,
>>  	tmp.name[sizeof(tmp.name) - 1] = 0;
>>  
>>  	countersize = COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
>> -	newinfo = vmalloc(sizeof(*newinfo) + countersize);
>> +	newinfo = __vmalloc(sizeof(*newinfo) + countersize, GFP_KERNEL_ACCOUNT,
>> +			    PAGE_KERNEL);
>>  	if (!newinfo)
>>  		return -ENOMEM;
>>  
>>  	if (countersize)
>>  		memset(newinfo->counters, 0, countersize);
>>  
>> -	newinfo->entries = vmalloc(tmp.entries_size);
>> +	newinfo->entries = __vmalloc(tmp.entries_size, GFP_KERNEL_ACCOUNT,
>> +				     PAGE_KERNEL);
>>  	if (!newinfo->entries) {
>>  		ret = -ENOMEM;
>>  		goto free_newinfo;
>> -- 
>> 2.20.1.415.g653613c723-goog
>>
> 
