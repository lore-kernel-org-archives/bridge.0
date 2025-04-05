Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04301A5B8B
	for <bridge@lists.linux-foundation.org>; Sat,  5 Apr 2025 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743841079; cv=none; b=IgDlomeTKn+2bQWv8O53ICeT2WCVmEeK5T4rsM+FDY6tErNvmLiqbkenkapdJti9BqbqfrJWLR9Nx5b3RX/gxQEqWhP4kpKqmg8YYaFhJshizdAvt0ICzBa7flSss+2T1dxIuA1Ff9efMb2qJps14Bk9IJI1DvHCigpWmNiLnhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743841079; c=relaxed/simple;
	bh=Sk5EfWtbpIrDoBOQs1tLfZu5DMGKFwD+3E8Z91flcBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ud9GDWnUjn5OVvhKyZomcIFLNF8JmKiy+iOL0tIQNW9qNUmVwXQXG251b8rJ/OsBkcgwlLddj7SaUIDszjnCpQf8QejAgEufh+TuJaaXGyfWSx0PVvqnRoRyuPw7PNkvGzgM3E+y8toFIzZXM/Nn62Oe8mkzDsyyW/eJqFCduAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=0JB5OhOh; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0JB5OhOh"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C35660ABA
	for <bridge@lists.linux-foundation.org>; Sat,  5 Apr 2025 08:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JL3HMePeei9i for <bridge@lists.linux-foundation.org>;
 Sat,  5 Apr 2025 08:17:56 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5745B60766
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5745B60766
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=0JB5OhOh
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5745B60766
	for <bridge@lists.linux-foundation.org>; Sat,  5 Apr 2025 08:17:56 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-43d0618746bso19212705e9.2
        for <bridge@lists.linux-foundation.org>; Sat, 05 Apr 2025 01:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743841074; x=1744445874; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmh8VzGlGccoq62Okq7lLmPwtkx48Yd7cBlyMiMYKeA=;
        b=0JB5OhOhlP1NkQ4ab3DkVePgHwV+3p3ulLT7OnxqY+PLi2Uulr7/pqAQqPAu4pfzY2
         jDtLh2J0mITcWmwDQq7j50kmU988EvlB7kbFA0C+HXXBPHhj1vGVufy2IomKKrujORwl
         3r62xdLL4Z8xahIWe2eg+R1u6TrKuUIG8Pji2PdyIzTJw4kvS3fJT7s9iA/GWkKwfY9L
         Xq9O8YlHosmpINgnRVE7FQXoIpGeS+3BL0yTeDm4c4bXfLMdibdMC/B5k2bJfvBYJHNs
         gxxuuKGJ4ExpcrHPNIIrESsFqQNsDad5mvRUeyEq0CUKiV5IV8QkE6beoCF6UtkOT4A9
         vj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743841074; x=1744445874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmh8VzGlGccoq62Okq7lLmPwtkx48Yd7cBlyMiMYKeA=;
        b=NZt77qzZTR8OMkmhgrYXMQmyuirXoTKYVyIXS8HednwRriRL4kpkYxf0O+3c2oA+yT
         Mk0h4/zQF/NRcDaQYVoCpOMV/avCqywNfZoN8wgyoK/t2fVAKNVDmcGca4ckTaf0/xic
         wL+2//1QolAay3lthtQA334UTefYyQUMGCdDzgogQzIS8iiPMEg88v1i0dTJhTi4XNJA
         ZyPxznyTwwJnymXWurifbDe71beOSOU0rGIy3bwTH/IG8vo7sfgDnGy9o0sUDg/LT1iL
         3XKdGk1pEKM108A8Qt1YRsjwfTc1QnovA41z9jMGdjAcvpXZVVuperyoEDFcuaEh5QGB
         mMAg==
X-Forwarded-Encrypted: i=1; AJvYcCUNeZpt4tQUAb/kcgSPWNBwn79a+9I7rOrPT6fcPEn8GtEj4StYDD18Am/0Kzbx224SMG3q6lo=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx9ufyDPE/ZnP2Ic390ceNIB1wApdWta+7ALYFXDww71IJIwLiO
	eNTebxl0e9eCwHR4+niB0oEyfIy8IeOO/kByMezxwlSto5ezudeaTWT+Unz1ASM=
X-Gm-Gg: ASbGncs6ZKXi5CuEvvgrM1a0TBC8l8+l2O4gxcwAhE8hIS2LCXHQ+zFFb7ff9gCOFeL
	aDWxLWEGNMQ1zgceJiO+l/iTbMFwtfsGhxPpW1Aiut5UATjdb27IXovj3bD6ngf8wElo4xFxp3D
	bancgO2WiGj+rSJ1RvknKktez3oeowTQUSkH0BYsKPHNj7/azjms2t+NYq/0JZu41vm25WIBSrG
	lgW9f3xJ3+uSL6M5galwBlQMy5XRd+ifXHIJop+BBWqJXZj21aB8IMtbOlzTdi1EbY1wuho0awF
	P3CVHz+l3SroGkmMJq/LCHvIEH2pqIjL/GssSF9tTSwhjfJFzV0zqd9Z8Dm4tqM0Xn1KeHlR+7x
	1
