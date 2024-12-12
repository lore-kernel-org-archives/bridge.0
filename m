Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69370211496
	for <bridge@lists.linux-foundation.org>; Thu, 12 Dec 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001499; cv=none; b=QwFzphqjZGr373z6njvqZCQjfnABQTeRQN8zQo/BBMOJ2l71D2yZGX5NBcouCfRDCbnaCT4fKepvcgKVfdNjc4UtyU3+Z3UwFkULScjrvwI4A3yLG8PhgPvaLB6dJK+khVeY4EBDdS5l70roVSHNIUYyGLWy8dStwqTz4PyhJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001499; c=relaxed/simple;
	bh=3LoECToaAO1us1lNLhLHI4a+XL3SJL8jIA2LmdigVVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERCVqL+joO749gTVD4cj501wqZM/F2GzC+Di2ry0viZ+NLM0bX3xvBgioJ4h7ergwTmZhww9iKegXrrmYLQHcaTs6OnqCrwuJECfpbLdD//GfSVXsCmEsf95/npmYnM+bTe7/nOPvcGigB8he0Qbw+DgtARFxGhekG7JteHQRKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=uYGg2ar1; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="uYGg2ar1"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA1D3844E5
	for <bridge@lists.linux-foundation.org>; Thu, 12 Dec 2024 11:04:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w3lJrfMuGAVS for <bridge@lists.linux-foundation.org>;
 Thu, 12 Dec 2024 11:04:56 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0D9B1844E1
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D9B1844E1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=uYGg2ar1
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0D9B1844E1
	for <bridge@lists.linux-foundation.org>; Thu, 12 Dec 2024 11:04:55 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so625587a12.1
        for <bridge@lists.linux-foundation.org>; Thu, 12 Dec 2024 03:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734001494; x=1734606294; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dqiC1sBrXF/9+8aXy6G6XjlIZQN7Op5ZoQNj2VOvs4U=;
        b=uYGg2ar1UMkEnelicTzyLOBkvX9QajFWNuRbRz7NPYLXjf9vLT5XfRDNhsB+XDyAEf
         a1drDXMFIyrmpqfWzEG8WZptbuSddkdrRG/TkQJ9QCqVQVFL4sxcEFrATxdYuZjoux9+
         E1uxceUujoieX4EGLA8A7CpQBsowqbTZx0s8YIsQRiA31zxDAyxrw+K9SfzXdVmNCVJN
         ZLC7psWaQIyhcnOjMZLQO99GwC3VXgIkDUDhBm9ss0Sq5zhDYZOcRl2CQhPiaWMlbQPS
         9nRilnPU9eksuf1y+0Xt3SEA3EeSOufQXYx5MWohoKf8hq/R465SSeIuZ8FVrLiAFFF0
         jZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734001494; x=1734606294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqiC1sBrXF/9+8aXy6G6XjlIZQN7Op5ZoQNj2VOvs4U=;
        b=bw+YS+zruBXQY7lDurAjSQQba8rP8GssySxnA3N5SPNT93Vso+Mm6TK8LtHfGNkA+f
         5lx069tC06e6l98SGn4X+kM2IyIu9XcBEd642GgLFtn4irbEcm3oS89/1H8KP2zwQHkR
         GQONcymsxHdy9c+urWRneYt2u/jp7d7M2R5PHxQPNvKMgUQJaqdmkM+Ra5UyDOSuKQ0D
         XLXBKWAIpq1kPFYbxJzXCfj2JZ+EERDfdyOpJOSbQDd9owFeMjqiA92AVg+bUMp3pu+N
         AmTPWZkSnQlRBPFOjdG8WLlxI/5r5ZJqFYPQpjTsm2Uw4rEgopszACgtx1h+dSg/3eGc
         eZ5g==
X-Forwarded-Encrypted: i=1; AJvYcCWZN+CTvq0mlE2Ske4oFYFeqPaUv69o3HHdqnIsl70rresdImsby4o8xZ9SpfYzsVKvzqfi3QU=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzokkMxoZQcCXBfqH2C1u7ro0+h7cIbHLuNvhRge1Vl4uX3GI3M
	v14GOQmn4md8ko5Cv/ABbUIG4aeV6TlrPngNvYKwq43JReAADoaEVcDGFhXVKrk=
X-Gm-Gg: ASbGncv3AEdi7VWiv96V22+sGbP7A3fo6UBjBAnxmke62Y8RmnMnBF2DM/ttSrFOtCR
	DzdIHZqk6LU9LZaGxOh2xKfv6H4A+A9zPjhWhpU8Mb4kPk1+mdNH0z+3NQbTxO4DTcaHYM3pvVN
	I1kXq6zKN3sGL9A2dxehXHbiSUm0iT9Y75da6l+6Ns15vNr/Dk0oukcZt1CaS6sRHBoKjqItpAI
	/NsdxEmTAvek8EdAAZmDJ33RipupUCKOIJ+nd6ts/qj9Md7Mxl+hwbJkGA=
