Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395313B2B1
	for <bridge@lists.linux.dev>; Sat, 31 Aug 2024 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725093115; cv=none; b=VNd4OyYyFmU8nBoYbt/SWuI+RFizq4hJch8x7oax5bSrRXkS7gJ716j1iZpWEdUTEyfZbihi9YilpuzKVT17uQaBUoBYECQTYF/x88xsZ6MUa+rRpNyoN4nUUYi1SZQtrFSOtP6GooGfVL9xNPcO6HViqnnMzPxJLrdpW8iB4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725093115; c=relaxed/simple;
	bh=6QS03Af/MoBQ8a6Cs4bahqVKed0R6qgBy0cH7tmKUTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOda9sUDk19vyPAN2jVn8+ltLTEEKjn3eHJZBXii1rjYeAJPw5JD+uZuqyWBEOdzyqhzZy/Bymvv5g/79KLGKD1fjlRwG2rBUV0pZ8i2piHl+EtJ1unX0/KSLQ1s1ppjE6oYQiL6ZyYWwJOdAG2WU0CFEKLyJNEgKVi9fcGe1iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=L13+w3Wu; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="L13+w3Wu"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c0aa376e15so1380554a12.1
        for <bridge@lists.linux.dev>; Sat, 31 Aug 2024 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1725093112; x=1725697912; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOV1kiUJDRR+j9uQkiPHWDoz6/Z27FF4aCc5rgHaQD4=;
        b=L13+w3WuWGbvSpPhx0Ib7GBbIEQ7mmVMVM/qqC7g338dmoJlbdXn6Xbmy5Agff3hi3
         o/LPSvT5sbn5X3BTdgVtPzDilFQ0q4ra97FcGmGlPPZhC+5gtNKlKO5jKR7YxLrXPKkJ
         /v1T242BG/Hfbz8ZrfYPxNUfzCkgHUahMSME3SkmU5Xt8QIwG+pSYeT8hNEfNzfx2cZh
         +8f/BZm1c5rAwIUzvx/ECXIkkcU0mAraCmQRZO5UJYvixpAwaybCXS268CZCx1/Z/Ufj
         QTm2Ngyh32FgETpuIXURQEv5wdc9BQsrOc7bOaoKpFhReGEax/nD1VYrPfx2E0nqVuPN
         O7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725093112; x=1725697912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOV1kiUJDRR+j9uQkiPHWDoz6/Z27FF4aCc5rgHaQD4=;
        b=Whu4ZaqetDpIG555BE2wpX1GKeohil1F1yTWjQCwds+IEYbxiUnqFk1zSRwHop5LwX
         2Xb6IZk7a9Tg9+OAg7gkFvJXmS0iGASh0mCIiovY99usX47vwy0f919fo0/E24l+MbP6
         /d9OKk7+wK24U/fvQT2Vf/P4e059OLL7/JfTKH7dtN+9yLI/2XIO3K/piAAAPu2Rjjxn
         /LvE1WFy0GpKI76TDsnuATiGI9bepQ0Fc7s1UPeN7C1NeLp73LkBUWKhJie7IDomLLTx
         7LGJLUblDnOTgkaoxhFhXqIQkrJLaGnQNYglSaDA11SqAp8K4/jBSafHB78HRKszbOhP
         nt7Q==
X-Gm-Message-State: AOJu0YzRgrZ5iILgWsCt0gDheh5i63wsKOS9SCViV8OxPBMhrbFtHyen
	u2j7EqT90S5Ty59TXgfJ/Rmx7kaJiqo9L0OaXtZ4erCyxG9FW3Pxh1pM+PZt8c4=
X-Google-Smtp-Source: AGHT+IFNJzHWAkqlbN4tO19pqGtKh+I+2ux2PP0WqSEH/TbifvCm6opt7Enz3gSB3Aum6PuAkU7d2g==
X-Received: by 2002:a05:6402:d08:b0:5c2:1803:ac65 with SMTP id 4fb4d7f45d1cf-5c21ed54d08mr8440369a12.21.1725093112068;
        Sat, 31 Aug 2024 01:31:52 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a36fsm2731558a12.16.2024.08.31.01.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 01:31:51 -0700 (PDT)
Message-ID: <b0544c31-cf64-41c7-8118-a8b504a982d1@blackwall.org>
Date: Sat, 31 Aug 2024 11:31:50 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: allow users setting EXT_LEARN for user
 FDB entries
To: Jonas Gorski <jonas.gorski@bisdn.de>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Petr Machata <petrm@mellanox.com>, Ido Schimmel <idosch@mellanox.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240830145356.102951-1-jonas.gorski@bisdn.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240830145356.102951-1-jonas.gorski@bisdn.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/08/2024 17:53, Jonas Gorski wrote:
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
> update:
> 
>    if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
>            /* Refresh entry */
>            fdb->used = jiffies;
>    } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
>            /* Take over SW learned entry */
>            set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
>            modified = true;
>    }
> 
> Fix this by relaxing the condition for setting BR_FDB_ADDED_BY_EXT_LEARN
> by also allowing it if swdev_notify is true, which it will only be for
> user initiated updates.
> 
> Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user as such")
> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
> ---
>  net/bridge/br_fdb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index c77591e63841..c5d9ae13a6fb 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1472,7 +1472,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
>  			/* Refresh entry */
>  			fdb->used = jiffies;
> -		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> +		} else if (swdev_notify ||
> +			   !test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
>  			/* Take over SW learned entry */
>  			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
>  			modified = true;

This literally means if added_by_user || !added_by_user, so you can probably
rewrite that whole block to be more straight-forward with test_and_set_bit -
if it was already set then refresh, if it wasn't modified = true

