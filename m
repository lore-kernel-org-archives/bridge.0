Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53B28002F
	for <bridge@lists.linux.dev>; Fri, 16 May 2025 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747439758; cv=none; b=SOIUAi34zR+AHTKkJv+4FqQqgHJCa2EjN4CeYxA+RZjSRL5VO9BhNDIaY4opkSMigqFBi1wkSKrjqgS4XTlBIK79bTjw50d63rq7pSzklIFLIhKIYwz8XU0ZAjFtOpzPvDW2sBirFTVbyPeWi5olnSN6WQwI74qZq4oNldbAb+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747439758; c=relaxed/simple;
	bh=EufAfJqm0pMz0K/Z5Mq5mBGalNCwCgRsBFQ0MTjK0Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuaqdLUaTsF3wza/Tlm5WEjdJjXFN3yKPxD6jIGFTIwXqcYuITXcmCflwDyLeaZVGjFcHmZWoBCcAEjdsm+3+yD8maLY4OwjevH9wWHpLSqc1Bbocn5e94iRkWJh+mitaXDlaJVxXHOQ1t+NI+RS3IlAS6NLplzSWakSwaAShgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=KabNsCEp; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=nhi9N5vy; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="KabNsCEp";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="nhi9N5vy"
Received: by mail.netfilter.org (Postfix, from userid 109)
	id CF8CB6026D; Sat, 17 May 2025 01:55:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1747439746;
	bh=s4MLl8BZyMf/gXInxet0dsYr6y/8baeq4mQfN2URMqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KabNsCEpMrlQYRg4fXKOVDEU+lrohUroNI5iDpdwDfO3J411fHiZ5KlNdd4SamEaZ
	 dZJvO2A4xkSvlc9EEQw2j2+R3bRx/bnHrjw0gqnW9s1MtMbwgw38XEHTcyEpiHyDTS
	 Kd9KNS/zISLp4Rl8DA29HBZm3IdAVpvSHGVeNUAC3GfDW1Zd46exdYUDfMDfmadd7u
	 wvMn+e1ol5puV6odHYdTc50WAxisjW7ZchvOq/dV8pVn1MOTlicj1jvMHg9ycBxpsK
	 ebXJTGwrxkVBmNquWsaN6lHyKC0M/KCjZ+rKZ6f1Vxh6zV9DcyngGfUNx5/0j3Dq4T
	 HRMj76IErXa9w==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E245560254;
	Sat, 17 May 2025 01:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1747439745;
	bh=s4MLl8BZyMf/gXInxet0dsYr6y/8baeq4mQfN2URMqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhi9N5vyrGGNgXAjEW8Xp1OD9LnrSJFG1Z9s0QuBgqzc9bKkUCRFhBVFue/il8bW3
	 X236BhWVoZJ+CGADdzOJ/Q2dV4sqozjkxlf3IQsj2HrepDJLMOBRHQ33ZaO4yqv5gw
	 bIafvshgR95vhlMQrg3kLfhNvwTZFkydF/T9OyQ22Ye02myxkvWQoSdcwlP7yqXJk/
	 olJam/0UaiYGyJBHwE/mWXzFaO7ykCiHhm/VVBZOJQaFSUqmviIw4mgN6mWMH5iJKo
	 OOY6S3th9A+jWb+CdcH6IdSAYgZjC+mrqHAw2pa25GTL2uwDxf4QZdHPk1zCcEXHTc
	 s+mJp7DgMXV4g==
Date: Sat, 17 May 2025 01:55:42 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	razor@blackwall.org, venkat.x.venkatsubra@oracle.com,
	horms@kernel.org, fw@strlen.de
Subject: Re: [PATCH net] bridge: netfilter: Fix forwarding of fragmented
 packets
Message-ID: <aCfQfq_FEwa98RCw@calendula>
References: <20250515084848.727706-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250515084848.727706-1-idosch@nvidia.com>

On Thu, May 15, 2025 at 11:48:48AM +0300, Ido Schimmel wrote:
[...]
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index d5b3c5936a79..4715a8d6dc32 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -505,6 +505,7 @@ struct net_bridge {
>  		struct rtable		fake_rtable;
>  		struct rt6_info		fake_rt6_info;
>  	};

This is missing #ifdef to restrict it to bridge netfilter.

> +	u32				metrics[RTAX_MAX];
>  #endif
>  	u16				group_fwd_mask;
>  	u16				group_fwd_mask_required;
> -- 
> 2.49.0
> 
