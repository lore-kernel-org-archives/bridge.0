Return-Path: <john.p.donnelly@oracle.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33BD740B69
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 322E940500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Z39XGWxrVMnIIdmv9B+3ktyklH0w0l3gqW0VT6bQfxA=;
 b=ONJKv6pJJ/DwseHTwTBxBzciXFO6wFMH/B3I5oZFXLyklA4lX1xgNCn1EcSnjR43eCAC
 GOCgQQkUPsnguPWhag4f8jjKwx2K5JsTicGoXJHiJ8cA/JPpr6XH7lmO1FwYSDsp6dEQ
 oSLGPOJ4KajlvoFSHzjawrDVLE04dbDpXEt44xjQ5NTBL/ixfI7Ta4m8ezrqnfMQ2c95
 Uf5bWKJnkuecH+y7S8zb8CPtuHKrvaQ/h4Zccg991I79vI+apoJjCSXmRuqzQ0ZG7m/7
 M8QZCz4U5tAsdtcb/bZhzBG3UW878MOiOdrdsl3qdU7VOcbc5VFv/RC+OLab+N3/SoyC mQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z39XGWxrVMnIIdmv9B+3ktyklH0w0l3gqW0VT6bQfxA=;
 b=cGvpR07hdBcLnW7TeYX1RJr+XNhWz9tlrda1xJLwuL4V+ovgJ3FZdQOcfMVrkeCOUdvhHfefm6ks80zU6LhEPPfEjGNxlcSnd9D7ndoPHQDVoy3/30FEggyLQVZhfxoXvn7DM2W1xU4Ied5tCZIC6/A92yYwUyDMzfdZS9ErkP4=
Message-ID: <93eca5ab-46ee-241a-b01c-a6131b28ba29@oracle.com>
Date: Mon, 29 Aug 2022 08:57:11 -0500
Content-Language: en-US
References: <20220820070331.48817-1-harshit.m.mogalapalli@oracle.com>
 <20220820173555.131326-1-fw@strlen.de>
From: john.p.donnelly@oracle.com
In-Reply-To: <20220820173555.131326-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH nf] netfilter: ebtables: reject blobs that
 don't provide all entry points
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Cc: vegard.nossum@oracle.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, george.kennedy@oracle.com, syzkaller@googlegroups.com, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

On 8/20/22 12:35 PM, Florian Westphal wrote:
> For some reason ebtables reject blobs that provide entry points that are
> not supported by the table.
> 
> What it should instead reject is the opposite, i.e. rulesets that
> DO NOT provide an entry point that is supported by the table.
> 
> t->valid_hooks is the bitmask of hooks (input, forward ...) that will
> see packets.  So, providing an entry point that is not support is
> harmless (never called/used), but the reverse is NOT, this will cause
> crash because the ebtables traverser doesn't expect a NULL blob for
> a location its receiving packets for.
> 
> Instead of fixing all the individual checks, do what iptables is doing and
> reject all blobs that doesn't provide the expected hooks.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Hi,

  Could you please add the panic stack mentioned above  and syzkaller 
reproducer ID to the commit text ?



