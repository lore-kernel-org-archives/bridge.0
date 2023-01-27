Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4746D417CD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A1D4400D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIq/f+MlrXemkUn2KwP3Vd5EB4Af8Ean9vt4f2VAZjA=;
 b=Ujivl0FQ02eWUptu2R8Pfho+ZCFpg2y/MCcseDN0hB8GWXcsB/iW9GwS6CmNP8BgOer7seRrzjoyPRvuNKmmFguauUP/BbJCKBaylztVYep9R/6Gy3HB+NnFYmY+1fdIDAh7og51XO0R4oaTD49rYoRXb351P6qfyXsRlexpYr6TBU7eQI1t1RWQ8JriOFemDUmx+yrq50d27M/09c+Hzupojeukh8GXGUeLHTH1Tj+a7omv9JKm1M3bkVbmDqcgcxZlh5WDljJE4vpGYOeHXx/CgWiYeCugb6nNj1cpILIUZlbTTLybKLvJ5jw6MgFvLSvgkc6RDVLKjfQojyrgSA==
References: <cover.1674752051.git.petrm@nvidia.com>
 <ed2e2e305dd49423745b62c0152a0b85bc84a767.1674752051.git.petrm@nvidia.com>
 <20230126125344.1b7b34e2@gandalf.local.home>
From: Petr Machata <petrm@nvidia.com>
Date: Fri, 27 Jan 2023 15:29:19 +0100
In-Reply-To: <20230126125344.1b7b34e2@gandalf.local.home>
Message-ID: <87h6wc3um7.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 06/16] net: bridge: Add a tracepoint
 for MDB overflows
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

>> diff --git a/include/trace/events/bridge.h b/include/trace/events/bridge.h
>> index 6b200059c2c5..00d5e2dcb3ad 100644
>> --- a/include/trace/events/bridge.h
>> +++ b/include/trace/events/bridge.h
>> @@ -122,6 +122,73 @@ TRACE_EVENT(br_fdb_update,
>>  		  __entry->flags)
>>  );
>>  
>> +TRACE_EVENT(br_mdb_full,
>> +
>> +	TP_PROTO(const struct net_device *dev,
>> +		 const struct br_ip *group),
>> +
>> +	TP_ARGS(dev, group),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(dev, dev->name)
>> +		__field(int, af)
>> +		__field(u16, vid)
>> +		__array(__u8, src4, 4)
>> +		__array(__u8, src6, 16)
>> +		__array(__u8, grp4, 4)
>> +		__array(__u8, grp6, 16)
>> +		__array(__u8, grpmac, ETH_ALEN) /* For af == 0. */
>
> Instead of wasting ring buffer space, why not just have:
>
> 		__array(__u8, src, 16)
> 		__array(__u8, grp, 16)
>
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(dev, dev->name);
>> +		__entry->vid = group->vid;
>> +
>> +		if (!group->proto) {
>> +			__entry->af = 0;
>> +
>> +			memset(__entry->src4, 0, sizeof(__entry->src4));
>> +			memset(__entry->src6, 0, sizeof(__entry->src6));
>> +			memset(__entry->grp4, 0, sizeof(__entry->grp4));
>> +			memset(__entry->grp6, 0, sizeof(__entry->grp6));
>> +			memcpy(__entry->grpmac, group->dst.mac_addr, ETH_ALEN);
>> +		} else if (group->proto == htons(ETH_P_IP)) {
>> +			__be32 *p32;
>> +
>> +			__entry->af = AF_INET;
>> +
>> +			p32 = (__be32 *) __entry->src4;
>> +			*p32 = group->src.ip4;
>> +
>> +			p32 = (__be32 *) __entry->grp4;
>> +			*p32 = group->dst.ip4;
>
> 			struct in6_addr *in6;
>
> 			in6 = (struct in6_addr *)__entry->src;
> 			ipv6_addr_set_v4mapped(group->src.ip4, in6);
>
> 			in6 = (struct in6_addr *)__entry->grp;
> 			ipv6_addr_set_v4mapped(group->grp.ip4, in6);
>
>> +
>> +			memset(__entry->src6, 0, sizeof(__entry->src6));
>> +			memset(__entry->grp6, 0, sizeof(__entry->grp6));
>> +			memset(__entry->grpmac, 0, ETH_ALEN);
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +		} else {
>> +			struct in6_addr *in6;
>> +
>> +			__entry->af = AF_INET6;
>> +
>> +			in6 = (struct in6_addr *)__entry->src6;
>> +			*in6 = group->src.ip6;
>> +
>> +			in6 = (struct in6_addr *)__entry->grp6;
>> +			*in6 = group->dst.ip6;
>> +
>> +			memset(__entry->src4, 0, sizeof(__entry->src4));
>> +			memset(__entry->grp4, 0, sizeof(__entry->grp4));
>> +			memset(__entry->grpmac, 0, ETH_ALEN);
>> +#endif
>> +		}
>> +	),
>> +
>> +	TP_printk("dev %s af %u src %pI4/%pI6c grp %pI4/%pI6c/%pM vid %u",
>> +		  __get_str(dev), __entry->af, __entry->src4, __entry->src6,
>> +		  __entry->grp4, __entry->grp6, __entry->grpmac, __entry->vid)
>
> And just have: 
>
> 	TP_printk("dev %s af %u src %pI6c grp %pI6c/%pM vid %u",
> 		  __get_str(dev), __entry->af, __entry->src, __entry->grp,
> 		  __entry->grpmac, __entry->vid)
>
> As the %pI6c should detect that it's a ipv4 address and show that.

So the reason I split the fields was that %pI4, %pI6c, %pM do not seem
to work with buffers of wrong size.

But I can consolidate 4/6 by changing the address to IPv6 like you
propose. I'll do this for v2. Thanks!
