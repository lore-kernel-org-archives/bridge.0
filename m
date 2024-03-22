Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FC5446B4
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112088; cv=none; b=tzjL1Ciq9FDmFCf3yJ7tixMg5uohU9mg5Tt1NDSnZU6YAW7favV17Y2SEwV6fEMHceIqPn5f1rkK3hHjUZicGiRAuz1pqGOcr8Xp8r75b69p2uD7CmK7//zrQaaIy5I4KD278H8gsn0Ia48WH8TvWfeYZjPIircdgfpmvm26A/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112088; c=relaxed/simple;
	bh=qUID3mZSQIA6An1Y3lJr2Guwz4uyB38nOJOdjkA63jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA0DcRrUPVJlSXKSJWT7963MoAczCEhdgo1OQ3DpCJ4tF15A1E0lBZtpKjwig5yGmF29mN2FZ0G5J3TpTej+Gssn+OZ4GhEFBJ6wPEeUrgAUAVTgHOO2HxbUYJVsX1TZYTnYlyS476smCNXCcQkA9ElXqgOMEjxPs8ZssJug+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=whWIhGhw; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="whWIhGhw"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C73160656
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 12:54:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YXcikIZU1u8S for <bridge@lists.linux-foundation.org>;
	Fri, 22 Mar 2024 12:54:46 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::132; helo=mail-lf1-x132.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8434B60644
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8434B60644
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=whWIhGhw
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8434B60644
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 12:54:46 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-512e4f4e463so2367773e87.1
        for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1711112084; x=1711716884; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nO3bLdBvKpvF/4JLicbn4vnf6TMOKC5qR7Lasn1JfQU=;
        b=whWIhGhwrFZv4pHM5rWlNJQLTpsaK5vBuxUBMjuuyr94YKSaMbmiKNp+pC0yHCjYFx
         z6/WlMbzvnFgJMcWfDSBZUjaevr7KVtfDJ0uXs/KRggjnf4IhCXOD1xg4YoN6pclayB0
         4U7ERtl62sRelqSBjtnn4Jh5bD0LzpQp2q92GCCFTrMYLBUyvenfdEmyVJ2Fwen8MpJo
         mNPVnle6pf59eA40FPUbw6lCGoF6NTb4j6iFvIIV+rJHuyPDIHxfiEXTw3+/biANqS1r
         knT8oQMGBLiQnX0s2RTtEVfZjdkskcRFiE14ppA0hS/DV+TBUA/tp/60wSjlBDyEGwl8
         0CGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711112084; x=1711716884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nO3bLdBvKpvF/4JLicbn4vnf6TMOKC5qR7Lasn1JfQU=;
        b=Jo/jZpZhTRbiVHAC39IU191K5kTKRmesRQh6RUIKx7oT281yO+066qGq+7gqKLmDFf
         UHfVcAmiFJeYeh3+BhdV1ytxzy+RZ+a1+7mCmfS6RHvYKmL9R+xG8S6uzPFCmLF864JW
         odzLoAVp58aebhPYO2FLP4Rt6J9ni3W578lb/5/HouBoh+ywCLp89COKdKnjEYjZD1n1
         jKkPDhSe6QAFdFlDwJARjqoVSI/Y1Bus+Xz9W71n+PZnlTy6hjcveG5XGodubtK+RPWC
         +sGC6E0iRuXX8BG63+tBp0BS5fK6ZiWFIwAvEDhs2xx07GEffHIZxUadA+fIyE/qZXzx
         FdLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcOmiEN/WW/4eXWwdhJYeQwNNOxxZPYZlLzr7pV3yAs5ByFazYBDs+i0LL8baTJqPAbN72CSAgDAg1CqaSAq5ggIE4b6Hph5+3eI6CjvklkGg=
X-Gm-Message-State: AOJu0YwaAuyYvEGH6e1d+lDJwj5BWRXcNhDOxs74RzwxA2/sxEGdwZov
	16K/Z1+M3yCaaBfigdk8IDaBAqL/mADFIofXLokKWUA4cl8LTZTS1xEEBnKubJc=
X-Google-Smtp-Source: AGHT+IF2FmLRiyJWG3aBET98LmEM8Iy1aRGSNxJMJbjg9nQmG4wOrKzN129FIU2JTpMMfNrZbUlREw==
X-Received: by 2002:a19:8c55:0:b0:515:8625:ae97 with SMTP id i21-20020a198c55000000b005158625ae97mr1792909lfj.37.1711112084197;
        Fri, 22 Mar 2024 05:54:44 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id f6-20020a1709067f8600b00a4674ad8ab9sm980245ejr.211.2024.03.22.05.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 05:54:43 -0700 (PDT)
Message-ID: <1315d24a-f8b4-442f-af24-baf4c7a3df05@blackwall.org>
Date: Fri, 22 Mar 2024 14:54:43 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 1/2] bridge: vlan: fix compressvlans
 usage
Content-Language: en-US
To: Date Huang <tjjh89017@hotmail.com>, roopa@nvidia.com, jiri@resnulli.us
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20240322123923.16346-1-tjjh89017@hotmail.com>
 <MAZP287MB05030EB14BE2BDAC9E1DB01EE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <MAZP287MB05030EB14BE2BDAC9E1DB01EE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 14:39, Date Huang wrote:
> Fix the incorrect short opt for compressvlans and color
> in usage
> 
> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
> ---
>   bridge/bridge.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bridge/bridge.c b/bridge/bridge.c
> index f4805092..ef592815 100644
> --- a/bridge/bridge.c
> +++ b/bridge/bridge.c
> @@ -39,7 +39,7 @@ static void usage(void)
>   "where  OBJECT := { link | fdb | mdb | vlan | vni | monitor }\n"
>   "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
>   "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
> -"                    -c[ompressvlans] -color -p[retty] -j[son] }\n");
> +"                    -com[pressvlans] -c[olor] -p[retty] -j[son] }\n");
>   	exit(-1);
>   }
>   

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

