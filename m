Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F527FB27
	for <bridge@lists.linux-foundation.org>; Wed, 11 Jun 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644991; cv=none; b=gujiTrN/99brwBYokiyvKKKw9A1WCM4ombd0u6eUbzc7USB6PK3voBqJmqW1fgYalMQhClx78XDL6dPVGWnVmORJ6JtrguJvtAa6/Emy/o/ypZVxnqwbvxE5GzRUaphq1hd8Zi0WL9p1sCwochBxEPgjWQ+2s6rsY5viR2j1adw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644991; c=relaxed/simple;
	bh=ANm72Ell2Mcs7VfR4kBTV+tqXgsR0+Fzxi0xOPgxmU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyIThYz2Ere6bDhdOCd4ZvdnF1oe+mhRyHkDksRTJz1Uqk0Go+V+gCUhiCorhrYZBKXDpNv5M4dGFp7d4i4N4MHainyYa9UbGJCT3RweAONCZKRQNlu9hWykF5ejCcYx1Ji2V7QdOpJYNO26T0ny3Lr0tp1qomBbUcqqUu0lnd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE68D60787
	for <bridge@lists.linux-foundation.org>; Wed, 11 Jun 2025 12:29:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LSV1bE5faEOb for <bridge@lists.linux-foundation.org>;
 Wed, 11 Jun 2025 12:29:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=f.pfitzner@pengutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C82FE60879
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C82FE60879
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C82FE60879
	for <bridge@lists.linux-foundation.org>; Wed, 11 Jun 2025 12:29:48 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uPKMS-0004Ti-EM; Wed, 11 Jun 2025 14:15:20 +0200
Message-ID: <72a195be-b6c7-4d1a-8e3b-e3467ae4b2ea@pengutronix.de>
Date: Wed, 11 Jun 2025 14:15:19 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: dump mcast querier state per vlan
To: Ido Schimmel <idosch@nvidia.com>, razor@blackwall.org
Cc: netdev@vger.kernel.org, dsahern@gmail.com,
 bridge@lists.linux-foundation.org, entwicklung@pengutronix.de
References: <20250604105322.1185872-1-f.pfitzner@pengutronix.de>
 <aEFmoU9_ci0rqQTQ@shredder>
Content-Language: en-US, de-DE
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
In-Reply-To: <aEFmoU9_ci0rqQTQ@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bridge@lists.linux-foundation.org

On 6/5/25 11:42, Ido Schimmel wrote:
> + Nik
>
> On Wed, Jun 04, 2025 at 12:53:23PM +0200, Fabian Pfitzner wrote:
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
>> This patch is a bit redundant compared to [1]. It makes sense to put it
>> into a helper function, but i am not sure where to place this function.
>> Maybe somewhere under /lib?
> Not sure it's appropriate to put this in lib. Given this duplication is
> not new (see ip/iplink_bridge_slave.c and bridge/link.c, for example)
> and that the code isn't complex, I would keep it as-is.
>
>>   bridge/vlan.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/bridge/vlan.c b/bridge/vlan.c
>> index ea4aff93..b928c653 100644
>> --- a/bridge/vlan.c
>> +++ b/bridge/vlan.c
>> @@ -892,6 +892,64 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
>>   		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
>>   			   rta_getattr_u8(vattr));
>>   	}
>> +	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
>> +		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
>> +		SPRINT_BUF(other_time);
>> +
>> +		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]);
>> +		memset(other_time, 0, sizeof(other_time));
>> +
>> +		open_json_object("mcast_querier_state_ipv4");
>> +		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
>> +			print_string(PRINT_FP,
>> +				NULL,
>> +				"%s ",
>> +				"mcast_querier_ipv4_addr");
> Is there a reason for this misalignment and the overly long lines?
> How about something like [1] instead (compile tested only)?
Thanks. I tested your changes successfully.
Made a v2: 
https://lore.kernel.org/netdev/20250611121151.1660231-1-f.pfitzner@pengutronix.de/ 