> ---
>   Harshit, can you check if this also silences your reproducer?
> 
>   Thanks!
> 
>   include/linux/netfilter_bridge/ebtables.h | 4 ----
>   net/bridge/netfilter/ebtable_broute.c     | 8 --------
>   net/bridge/netfilter/ebtable_filter.c     | 8 --------
>   net/bridge/netfilter/ebtable_nat.c        | 8 --------
>   net/bridge/netfilter/ebtables.c           | 8 +-------
>   5 files changed, 1 insertion(+), 35 deletions(-)
> 
> diff --git a/include/linux/netfilter_bridge/ebtables.h b/include/linux/netfilter_bridge/ebtables.h
> index a13296d6c7ce..fd533552a062 100644
> --- a/include/linux/netfilter_bridge/ebtables.h
> +++ b/include/linux/netfilter_bridge/ebtables.h
> @@ -94,10 +94,6 @@ struct ebt_table {
>   	struct ebt_replace_kernel *table;
>   	unsigned int valid_hooks;
>   	rwlock_t lock;
> -	/* e.g. could be the table explicitly only allows certain
> -	 * matches, targets, ... 0 == let it in */
> -	int (*check)(const struct ebt_table_info *info,
> -	   unsigned int valid_hooks);
>   	/* the data used by the kernel */
>   	struct ebt_table_info *private;
>   	struct nf_hook_ops *ops;
> diff --git a/net/bridge/netfilter/ebtable_broute.c b/net/bridge/netfilter/ebtable_broute.c
> index 1a11064f9990..8f19253024b0 100644
> --- a/net/bridge/netfilter/ebtable_broute.c
> +++ b/net/bridge/netfilter/ebtable_broute.c
> @@ -36,18 +36,10 @@ static struct ebt_replace_kernel initial_table = {
>   	.entries	= (char *)&initial_chain,
>   };
>   
> -static int check(const struct ebt_table_info *info, unsigned int valid_hooks)
> -{
> -	if (valid_hooks & ~(1 << NF_BR_BROUTING))
> -		return -EINVAL;
> -	return 0;
> -}
> -
>   static const struct ebt_table broute_table = {
>   	.name		= "broute",
>   	.table		= &initial_table,
>   	.valid_hooks	= 1 << NF_BR_BROUTING,
> -	.check		= check,
>   	.me		= THIS_MODULE,
>   };
>   
> diff --git a/net/bridge/netfilter/ebtable_filter.c b/net/bridge/netfilter/ebtable_filter.c
> index cb949436bc0e..278f324e6752 100644
> --- a/net/bridge/netfilter/ebtable_filter.c
> +++ b/net/bridge/netfilter/ebtable_filter.c
> @@ -43,18 +43,10 @@ static struct ebt_replace_kernel initial_table = {
>   	.entries	= (char *)initial_chains,
>   };
>   
> -static int check(const struct ebt_table_info *info, unsigned int valid_hooks)
> -{
> -	if (valid_hooks & ~FILTER_VALID_HOOKS)
> -		return -EINVAL;
> -	return 0;
> -}
> -
>   static const struct ebt_table frame_filter = {
>   	.name		= "filter",
>   	.table		= &initial_table,
>   	.valid_hooks	= FILTER_VALID_HOOKS,
> -	.check		= check,
>   	.me		= THIS_MODULE,
>   };
>   
> diff --git a/net/bridge/netfilter/ebtable_nat.c b/net/bridge/netfilter/ebtable_nat.c
> index 5ee0531ae506..9066f7f376d5 100644
> --- a/net/bridge/netfilter/ebtable_nat.c
> +++ b/net/bridge/netfilter/ebtable_nat.c
> @@ -43,18 +43,10 @@ static struct ebt_replace_kernel initial_table = {
>   	.entries	= (char *)initial_chains,
>   };
>   
> -static int check(const struct ebt_table_info *info, unsigned int valid_hooks)
> -{
> -	if (valid_hooks & ~NAT_VALID_HOOKS)
> -		return -EINVAL;
> -	return 0;
> -}
> -
>   static const struct ebt_table frame_nat = {
>   	.name		= "nat",
>   	.table		= &initial_table,
>   	.valid_hooks	= NAT_VALID_HOOKS,
> -	.check		= check,
>   	.me		= THIS_MODULE,
>   };
>   
> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
> index f2dbefb61ce8..9a0ae59cdc50 100644
> --- a/net/bridge/netfilter/ebtables.c
> +++ b/net/bridge/netfilter/ebtables.c
> @@ -1040,8 +1040,7 @@ static int do_replace_finish(struct net *net, struct ebt_replace *repl,
>   		goto free_iterate;
>   	}
>   
> -	/* the table doesn't like it */
> -	if (t->check && (ret = t->check(newinfo, repl->valid_hooks)))
> +	if (repl->valid_hooks != t->valid_hooks)
>   		goto free_unlock;
>   
>   	if (repl->num_counters && repl->num_counters != t->private->nentries) {
> @@ -1231,11 +1230,6 @@ int ebt_register_table(struct net *net, const struct ebt_table *input_table,
>   	if (ret != 0)
>   		goto free_chainstack;
>   
> -	if (table->check && table->check(newinfo, table->valid_hooks)) {
> -		ret = -EINVAL;
> -		goto free_chainstack;
> -	}
> -
>   	table->private = newinfo;
>   	rwlock_init(&table->lock);
>   	mutex_lock(&ebt_mutex);

