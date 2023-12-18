Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D901F1401E
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="LCcFGY53"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5CBF64031C
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:25:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CBF64031C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=LCcFGY53
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L8bk5l5jIKPV for <bridge@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 10:25:04 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DDBAC40128
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:25:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDBAC40128
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40d12ade25dso13577495e9.2
        for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 02:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702895101; x=1703499901; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h93OzPRkUcmlf3am5IalhLc0+8pp7MWahdAUi9UR6fQ=;
        b=LCcFGY53LXMevrCLxnPMnPU5zcPQCV1Dgb+X1LMQbAtMo04pLpocNBHewxdAR08hKc
         wDyauSIFUQgBNVHoVg8ubxj1aVPfQFWlQSGU4W6KQwaZ2UhUmdA6MYlCAMiieQGwmsLD
         b4jAWG0Fffe4YAUuaZEZ8bX1n1aX5qNki+18+1v5eqOIqiqqaZ+Pzv7ueimoLAdOCT0u
         H1vXDEb4KCh4m2cb/DwD37lEkisHLgHaulZ3+g9J3cezwPpX5Jg8NF0X8e3rX5eRAg5u
         9k/7aAmybcvfaTPk+Wb5C/ozckjYgfCkHrgiXozMo5gKLT7PUEbhkQbOSVh1bL2zk2yz
         VjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895102; x=1703499902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h93OzPRkUcmlf3am5IalhLc0+8pp7MWahdAUi9UR6fQ=;
        b=TdCvYCrBVd5/ZQO/HfTAt5m6+qRN/JNegHiyKNkbhybW18QaSFh27wmAbX9eFsMctc
         DLby44th/PkdL6eS8ocpKo6TW6P8qGiQQEsFLnxfTXJk0PTs5tBtjj+ggMlFvHEJWRYo
         YA0NJCY+xdQCxWdheC4TzoydnpBx+RDStaWIr2XsBmmejAC/e9kQZ3Yy2VbABffyqbN5
         0JwaUDJWPd0SNiIOTSUjukC9JzIDaRREIOa+jRvvetpNrmHZOfeapf24ExSrpSiK+Yyy
         xEZGJN/gtBR+gBANsUcQP0D/EiCI31jMc3RHHh+EmvM3CAyVj+Ka1/rdhRFrzmLq1SJs
         qyPA==
X-Gm-Message-State: AOJu0YzBHEcpIx3fVPNAFiow1Jyv0lZSdKTCkidhIIHdfOT2GxVKc0uo
	A2nR8HfrhrGhr1ehxWSJoTG0Ew3JKi1zNLoYh68=
X-Google-Smtp-Source: AGHT+IHrOrd2g+g3JS50mJL+q4OWq0mkCy7Z59nshTserUX0d4Hdx1AZgw/tu5LuWwuTG8QutiYqjQ==
X-Received: by 2002:a7b:c857:0:b0:40b:5e21:ec22 with SMTP id c23-20020a7bc857000000b0040b5e21ec22mr7930474wml.84.1702895101519;
        Mon, 18 Dec 2023 02:25:01 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b0040d1775dfd6sm5777864wmo.10.2023.12.18.02.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:25:00 -0800 (PST)
Message-ID: <90965963-4d0c-439a-b0de-77ed3ae1ea11@blackwall.org>
Date: Mon, 18 Dec 2023 12:25:00 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/9] rtnetlink: bridge: Enable MDB bulk deletion
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-8-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-8-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Now that both the common code as well as individual drivers support MDB
> bulk deletion, allow user space to make such requests.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   net/core/rtnetlink.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 349255151ad0..33f1e8d8e842 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -6747,5 +6747,6 @@ void __init rtnetlink_init(void)
>   
>   	rtnl_register(PF_BRIDGE, RTM_GETMDB, rtnl_mdb_get, rtnl_mdb_dump, 0);
>   	rtnl_register(PF_BRIDGE, RTM_NEWMDB, rtnl_mdb_add, NULL, 0);
> -	rtnl_register(PF_BRIDGE, RTM_DELMDB, rtnl_mdb_del, NULL, 0);
> +	rtnl_register(PF_BRIDGE, RTM_DELMDB, rtnl_mdb_del, NULL,
> +		      RTNL_FLAG_BULK_DEL_SUPPORTED);
>   }

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