X-Google-Smtp-Source: AGHT+IFlaB5RZ24gUCVv8qgpzRSTZkltDq8S7WcmZLXJR4d0ofItD6HR1+fUdJYRvRlPRI9Kj+5zMg==
X-Received: by 2002:a17:906:31cc:b0:aa6:93c4:c68c with SMTP id a640c23a62f3a-aa6b13964d1mr688528766b.41.1734001493608;
        Thu, 12 Dec 2024 03:04:53 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6761d0ab3sm685087266b.201.2024.12.12.03.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 03:04:53 -0800 (PST)
Message-ID: <0e97175f-7713-42c6-ab34-e51757602b56@blackwall.org>
Date: Thu, 12 Dec 2024 13:04:52 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 iproute] bridge: dump mcast querier state
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, bridge@lists.linux-foundation.org, roopa@nvidia.com,
 stephen@networkplumber.org, entwicklung@pengutronix.de
References: <20241211072223.87370-1-f.pfitzner@pengutronix.de>
 <f1aac209-9001-428d-b210-495fe3b28e75@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <f1aac209-9001-428d-b210-495fe3b28e75@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/12/24 12:46, Fabian Pfitzner wrote:
> Forgot to mention the Acked-by from [1] in the trailer:
> 
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> [1] https://lore.kernel.org/netdev/12a687d5-cc87-4993-aec2-07ea799ce334@blackwall.org/#t
> 

Please don't send separate acks on behalf of other people. I was going to ack
the patch again. Also please don't top post on netdev.

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

> On 11.12.24 08:22, Fabian Pfitzner wrote:
>> Kernel support for dumping the multicast querier state was added in this
>> commit [1]. As some people might be interested to get this information
>> from userspace, this commit implements the necessary changes to show it
>> via
>>
>> ip -d link show [dev]
>>
>> The querier state shows the following information for IPv4 and IPv6
>> respectively:
>>
>> 1) The ip address of the current querier in the network. This could be
>>     ourselves or an external querier.
>> 2) The port on which the querier was seen
>> 3) Querier timeout in seconds
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
>>
>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
>> ---
>>
>> v1->v2
>>     - refactor code
>>     - link to v1: https://lore.kernel.org/netdev/20241025142836.19946-1-f.pfitzner@pengutronix.de/
>> v2->v3
>>     - use print_color_string for addresses
>>     - link to v2: https://lore.kernel.org/netdev/20241030222136.3395120-1-f.pfitzner@pengutronix.de/
>> v3->v4
>>     - drop new line between bqtb and other_time declarations
>>     - link to v3: https://lore.kernel.org/netdev/20241101115039.2604631-1-f.pfitzner@pengutronix.de/
>>
>>   ip/iplink_bridge.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
>> index f01ffe15..1fe89551 100644
>> --- a/ip/iplink_bridge.c
>> +++ b/ip/iplink_bridge.c
>> @@ -661,6 +661,65 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>>                  "mcast_querier %u ",
>>                  rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
>>
>> +    if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
>> +        struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
>> +        SPRINT_BUF(other_time);
>> +
>> +        parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
>> +        memset(other_time, 0, sizeof(other_time));
>> +
>> +        open_json_object("mcast_querier_state_ipv4");
>> +        if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
>> +            print_string(PRINT_FP,
>> +                NULL,
>> +                "%s ",
>> +                "mcast_querier_ipv4_addr");
>> +            print_color_string(PRINT_ANY,
>> +                COLOR_INET,
>> +                "mcast_querier_ipv4_addr",
>> +                "%s ",
>> +                format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
>> +        }
>> +        if (bqtb[BRIDGE_QUERIER_IP_PORT])
>> +            print_uint(PRINT_ANY,
>> +                "mcast_querier_ipv4_port",
>> +                "mcast_querier_ipv4_port %u ",
>> +                rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
>> +        if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
>> +            print_string(PRINT_ANY,
>> +                "mcast_querier_ipv4_other_timer",
>> +                "mcast_querier_ipv4_other_timer %s ",
>> +                sprint_time64(
>> +                    rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
>> +                                    other_time));
>> +        close_json_object();
>> +        open_json_object("mcast_querier_state_ipv6");
>> +        if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
>> +            print_string(PRINT_FP,
>> +                NULL,
>> +                "%s ",
>> +                "mcast_querier_ipv6_addr");
>> +            print_color_string(PRINT_ANY,
>> +                COLOR_INET6,
>> +                "mcast_querier_ipv6_addr",
>> +                "%s ",
>> +                format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
>> +        }
>> +        if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
>> +            print_uint(PRINT_ANY,
>> +                "mcast_querier_ipv6_port",
>> +                "mcast_querier_ipv6_port %u ",
>> +                rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
>> +        if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
>> +            print_string(PRINT_ANY,
>> +                "mcast_querier_ipv6_other_timer",
>> +                "mcast_querier_ipv6_other_timer %s ",
>> +                sprint_time64(
>> +                    rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
>> +                                    other_time));
>> +        close_json_object();
>> +    }
>> +
>>       if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
>>           print_uint(PRINT_ANY,
>>                  "mcast_hash_elasticity",
>> -- 
>> 2.39.5
>>
>>
>>

