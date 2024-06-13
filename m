Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF914A0B5
	for <bridge@lists.linux.dev>; Thu, 13 Jun 2024 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301505; cv=none; b=RmJPXCYq4KXjalcssENdCV+KY70K8OsnzFALYgp/ap58giX15h1PB9o0dkLcAdQXvNQS1BqFaQGNctulBakvxAPEe2kGn6mYIkUy6/xeFurU6KQY4tPQu/avomXwYiOvi9OWLpJBldXDEYSaYiM8dwxRXE7DyqTbn8v+MGB3vkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301505; c=relaxed/simple;
	bh=4uaYQwMmXudEVQoqF/PT02d+uOaxbMCHRjXCjlN4PKo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWn5PW5K927rtq9s111EQSr+P9X0WPm6QebBbWGdt1Y4z2h9xUUYAQ2/+/FIRTbL2KvE65avYwvX7IbSXrp/eKnWYnEQyLpRtRbSuF4l5XdYVUd5r2GF3TERB75NAB/+Jkr4yVvPtrnOr3gxHajo8H8F8S2oTTNnmCHembsp55U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+2WiusE; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+2WiusE"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebdfe26217so11948311fa.2
        for <bridge@lists.linux.dev>; Thu, 13 Jun 2024 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718301502; x=1718906302; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LJdaR0AKwDxb6UxD8VgG/YvgQDgT5IhbR4y3pM8S3I4=;
        b=U+2WiusE+28DGMZ6jkpoB5B2BtrG/wgi7rSGis/c2NDzLAJ47ICoTzhxBCumrbpkND
         fi2CQmD3cuas/43QrMoXQgLWoC2Ck6y7HFWdobVLnaBrgEbtUy3uA05xZSgTLJrdNSrb
         dqkvI7OtP4YO9EYZ65csGnMvksbX9VxfAko5WcNDhBFmTpAH0uZmXhAf4QZ6RvihorzM
         MMYXWB2cqBz2q2mpA4sX4/f+Cm+AytWr+LqcXGQOP7fXgggYdUMCPiHDKBBS91Su/xSC
         v2toZJnoyQJdBaSvWu28OKWdmWYbIxycp99r3eOfPM6aJYy9nvxrtYI03p77cMQVmYTp
         D/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718301502; x=1718906302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJdaR0AKwDxb6UxD8VgG/YvgQDgT5IhbR4y3pM8S3I4=;
        b=G7xuS+Ea8jAzSojuGPWm7RviK7I4/dJwc5nA9p8BOF0qJAYm0bIw712Qfcd394SFNR
         LLXtmd/T9wUttFtvLfrjm2SQFn6pTEkZGL+AnO1ntYUYP/L1xj7RA4r83QmFv3KgeOOw
         giWS4ngwHczGrKatqjc6VcXZ0QPPJDOoy4M8KL8w4JTD2yemKjh3TurmGnIaJyBZqDTk
         3hlpQnFk7rMSNmpeGhBVeOybj21ZX+/Wh/6PHpLwfL225/SbX8vNgitVWA6T6BMB/UEK
         nYUq/wYe4H/xNP4FumDr5/NgSHW7QMd4sxD/cgJ3+p956JVQ3odjDmwLq8ho52pdKqbm
         GIaA==
X-Forwarded-Encrypted: i=1; AJvYcCW7BUxIfjHy6AwdPp+O8jz/SslQ1olFQpExzRg7I2TlwG74YfKnhPl1tL51oVgEXVGwS+mk8pHehWysoSaH3EwMxIs9XVP8
X-Gm-Message-State: AOJu0YytI7FIjNJd6jEvZAFL3QYme/uy1F/mUuhHHVC2+nrz92l9slFD
	An47eYAoUxBzAULsWA9uAbJ+Vc0j1Q7xpm06byC3+hinyBe9zRNi
X-Google-Smtp-Source: AGHT+IEhErzyVFwc5vrtNZW2dG954f3qNIGROFYFFTe33sAR7d1zhfiUTqk8uRw2thbyuYd+W2q+QA==
X-Received: by 2002:a2e:9dd4:0:b0:2ec:453:e46e with SMTP id 38308e7fff4ca-2ec0e5a0442mr3954341fa.42.1718301501351;
        Thu, 13 Jun 2024 10:58:21 -0700 (PDT)
Received: from pc636 (host-90-233-218-141.mobileonline.telia.com. [90.233.218.141])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c8a85esm3330101fa.117.2024.06.13.10.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 10:58:20 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 13 Jun 2024 19:58:17 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>, linux-block@vger.kernel.org,
	kernel-janitors@vger.kernel.org, bridge@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nicholas Piggin <npiggin@gmail.com>, netdev@vger.kernel.org,
	wireguard@lists.zx2c4.com, linux-kernel@vger.kernel.org,
	ecryptfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
	linux-can@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH 00/14] replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <ZmszOd5idhf2Cb-v@pc636>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240612143305.451abf58@kernel.org>
 <baee4d58-17b4-4918-8e45-4d8068a23e8c@paulmck-laptop>
 <ZmrfA1p2zSVIaYam@zx2c4.com>
 <80e03b02-7e24-4342-af0b-ba5117b19828@paulmck-laptop>
 <Zmru7hhz8kPDPsyz@pc636>
 <7efde25f-6af5-4a67-abea-b26732a8aca1@paulmck-laptop>
 <Zmsuswo8OPIhY5KJ@pc636>
 <cb51bc57-47b8-456a-9ac0-f8aa0931b144@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb51bc57-47b8-456a-9ac0-f8aa0931b144@paulmck-laptop>

