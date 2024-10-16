Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0F206E82
	for <bridge@lists.linux.dev>; Wed, 16 Oct 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076886; cv=none; b=usDgWiGP7T8rLGzXvLeDZb4eQVPgOu9XxvdxctlVwFhiXi4k2hKtgoMduMm/9GKLyrlOo26hBy07CQevJjVZc/C5KONq2CKgCfnxN6NGCuq8EG7QLWqw76ermRfac3egFWpxt5qs8udiDFWJOnT8YZaQ2MnSOwzX+I3b2EU2arc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076886; c=relaxed/simple;
	bh=GxKG4+Zaa8Exeey8AdpBwGfCynvajyhPcr9selFKhGE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPVXG/C2FfVhmvKZh/ly62m0wYjHHOC8azX8qdbLrMvKyz2jCuB73KvzO6Z0VKiVQ3PLKAAbTIn0b35+No+2KqlxBXzwQ9+oyNVZjExqi/vjN0bjg8gFZBd3M/sjX3na2ccksvxEdHVVPrXCzj0xmXgSAgk45ywfuxKrrpp9uWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEd28Ind; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEd28Ind"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so31590101fa.3
        for <bridge@lists.linux.dev>; Wed, 16 Oct 2024 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729076883; x=1729681683; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPuPFBsmpS6kyoRLa40oYeelH6usyUcNmM0E4LHOWqA=;
        b=JEd28Ind9C9hniF72IS3aryqt09MGZhpdOqtyOPyeBThhxAGPS5PNZZPtrunx4sqrz
         wVicQBSEbeqx0ShEcK/xL745mIsPe9Mf2D2ZBtOJm8BpGPqM0nht/URzLQBBdHRLsYq/
         i3mjjSPFB/6h+QeM2dnXLGMPSXeQo34g/U87A9hjajNmWGrfA2bQo4u5w0TDZWn9HT14
         n3rprlvT+5yNetAnnQWPU0V7aRbYescGnnhL0FBkL5Dv7uelC7iyWdtozB/qHqvpQkDJ
         rZ4Rb0qwUZ2qV2edhIP9fB/B7o6lYrRNfUluX2soekFxHJYOvK6T7TM2kQ6Q6ramVVrX
         qbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729076883; x=1729681683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPuPFBsmpS6kyoRLa40oYeelH6usyUcNmM0E4LHOWqA=;
        b=JhfMV6fFkf1x1O6iDzljG6oxJsuWPlVm2kqJBTev3wgX2M8XELVMj5uibNRJxXP/02
         N1X8kKksJJoGAq9RfzgM89TnMfOwf8Ih3em2LKvXIPKki7VRT5FkcVh6v6yN9ZvR0X82
         oIsnRRFtoKsE42ybcsrK1PoOmfaCICLlARFZ2zT26Mov6dqYPIAKN78QEjP+369B3XKi
         wWvzSZmUH4KZT2AS3m7M0tO36PRmA/Qjs8yxSB3xjyWM57QU+RiuHmHib2JSuAoqJoPI
         0FA1VzX8SO4mxZYTOhpM9mpAn59MlFIGbQP/XhzSVCtrmOCRd42vuOBh5zGQfMO6iZiI
         sVPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3hmGOQOHJCBllPboPDi6b4alYO4PUP3CDixGNXw9Ac61G3bpSfIb+m1eXBtWVf/zlJSyGDrI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwqcC4/G8waN0Vtu2VOmcDw/VONDwFM8VngXsXyYnmxL/WxEX8T
	2Bf7aiXidSQ4rLglmPtCq8S57AwmYyHxbQ7mi7Z2jzKeJdA6hw7I
X-Google-Smtp-Source: AGHT+IEHessqDzBZmmSlW84vsn2IkViAv/IV58tYEB2Akc/jcICFPjSzRBjgIngWFJgycMKdtw7HXw==
X-Received: by 2002:a2e:b88b:0:b0:2fb:57b7:5cc with SMTP id 38308e7fff4ca-2fb61bb6a8emr23201981fa.36.1729076882416;
        Wed, 16 Oct 2024 04:08:02 -0700 (PDT)
Received: from pc636 (host-95-203-1-67.mobileonline.telia.com. [95.203.1.67])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb5d0fdde5sm3912151fa.21.2024.10.16.04.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:08:01 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Oct 2024 13:07:58 +0200
To: Julia Lawall <Julia.Lawall@inria.fr>, Roopa Prabhu <roopa@nvidia.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, kernel-janitors@vger.kernel.org,
	vbabka@suse.cz, paulmck@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] net: bridge: replace call_rcu by kfree_rcu for
 simple kmem_cache_free callback
Message-ID: <Zw-ejnmxwVkiVPNM@pc636>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
 <20241013201704.49576-9-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013201704.49576-9-Julia.Lawall@inria.fr>

On Sun, Oct 13, 2024 at 10:16:55PM +0200, Julia Lawall wrote:
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
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
