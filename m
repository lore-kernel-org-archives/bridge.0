Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF867126C17
	for <bridge@lists.linux-foundation.org>; Fri,  6 Jun 2025 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222686; cv=none; b=OFLMYO5oLOJnoOcNe2BtZT1vldUrCdyRRHMfzre8usVE58SDG9DqVtn7pvLPxvrWFHpKTQ+u4icYMKzs5zewx6p3x+1E1RVoFlCjMNq3l/2CGnfRhc0voFLgPfb6igmvyVHHvsGqVs/lWcli35oeOLvc+T4un7gwJp/FoD4O7xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222686; c=relaxed/simple;
	bh=B+R73Exjeh0Xd99cKtD7I7KglHFjMxwv1OWHBPlof30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxWpukXDb8XM8YTLsuWaxfLSzHDifYYPgK/hF/2TNQu6qHnxYqFkBIgaxNeN6qD44nwA27m2DLB7jvrMYlc0d1nkThAFHrZFJlsY/85EIpd0mrFl6dkA0BN0gog+o614w5i+Yb8QxJ4xmuhMssqVEtgqjBaK551B+LkAKJYY3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=LOqcnQXX; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="LOqcnQXX"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FCE583C9C
	for <bridge@lists.linux-foundation.org>; Fri,  6 Jun 2025 15:11:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9BU3NgBmH7KJ for <bridge@lists.linux-foundation.org>;
 Fri,  6 Jun 2025 15:11:22 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12f; helo=mail-lf1-x12f.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 945E383C71
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 945E383C71
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=LOqcnQXX
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 945E383C71
	for <bridge@lists.linux-foundation.org>; Fri,  6 Jun 2025 15:11:21 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-551efd86048so2362753e87.3
        for <bridge@lists.linux-foundation.org>; Fri, 06 Jun 2025 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749222679; x=1749827479; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itzGHGnOEeIfDPuTwt7H7T7bTkJezQTKebuH/HLY0ME=;
        b=LOqcnQXX9cHA9scvVdQKUYJeDVG84JARN2teWfLOY21az1yA+V3UyJEdhz/nUEuT8S
         yW07wExcW43SPNXsBBS32c9NZoA+e+4DFWosFLdCcD5HKyuA9Tfe6XOTIXxLpEYtw5LX
         OSrvrMlDm9vAK4RqtHr2Au+RyeC9Fo0hTwMtUO8UlX+TbR/pJi6I3Pv7r2E074vuecK/
         fNflF5cJHxlwkf89S8/tkIQNnNL/kdQ6lfTurnSRWka5XYcftuxWtShsHeViEe5kRCTW
         rK2blb+w3u+lQa4d3oeMVJV18FiCbdjjHSBhtP5ceBnsEb3/xxt/g/1Hteqtde8xDeyF
         DfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749222679; x=1749827479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itzGHGnOEeIfDPuTwt7H7T7bTkJezQTKebuH/HLY0ME=;
        b=wIYD+mnjuMgSIuceyRaZt3IFcHi19qB8CSLBBy9FEwrG5RpHNGQ32l1WGZeqS7Nlg8
         1u1mwrvgHm/BMl/oQAXb8xHMVLOUZUJMNoKaBDerDWJJX89j2cyq0fFKUHW8OwdDRavC
         jJzAalkWUPT/NFPFXULydapujzyyzr7DGCZ7Uqt/SIDgN4nc8GLbZhxCaSI/x0Ueg0b7
         dNhkUl4Jbvdg/6C3/Zq7BQRaJqz5qE1Efw9MHWWPyBYRgMoZODcV1q00WsTARpDFuAsU
         jmkd7SWiZU4IOxZAjHgxb/qvmRpwsutG4iMdu0pgBooOgYrxsls3kjKq2gvriwt9WbX1
         db/w==
X-Forwarded-Encrypted: i=1; AJvYcCUFr1tVquM+2MVJbe8ZpOeHVg0YruTmLkmgp2LThxMk7LyNavYHtbDXGdyiemdhCmlaj8Hl5TM=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyKywEEQN1oWT9mh2akABTt3SUUFn2cFfIbK/2QyfpYI5Zaoj/d
	5aPkyJfZA6RzmFwvJqa7edxuEQ8+GquakOkvaTVJGYpYWhUBcnmIzjAmrc4jm9mQpeg=
X-Gm-Gg: ASbGncsnhD8ha+B/BZ7JhaK322J3nC/i0K2tNyiCi0ClQu5AReJY2WF+kl1QKUn6qMv
	VJoTcjv7ksQD5QukKlLQW1Ntga1DZ/Y3fBqvEX+dnyhwDjUCPJTyrHmWDaSh2DBjQZkOM60TJ/H
	OuzCC7vJ3Ur3efbSy9jMB8iuU+p2HZdpd2rXn4VH47ww5NUdTvKUs/HK9lASrIe6btrvJKQIfhG
	et+TwoRfIdD+2qY2X/fzBTgMwc42KFTaoCyQJVcB5p7u8LC7O4F9Wf1rUR9coSPie6XSUVk96rt
	GHp21MpFzEBJrJqG+AYS3AOWu6gOve74CKC86VNwPmYXg5y2Sci2HBCWoTAlRJv7lZ7VO23Cnm5
	Vk5Wmn0yjfWTSToNagnAdBlM+N7moYXU=
X-Google-Smtp-Source: AGHT+IH2awoiSA6mm25bVWfOeGii4cBXCRrxouY2YcXrG3O4Hkw8GwGB2ald7tppyTjCgz13j9DL1w==
X-Received: by 2002:a05:6512:3c8b:b0:553:279b:c55d with SMTP id 2adb3069b0e04-55366c2ff61mr976974e87.45.1749222678724;
        Fri, 06 Jun 2025 08:11:18 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.185.kyiv.nat.volia.net. [176.111.185.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553676d7651sm207508e87.72.2025.06.06.08.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 08:11:17 -0700 (PDT)
Message-ID: <4c58aaf8-bd4c-45f9-bd0f-8bb9bac5efc0@blackwall.org>
Date: Fri, 6 Jun 2025 18:11:14 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: dump mcast querier state per vlan
To: Ido Schimmel <idosch@nvidia.com>,
 Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org, dsahern@gmail.com,
 bridge@lists.linux-foundation.org, entwicklung@pengutronix.de
References: <20250604105322.1185872-1-f.pfitzner@pengutronix.de>
 <aEFmoU9_ci0rqQTQ@shredder>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <aEFmoU9_ci0rqQTQ@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/25 12:42, Ido Schimmel wrote:
> + Nik
> 

Thanks

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
> 
> Not sure it's appropriate to put this in lib. Given this duplication is
> not new (see ip/iplink_bridge_slave.c and bridge/link.c, for example)
> and that the code isn't complex, I would keep it as-is.
>

+1
just do what we've already been doing, copy what you need

Cheers,
  Nik
  
>>
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
> 
> Is there a reason for this misalignment and the overly long lines?
> How about something like [1] instead (compile tested only)?
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
> 
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

