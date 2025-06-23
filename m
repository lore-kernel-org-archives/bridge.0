Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1355922FF59
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669602; cv=none; b=OSmNj8t+mUxYpVfjfhjWCQHQbtXk+3xEStJVKBrJHtojxElBGCsO/BI+S6hFiM2VWQOv/2vxagIxrvMhs6FKOSV33o7iorF8E2GH6c+c41R4evhu1hhKUbwv6LXBfCWfk3/Vvh8Q+AGtNUXPoGwe1rO8RP+muNhyJGNG+OuiXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669602; c=relaxed/simple;
	bh=NplCcx7sOXvlDjDGShpLbLZzNcDPmjan4xA+/QRgM+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLQbGv4FTUKbF/WuuNoOY/7fjaNyYK3CxM7xy6gHrJfak+wBJb1MFTOoXRTOkjr+Ht5+phUS1K0zTFcyJyC7UKzFKhcFFW4o8b7i+uKIi9DMj3/CKjmKjbT9P4tlsgVwBiJdKb1WCT7mXGbno9dl2My+Te/DGfLBEim6LMSGwc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=J48lR/Z+; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="J48lR/Z+"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 882ED81F55
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:06:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P0d9ULJ0dw6y for <bridge@lists.linux-foundation.org>;
 Mon, 23 Jun 2025 09:06:39 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 494B681F33
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 494B681F33
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=J48lR/Z+
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 494B681F33
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:06:39 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-6097b404f58so7154548a12.3
        for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 02:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750669597; x=1751274397; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ey45mjsLzFT2alZQ43V/e5P4ouEuI9k+6FzGtpkIa8o=;
        b=J48lR/Z+dMF0XNCDBWvXuueJwHaG/bhuYOpVYvI7+2fxSlhsz9lCQHJNMJQGsbA/iU
         qvgw4hf1/ccU+DnTbfkREIC/pTrlZm/ENo6yYmQhLsAXr69LX+LnrKimgmTHEMuThA8j
         TkVwqtp5YSaDnbe8mMVr2UyIUUEqcx7dCqskcU/K57X69ON98bUQsi94t6Qu6/inag2L
         z9fPAtu0+aH4cN5tKSrrNRR2Vmodwp2WKXBZkwUmfuFd7QvXTXNnfq5zVnZ4E9HX4CgU
         AJGC8vDQE7ySRAPM9kZjfF/kNmJy+qBr4Tp7OhaNz13miucaFD1FB2aV4Q4VSHkyQO6B
         Rveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669597; x=1751274397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey45mjsLzFT2alZQ43V/e5P4ouEuI9k+6FzGtpkIa8o=;
        b=j0Av8XSsiZDAOL4I8WiWC8lZfjeuWcmmNe3ZK302JYbuJcyYyv4bITyCK/bsjD/EQf
         sXP7ABtsBi/FjY/YvsZ+RnvVt0PeMgrhTg+Q+Dtzh0Na0Btmvg/FWW45qrmTtxEWuGiZ
         muItTkcBAXaJZRnqL+6tuWV7Vf+Lsg8bLa+08MMZl1ZIfsGZS+ZwmmPJGDQGLkB+ycnt
         P/7sGQP4vNOd91QCLJYr4gCZu9OV2B0hG1xDuiNCPhDavyYj8RKmt3J44mso9ZYnYBQN
         mgUZqaOXCjuLUGhDc4jDVtsN+l9Km+YdJ+GmSulyUYRs7EmOfp+mhdaPpi1eGE74wPpS
         5jIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbOcBcGn9d4UnLTEhuW+5mHOcC0EAxAurdlJ6M0tIJ0YXUcYxtc4L5vVpFoFo7U3zSdbwWVWU=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwySqIg5iaoEDzmFqNyFkv1ZsN6Re44yilafCq//9/EVsniz1FB
	xDx+VXqlx4ve9RhUZnLj2rDCo2xl+hioG9VV16ndRq3Tp5ISNHcZeVMfwbROIqGrUmI=
X-Gm-Gg: ASbGncsGOXLKrsR7Bj/MAl2YrOfCFmmmb5RDE9qr29JrlGVPDFERgWWz4VSQgB7YVDB
	nNzeu/9NlDVNmGW/sRdAoRLrqchL9V8y2Gk8uNzA1mnrXtZoemjsBR6EiNjVawqdoJ8V4oiPmjS
	0QojCoBRWLWmUkkkXcZYPO8rUlQsGEDIp1H3at3oUNESTPgQUXn/o4hlRSDTkmsqQqloT8+By/D
	hDsHbC/KCtkzPk6FPXSZFtNcPVfAySVATDBXD1iBm9AtDtRXGs07pKIRez1Qf/yyXGrjjmDCuqr
	vlnr2xEwYYK2NKciPC4je5260M+c015WAE9G8Qx/TtislXEr9Ftsy0Xeu+BIrHZ4BTefrDqlgai
	6Zoqe3qpDTGs48M1Hmw==
X-Google-Smtp-Source: AGHT+IFGuDV0WJYvzUIRo4zGv+/lfxQm1RgBphY+vdx+pduqP9EOGUI2FTqk9mV29+Pn1Tk6nwgVgw==
X-Received: by 2002:a05:6402:28a8:b0:606:c5f9:8aea with SMTP id 4fb4d7f45d1cf-60a1cd1d83amr8899589a12.16.1750669596719;
        Mon, 23 Jun 2025 02:06:36 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a18542a3esm5761882a12.23.2025.06.23.02.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 02:06:35 -0700 (PDT)
Message-ID: <ca883bc3-84e7-4ff9-81fa-cc7755b2bdb7@blackwall.org>
Date: Mon, 23 Jun 2025 12:06:34 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v4 1/3] bridge: move mcast querier dumping
 code into a shared function
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250623084518.1101527-1-f.pfitzner@pengutronix.de>
 <20250623084518.1101527-2-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250623084518.1101527-2-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 11:45, Fabian Pfitzner wrote:
> Put mcast querier dumping code into a shared function. This function
> will be called from the bridge utility in a later patch.
> 
> Adapt the code such that the vtb parameter is used
> instead of tb[IFLA_BR_MCAST_QUERIER_STATE].
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
> 
> I decided to not only move the code into a separate function, but also
> to adapt it to fit into the function. If I split it into a pure refactoring
> and an adapting commit, the former will not compile preventing git bisects.
> 
>  include/bridge.h   |  3 +++
>  ip/iplink_bridge.c | 58 ++------------------------------------------
>  lib/bridge.c       | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 56 deletions(-)
> 
> diff --git a/include/bridge.h b/include/bridge.h
> index 8bcd1e38..b2f978f4 100644
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
> +void bridge_print_mcast_querier_state(const struct rtattr* vtb);
> +
>  #endif /* __BRIDGE_H__ */
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index 31e7cb5e..4e1f5147 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -682,62 +682,8 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
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
> +		struct rtattr *vtb = tb[IFLA_BR_MCAST_QUERIER_STATE];
> +		bridge_print_mcast_querier_state(vtb);
>  	}
> 
>  	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])

Please run checkpatch against the patches before sending them.

WARNING: Missing a blank line after declarations
#175: FILE: ip/iplink_bridge.c:685:
+		struct rtattr *vtb = tb[IFLA_BR_MCAST_QUERIER_STATE];
+		bridge_print_mcast_querier_state(vtb);



