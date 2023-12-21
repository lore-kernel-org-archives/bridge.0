Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAEA1A72A
	for <bridge@lists.linux.dev>; Thu, 21 Dec 2023 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="KR4mghmZ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a236456fee1so60052866b.1
        for <bridge@lists.linux.dev>; Thu, 21 Dec 2023 00:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1703148764; x=1703753564; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FTIeI4DoPouDjkk2jweCozK50yrWApKhZHnyb+L8pDY=;
        b=KR4mghmZjOD6qAnJrNnbHwZm4bl0a57xFZeq31aWY6H5Jtmm5qX2AYUycEQq8AAgmB
         PTs6qchXl/Cuaoio+zJ+1oMC/jGhugNz8CfpKlKaEd7OYLulBhgSQjIvN6jHTNa/BHlt
         tEPBhR7plF7rYpOB0rhbdbCYdUyBNt4cFsCgrumFVOc64qRKclzdk18Jt4MB+N4Laktg
         IrlqH9H/SYyRhvH8U7h+wTdIUqXGP7DD7hSgkYYdZocGZt70TGGeF7gcGFYZZzjvl5je
         ofFpe+s8z36W064a4IwRZekaBTUTrf350nz1sX81c3ZK8/iHqDzIGJy4pvl2oAmti1sG
         YRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703148764; x=1703753564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTIeI4DoPouDjkk2jweCozK50yrWApKhZHnyb+L8pDY=;
        b=fjUop4n7LBKUd/MEYmhvUoebF5rhiIIhq2r5DVO7DR8UenBipQe0RB7W8Zj5ePGgyt
         7A7cdF/iQ9SXs1FmbL0mX1YQozjoaYGU9ilzQim2V7Kqnnzx7vNGz1mjfELw9lBaDaXG
         ciF5XUrjSmFwYQXf97ouGKA4MhsTvOluf8Vz7rPJX0xrjjp82dnJbt/+IlTOaAEn3phz
         NGBKjQ6kro8ZWvsYVDLxzCVD3POrvZE15mYxBj5nvMxzfXVGHBczajug9wbci8upp66n
         9yjBPVz45OHI3zJV4MD/04DAUehEqv/BaFhXneINXXcrurkFi+rxUisMWXMbikw5P2JK
         lIXQ==
X-Gm-Message-State: AOJu0Yzw1DISOFWgzMKbhESkYFTXF/MBhfxwYeJv9gVX+lOMgIeR8xwh
	nSrL8/GGUSjABrRYDqPda+kgWg==
X-Google-Smtp-Source: AGHT+IEWMOTPB9r62Wb7FIh3oonVv5j6dbF/GZFxvecSF5+3yVgCdDo/ASxWxlvTlimQhzhpshBYqg==
X-Received: by 2002:a17:906:4e82:b0:a26:98ff:6464 with SMTP id v2-20020a1709064e8200b00a2698ff6464mr994115eju.17.1703148763984;
        Thu, 21 Dec 2023 00:52:43 -0800 (PST)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id rh9-20020a17090720e900b00a269e87ad84sm707136ejb.189.2023.12.21.00.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 00:52:43 -0800 (PST)
Message-ID: <dff34170-fc5d-4344-b6a2-6af2b2903208@blackwall.org>
Date: Thu, 21 Dec 2023 10:52:41 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] bridge: cfm: fix enum typo in
 br_cc_ccm_tx_parse
To: Lin Ma <linma@zju.edu.cn>, roopa@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horatiu.vultur@microchip.com, henrik.bjoernlund@microchip.com,
 bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org
References: <20231220163451.2720130-1-linma@zju.edu.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231220163451.2720130-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/12/2023 18:34, Lin Ma wrote:
> It appears that there is a typo in the code where the nlattr array is
> being parsed with policy br_cfm_cc_ccm_tx_policy, but the instance is
> being accessed via IFLA_BRIDGE_CFM_CC_RDI_INSTANCE, which is associated
> with the policy br_cfm_cc_rdi_policy.
> 
> This problem was introduced by commit 2be665c3940d ("bridge: cfm: Netlink
> SET configuration Interface.").
> 
> Though it seems like a harmless typo since these two enum owns the exact
> same value (1 here), it is quite misleading hence fix it by using the
> correct enum IFLA_BRIDGE_CFM_CC_CCM_TX_INSTANCE here.
> 
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> V1 -> V2: remove Fixes tag as this patch resolves nothing but a typo.
> 
>  net/bridge/br_cfm_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
> index 5c4c369f8536..2faab44652e7 100644
> --- a/net/bridge/br_cfm_netlink.c
> +++ b/net/bridge/br_cfm_netlink.c
> @@ -362,7 +362,7 @@ static int br_cc_ccm_tx_parse(struct net_bridge *br, struct nlattr *attr,
>  
>  	memset(&tx_info, 0, sizeof(tx_info));
>  
> -	instance = nla_get_u32(tb[IFLA_BRIDGE_CFM_CC_RDI_INSTANCE]);
> +	instance = nla_get_u32(tb[IFLA_BRIDGE_CFM_CC_CCM_TX_INSTANCE]);
>  	nla_memcpy(&tx_info.dmac.addr,
>  		   tb[IFLA_BRIDGE_CFM_CC_CCM_TX_DMAC],
>  		   sizeof(tx_info.dmac.addr));

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

