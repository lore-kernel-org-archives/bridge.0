Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D4F266580
	for <bridge@lists.linux.dev>; Wed, 16 Jul 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680573; cv=none; b=cSb/FLShKc0/KHyuo4sjTkuAzyVxcOtZIXdJy0FyqZgSKirXe2Tgx2pKVacONudae75D0P0cVdM6bjSsWJPh4W20l4IiFQQ0CWXgKEWX+wvDlmRa+Oe1P+KVZSmWF7JpJ7DhItnrW1+aNBTI7rC0w38kT/anBxnOeZhq2cFM7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680573; c=relaxed/simple;
	bh=LkfYF7pYFAHo2uQSC7pPYzH3bZTmHka3sLvqjeIRpbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOYwuYRfLJrpCUZs+K8cugdHUr4ING2RwrmBZmeAWl77+IP1+XSNu1WQO6NXVw6PTH32rOxgsQBRNQ3dHYr525mVmNzpzQ6cQAeoW+lucx0gTxqEzqa4jLTkg+iMOqwJoGqZZokh99iGwbH3wPeSrtbYh6L7Pjuw3RcEVeljIgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=G3P1GKcs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="G3P1GKcs"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso11772366b.0
        for <bridge@lists.linux.dev>; Wed, 16 Jul 2025 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1752680569; x=1753285369; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxjVPc9lLv7029fkYsxMY5nTf0b4uYTpgTGxXCLpHBQ=;
        b=G3P1GKcstUSHllgxRG/3eqpebSisDPoCXx5HQjo7JNXLNotxGzfbPYyBN5XPyUemOT
         3Hv1gR5c2V4wngBrgDwxXKPl1GeTsyTzFZxrh5CU5Ld5tsODnjOWEfWy+jESs6MT0K2p
         Qi1JgH0G3LiryiYkC8hxpfnE5QUlXtFhjnhW3blUWQXMtKCUySlDlxmlfKDK1uR3/1VQ
         ZMxsnX/7Cuw9/ghFTaTG1bhmZb/7pN+sIEWFrFN/b7D9MGUoghax/ed4aUQQFkz/k0lw
         HhjyqVuzKk9M7n6Q3u3OpUC1iieAkIV8UgrCRR8sGdq5y5QTGwllxDFQY1nCoBbbBQiL
         eplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680569; x=1753285369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxjVPc9lLv7029fkYsxMY5nTf0b4uYTpgTGxXCLpHBQ=;
        b=NlG7wjkVATEYigJku644DzvvgKaTCXRpQ4aJ9qk8JjVsEXyCvLx5wNgVRcqqtT/DAh
         0jLThcyMMRVOZP54xBfCu/Edv/jpeg1NOeFJtEPTnjCBMfHpx2mdLIrCkMBORWnJBkHk
         M9d989L/m0YhAVVHj7KyATednHBMxIVNp/x6Ig0YmQSHbXWIIWY+P0fFDLG3Dv9JV/O2
         ruKqr1mvbPy6aTvZ6lognm8DMWHNEidaGPCc6Fcw6yBUPIEWqVpK3VDn7BMUSVRTKvLz
         MSQCQw3sgty1zGUy0wQ+bAwppRIIOzf9PqgsQ4XAicGqYwVB3+VRDrkLOPD+7ADsICVI
         ywxA==
X-Forwarded-Encrypted: i=1; AJvYcCVXBKG1MWFGvNW/Z6/+xwZJkOYEW+RQotzai3YU8dqAaT8ORxouqXY4ZAM92VdonZe8vGo2fYY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwMbTYJtDVOvC6DdqMvUWO9n5JUUyEpVMpu+0cjwofjSEl/vl3B
	54w8mnXMphyK605Dg0pIqTMN81fZFdr/CjjKIm3w1LLFVQs1HmpcUXYmLRmNLudc/uY=
X-Gm-Gg: ASbGncspayCD20KChc9Pu6W40wdveQ4z9Hu3N3yY5YQHZK6T8FmJIWTUHTie/kOwtNn
	n+rsQXb1dIennzJVTrtIReiLuv/kJ/TeKU5mC+1pSs23np4QcxJv8M6SUeLRFcwaKKPHog6oCYs
	E7FVcW6/Y05otrWoom1cAHVo6OeV0Navd1NIgLYgnwecQzoeTd6Be0KBu7xwh2pGgrIjCFdf/sA
	9bia4MpK1pKb1O+6wgDCU74FzCxvLU/8U8sRZYjmavmy0k3m/WzwT5lV8msRmms9i5yXnFSC7vt
	EArITMAJMGb8q6xPXWXhR7C+EyLPCPOjWvmlPzQemk6gFsPYkFz5jnn84LmF02im55YwCfISGwV
	THqGKi9o35agtBlseEHJ3RlG4EkC7IRVv/NWE2iowEa8/v3oIyWhcNw==
X-Google-Smtp-Source: AGHT+IEXxAmRZhBfXJJ6RXAaXnDHc3IiJuVLZMZWlWOmL9qwv0jbe41xNN9dmF6K4gloyVg6nJBmJw==
X-Received: by 2002:a17:907:3f94:b0:ae6:d51a:4ca3 with SMTP id a640c23a62f3a-aec4cff8016mr2809166b.25.1752680568653;
        Wed, 16 Jul 2025 08:42:48 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2efsm1217605566b.151.2025.07.16.08.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:42:48 -0700 (PDT)
Message-ID: <1757a42e-573c-41ab-b2c4-b8e1f2c8f46b@blackwall.org>
Date: Wed, 16 Jul 2025 18:42:46 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] net: bridge: Do not offload IGMP/MLD messages
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250716153551.1830255-1-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250716153551.1830255-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/25 18:35, Joseph Huang wrote:
> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
> being unintentionally flooded to Hosts. Instead, let the bridge decide
> where to send these IGMP/MLD messages.
> 
> Consider the case where the local host is sending out reports in response
> to a remote querier like the following:
> 
>        mcast-listener-process (IP_ADD_MEMBERSHIP)
>           \
>           br0
>          /   \
>       swp1   swp2
>         |     |
>   QUERIER     SOME-OTHER-HOST
> 
> In the above setup, br0 will want to br_forward() reports for
> mcast-listener-process's group(s) via swp1 to QUERIER; but since the
> source hwdom is 0, the report is eligible for tx offloading, and is
> flooded by hardware to both swp1 and swp2, reaching SOME-OTHER-HOST as
> well. (Example and illustration provided by Tobias.)
> 
> Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
> v1: https://lore.kernel.org/netdev/20250701193639.836027-1-Joseph.Huang@garmin.com/
> v2: https://lore.kernel.org/netdev/20250714150101.1168368-1-Joseph.Huang@garmin.com/
>     Updated commit message.
> v3: Return early if it's an IGMP/MLD packet.
> ---
>  net/bridge/br_switchdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 95d7355a0407..9a910cf0256e 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -17,6 +17,9 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
>  	if (!static_branch_unlikely(&br_switchdev_tx_fwd_offload))
>  		return false;
>  
> +	if (br_multicast_igmp_type(skb))
> +		return false;
> +
>  	return (p->flags & BR_TX_FWD_OFFLOAD) &&
>  	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
>  }

LGTM,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

