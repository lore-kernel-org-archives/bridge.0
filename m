Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEB512B8D
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="UbdVFIW5"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6997C60E47
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:07:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6997C60E47
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=UbdVFIW5
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ql_CSOB7iHhs for <bridge@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 10:07:22 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4E3F760ACD
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:07:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E3F760ACD
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3366920db54so427760f8f.1
        for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 02:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702894040; x=1703498840; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgSaHLgLTodWC2yz9NpazNVGTJRi7IzB1/Q/gA4W3IA=;
        b=UbdVFIW56y3JNrY9rBiwm2z4fWAc8qMsm8Ih3znIZiWkHcRVET1e2tc/bPN2WwDfI8
         Jb0rT4KOTAMXlRwdAA6ZBzSuhT9pK2S60JdSxQLpa1D4CFXhX0h9Vvht2vmTz9hufw1l
         SGIo2Dd8XspmfPzs6t3YfDUgt004bKVcPGFchWkb7+vdgbTmbKVlgw+a7dtT+qd3sHIP
         hjiIOvRc0iiTPjSIj1XD9KMdlZvlc0T1V1evGybA+Bd9J85c8V16zzE11j1LaCc2mjKG
         QiaoKKmP+k3Ga8DwCgtM2CAH3DBcfvgSoOfU+4VXJaCxQorxIFz4hkSeNqk+eW2QbEpg
         wTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894040; x=1703498840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgSaHLgLTodWC2yz9NpazNVGTJRi7IzB1/Q/gA4W3IA=;
        b=Sgt9pE5jQ4D9lf84IgpPxYDTTm00qEcxE8tX5oW57jmM42NKz3q4Ws/MvYxTWuCf9i
         rBjNUB/OIyj5lWqLB/g+ylyJSIsmuGTzb4XVUarNgLmHGbjsC24lgzD1Jl72A3Cmn8ww
         cVly8HO/1lg4vw4Xr7g3G17BGkfq6lCkeUIqsNVyI65EM+qcyCfXxf28yPeUDXfVAqb8
         vXqGPL2ueHITuPpftN+KnRNssnfoeiSBGkdevpWHy1/27I/F3lqZsFOfkUsaxpm8LqDb
         9i0s0bhMo5IRfJwYWlE2Z5nqq5xISoGa3nl16PlNsIXJ/XMxTUXSKK15j1IfytiSW6I3
         uDrQ==
X-Gm-Message-State: AOJu0Yy4NMz+Wlx51y5hqWgMrJSiwy3x+wsVtYCOaXOCeqoOBFPgmXtj
	4Xq2PmmPZAV0vrFNgY4xjoZP7w==
X-Google-Smtp-Source: AGHT+IFZ5DOHfPejP2r4NdgO3Ho+kff8z8GEToJyblH512W1+JmsUPr1ACnRBwBIbILc84wi8MiuGQ==
X-Received: by 2002:a1c:7c07:0:b0:40c:62be:4fe7 with SMTP id x7-20020a1c7c07000000b0040c62be4fe7mr1868633wmc.118.1702894039977;
        Mon, 18 Dec 2023 02:07:19 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b0040c43be2e52sm33818365wmb.40.2023.12.18.02.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:07:19 -0800 (PST)
Message-ID: <8527ed96-8d91-40cf-b1dc-4a99e732872d@blackwall.org>
Date: Mon, 18 Dec 2023 12:07:18 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/9] bridge: add MDB state mask uAPI attribute
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-2-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Currently, the 'state' field in 'struct br_port_msg' can be set to 1 if
> the MDB entry is permanent or 0 if it is temporary. Additional states
> might be added in the future.
> 
> In a similar fashion to 'NDA_NDM_STATE_MASK', add an MDB state mask uAPI
> attribute that will allow the upcoming bulk deletion API to bulk delete
> MDB entries with a certain state or any state.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   include/uapi/linux/if_bridge.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index 2e23f99dc0f1..a5b743a2f775 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -757,6 +757,7 @@ enum {
>   	MDBE_ATTR_VNI,
>   	MDBE_ATTR_IFINDEX,
>   	MDBE_ATTR_SRC_VNI,
> +	MDBE_ATTR_STATE_MASK,
>   	__MDBE_ATTR_MAX,
>   };
>   #define MDBE_ATTR_MAX (__MDBE_ATTR_MAX - 1)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


