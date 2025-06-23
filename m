Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E661388
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664732; cv=none; b=ZjlfFkte/kwGl6qUWntXxmocdnp8ctF/GNDBEH4Go8GUh/L2FzCjip8YP7DyC4/FX76rOrIaEp8WqlAwqlWVPr9dAZOBI3FXUO5Evbe5U6Szy3IYdHeLSNQGOcPXUrJlpvffVMxveQbbPtoTk3hgsqM4JnnTKmReE8tSVNteIPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664732; c=relaxed/simple;
	bh=mmBksMTTd27HyDcg6ireOZHAyB0klljVc3tmVvzCzns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruCEFB0LWSf0yigxGonWWhHNqKGEj0idQP3EswVknYMgEmPGTQkn8NwzoWVmqyU+Qzd0uceoRYXUSjXPtoVwZv0b88QZ7GmmrRqTsrEf5MiVEIUkaK3+6XQOO8hzUt5U8FxpckwCb/TeEx+P+551uXyoxkdpQNH2lAomKSAHMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D4E5340118
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 07:45:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3kP80tzH14Q6 for <bridge@lists.linux-foundation.org>;
 Mon, 23 Jun 2025 07:45:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=f.pfitzner@pengutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3CF50400A2
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CF50400A2
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3CF50400A2
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 07:45:27 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uTbrk-0000dH-Dy; Mon, 23 Jun 2025 09:45:20 +0200
Message-ID: <dbc2fcc9-5cd9-43c9-a9f9-9d5d16bb81b4@pengutronix.de>
Date: Mon, 23 Jun 2025 09:45:21 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bridge: dump mcast querier state per vlan
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250620121620.2827020-1-f.pfitzner@pengutronix.de>
 <d8d5a8f4-33a8-4a62-b48e-fb82b8de245b@blackwall.org>
Content-Language: en-US, de-DE
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
In-Reply-To: <d8d5a8f4-33a8-4a62-b48e-fb82b8de245b@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bridge@lists.linux-foundation.org

