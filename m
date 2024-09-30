Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A11E1F95A
	for <bridge@lists.linux.dev>; Mon, 30 Sep 2024 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690789; cv=none; b=JNcppZnsZm5ErSZZvQgNvlparbGMPcG8+cQybylyTN5hGBh3cEekXvVbkR2tBGjySEoM478N348JEiGMVpK1UnPA9Tw28f0M0m9kyzEI4JZ9ZA3FCIuf0HSsbMRWCzh70WEdF+hfplEVMJSQ9SkIhl+I+/O24jRGazd6POW21Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690789; c=relaxed/simple;
	bh=wQenqqC5rFf6LNvtPngLZ2vPjI6ubNFAVrQv2EewOoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OblZysAKlW9Xl5uRcslEsnS0rVfJxY3gfOSsFMTaEqDl80ZlS0Uo8l+9TMoC0ehjd+FrvDOhY9xZ9raJJEAX3ta8pRTsee+flNm6hPtLu5Ur13aloDJqaU5el9/OugZ4Frzxy+NGg4EmP/9VCOifXHZc5IjvrR34ow173g2rhOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=smME/ZFx; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="smME/ZFx"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398939d29eso2808455e87.0
        for <bridge@lists.linux.dev>; Mon, 30 Sep 2024 03:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1727690786; x=1728295586; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LK/6hIFc6R+Q+3qL3TGrc7l6PDeV/3Luhg3R8QTWgLU=;
        b=smME/ZFx1d3R0jjdZr9n5Nuqmck3OMEHjfZl+VJ1xOSO9AHWFt44Y2U0uqXKk0ZVfX
         VldKR0tyGJGM0GpP5Uld57wOgdNvQPz300np1ORg6Ij9CReZq/nrY+T3Rd61eZ12tl4V
         rMcl4DXCQFaR4jW0C1GcsmUzdGMZimj6rbBzkE1xfQaFXoKE9PlmxjTKpHRa/NyDsiL5
         J7ABw37Sf7K2xohBTlEvMmnn0uZw4OJZPyp5HIL12ZsaukBwN5qaqEQ89mc4t48+0ven
         3GwTnbJi3W0BoselxaAA8A2vlrU77UqYupDDhQgiJHTsGon5HHXpDrwND2Y2o5smBifa
         Tj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727690786; x=1728295586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LK/6hIFc6R+Q+3qL3TGrc7l6PDeV/3Luhg3R8QTWgLU=;
        b=L14C2ZkfkJDSdjY8PeTZE+0qPKIyOLUHU/yPmgzXPbTZ19lPQfykJGSDM9PffphIAj
         N9yk6zgNB1I/Q5ZSqJq6inoqfc9Wzi0Bp8ti1xTpmokP5H4JF2KOd6J/0J94vQ/Ock3b
         nOG+kUIaZHJkMipHTnNoWxmPVr0U5HiekaGnG/ZWAHaA7iVQeuls9oK+Hh3YodLki38y
         q08fPg5MXChUkejxyO/1tTj1wy73ZW7ooIV6OrpSJQ2kQgdOGSZLit3Me01mtvZ0bkbd
         87ojLIH6ZK8ipJzrYeQ6+WKvcRp0LHPfOUNN8LEIr3ialvbopF3iGusyhUyKgJSN6+ao
         eapw==
X-Forwarded-Encrypted: i=1; AJvYcCWC4QQWqJMoKoa8wQaCS+M+KuN2x2xwmQARxuW5h3skbEVMnT993aLBDm7vD5ohjCdkXl9FpuM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxCt7+yna5ER24fdUVZUoS4T7thHvbbVqtMMTGiIikGEj0dX6SQ
	2sOb8BNs3otGBJRvb1sO3Ox+ioG2uCqHjn0u4kvYYO4B9537MWWMX7fe/6K7bEY=
X-Google-Smtp-Source: AGHT+IGAHgFxCQCJq1B5VvaJKWcHBh8e9dNIeWpP4myTAS2i0+MebsS7UNOcWE2YO2bCvp4aR252VQ==
X-Received: by 2002:a05:6512:3c8f:b0:531:4c6d:b8ef with SMTP id 2adb3069b0e04-5389fc34548mr6133879e87.6.1727690785629;
        Mon, 30 Sep 2024 03:06:25 -0700 (PDT)
Received: from [192.168.1.18] (176.111.185.181.kyiv.nat.volia.net. [176.111.185.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a04399d3sm1189833e87.191.2024.09.30.03.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 03:06:24 -0700 (PDT)
Message-ID: <7ff94e87-1b9d-41e6-82a0-c13ff986adf5@blackwall.org>
Date: Mon, 30 Sep 2024 13:06:23 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: mcast: Fail MDB get request on empty entry
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, bridge@lists.linux.dev,
 jamie.bainbridge@gmail.com
References: <20240929123640.558525-1-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240929123640.558525-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/24 15:36, Ido Schimmel wrote:
> When user space deletes a port from an MDB entry, the port is removed
> synchronously. If this was the last port in the entry and the entry is
> not joined by the host itself, then the entry is scheduled for deletion
> via a timer.
> 
> The above means that it is possible for the MDB get netlink request to
> retrieve an empty entry which is scheduled for deletion. This is
> problematic as after deleting the last port in an entry, user space
> cannot rely on a non-zero return code from the MDB get request as an
> indication that the port was successfully removed.
> 
> Fix by returning an error when the entry's port list is empty and the
> entry is not joined by the host.
> 
> Fixes: 68b380a395a7 ("bridge: mcast: Add MDB get support")
> Reported-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> Closes: https://lore.kernel.org/netdev/c92569919307749f879b9482b0f3e125b7d9d2e3.1726480066.git.jamie.bainbridge@gmail.com/
> Tested-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index bc37e47ad829..1a52a0bca086 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -1674,7 +1674,7 @@ int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
>  	spin_lock_bh(&br->multicast_lock);
>  
>  	mp = br_mdb_ip_get(br, &group);
> -	if (!mp) {
> +	if (!mp || (!mp->ports && !mp->host_joined)) {
>  		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
>  		err = -ENOENT;
>  		goto unlock;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

