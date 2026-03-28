Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7056F3054EB
	for <bridge@lists.linux.dev>; Sat, 28 Mar 2026 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680240; cv=none; b=r+voXg7OVYM2lTLXk6Y65zLSVH96JU41MBXtmeEe1BP6x4hj1l64ev8qspUjaTFHdDgWbMTtCa0TM6eT5nP1+ua8F13QQeE6qN0Ux+uR3OnxgnBKTIoydbcjoimxFuLVYDQ3NULRejjvzj4vaK1O6QVoZawrV2mWDWdn/mdhwz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680240; c=relaxed/simple;
	bh=hfjcWNuJUVEJgqQCxmPLiTB7SL/cK6kL9Nls1Qqn6KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFCDbf1A3W3702m/0kyAO2WpKyV6ysDcNdfAiQwHkhpYDoTNkuClcqrQAsewOLZOUgdHe5aI1ahMXkcgDqMF+YIY1Fqd6zPADHzRTqjtbrFdrohoNbPl8BQRIbs9k0x7oYLgjRtla9j5/Ami4YL8lXY4doc4eEztDJc23qiaMD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=QM1pWbc8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="QM1pWbc8"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so26015735e9.2
        for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 23:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774680238; x=1775285038; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQRyCKnELyMmPKJqIMqI/mkrkiIt4Ei/tLsOxy9g7BY=;
        b=QM1pWbc82NhLuymWhMYSPJiQivczKZu78FeBcJP0bq/jHL+4sYwDQ7+P3Xe36d5ho6
         IfuJr74ezIPntPwvlubM6roJI9v1xQXuD3f2lxWmzhR6ya+DEp8KWdW5PfTgqhWaJYt2
         2c/XwZtfQDDZ7I5uGLuAth5Oau3UoplTNsT4b08ArmxVrxnDq2ejqPjH5u7d23oB8Lwh
         Fv/gpKDYYCR0a6/6Y1P5rVj7hbth4tUdv2SwVO0oeopumsijo0LyEJuREV1hGkhcQbLN
         hiz2eo+T/AamvY15f76L+ZyMI8WUKRBsmUbQjqKvDswq+eGW3t7q6ofwS3gt1zESzakZ
         DneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680238; x=1775285038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQRyCKnELyMmPKJqIMqI/mkrkiIt4Ei/tLsOxy9g7BY=;
        b=X+5Nf/jFnDtxjkELxY8r2hOMukdkiLysyBK/WcX6UGgjlfvQokAv5l7Tlyyi2UVVbh
         zuCvKPFulLoGEdNQO6uQVolrItSTKoVX7o68kvfPP5TAOIKa4f3hsHHj2tUTlOBaJlPg
         pAODfdVQH2q5E1CRUvJbOFBClIgwEQTVYgJg8902zS4yZ2wb5L25w3339lbW7YAeNoqZ
         Wmq1Qs9422ts6AJC7ohHgi7CvtrzV5+KFbIWZ9W2Ir0TFSgjPqzutbS1xEj6WNomL8Cb
         AhAHSVgk40rF/ZwKD5qRUmd3OHm8rwAXMCW5rciSjcJVQDMU9vNkQwZ3tpXHHARgvPBs
         /MoQ==
X-Gm-Message-State: AOJu0YxkealRz/PbZ9se3VlZAN5rv0CR2gNFHuRz2lem6pC3tEkGxFgH
	dqyAzjAnt2FAaIKG0eplJxhZEF1bWeqwd/mocUCwmJ+oymWeK8Ntpa99b+PoTpUkQfQ=
