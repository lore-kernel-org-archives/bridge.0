Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103628B40A
	for <bridge@lists.linux-foundation.org>; Fri, 20 Jun 2025 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423449; cv=none; b=W6sY/VRGIatt+UhpUkFJyl6D3Se1WvV2JOl5SQBTxHamylWyVN2MFGv1mUoUrvLtzp1fZPGZ4OmxmGxIG9dGrea5f8kjsg6vcOl6270HP8IZKED/7UOA+t0cZeF3sYPVV01awrbdH7zLMnzVoxjT71M3fHYr9xh4YoifY0nB6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423449; c=relaxed/simple;
	bh=Q7AJCTZ5rLCW4KFJK07/psNA/meUZ4daYdiWK+pUJ7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+KipUBKBtXo59uIi2nGkeDQZUoRqI1ZFHzOHz23thRS1dwZBv5TbwEJB544PCMKzshouRcqvZJIdmh5pSzK+ExGzyR3S5odRUjAbQkyghbA8/xsSxdp+OFWy4T4Xs00PMBVye6MzqiYI+T8Ci2KZu1zo4gysrny3qz9SEMPyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=wG3uWade; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="wG3uWade"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8721340E33
	for <bridge@lists.linux-foundation.org>; Fri, 20 Jun 2025 12:44:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9CODd5ZL5fmD for <bridge@lists.linux-foundation.org>;
 Fri, 20 Jun 2025 12:44:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D0DB740E16
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0DB740E16
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=wG3uWade
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D0DB740E16
	for <bridge@lists.linux-foundation.org>; Fri, 20 Jun 2025 12:44:05 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-60727e46168so3304145a12.0
        for <bridge@lists.linux-foundation.org>; Fri, 20 Jun 2025 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750423444; x=1751028244; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9EG9FcB8Q0IvOTBGOenT1zDNKlCLORzQAxF8MGgqcv4=;
        b=wG3uWadewWBIlnAMY1qghBuOh8Q+/igZM5g1lye43swE+00CUyttDJVILJ9t3jlR96
         PsCxUYfir75n0jxGzSMRV3Mcf7DrlVhJbkOpbPvGDAl7wfSpRUTrjDSy9yWPwmcxaeak
         hVY0jutkML7nOQgiCaajw9RkGQeus4L6a/YWTSn33EjUjoyQEKBkyZDTD4oicFfPH50O
         uYZXY0h/ohuBZ0/kp4isp5jgit/XfM1e7+C9JlRNOO9RpDPc6bC3zBi5ENw6erDDk6rb
         NAAfcW0vpfdQ8vv21amojFnBFqo47kLlg9b+lT4+3Q2oMalcuMSyA87dm3fp/lfddz4k
         zQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750423444; x=1751028244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9EG9FcB8Q0IvOTBGOenT1zDNKlCLORzQAxF8MGgqcv4=;
        b=FTnt0iLKX6VOPQWlQkhPRXmES74vhbQSd6/os2ATFFZRkC3m2IfxUNtf7tZ6FikILp
         of30cZ3FSZdvJA2yj1qI4LQzU2ZddaXtnvO6VzXVR/Ytd5a4W7hOvch1oaKPidOZ2T2u
         PclmRda5gr2LoDPgv5IEEPEhngjwj9YBVe1Aow9eqwxyLbzVCevya3WkN9nC9LAeo+DJ
         iKtl9vz/opDxstA7vbOad9fNIVYypHE2GjOJs80POsKmrNnqEfKplykyrg7Z3Xd7Kutd
         KhQZspJUZA1djjy7WN4yXqms5Hnkp+YJr5auJWNeXVSRHK6Y3FZuaW+JtNjuxQQXuEmP
         JBuA==
X-Forwarded-Encrypted: i=1; AJvYcCWPuZLSsZFXpaxSk7R3IFaYKrPGYmMGLbph0lYpsePLVYKTiZtqH0f2RSkphJfgtmNxluaPa/Q=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxXhRdpLHBVVAKVQVquLv9cAmcZXFnHqy8P6lXntYLvPB3j8pqG
	lvAv/EUOuDmDWMwfscTKNsyGN3l40ktV99n37Ot8wii8/MmxSF4ZEbaZuutdBDXbf2w=
