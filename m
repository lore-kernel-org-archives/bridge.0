Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FFF1C768D
	for <bridge@lists.linux.dev>; Tue,  3 Sep 2024 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353532; cv=none; b=Qu/0yOY8925o3C3JG2loloc9h6Va7qSToUl4XIhx85cuOdByF1PlodBElPWVfgOdURXeeaOTauNZxmwDogbnfk6C8citFpTB2Imem7+vpLHhmT7HUQxuUv3LWqEmT2vzviQ9bgquara2evcocfkKRj3osZpLbMiFXLX/C8hsE9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353532; c=relaxed/simple;
	bh=6kk5VlDisA56DTM4hfMpwZ8VjhenCqrjla/XVC0EZ5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyASdYAUscR660kCU5yDUIA/6Ne+bh0mabCtYKjebtewUjQBiwYGFlQRuH0U9oZYnWdBuyZr79zqXg3iYgWLmS8PGlRcL9OpWLpA0NOg63U2bB2Ub+O+ZYD/Ia3WZQvYsuk3WEs73Bmz8apPYO9SsLODX2DnYAAc5/IXd7s/eyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=JcuO0zd2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="JcuO0zd2"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8692bbec79so563957666b.3
        for <bridge@lists.linux.dev>; Tue, 03 Sep 2024 01:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1725353528; x=1725958328; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHMd3CmyF+UqSFpXp3YC4GWm8WtabyKorKiJxYaO3+A=;
        b=JcuO0zd2RTgFG+WsUkyN3wGJL80ITUAIajqgbhEbaJcoQA/f76FmD8Iw1pjNC7vXpT
         OnBH/fi72Wlr5B9XqEe9s/7Cf3Hv9jc9mwfZQmpO0ztnRG9Nv7tsXdugpZTW7sLwg49w
         E3+Vs6dGsb3+n1mbaUx02ce8o5lWrUHdlsruc1n8EWJEerG5jEbM7ZFR981LHL3DYm3e
         waZrLzu3pLc8LLoIpdSYgaWikGfoU3Nc6lOt6DNpWLRvNmupb7H79p7P77Y+dYIxwIji
         jFJVlkwiQwlwFBsk04ranyHSz99jsXcysHdG61OHsFtS5YIfcTt+LHeDRV6bLctUDXOv
         VfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725353528; x=1725958328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHMd3CmyF+UqSFpXp3YC4GWm8WtabyKorKiJxYaO3+A=;
        b=EqWqNhUw63u77mOMP3Mdac0QjpMEE73uDeLhDdQ+de7H3N+hioWTKU0+gNMmYPz4QU
         yoFgDo79Amw9hVTgmmB+O6DrlmKzcoTe22rj2pdaCnTYdTwtgcydn+6IYvTTFO9+3I8r
         FfEQfMzuPnXCV5HVPCE8McHP0nXHK5mW2YltA7I1xQyguccppWojlmXPFMM8LRLmwTmy
         SVY4eBENWU0EO/wkz6D94LrowEhqBf/8DrpyMugt1NOaSG7UvDS7u4BwBRZykx1DsAAy
         zhp0/iFYR8LeKwNS08ugrc6z+UNhVCpSkxlBaaBRNTkCyXAQ7d8V4BYJNIrNt8J44PP2
         /zxg==
X-Gm-Message-State: AOJu0YyTbbY/KrJsOxWc3s0Hv0aLNcVRVW76V0bOJORgg4sQHG+Xu9z4
	1xmlnLBM1s8bEVeP++RwpEGCxomOzpUECGHxQr7pEU0kjOMooCaoDpITMJSfqkA=
X-Google-Smtp-Source: AGHT+IFkGNoCxh3jtKQW1b/cJ+gceEuYXUIU4qroSCyryYhzcTuRXG2ufP1+eQ3YqWuMZ/KD+8npyA==
X-Received: by 2002:a17:907:9407:b0:a86:96b3:86be with SMTP id a640c23a62f3a-a89a3826268mr783881966b.63.1725353527069;
        Tue, 03 Sep 2024 01:52:07 -0700 (PDT)
Received: from [192.168.0.105] (bras-109-160-30-236.comnet.bg. [109.160.30.236])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f6b9sm653684866b.76.2024.09.03.01.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 01:52:06 -0700 (PDT)
Message-ID: <56ef0a03-500a-4f0d-a231-25b1f7d58758@blackwall.org>
Date: Tue, 3 Sep 2024 11:52:05 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2] net: bridge: br_fdb_external_learn_add(): always
 set EXT_LEARN
To: Jonas Gorski <jonas.gorski@bisdn.de>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@mellanox.com>, Petr Machata <petrm@mellanox.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240903081958.29951-1-jonas.gorski@bisdn.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240903081958.29951-1-jonas.gorski@bisdn.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 11:19, Jonas Gorski wrote:
> When userspace wants to take over a fdb entry by setting it as
> EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
> BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().
> 
> If the bridge updates the entry later because its port changed, we clear
> the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USER
> flag set.
> 
> If userspace then wants to take over the entry again,
> br_fdb_external_learn_add() sees that BR_FDB_ADDED_BY_USER and skips
> setting the BR_FDB_ADDED_BY_EXT_LEARN flags, thus silently ignores the
> update.
> 
> Fix this by always allowing to set BR_FDB_ADDED_BY_EXT_LEARN regardless
> if this was a user fdb entry or not.
> 
> Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user as such")
> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
> ---
> Changelog:
> V2:
>  * always allow setting EXT_LEARN regardless if user entry
>  * reworded the commit message a bit to match the new behavior
>  * dropped the redundant code excerpt from the commit message as it's
>    already in the context
> 
>  net/bridge/br_fdb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index c77591e63841..ad7a42b505ef 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1469,12 +1469,10 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  			modified = true;
>  		}
>  
> -		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> +		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
>  			/* Refresh entry */
>  			fdb->used = jiffies;
> -		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> -			/* Take over SW learned entry */
> -			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> +		} else {
>  			modified = true;
>  		}
>  

Although the curly braces aren't needed, I don't mind in this case.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

