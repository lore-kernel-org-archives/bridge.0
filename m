Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF912B97
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="kczHac4z"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2091418AE
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:09:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2091418AE
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=kczHac4z
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TBWbQYmUo0wC for <bridge@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 10:09:28 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 121BC418A1
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 121BC418A1
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so32004295e9.1
        for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 02:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702894166; x=1703498966; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RkBeg4SFMd3zKgTAJBJhbgkME0fGFVwa3jyVxGZCBFc=;
        b=kczHac4zo/Q9+hxRd5tze+AOancAHIZ5SEskMpPaV28YqHXaRcCQZNBjxhqJtItUiX
         K/WhoYPKAebFa3exLNPxmwBUfjn5muexeaEGNMKEYNUMVJIVUrGFOq2Aqyb0dzOur6zp
         fSNuWqy42+2j+INLTqJ2JSw7LRDO+ozZhakHd+hAquUVqz0zo51dyptiU608Bxn4nsfT
         lTyaapTeiB/7T/LfgIyVPOnN/L/C+sXfAgNAy1qK7Tw1nqNcq0ct5P+TKxsPdTYKt4kA
         GyHuHNESrMGx7qZ1mwPBF7RafqpjqUuqHus4gIcRNPOfYBXe4qNeoyn9YqO8hVB3ahbD
         HvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894166; x=1703498966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RkBeg4SFMd3zKgTAJBJhbgkME0fGFVwa3jyVxGZCBFc=;
        b=LwfBI1r1c30+odSYCUNkdJzVlZXkaxwqkBXcN9mLYzv2aOGvFLwz0RIs43U70NHcPE
         kdbd1XLKZX6gX1joZhPxuNi7z5mWR7t/tsfiPO0RrvHILPS7VyVzZmjBbXEEGutUyWCQ
         xBcDyM86D4+vAJC3KM0m9rYgD8jA8juZhEfO1Djk2kELclEWg+5q/E4i3HPc5tlw7wxe
         AoP2Riokvqw/wpIwhtzFW/+B1b9lOF8jrLjy7b9MfblQE/rXQZu2cmEKuUWmxz5GjNt1
         P3uba7uvsppLRqCVFBApww26wK1toV3bx1Y+vVZ7JtTQGF99XFITuOWCkvsE6LRJBuCH
         7fAQ==
X-Gm-Message-State: AOJu0YxtTRnn1F3vgqXR+r8+1zFrYm8064MrzX90McGfzDcFSeMjrx3+
	6dc9aoy2SlXcL+vOat5LoP/Gyw==
X-Google-Smtp-Source: AGHT+IG8RKtvGHhE2Dl+3x3GTo/6R/ZSuvZjlmQsWFozPBkaOqRCD3ltyiI3jR68Y+QLWYGwyd466w==
X-Received: by 2002:a05:600c:35d3:b0:40d:18e2:898 with SMTP id r19-20020a05600c35d300b0040d18e20898mr411248wmq.196.1702894165956;
        Mon, 18 Dec 2023 02:09:25 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b0040c43be2e52sm33818365wmb.40.2023.12.18.02.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:09:25 -0800 (PST)
Message-ID: <00305092-d095-4c8c-8971-a6eda9e7ee6d@blackwall.org>
Date: Mon, 18 Dec 2023 12:09:24 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/9] rtnetlink: bridge: Invoke MDB bulk deletion
 when needed
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-5-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Invoke the new MDB bulk deletion device operation when the 'NLM_F_BULK'
> flag is set in the netlink message header.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   net/core/rtnetlink.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 30f030a672f2..349255151ad0 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -6494,6 +6494,14 @@ static int rtnl_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
>   		return -EINVAL;
>   	}
>   
> +	if (del_bulk) {
> +		if (!dev->netdev_ops->ndo_mdb_del_bulk) {
> +			NL_SET_ERR_MSG(extack, "Device does not support MDB bulk deletion");
> +			return -EOPNOTSUPP;
> +		}
> +		return dev->netdev_ops->ndo_mdb_del_bulk(dev, tb, extack);
> +	}
> +
>   	if (!dev->netdev_ops->ndo_mdb_del) {
>   		NL_SET_ERR_MSG(extack, "Device does not support MDB operations");
>   		return -EOPNOTSUPP;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

