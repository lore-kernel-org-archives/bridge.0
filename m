Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D5933C9
	for <bridge@lists.linux.dev>; Mon, 14 Oct 2024 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889462; cv=none; b=lvWHStOj93OsOE7yqCJGdw4pCKrqzltWKKPBpYqJHlY15ztZCecd1giZLVPIb/e2wmq4DOxJ5bkVrNfgi7yZ1d6ZVWk1uwlLrt1T/zHkbzfmjRpkVyCueLtC2dnq2Msoa57MQBbe2mYKdqVUvmLh9t+VJ6I8pAqGrajY52VtdXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889462; c=relaxed/simple;
	bh=NNv6gvfmx2HjUFMGU+o2ltt/UiZOt25h1rUaIZXBx2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnkscYN+X68Iy9mmyXv2U0HCFlExLatvSsFEMQgxJxy4eakrcSfYSkaYHTOP3MKjNyaJ1nWS5FtWU+SOcFvQop3MEgg/C32IzxtPkvKNriPH8eRhlrQNb9IG+aMqyAsM3J+PXbP48hU1tkXgDgVJ9ovz22CjudC/ABmCa/tL+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=UXwG1JFS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="UXwG1JFS"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb443746b8so5130841fa.0
        for <bridge@lists.linux.dev>; Mon, 14 Oct 2024 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728889459; x=1729494259; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vGaIhPPoqC5MI9WRgwGY99B8fU3f7PY4Vcuv5+yQqFs=;
        b=UXwG1JFSGC/khJqRaTDjPDoS9X/+YZ/pt2ni3tYQUDxHsK4LpTka+Bgx3+LOSGNk4o
         fjaQ4pA3KBJCNhiksyPFX6KGm5Zq5Ds6BTnhTgNvUEk7HkCYWiN2yqoMQhNBCvtdJ1zU
         Nq3eED0O/fgzIxwjcNcIKl5O6qmloc0FsKq538wuwuNuqKJb8ltPRgkLd/hX/LNxwqGQ
         IU4/ojzm6VFHIm1Y9DMS2Uz9UCQvz+kw/U6cYbMeUnby55LnsnktfZJO4JiicG0Q+wrB
         WMdwF3YyX1ZfrsC7fPCDwAEV5ps4ScHgAIjuMvDqzdUo+kvw7PUgR8fL5Yh+CLg6Tw3h
         bw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728889459; x=1729494259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGaIhPPoqC5MI9WRgwGY99B8fU3f7PY4Vcuv5+yQqFs=;
        b=wQsdBSZ9RbS8JYB4dG6+v9A8Kgp9nZo75ceLtWFqFNbj4zc9xDjfh4QwN1YZCNg9T0
         Djp8/855W5RxLFI2b+v870SLBor4utj2m6KPoechf0Ty4nY3ukKsAraYeN4PKxCNhF9w
         rJvS1uiVjHQET7XK5V4PBoZWlFkXvmQ8k7tPO3CuWdKaUwyxHVvQBWcJcuhTPHoIvNIm
         QnDZGDCyWSW/oa7KTxMSHtdb4n8mZVpQfgLsIx96RUpKLJaMaNZII0w2GYHnVsvpD6Bs
         DNdTZfCvC5c8oGAYwCHQQ33iXfQakqZkRmoDC/A6Uks8huogyQP2LuI+pKK+rn+iKtAB
         ZPgw==
X-Forwarded-Encrypted: i=1; AJvYcCWA6YemHut+oxu7ChelDiZHOjQYe7yIaoEpwjaIsLVLUpEjI61xJCpHzpt8PyNmNa8OCKNML9E=@lists.linux.dev
X-Gm-Message-State: AOJu0YxiISVvJmPcQN07P68EuBgmoUqYiNWpYOPK5SaG36NUqE67+UJP
	vH96JgCG+wjSScbZJntorSHykLloWX6316RztN1hV5E5R8sDO+1L+2q1/+2LHqw=
X-Google-Smtp-Source: AGHT+IEm+t/0wxGBRiGGCCWGQXQM/paXJQi/z5wDFT45Y4vSsDzbKlZTz1XXD3y2hVv/E6wIFsje1Q==
X-Received: by 2002:a2e:6111:0:b0:2f9:ce91:dea9 with SMTP id 38308e7fff4ca-2fb327a6df0mr33120871fa.32.1728889458495;
        Mon, 14 Oct 2024 00:04:18 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d2196sm4631649a12.7.2024.10.14.00.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 00:04:18 -0700 (PDT)
Message-ID: <7982b197-8ca6-4621-b983-2a6b24aad2b6@blackwall.org>
Date: Mon, 14 Oct 2024 10:04:16 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] net: bridge: replace call_rcu by kfree_rcu for
 simple kmem_cache_free callback
To: Julia Lawall <Julia.Lawall@inria.fr>, Roopa Prabhu <roopa@nvidia.com>
Cc: kernel-janitors@vger.kernel.org, vbabka@suse.cz, paulmck@kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
 <20241013201704.49576-9-Julia.Lawall@inria.fr>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241013201704.49576-9-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/10/2024 23:16, Julia Lawall wrote:
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
> 
> The changes were made using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  net/bridge/br_fdb.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 642b8ccaae8e..1cd7bade9b3b 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -73,13 +73,6 @@ static inline int has_expired(const struct net_bridge *br,
>  	       time_before_eq(fdb->updated + hold_time(br), jiffies);
>  }
>  
> -static void fdb_rcu_free(struct rcu_head *head)
> -{
> -	struct net_bridge_fdb_entry *ent
> -		= container_of(head, struct net_bridge_fdb_entry, rcu);
> -	kmem_cache_free(br_fdb_cache, ent);
> -}
> -
>  static int fdb_to_nud(const struct net_bridge *br,
>  		      const struct net_bridge_fdb_entry *fdb)
>  {
> @@ -329,7 +322,7 @@ static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
>  	if (test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &f->flags))
>  		atomic_dec(&br->fdb_n_learned);
>  	fdb_notify(br, f, RTM_DELNEIGH, swdev_notify);
> -	call_rcu(&f->rcu, fdb_rcu_free);
> +	kfree_rcu(f, rcu);
>  }
>  
>  /* Delete a local entry if no other port had the same address.
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