X-Google-Smtp-Source: AGHT+IEXH45zB9LxZqysktVTid75uKBWXT5GBeIvYEtODK5u/9rwtAa53Qy+v47CfQV3MHceLwM1jg==
X-Received: by 2002:a05:600c:c1a:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-43ecfa06fd2mr69792675e9.30.1743841070178;
        Sat, 05 Apr 2025 01:17:50 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec147c9dbsm71352615e9.0.2025.04.05.01.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 01:17:49 -0700 (PDT)
Message-ID: <d20cb48c-116c-44ca-84c5-db67d9f934ae@blackwall.org>
Date: Sat, 5 Apr 2025 11:17:49 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 iproute2-next 2/2] iplink_bridge: Add
 mdb_offload_fail_notification
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org,
 Joseph Huang <joseph.huang.2024@gmail.com>
References: <20250404215328.1843239-1-Joseph.Huang@garmin.com>
 <20250404215328.1843239-3-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250404215328.1843239-3-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/25 00:53, Joseph Huang wrote:
> Add mdb_offload_fail_notification option support.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  ip/iplink_bridge.c    | 19 +++++++++++++++++++
>  man/man8/ip-link.8.in |  7 +++++++
>  2 files changed, 26 insertions(+)
> 

Sorry, but a few more things I just noticed below,

> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index 1fe89551..c730aa68 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -62,6 +62,7 @@ static void print_explain(FILE *f)
>  		"		  [ nf_call_iptables NF_CALL_IPTABLES ]\n"
>  		"		  [ nf_call_ip6tables NF_CALL_IP6TABLES ]\n"
>  		"		  [ nf_call_arptables NF_CALL_ARPTABLES ]\n"
> +		"		  [ mdb_offload_fail_notification MDB_OFFLOAD_FAIL_NOTIFICATION ]\n"
>  		"\n"
>  		"Where: VLAN_PROTOCOL := { 802.1Q | 802.1ad }\n"
>  	);
> @@ -413,6 +414,18 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
>  
>  			addattr8(n, 1024, IFLA_BR_NF_CALL_ARPTABLES,
>  				 nf_call_arpt);
> +		} else if (strcmp(*argv, "mdb_offload_fail_notification") == 0) {
> +			__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
> +			__u8 mofn;
> +
> +			NEXT_ARG();
> +			if (get_u8(&mofn, *argv, 0))
> +				invarg("invalid mdb_offload_fail_notification", *argv);
> +			bm.optmask |= 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
> +			if (mofn)
> +				bm.optval |= mofn_bit;
> +			else
> +				bm.optval &= ~mofn_bit;
>  		} else if (matches(*argv, "help") == 0) {
>  			explain();
>  			return -1;
> @@ -623,6 +636,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  		__u32 mcvl_bit = 1 << BR_BOOLOPT_MCAST_VLAN_SNOOPING;
>  		__u32 no_ll_learn_bit = 1 << BR_BOOLOPT_NO_LL_LEARN;
>  		__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
> +		__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;

Please keep this arranged in reverse xmas tree, i.e. longest to shortest line.

>  		struct br_boolopt_multi *bm;
>  
>  		bm = RTA_DATA(tb[IFLA_BR_MULTI_BOOLOPT]);
> @@ -641,6 +655,11 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  				   "mst_enabled",
>  				   "mst_enabled %u ",
>  				   !!(bm->optval & mst_bit));
> +		if (bm->optmask & mofn_bit)
> +			print_uint(PRINT_ANY,
> +				   "mdb_offload_fail_notification",
> +				   "mdb_offload_fail_notification %u ",
> +				   !!(bm->optval & mofn_bit));
>  	}
>  
>  	if (tb[IFLA_BR_MCAST_ROUTER])
> diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
> index efb62481..3a7d1045 100644
> --- a/man/man8/ip-link.8.in
> +++ b/man/man8/ip-link.8.in
> @@ -1753,6 +1753,8 @@ the following additional arguments are supported:
>  .BI nf_call_ip6tables " NF_CALL_IP6TABLES "
>  ] [
>  .BI nf_call_arptables " NF_CALL_ARPTABLES "
> +] [
> +.BI mdb_offload_fail_notification " MDB_OFFLOAD_FAIL_NOTIFICATION "
>  ]
>  
>  .in +8
> @@ -1977,6 +1979,11 @@ or disable
>  .RI ( NF_CALL_ARPTABLES " == 0) "
>  arptables hooks on the bridge.
>  
> +.BI mdb_offload_fail_notification " MDB_OFFLOAD_FAIL_NOTIFICATION "
> +- turn mdb offload fail notification on
> +.RI ( MDB_OFFLOAD_FAIL_NOTIFICATION " > 0) "
> +or off
> +.RI ( MDB_OFFLOAD_FAIL_NOTIFICATION " == 0). "


Please add also what is the default value.
Other than that the patches look good and you can drop the RFC.

Thanks,
 Nik