X-Gm-Gg: ASbGnct6zw/Wzoey0KENP77yJnjICqRW9L/ULKm7aVwCH4JW/W+IxeOXAvDR0T0wZW3
	W+mB12w4GuCtoDLJMI48Y5lHmdAlJGzX7CakjeuzM9coiwEHvQfYV34VvOXEyvLDPqv2UuGyQdu
	x6AL2YHLgfDh5vuXtwCBdCewRCQXXMVtzVYxGhrbHBKr8FFqvwxhCr8pyPcLrL875I6vjfcGH8T
	lXhuSH/QI6sqNDI/yUMmnpNq06GrKpD+BiyRZzrttJCKONB1vUsEcGhL3c1pSTrO4RDT6vFKngQ
	D1b8r37T1Bxcvojph4BiVNF9dJ+k6Sgv0ugxyXW3YduirGM+4Wqq7GGEOuW9a0JZl/fhBXxIPEm
	CBtT1MdZlrq36k/HhYg==
X-Google-Smtp-Source: AGHT+IHXpQOnRW/S/YtZ5szU+d2WggG4z/q062bO8tBuw5oUwTLDA+GgY3DAtOvQndTO40pBMTYz4Q==
X-Received: by 2002:a17:907:6d17:b0:ae0:13e5:1883 with SMTP id a640c23a62f3a-ae057b89b6bmr249393566b.40.1750423443324;
        Fri, 20 Jun 2025 05:44:03 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b752asm156141766b.127.2025.06.20.05.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 05:44:02 -0700 (PDT)
Message-ID: <d8d5a8f4-33a8-4a62-b48e-fb82b8de245b@blackwall.org>
Date: Fri, 20 Jun 2025 15:44:01 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bridge: dump mcast querier state per vlan
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250620121620.2827020-1-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250620121620.2827020-1-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 15:16, Fabian Pfitzner wrote:
> Dump the multicast querier state per vlan.
> This commit is almost identical to [1].
> 
> The querier state can be seen with:
> 
> bridge -d vlan global
> 
> The options for vlan filtering and vlan mcast snooping have to be enabled
> in order to see the output:
> 
> ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1
> 
> The querier state shows the following information for IPv4 and IPv6
> respectively:
> 
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
> 
> [1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
> 
> v1->v2
> 	- refactor code
> 	- link to v1: https://lore.kernel.org/netdev/20250604105322.1185872-1-f.pfitzner@pengutronix.de/
> 
> v2->v3
> 	- move code into a shared function
> 	- use shared function in bridge and ip utility
> 	- link to v2: https://lore.kernel.org/netdev/20250611121151.1660231-1-f.pfitzner@pengutronix.de/
> ---
>  bridge/vlan.c      |  3 +++
>  include/bridge.h   |  3 +++
>  ip/iplink_bridge.c | 57 +---------------------------------------------
>  lib/bridge.c       | 56 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 63 insertions(+), 56 deletions(-)
> 

Hi,
The subject should contain the target for this patch which is iproute2-next,
e.g. [PATCH iproute2-next v3]. Since there would be another version, I'd split
it in 2 patches - 1 that moves the existing code to lib/bridge.c and the second
which adds the vlan querier print code.

Also a few comments below..

> diff --git a/bridge/vlan.c b/bridge/vlan.c
> index 14b8475d..0233eaf6 100644
> --- a/bridge/vlan.c
> +++ b/bridge/vlan.c
> @@ -852,6 +852,9 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
>  		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
>  			   rta_getattr_u8(vattr));
>  	}
> +	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
> +		dump_mcast_querier_state(vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]);

Add a local variable for the attribute and make this line shorter (<= 80chars).

