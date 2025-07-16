Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9155E262815
	for <bridge@lists.linux.dev>; Wed, 16 Jul 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676199; cv=none; b=gVLUmZuXRcgytAcU8MYN5U/AS7YRejRa7J+MiN8/X1WIXRCACeNKpNXTVSlSEXiL8nIGsS1Ektw1jh0oV0w9nuPxbmAWYLZqFpvXhPofmsQCxkD0hRxkfztggMz/EWK2rCsSKgGokn/Qtb8EN2miW5stGTinv9jtTiW9C7lUS9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676199; c=relaxed/simple;
	bh=R3X47Anq6N11xoa48VLLuGRxi8pi4MkwN/qO2tgC6wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sriz0sWdBu+f6ianwDLYKD3LavP9YOGo9nIu1gxvJFUPzg/C6PG5GkxWcya8s1uJgRPjLux7gmeeHcY9PCOFKSUUsMjqBRRLjOq6bKymVgc6+yZ19nNR/joKne3hnSUDu2T6bCi/5Vk6Mm+T3iGP9HdZQRZP6PF2mHGY2WdKUgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoNw9SQ3; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoNw9SQ3"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7183dae670dso4907297b3.2
        for <bridge@lists.linux.dev>; Wed, 16 Jul 2025 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752676196; x=1753280996; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GncqGP7goJeoYVJ46y/gd3Gd5COzdFRWNNvDrQIFaFQ=;
        b=ZoNw9SQ34W2f9QBChUSnsZuje8DO/OSfpcS4KFlWw+VdN2hMmR4uK2O51fCAzASP2z
         PGGJAMJmT663CzxoO052S8eTrzfTy4zF6Q6PD3MRzoh9++CHA+/LyqS3eGwYBs6Bd3qZ
         CHa7fIVz5cDJ0Ui7jBD4lMZiUExAco6//fq0OB+zMqpTsrA5UZmFO4/l8oVlS+4tBa5b
         gSc2mQIwv7bJPYDHXmbh6VZyxB7w3b6gLFm8YnMKL9VbbUxTES3frmCysHHGBm2H5Ik1
         Zrp15/P8/4kN28NmIbI3PdY8r3mimBx+lgh91bZ4+a8fNrvpeXkxoKzpCdG76/CS9LwN
         p64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676196; x=1753280996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GncqGP7goJeoYVJ46y/gd3Gd5COzdFRWNNvDrQIFaFQ=;
        b=SRC0w6LrcKi3DdvD8O5MApsMqfFlQUheHe1NLKggGUriSkULmFYLZj9EuK1mo0OSiK
         40YSFBERqSu6cmv1MwIpO4ah/b9Ne8UbL85VIbS5DQhhNpO9N24tGrVMO72EPPg5Anbw
         gkLgz6of46lzt9JkXSs4CbflGr3+ghZRuAp0h6tsmdG0V3bXG3/9Fli6zJX6hp3n7Mrc
         Gx2SgDyLhbR9qT1mxGRJwMQLs8WJzJfC5EERZ7c/2k3mSrxyGO58o3PvSUJWrjnfqPS1
         FvqvYDfQ2MWP8SOTjPJoV0BMKLOaxT1oHnM7I2sibwQb1K9DGNCOZrSNiEsEeKP32NYf
         cfnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3QTYeM9o7kNPWN6Zky+Dz4HiVZ3kUJi74fkcjVRCufQANq/cHKswwpRKXzobe1J2K9XqMl8g=@lists.linux.dev
X-Gm-Message-State: AOJu0YwED7I1w4JTw01fxz8Z03IQBTlNHlvmeSBtSR47A8MgzXkP+QS/
	Behqd02Lx2ZxjJNO9KE/qQ0pRTI50AGmx6gioo7iXTjEabcT0hKNduuC