X-Gm-Gg: ATEYQzyLI8b4wFSEA0+R56mQPbpijbjgMj5Glcd1qk8uiMFK1aQo+53KlCjozUR6GXg
	x/MxH8piPQo9lyCkefziGjMWPhg6YmUQstUTXiVEDu7f05SzhiaQsuF1yWReRR5AH3paS/WKTmU
	RB74aBgPglK01qCqY8J4ilfSFYN6Teq0ZA6iR9rXMggxZ03a/GiCFUcUeBnwBp1jib21imcJQwB
	CbOtINPORxOdMNjIbsfdy17sdiZev4tI6lprSOKHjuScYRtfARn+b0kQw4GWWiRW/gmVjhwrg7N
	VizH8yiyntNSKVbG/YAtTCImNEe/WcgAOe5/bcMFESvHv4D/DwvCaJA5BO+WnEi/rExNoYubrmx
	iFdFonHS3Pta28HLpoeul67HpI7lZ9id+/EIUMMI6LJ4C/PKRvlMipKZciIz3PkWkgzUgi95AYy
	cBIoMJpihlQ8NuA7pFaIPKE5WmXs658fFIqxBse6OpucUpUtI3tk4PvA==
X-Received: by 2002:a05:600c:154c:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-48727ede0admr86897515e9.24.1774680237838;
        Fri, 27 Mar 2026 23:43:57 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873069961esm28205305e9.12.2026.03.27.23.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:43:57 -0700 (PDT)
Message-ID: <edad225a-79cc-42de-a771-b1ea6d430ef7@blackwall.org>
Date: Sat, 28 Mar 2026 08:43:56 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bridge: mrp: reject zero test interval to avoid
 OOM panic
To: Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, horms@kernel.org, kuba@kernel.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, bestswngs@gmail.com
References: <20260328063000.1845376-1-xmei5@asu.edu>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260328063000.1845376-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/03/2026 08:30, Xiang Mei wrote:
> br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> interval value from netlink without validation. When interval is 0,
> usecs_to_jiffies(0) yields 0, causing the delayed work
> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> itself with zero delay. This creates a tight loop on system_percpu_wq
> that allocates and transmits MRP test frames at maximum rate, exhausting
> all system memory and causing a kernel panic via OOM deadlock.
> 
> The same zero-interval issue applies to br_mrp_start_in_test_parse()
> for interconnect test frames.
> 
> Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
> IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
> IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
> netlink attribute parsing layer before the value ever reaches the
> workqueue scheduling code. This is consistent with how other bridge
> subsystems (br_fdb, br_mst) enforce range constraints on netlink
> attributes.
> 
> Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
> Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>   net/bridge/br_mrp_netlink.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> index ce6f63c77cc0..86f0e75d6e34 100644
> --- a/net/bridge/br_mrp_netlink.c
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -196,7 +196,7 @@ static const struct nla_policy
>   br_mrp_start_test_policy[IFLA_BRIDGE_MRP_START_TEST_MAX + 1] = {
>   	[IFLA_BRIDGE_MRP_START_TEST_UNSPEC]	= { .type = NLA_REJECT },
>   	[IFLA_BRIDGE_MRP_START_TEST_RING_ID]	= { .type = NLA_U32 },
> -	[IFLA_BRIDGE_MRP_START_TEST_INTERVAL]	= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_START_TEST_INTERVAL]	= NLA_POLICY_MIN(NLA_U32, 1),
>   	[IFLA_BRIDGE_MRP_START_TEST_MAX_MISS]	= { .type = NLA_U32 },
>   	[IFLA_BRIDGE_MRP_START_TEST_PERIOD]	= { .type = NLA_U32 },
>   	[IFLA_BRIDGE_MRP_START_TEST_MONITOR]	= { .type = NLA_U32 },
> @@ -316,7 +316,7 @@ static const struct nla_policy
>   br_mrp_start_in_test_policy[IFLA_BRIDGE_MRP_START_IN_TEST_MAX + 1] = {
>   	[IFLA_BRIDGE_MRP_START_IN_TEST_UNSPEC]	= { .type = NLA_REJECT },
>   	[IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID]	= { .type = NLA_U32 },
> -	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= NLA_POLICY_MIN(NLA_U32, 1),
>   	[IFLA_BRIDGE_MRP_START_IN_TEST_MAX_MISS]	= { .type = NLA_U32 },
>   	[IFLA_BRIDGE_MRP_START_IN_TEST_PERIOD]	= { .type = NLA_U32 },
>   };

Alright, let's limit them :-)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

