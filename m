Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0213C9DE
	for <bridge@lists.linux-foundation.org>; Thu, 12 Dec 2024 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000372; cv=none; b=gFfyqbceKXYN9Mzq+OBVLOIMDe01P9XR6ifKq7PTpJ/c/b+lmy+Lu3ZF+q99eEsM5NjvmPj0gDF4IXcAkhYiAWPzamqIZc/G/aVPNektdkMb2EwO0KQNLzQylFoSBd19yry9SGWDXeVXTBUZfpzcULN5D08k882WUUtGeMZNwcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000372; c=relaxed/simple;
	bh=vFHvHyjw8Pzj5uQMmfEKwV/QcuKo8q6n0RTSNSh0H4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWvdd77YPDvuXfkcg6qLiRJRpVigkg8fMwfBRPyIx1LhC4OGi0Os/0ib0fyIoXyIhbxSmdD45UDrfX1EnWlf+L95UMqBlPjAHyrOeAfkCH7Ju2opySDMoFvirRXmlJHI4aVcJCX1x/QN/N3Mxrxs5KYFdp0PwJiUWjeKlLvDfmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 704668432E
	for <bridge@lists.linux-foundation.org>; Thu, 12 Dec 2024 10:46:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 85flGFSpFHwh for <bridge@lists.linux-foundation.org>;
 Thu, 12 Dec 2024 10:46:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=f.pfitzner@pengutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E09FD842BB
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E09FD842BB
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E09FD842BB
	for <bridge@lists.linux-foundation.org>; Thu, 12 Dec 2024 10:46:06 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1tLghm-0007G9-Qg; Thu, 12 Dec 2024 11:46:02 +0100
Message-ID: <f1aac209-9001-428d-b210-495fe3b28e75@pengutronix.de>
Date: Thu, 12 Dec 2024 11:46:00 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 iproute] bridge: dump mcast querier state
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com, razor@blackwall.org,
 bridge@lists.linux-foundation.org, roopa@nvidia.com,
 stephen@networkplumber.org, entwicklung@pengutronix.de
References: <20241211072223.87370-1-f.pfitzner@pengutronix.de>
Content-Language: en-US, de-DE
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
In-Reply-To: <20241211072223.87370-1-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bridge@lists.linux-foundation.org

Forgot to mention the Acked-by from [1] in the trailer:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

[1] 
https://lore.kernel.org/netdev/12a687d5-cc87-4993-aec2-07ea799ce334@blackwall.org/#t

On 11.12.24 08:22, Fabian Pfitzner wrote:
> Kernel support for dumping the multicast querier state was added in this
> commit [1]. As some people might be interested to get this information
> from userspace, this commit implements the necessary changes to show it
> via
>
> ip -d link show [dev]
>
> The querier state shows the following information for IPv4 and IPv6
> respectively:
>
> 1) The ip address of the current querier in the network. This could be
>     ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
>
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
>
> v1->v2
> 	- refactor code
> 	- link to v1: https://lore.kernel.org/netdev/20241025142836.19946-1-f.pfitzner@pengutronix.de/
> v2->v3
> 	- use print_color_string for addresses
> 	- link to v2: https://lore.kernel.org/netdev/20241030222136.3395120-1-f.pfitzner@pengutronix.de/
> v3->v4
> 	- drop new line between bqtb and other_time declarations
> 	- link to v3: https://lore.kernel.org/netdev/20241101115039.2604631-1-f.pfitzner@pengutronix.de/
>
>   ip/iplink_bridge.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
>
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index f01ffe15..1fe89551 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -661,6 +661,65 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>   			   "mcast_querier %u ",
>   			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
>
> +	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
> +		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> +		SPRINT_BUF(other_time);
> +
> +		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
> +		memset(other_time, 0, sizeof(other_time));
> +
> +		open_json_object("mcast_querier_state_ipv4");
> +		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
> +			print_string(PRINT_FP,
> +				NULL,
> +				"%s ",
> +				"mcast_querier_ipv4_addr");
> +			print_color_string(PRINT_ANY,
> +				COLOR_INET,
> +				"mcast_querier_ipv4_addr",
> +				"%s ",
> +				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
> +		}
> +		if (bqtb[BRIDGE_QUERIER_IP_PORT])
> +			print_uint(PRINT_ANY,
> +				"mcast_querier_ipv4_port",
> +				"mcast_querier_ipv4_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv4_other_timer",
> +				"mcast_querier_ipv4_other_timer %s ",
> +				sprint_time64(
> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
> +									other_time));
> +		close_json_object();
> +		open_json_object("mcast_querier_state_ipv6");
> +		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
> +			print_string(PRINT_FP,
> +				NULL,
> +				"%s ",
> +				"mcast_querier_ipv6_addr");
> +			print_color_string(PRINT_ANY,
> +				COLOR_INET6,
> +				"mcast_querier_ipv6_addr",
> +				"%s ",
> +				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
> +		}
> +		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
> +			print_uint(PRINT_ANY,
> +				"mcast_querier_ipv6_port",
> +				"mcast_querier_ipv6_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv6_other_timer",
> +				"mcast_querier_ipv6_other_timer %s ",
> +				sprint_time64(
> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
> +									other_time));
> +		close_json_object();
> +	}
> +
>   	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
>   		print_uint(PRINT_ANY,
>   			   "mcast_hash_elasticity",
> --
> 2.39.5
>
>
>
-- 
Pengutronix e.K.                           | Fabian Pfitzner             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