On 6/20/25 14:44, Nikolay Aleksandrov wrote:
> On 6/20/25 15:16, Fabian Pfitzner wrote:
>> Dump the multicast querier state per vlan.
>> This commit is almost identical to [1].
>>
>> The querier state can be seen with:
>>
>> bridge -d vlan global
>>
>> The options for vlan filtering and vlan mcast snooping have to be enabled
>> in order to see the output:
>>
>> ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1
>>
>> The querier state shows the following information for IPv4 and IPv6
>> respectively:
>>
>> 1) The ip address of the current querier in the network. This could be
>>     ourselves or an external querier.
>> 2) The port on which the querier was seen
>> 3) Querier timeout in seconds
>>
>> [1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2
>>
>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
>> ---
>>
>> v1->v2
>> 	- refactor code
>> 	- link to v1: https://lore.kernel.org/netdev/20250604105322.1185872-1-f.pfitzner@pengutronix.de/
>>
>> v2->v3
>> 	- move code into a shared function
>> 	- use shared function in bridge and ip utility
>> 	- link to v2: https://lore.kernel.org/netdev/20250611121151.1660231-1-f.pfitzner@pengutronix.de/
>> ---
>>   bridge/vlan.c      |  3 +++
>>   include/bridge.h   |  3 +++
>>   ip/iplink_bridge.c | 57 +---------------------------------------------
>>   lib/bridge.c       | 56 +++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 63 insertions(+), 56 deletions(-)
>>
> Hi,
> The subject should contain the target for this patch which is iproute2-next,
> e.g. [PATCH iproute2-next v3]. Since there would be another version, I'd split
> it in 2 patches - 1 that moves the existing code to lib/bridge.c and the second
> which adds the vlan querier print code.
>
> Also a few comments below..
I'll split it into three commits then:
1. Move existing code into shared function
2. Call shared function in bridge/vlan.c as well
3. Refactor code according to Ido's code proposal from v1
>
>> diff --git a/bridge/vlan.c b/bridge/vlan.c
>> index 14b8475d..0233eaf6 100644
>> --- a/bridge/vlan.c
>> +++ b/bridge/vlan.c
>> @@ -852,6 +852,9 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
>>   		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
>>   			   rta_getattr_u8(vattr));
>>   	}
>> +	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
>> +		dump_mcast_querier_state(vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]);
> Add a local variable for the attribute and make this line shorter (<= 80chars).
>
>> +	}
>>   	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
>>   		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
>>   		print_uint(PRINT_ANY, "mcast_igmp_version",
>> diff --git a/include/bridge.h b/include/bridge.h
>> index 8bcd1e38..9e9447c6 100644
>> --- a/include/bridge.h
>> +++ b/include/bridge.h
>> @@ -3,9 +3,12 @@
>>   #define __BRIDGE_H__ 1
>>
>>   #include <linux/if_bridge.h>
>> +#include <linux/rtnetlink.h>
>>
>>   void bridge_print_vlan_flags(__u16 flags);
>>   void bridge_print_vlan_stats_only(const struct bridge_vlan_xstats *vstats);
>>   void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats);
>>
>> +void dump_mcast_querier_state(const struct rtattr* vtb);
>> +
>>   #endif /* __BRIDGE_H__ */
>> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
>> index 31e7cb5e..68a277ef 100644
>> --- a/ip/iplink_bridge.c
>> +++ b/ip/iplink_bridge.c
>> @@ -682,62 +682,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>>   			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
>>
>>   	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
>> -		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
>> -		SPRINT_BUF(other_time);
>> -
>> -		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
>> -		memset(other_time, 0, sizeof(other_time));
>> -
>> -		open_json_object("mcast_querier_state_ipv4");
>> -		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
>> -			print_string(PRINT_FP,
>> -				NULL,
>> -				"%s ",
>> -				"mcast_querier_ipv4_addr");
>> -			print_color_string(PRINT_ANY,
>> -				COLOR_INET,
>> -				"mcast_querier_ipv4_addr",
>> -				"%s ",
>> -				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
>> -		}
>> -		if (bqtb[BRIDGE_QUERIER_IP_PORT])
>> -			print_uint(PRINT_ANY,
>> -				"mcast_querier_ipv4_port",
>> -				"mcast_querier_ipv4_port %u ",
>> -				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
>> -		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
>> -			print_string(PRINT_ANY,
>> -				"mcast_querier_ipv4_other_timer",
>> -				"mcast_querier_ipv4_other_timer %s ",
>> -				sprint_time64(
>> -					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
>> -									other_time));
>> -		close_json_object();
>> -		open_json_object("mcast_querier_state_ipv6");
>> -		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
>> -			print_string(PRINT_FP,
>> -				NULL,
>> -				"%s ",
>> -				"mcast_querier_ipv6_addr");
>> -			print_color_string(PRINT_ANY,
>> -				COLOR_INET6,
>> -				"mcast_querier_ipv6_addr",
>> -				"%s ",
>> -				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
>> -		}
>> -		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
>> -			print_uint(PRINT_ANY,
>> -				"mcast_querier_ipv6_port",
>> -				"mcast_querier_ipv6_port %u ",
>> -				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
>> -		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
>> -			print_string(PRINT_ANY,
>> -				"mcast_querier_ipv6_other_timer",
>> -				"mcast_querier_ipv6_other_timer %s ",
>> -				sprint_time64(
>> -					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
>> -									other_time));
>> -		close_json_object();
>> +		dump_mcast_querier_state(tb[IFLA_BR_MCAST_QUERIER_STATE]);
>>   	}
>>
>>   	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
>> diff --git a/lib/bridge.c b/lib/bridge.c
>> index a888a20e..13b0d633 100644
>> --- a/lib/bridge.c
>> +++ b/lib/bridge.c
>> @@ -45,3 +45,59 @@ void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)
>>
>>   	close_json_object();
>>   }
>> +
>> +void dump_mcast_querier_state(const struct rtattr *vtb)
> Stay consistent with the rest of lib/bridge.c and add bridge_ in front of the name.
> And maybe bridge_print_mcast_querier_state?
>
>> +{
>> +	struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
>> +	const char *querier_ip;
>> +	SPRINT_BUF(other_time);
>> +	__u64 tval;
>> +
>> +	parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb);
>> +	memset(other_time, 0, sizeof(other_time));
>> +
>> +	open_json_object("mcast_querier_state_ipv4");
>> +	if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
>> +		querier_ip = format_host_rta(AF_INET,
>> +						bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
>> +		print_string(PRINT_FP, NULL, "%s ",
>> +				"mcast_querier_ipv4_addr");
> formatting is off, "mcast_querier_ipv4_addr" should start under PRINT_FP
> use tabs as much as possible (before going over) and if
> needed finish alignment with spaces, e.g.:
Hmm, for some reason my editor replaced the spaces with tabs when I 
copied Ido's proposal.
Did not notice that... Sorry. I'll send a new patch.
>
> 		querier_ip = format_host_rta(AF_INET,
> 					     bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
> or
>
> 		print_string(PRINT_FP, NULL, "%s ",
> 			     "mcast_querier_ipv4_addr");
>
>> +		print_color_string(PRINT_ANY, COLOR_INET,
>> +					"mcast_querier_ipv4_addr", "%s ",
>> +					querier_ip);
> same about formatting
>
>> +	}
>> +	if (bqtb[BRIDGE_QUERIER_IP_PORT])
>> +		print_uint(PRINT_ANY, "mcast_querier_ipv4_port",
>> +				"mcast_querier_ipv4_port %u ",
>> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
> formatting
>
>> +	if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]) {
>> +		tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]);
>> +		print_string(PRINT_ANY,
>> +				"mcast_querier_ipv4_other_timer",
>> +				"mcast_querier_ipv4_other_timer %s ",
>> +				sprint_time64(tval, other_time));
> formatting
>
>> +	}
>> +	close_json_object();
>> +	open_json_object("mcast_querier_state_ipv6");
>> +	if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
>> +		querier_ip = format_host_rta(AF_INET6,
>> +						bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]);
>> +		print_string(PRINT_FP, NULL, "%s ",
>> +				"mcast_querier_ipv6_addr");
>> +		print_color_string(PRINT_ANY, COLOR_INET6,
>> +					"mcast_querier_ipv6_addr", "%s ",
>> +					querier_ip);
> formatting
>> +	}
>> +	if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
>> +		print_uint(PRINT_ANY, "mcast_querier_ipv6_port",
>> +				"mcast_querier_ipv6_port %u ",
>> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
> formatting
>> +	if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]) {
>> +		tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]);
>> +		print_string(PRINT_ANY,
>> +				"mcast_querier_ipv6_other_timer",
>> +				"mcast_querier_ipv6_other_timer %s ",
>> +				sprint_time64(tval, other_time));
> formatting
>
>> +	}
>> +	close_json_object();
>> +}
>> --
>> 2.39.5
>>
>
-- 
Pengutronix e.K.                           | Fabian Pfitzner             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