On Thu, Jun 13, 2024 at 10:45:59AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 13, 2024 at 07:38:59PM +0200, Uladzislau Rezki wrote:
> > On Thu, Jun 13, 2024 at 08:06:30AM -0700, Paul E. McKenney wrote:
> > > On Thu, Jun 13, 2024 at 03:06:54PM +0200, Uladzislau Rezki wrote:
> > > > On Thu, Jun 13, 2024 at 05:47:08AM -0700, Paul E. McKenney wrote:
> > > > > On Thu, Jun 13, 2024 at 01:58:59PM +0200, Jason A. Donenfeld wrote:
> > > > > > On Wed, Jun 12, 2024 at 03:37:55PM -0700, Paul E. McKenney wrote:
> > > > > > > On Wed, Jun 12, 2024 at 02:33:05PM -0700, Jakub Kicinski wrote:
> > > > > > > > On Sun,  9 Jun 2024 10:27:12 +0200 Julia Lawall wrote:
> > > > > > > > > Since SLOB was removed, it is not necessary to use call_rcu
> > > > > > > > > when the callback only performs kmem_cache_free. Use
> > > > > > > > > kfree_rcu() directly.
> > > > > > > > > 
> > > > > > > > > The changes were done using the following Coccinelle semantic patch.
> > > > > > > > > This semantic patch is designed to ignore cases where the callback
> > > > > > > > > function is used in another way.
> > > > > > > > 
> > > > > > > > How does the discussion on:
> > > > > > > >   [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks"
> > > > > > > >   https://lore.kernel.org/all/20240612133357.2596-1-linus.luessing@c0d3.blue/
> > > > > > > > reflect on this series? IIUC we should hold off..
> > > > > > > 
> > > > > > > We do need to hold off for the ones in kernel modules (such as 07/14)
> > > > > > > where the kmem_cache is destroyed during module unload.
> > > > > > > 
> > > > > > > OK, I might as well go through them...
> > > > > > > 
> > > > > > > [PATCH 01/14] wireguard: allowedips: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
> > > > > > > 	Needs to wait, see wg_allowedips_slab_uninit().
> > > > > > 
> > > > > > Also, notably, this patch needs additionally:
> > > > > > 
> > > > > > diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
> > > > > > index e4e1638fce1b..c95f6937c3f1 100644
> > > > > > --- a/drivers/net/wireguard/allowedips.c
> > > > > > +++ b/drivers/net/wireguard/allowedips.c
> > > > > > @@ -377,7 +377,6 @@ int __init wg_allowedips_slab_init(void)
> > > > > > 
> > > > > >  void wg_allowedips_slab_uninit(void)
> > > > > >  {
> > > > > > -	rcu_barrier();
> > > > > >  	kmem_cache_destroy(node_cache);
> > > > > >  }
> > > > > > 
> > > > > > Once kmem_cache_destroy has been fixed to be deferrable.
> > > > > > 
> > > > > > I assume the other patches are similar -- an rcu_barrier() can be
> > > > > > removed. So some manual meddling of these might be in order.
> > > > > 
> > > > > Assuming that the deferrable kmem_cache_destroy() is the option chosen,
> > > > > agreed.
> > > > >
> > > > <snip>
> > > > void kmem_cache_destroy(struct kmem_cache *s)
> > > > {
> > > > 	int err = -EBUSY;
> > > > 	bool rcu_set;
> > > > 
> > > > 	if (unlikely(!s) || !kasan_check_byte(s))
> > > > 		return;
> > > > 
> > > > 	cpus_read_lock();
> > > > 	mutex_lock(&slab_mutex);
> > > > 
> > > > 	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
> > > > 
> > > > 	s->refcount--;
> > > > 	if (s->refcount)
> > > > 		goto out_unlock;
> > > > 
> > > > 	err = shutdown_cache(s);
> > > > 	WARN(err, "%s %s: Slab cache still has objects when called from %pS",
> > > > 	     __func__, s->name, (void *)_RET_IP_);
> > > > ...
> > > > 	cpus_read_unlock();
> > > > 	if (!err && !rcu_set)
> > > > 		kmem_cache_release(s);
> > > > }
> > > > <snip>
> > > > 
> > > > so we have SLAB_TYPESAFE_BY_RCU flag that defers freeing slab-pages
> > > > and a cache by a grace period. Similar flag can be added, like
> > > > SLAB_DESTROY_ONCE_FULLY_FREED, in this case a worker rearm itself
> > > > if there are still objects which should be freed.
> > > > 
> > > > Any thoughts here?
> > > 
> > > Wouldn't we also need some additional code to later check for all objects
> > > being freed to the slab, whether or not that code is  initiated from
> > > kmem_cache_destroy()?
> > >
> > Same away as SLAB_TYPESAFE_BY_RCU is handled from the kmem_cache_destroy() function.
> > It checks that flag and if it is true and extra worker is scheduled to perform a
> > deferred(instead of right away) destroy after rcu_barrier() finishes.
> 
> Like this?
> 
> 	SLAB_DESTROY_ONCE_FULLY_FREED
> 
> 	Instead of adding a new kmem_cache_destroy_rcu()
> 	or kmem_cache_destroy_wait() API member, instead add a
> 	SLAB_DESTROY_ONCE_FULLY_FREED flag that can be passed to the
> 	existing kmem_cache_destroy() function.  Use of this flag would
> 	suppress any warnings that would otherwise be issued if there
> 	was still slab memory yet to be freed, and it would also spawn
> 	workqueues (or timers or whatever) to do any needed cleanup work.
> 
>
The flag is passed as all others during creating a cache:

  slab = kmem_cache_create(name, size, ..., SLAB_DESTROY_ONCE_FULLY_FREED | OTHER_FLAGS, NULL);

the rest description is correct to me.

--
Uladzislau Rezki