X-Gm-Gg: ASbGncvBhE/gF0gBA/0EtIBcE89lLAUyhi3cmm7YSWBjD2vvE7N6fyX5xejwmcwVo7P
	iw7Ygx6Ck7M6NweqezP6k8rdlNyvCOruh8KvCkhOysPBSsICy11z5ywoP+YINs1j5zegYnAww1E
	nANXx+4HGcf61yEXltlCzdYFmW/xwBmzhnKruAaect8ZaSR2QiYz+uj2tPCeg3OMQnwnyCuxzqN
	CmQ6h1CujvA/BhRfg2da/4JGk21In1kpS/0g5eQBVwSNCTSYN++R5kezrNRnzrScroihGkpduld
	AYc+91duidqnQ9ixNqQCmoHIrD+CdeJjZhzuN9iSJU11grKpgxhi/n2XFzQbgjrz2QNVJGDnr9F
	xHv8koIObVGlYgqwzfUTjArFRvt7u53JzX1OaIISOWToi
X-Google-Smtp-Source: AGHT+IECZdXPUbZpvN2ZpX2PO+J3L3S4jMhg72Pi4l759WXRROZYGicT98mbxgDJQAus/1z4edwLdw==
X-Received: by 2002:a05:690c:6f82:b0:718:4511:e173 with SMTP id 00721157ae682-7184512026dmr7358367b3.12.1752676196435;
        Wed, 16 Jul 2025 07:29:56 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d734casm29278127b3.31.2025.07.16.07.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:29:56 -0700 (PDT)
Message-ID: <67753866-5237-4758-9bf3-d6a8611ac179@gmail.com>
Date: Wed, 16 Jul 2025 10:29:55 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: bridge: Do not offload IGMP/MLD messages
To: Ido Schimmel <idosch@nvidia.com>, Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250714150101.1168368-1-Joseph.Huang@garmin.com>
 <aHdF-1uIp75pqfSG@shredder>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <aHdF-1uIp75pqfSG@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/2025 2:26 AM, Ido Schimmel wrote:
> On Mon, Jul 14, 2025 at 11:01:00AM -0400, Joseph Huang wrote:
>> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
>> being unintentionally flooded to Hosts. Instead, let the bridge decide
>> where to send these IGMP/MLD messages.
>>
>> Consider the case where the local host is sending out reports in response
>> to a remote querier like the following:
>>
>>         mcast-listener-process (IP_ADD_MEMBERSHIP)
>>            \
>>            br0
>>           /   \
>>        swp1   swp2
>>          |     |
>>    QUERIER     SOME-OTHER-HOST
>>
>> In the above setup, br0 will want to br_forward() reports for
>> mcast-listener-process's group(s) via swp1 to QUERIER; but since the
>> source hwdom is 0, the report is eligible for tx offloading, and is
>> flooded by hardware to both swp1 and swp2, reaching SOME-OTHER-HOST as
>> well. (Example and illustration provided by Tobias.)
>>
>> Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
>> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> 
> I don't have personal experience with this offload, but it makes sense
> to not offload the replication of control packets to the underlying
> device and instead let the CPU handle it. These shouldn't be sent at an
> high rate anyway.
> 
> 
> I think you can just early return if the packet is IGMP/MLD. Something
> like:
> 
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 95d7355a0407..9a910cf0256e 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -17,6 +17,9 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
>   	if (!static_branch_unlikely(&br_switchdev_tx_fwd_offload))
>   		return false;
>   
> +	if (br_multicast_igmp_type(skb))
> +		return false;
> +
>   	return (p->flags & BR_TX_FWD_OFFLOAD) &&
>   	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
>   }

Talking about these packets being low rate, should I add unlikely() like so:

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 95d7355a0407..9a910cf0256e 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -17,6 +17,9 @@ static bool nbp_switchdev_can_offload_tx_fwd(const 
struct net_bridge_port *p,
   	if (!static_branch_unlikely(&br_switchdev_tx_fwd_offload))
   		return false;

+	if (unlikely(br_multicast_igmp_type(skb)))
+		return false;
+
   	return (p->flags & BR_TX_FWD_OFFLOAD) &&
   	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
   }

Thanks,
Joseph
