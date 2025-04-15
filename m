Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659CA288CAE
	for <bridge@lists.linux.dev>; Tue, 15 Apr 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710004; cv=none; b=dm89QPU8C9abUbmhDaNITU1Aj8InzIDLivD5LSfN6YXP1DcImnDo45/yj6UCVXS9QF8aknz001QCU7a2wWRWrTpQCWNgbxlOobioDn3eHkwOS8AAXSpHF0mcdYFeWKdYIW2T5MtLMqdT4aKHODr7kJRj454j4AlgybDa2wCmw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710004; c=relaxed/simple;
	bh=zuT+UrwO92mBo3PFOJ4dtbbO5SqyhaBWwQA8C7tLxqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eshv92N6XB/gybDbejfAo0g2TwWHE1ve8aD8dUp1jshWdLZrkOL3kWFXbPaHdc+ZpjhaxojbdVLrsRUAZwRsXs8SNJqg3L2O+wpYBhsteHwGee//jjThQ+z7uCH06ZF6HhO3Nb678o5eez7/VwtiL606s6M+IbwM7/IvUxkHCc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=qsX0qO5W; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="qsX0qO5W"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so44773355e9.3
        for <bridge@lists.linux.dev>; Tue, 15 Apr 2025 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744710000; x=1745314800; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmZOs8Rz2SRsBXQDEu0M9cDNyzZUv/bQ4RbErsr9sHY=;
        b=qsX0qO5WlILOdjPktUxMuqtgOMgKk7P+OGmEfUcx2JAHgeO+G7rr+EhaXCu0RM9vlQ
         xknjNxxALo9qCc7MIAsKjsXleH1D0EHnxqHg6ZizXE+4HEkbdABxQ6LVGUSMIu0egu3k
         zspDlZP6ODPxJ9zOtdZqg9ScQStmK3+wqZSD95380qj1xmJsF8N51287cHbBMTOVTswU
         aybUjb3O9pSaNDxT1z0OJb2Z4Rnv+xzmPjZu9ys+F3Qxgf6DstWaeweQotimkdKF8ZsP
         b4vWYR9Fb/ZbaEeYQtrnZmipCf7duosLzWnFopz6k00E29y4u4rD9r/zcdVH9/eaTRag
         INyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744710000; x=1745314800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmZOs8Rz2SRsBXQDEu0M9cDNyzZUv/bQ4RbErsr9sHY=;
        b=nPA47w/Yg933J/5hsAL0QEQ+HjwJSfscgh9GSjWzWcZ90X1iZuEKvt4gR3kotmpQwa
         4TK//pggIaB8XWKCcLhLw0jT9Nn5JIGkyJa+y4BB6ARVVPEid66ypcMgeTWZC7bqR4w1
         G/I+huu0pN24WO6ncYQ/Ue4ZAX5qIwZZ+qTVSGixFA5hffIM9BAbZ6FI+PplRHsLBl8/
         W8a+Q4ZdXNohY7LN39miVc11Vd+a9wmCynFI/em4BHtIqYAfOyqakIIIYvn7JqiN5NSX
         jTedjLM30coPANt5zCPEFQp3+ZivFGs25Z41gLoLlaWjWbpuO5I+9aY0tTE0e+ORhENQ
         CWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqyIJhGt/4auqMF6w06uQw1SLrZ/2cX4XDNBTP86j9I3eF3Ms79HsLEIhxsKDdHdvwQQ3cVQA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yza9raWMcgqtSFijTicg2xShTCJ6U5UwD/zEzcO8WdSx9QGwYgJ
	3wfN3pHTFlbEU/T3VeqToLiQgiHfNcKohhXSaYHizmmE8zYLMMcL2t05xFn9KAI=
X-Gm-Gg: ASbGncvd1a2G30WLXOKt2zmnpfUOEB5adO01dC+LpZhz3TNneM064fDIDok36nSLTkE
	7v0OtdFigZ1thsNQyPpQt0cAP869FfSVXnPcHDJvaQ8Uu8pId8bJJJUyLu5FvwicwFvXhYipVGY
	5MebkrN2gk9GgAJIA/r7Oec70mYItJx8xh27QEsWAoPa1bMouonfx7pLe14b6PZak8BeLxhnPuD
	VRFCUkfJuVwDCMED2GuMW+t01RfpVouwT11V4mrQqCyIQYQKR/cx2cRSZ4YIAE+lIDpwzDKL+g5
	LmKL7+r9+oHu6O42IPzr92NfpI/v52ugeSglhV/DmFNSBZUbdaBWKRE0tpTMMF1pAjmqxwzQwLy
	SzuJNkYo=
X-Google-Smtp-Source: AGHT+IHF2FagMNaFNbqP/pP/Mm5s2FMwRszKIuGZ4NXlyxggm0m0+ymsT1EDLfxfWhc/bLYDwM86og==
X-Received: by 2002:a05:600c:1f94:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-43f3a925eb1mr132089105e9.7.1744710000434;
        Tue, 15 Apr 2025 02:40:00 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d109sm207839905e9.20.2025.04.15.02.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 02:39:59 -0700 (PDT)
Message-ID: <8b338c8b-9514-43e4-b1b8-3240b3bde798@blackwall.org>
Date: Tue, 15 Apr 2025 12:39:58 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: bridge: locally receive all multicast
 packets if IFF_ALLMULTI is set
To: Shengyu Qu <wiagn233@outlook.com>, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
References: <OSZPR01MB8434308370ACAFA90A22980798B32@OSZPR01MB8434.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <OSZPR01MB8434308370ACAFA90A22980798B32@OSZPR01MB8434.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 13:56, Shengyu Qu wrote:
> If multicast snooping is enabled, multicast packets may not always end up
> on the local bridge interface, if the host is not a member of the multicast
> group. Similar to how IFF_PROMISC allows all packets to be received
> locally, let IFF_ALLMULTI allow all multicast packets to be received.
> 
> OpenWrt uses a user space daemon for DHCPv6/RA/NDP handling, and in relay
> mode it sets the ALLMULTI flag in order to receive all relevant queries on
> the network.
> 
> This works for normal network interfaces and non-snooping bridges, but not
> snooping bridges (unless multicast routing is enabled).
> 
> Reported-by: Felix Fietkau <nbd@nbd.name>
> Closes:https://github.com/openwrt/openwrt/issues/15857#issuecomment-2662851243
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
> Changes since v1:
>  - Move to net-next
>  - Changed code according to Nikolay's advice
> 
> Changes since v2:
>  - Fix alignment
>  - Remove redundant parenthesis
>  - Add more infomation in commit message
> ---
>  net/bridge/br_input.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 232133a0fd21..5f6ac9bf1527 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -189,7 +189,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
>  		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
>  			if ((mdst && mdst->host_joined) ||
> -			    br_multicast_is_router(brmctx, skb)) {
> +			    br_multicast_is_router(brmctx, skb) ||
> +			    br->dev->flags & IFF_ALLMULTI) {
>  				local_rcv = true;
>  				DEV_STATS_INC(br->dev, multicast);
>  			}

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