>
>> +			print_color_string(PRINT_ANY,
>> +				COLOR_INET,
>> +				"mcast_querier_ipv4_addr",
>> +				"%s ",
>> +				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
>> +		}
>> +		if (bqtb[BRIDGE_QUERIER_IP_PORT])
>> +			print_uint(PRINT_ANY,
>> +				"mcast_querier_ipv4_port",
>> +				"mcast_querier_ipv4_port %u ",
>> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
>> +		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
>> +			print_string(PRINT_ANY,
>> +				"mcast_querier_ipv4_other_timer",
>> +				"mcast_querier_ipv4_other_timer %s ",
>> +				sprint_time64(
>> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
>> +									other_time));
>> +		close_json_object();
>> +		open_json_object("mcast_querier_state_ipv6");
>> +		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
>> +			print_string(PRINT_FP,
>> +				NULL,
>> +				"%s ",
>> +				"mcast_querier_ipv6_addr");
>> +			print_color_string(PRINT_ANY,
>> +				COLOR_INET6,
>> +				"mcast_querier_ipv6_addr",
>> +				"%s ",
>> +				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
>> +		}
>> +		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
>> +			print_uint(PRINT_ANY,
>> +				"mcast_querier_ipv6_port",
>> +				"mcast_querier_ipv6_port %u ",
>> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
>> +		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
>> +			print_string(PRINT_ANY,
>> +				"mcast_querier_ipv6_other_timer",
>> +				"mcast_querier_ipv6_other_timer %s ",
>> +				sprint_time64(
>> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
>> +									other_time));
>> +		close_json_object();
>> +	}
>>   	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
>>   		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
>>   		print_uint(PRINT_ANY, "mcast_igmp_version",
> [1]
> diff --git a/bridge/vlan.c b/bridge/vlan.c
> index ea4aff931a22..2afdc7c72890 100644
> --- a/bridge/vlan.c
> +++ b/bridge/vlan.c
> @@ -892,6 +892,61 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
>   		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
>   			   rta_getattr_u8(vattr));
>   	}
> +	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
> +		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> +		const char *querier_ip;
> +		SPRINT_BUF(other_time);
> +		__u64 tval;
> +
> +		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX,
> +				    vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]);
> +		memset(other_time, 0, sizeof(other_time));
> +
> +		open_json_object("mcast_querier_state_ipv4");
> +		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
> +			querier_ip = format_host_rta(AF_INET,
> +						     bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
> +			print_string(PRINT_FP, NULL, "%s ",
> +				     "mcast_querier_ipv4_addr");
> +			print_color_string(PRINT_ANY, COLOR_INET,
> +					   "mcast_querier_ipv4_addr", "%s ",
> +					   querier_ip);
> +		}
> +		if (bqtb[BRIDGE_QUERIER_IP_PORT])
> +			print_uint(PRINT_ANY, "mcast_querier_ipv4_port",
> +				   "mcast_querier_ipv4_port %u ",
> +				   rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]) {
> +			tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]);
> +			print_string(PRINT_ANY,
> +				     "mcast_querier_ipv4_other_timer",
> +				     "mcast_querier_ipv4_other_timer %s ",
> +				     sprint_time64(tval, other_time));
> +		}
> +		close_json_object();
> +		open_json_object("mcast_querier_state_ipv6");
> +		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
> +			querier_ip = format_host_rta(AF_INET6,
> +						     bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]);
> +			print_string(PRINT_FP, NULL, "%s ",
> +				     "mcast_querier_ipv6_addr");
> +			print_color_string(PRINT_ANY, COLOR_INET6,
> +					   "mcast_querier_ipv6_addr", "%s ",
> +					   querier_ip);
> +		}
> +		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
> +			print_uint(PRINT_ANY, "mcast_querier_ipv6_port",
> +				   "mcast_querier_ipv6_port %u ",
> +				   rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]) {
> +			tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]);
> +			print_string(PRINT_ANY,
> +				     "mcast_querier_ipv6_other_timer",
> +				     "mcast_querier_ipv6_other_timer %s ",
> +				     sprint_time64(tval, other_time));
> +		}
> +		close_json_object();
> +	}
>   	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
>   		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
>   		print_uint(PRINT_ANY, "mcast_igmp_version",
>
-- 
Pengutronix e.K.                           | Fabian Pfitzner             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