> +	}
>  	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
>  		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
>  		print_uint(PRINT_ANY, "mcast_igmp_version",
> diff --git a/include/bridge.h b/include/bridge.h
> index 8bcd1e38..9e9447c6 100644
> --- a/include/bridge.h
> +++ b/include/bridge.h
> @@ -3,9 +3,12 @@
>  #define __BRIDGE_H__ 1
> 
>  #include <linux/if_bridge.h>
> +#include <linux/rtnetlink.h>
> 
>  void bridge_print_vlan_flags(__u16 flags);
>  void bridge_print_vlan_stats_only(const struct bridge_vlan_xstats *vstats);
>  void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats);
> 
> +void dump_mcast_querier_state(const struct rtattr* vtb);
> +
>  #endif /* __BRIDGE_H__ */
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index 31e7cb5e..68a277ef 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -682,62 +682,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
> 
>  	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
> -		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> -		SPRINT_BUF(other_time);
> -
> -		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
> -		memset(other_time, 0, sizeof(other_time));
> -
> -		open_json_object("mcast_querier_state_ipv4");
> -		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
> -			print_string(PRINT_FP,
> -				NULL,
> -				"%s ",
> -				"mcast_querier_ipv4_addr");
> -			print_color_string(PRINT_ANY,
> -				COLOR_INET,
> -				"mcast_querier_ipv4_addr",
> -				"%s ",
> -				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
> -		}
> -		if (bqtb[BRIDGE_QUERIER_IP_PORT])
> -			print_uint(PRINT_ANY,
> -				"mcast_querier_ipv4_port",
> -				"mcast_querier_ipv4_port %u ",
> -				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
> -		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
> -			print_string(PRINT_ANY,
> -				"mcast_querier_ipv4_other_timer",
> -				"mcast_querier_ipv4_other_timer %s ",
> -				sprint_time64(
> -					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
> -									other_time));
> -		close_json_object();
> -		open_json_object("mcast_querier_state_ipv6");
> -		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
> -			print_string(PRINT_FP,
> -				NULL,
> -				"%s ",
> -				"mcast_querier_ipv6_addr");
> -			print_color_string(PRINT_ANY,
> -				COLOR_INET6,
> -				"mcast_querier_ipv6_addr",
> -				"%s ",
> -				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
> -		}
> -		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
> -			print_uint(PRINT_ANY,
> -				"mcast_querier_ipv6_port",
> -				"mcast_querier_ipv6_port %u ",
> -				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
> -		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
> -			print_string(PRINT_ANY,
> -				"mcast_querier_ipv6_other_timer",
> -				"mcast_querier_ipv6_other_timer %s ",
> -				sprint_time64(
> -					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
> -									other_time));
> -		close_json_object();
> +		dump_mcast_querier_state(tb[IFLA_BR_MCAST_QUERIER_STATE]);
>  	}
> 
>  	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
> diff --git a/lib/bridge.c b/lib/bridge.c
> index a888a20e..13b0d633 100644
> --- a/lib/bridge.c
> +++ b/lib/bridge.c
> @@ -45,3 +45,59 @@ void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)
> 
>  	close_json_object();
>  }
> +
> +void dump_mcast_querier_state(const struct rtattr *vtb)

Stay consistent with the rest of lib/bridge.c and add bridge_ in front of the name.
And maybe bridge_print_mcast_querier_state?

> +{
> +	struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> +	const char *querier_ip;
> +	SPRINT_BUF(other_time);
> +	__u64 tval;
> +
> +	parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb);
> +	memset(other_time, 0, sizeof(other_time));
> +
> +	open_json_object("mcast_querier_state_ipv4");
> +	if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
> +		querier_ip = format_host_rta(AF_INET,
> +						bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
> +		print_string(PRINT_FP, NULL, "%s ",
> +				"mcast_querier_ipv4_addr");

formatting is off, "mcast_querier_ipv4_addr" should start under PRINT_FP
use tabs as much as possible (before going over) and if
needed finish alignment with spaces, e.g.:

		querier_ip = format_host_rta(AF_INET,
					     bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
or

		print_string(PRINT_FP, NULL, "%s ",
			     "mcast_querier_ipv4_addr");

> +		print_color_string(PRINT_ANY, COLOR_INET,
> +					"mcast_querier_ipv4_addr", "%s ",
> +					querier_ip);

same about formatting

> +	}
> +	if (bqtb[BRIDGE_QUERIER_IP_PORT])
> +		print_uint(PRINT_ANY, "mcast_querier_ipv4_port",
> +				"mcast_querier_ipv4_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));

formatting

> +	if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]) {
> +		tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]);
> +		print_string(PRINT_ANY,
> +				"mcast_querier_ipv4_other_timer",
> +				"mcast_querier_ipv4_other_timer %s ",
> +				sprint_time64(tval, other_time));

formatting

> +	}
> +	close_json_object();
> +	open_json_object("mcast_querier_state_ipv6");
> +	if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
> +		querier_ip = format_host_rta(AF_INET6,
> +						bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]);
> +		print_string(PRINT_FP, NULL, "%s ",
> +				"mcast_querier_ipv6_addr");
> +		print_color_string(PRINT_ANY, COLOR_INET6,
> +					"mcast_querier_ipv6_addr", "%s ",
> +					querier_ip);
formatting
> +	}
> +	if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
> +		print_uint(PRINT_ANY, "mcast_querier_ipv6_port",
> +				"mcast_querier_ipv6_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
formatting
> +	if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]) {
> +		tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]);
> +		print_string(PRINT_ANY,
> +				"mcast_querier_ipv6_other_timer",
> +				"mcast_querier_ipv6_other_timer %s ",
> +				sprint_time64(tval, other_time));

formatting

> +	}
> +	close_json_object();
> +}
> --
> 2.39.5
> 

