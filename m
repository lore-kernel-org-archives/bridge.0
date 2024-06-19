Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B5F12F5BF
	for <bridge@lists.linux.dev>; Wed, 19 Jun 2024 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796140; cv=none; b=NlQ9YxiRvFRu+3mQLj8dpqm27zcj0iqjj66+3lMVUqsYZ2ONJ/ozVbROZ/BQ+w0yxzlYQjHUfFts/4dBduNAtBXde8p4VE+6hgTGWvNIagmpNsDukSuYs6AMjHi7Bcfq5m6Upfi6Har9VqfmXED9x5LLF+vJOVsrCbwdwz/6Ba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796140; c=relaxed/simple;
	bh=75uxE1jIS7U/gZgImO3O5k1fhrGtDx8xK2bnlmud6ek=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9hG8Mu+hUCukq50a22nZ4clt1cYa/BHXO9I51GTvI3Ga5K1cl/1dV22XOcIueUPCenTro/qOFo5Rmm4+9kYiVjPUZ/Y1K4BmP0o1ZpOE6bl1Ue6jFqF5kUdGGwM2DniBsGuIZ0DsQtOj2GkG58YiAbaKIMspM47IJ1zedLY7vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tjf4ePIA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tjf4ePIA"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebdfe26217so60994711fa.2
        for <bridge@lists.linux.dev>; Wed, 19 Jun 2024 04:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718796136; x=1719400936; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1We8+J1M8/iGwbEuKq9QLdgleuBIYYNVC3Jie6+7WKQ=;
        b=Tjf4ePIAZPfCvBxPpZdMltXwU9vwkU36neYe7ELXv7V8bKUuU3W9ROLcLZ8ilLhSot
         YEvtG3jvgl5jhsNR+9Qpw6kbRIVyWVnBNIj+HLOCmYGrozj4oo25pNihHOxH1lv+ZULH
         fJsYigjJVZWwJiWZ9ba3mHk8nNAof/qrTHo9Fdp91XQxzP4nXc33f3buGnYomIaq45p0
         dgDCFsfnrMgCKE0Oq3TaalRtiYBQ2t+Id7n0VIvshBOeVHdzVIfYSp+LBfV6Bpr7eQEM
         vmUkFlScavdVgIaXDRde8mCoONmEzf0WVzPeJFh+uigssla8ZZ2Tc/QNQD0fz6XCqsZ2
         WHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718796136; x=1719400936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1We8+J1M8/iGwbEuKq9QLdgleuBIYYNVC3Jie6+7WKQ=;
        b=txb86GL7FzA/xL2H5bqaDo225B6g7y5U+G1XaGEBG97ABfoHyieMp6mfnqfWt7vEfd
         iLpdkAGdzOFKNZBeqRgbqesWEt8MO3vZJBLA++DqCuh0YOhelWQOO1TBtY2oHGWLtWLE
         E0CYthrZvRbyUDuYmBEAsAiznXmdk8jcFqKKeGpJ/Nb3gZB6N2y5uz89XZEcm96pozLT
         BjmpNlJki/6T/8j0URwWEwJQcLX7SyOpH2P6tJi3ieqL/OR42VWnquyiQYLYSljSY6XB
         W0FPSVxO5v+5kblVxW+FbVljMGXfT3WuykVt7S73t+Gh2k6XMT3v94mfOp0fODxZeOOo
         6f6g==
X-Forwarded-Encrypted: i=1; AJvYcCXge0p/cW+T03C9eQ9z/JfdtXeB6Jh5Y9K0/+yIUPqh1Flt9fq1dEE2pbVjzgY1U7FG9Hy7Gx2oFibIX9oGu/1AzI1DNXbV
X-Gm-Message-State: AOJu0YzG4JHekYB4MUrjDMCEzGpXXdjRUvQ6nb0lS5EsUWX52ZNVHrr/
	uW5FnUCmsDH0MuVrH9dWBUQNr9ALQDgj7yS6c8ciniO4cOqjun2N
X-Google-Smtp-Source: AGHT+IHY6I+1wjnfCL5bVO3aTBj0asX2DB6+TLCQy1IxnGK2EyJpAdTHcDYhDhl1lF4pI5isZiqATw==
X-Received: by 2002:a2e:7818:0:b0:2ec:3bc4:3e36 with SMTP id 38308e7fff4ca-2ec3ceb6a56mr15076241fa.14.1718796136224;
        Wed, 19 Jun 2024 04:22:16 -0700 (PDT)
Received: from pc636 (host-90-233-216-238.mobileonline.telia.com. [90.233.216.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c78126sm19577951fa.81.2024.06.19.04.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 04:22:15 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 19 Jun 2024 13:22:12 +0200
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 00/14] replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <ZnK_ZLlFM6MrdEah@pc636>
References: <Zmrkkel0Fo4_g75a@zx2c4.com>
 <e926e3c6-05ce-4ba6-9e2e-e5f3b37bcc23@suse.cz>
 <3b6fe525-626c-41fb-8625-3925ca820d8e@paulmck-laptop>
 <6711935d-20b5-41c1-8864-db3fc7d7823d@suse.cz>
 <ZnCDgdg1EH6V7w5d@pc636>
 <36c60acd-543e-48c5-8bd2-6ed509972d28@suse.cz>
 <ZnFT1Czb8oRb0SE7@pc636>
 <5c8b2883-962f-431f-b2d3-3632755de3b0@paulmck-laptop>
 <ZnKqPqlPD3Rl04DZ@pc636>
 <c208e95d-9aa9-476f-9dee-0242a2d6a24f@suse.cz>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c208e95d-9aa9-476f-9dee-0242a2d6a24f@suse.cz>

On Wed, Jun 19, 2024 at 11:56:44AM +0200, Vlastimil Babka wrote:
> On 6/19/24 11:51 AM, Uladzislau Rezki wrote:
> > On Tue, Jun 18, 2024 at 09:48:49AM -0700, Paul E. McKenney wrote:
> >> On Tue, Jun 18, 2024 at 11:31:00AM +0200, Uladzislau Rezki wrote:
> >> > > On 6/17/24 8:42 PM, Uladzislau Rezki wrote:
> >> > > >> +
> >> > > >> +	s = container_of(work, struct kmem_cache, async_destroy_work);
> >> > > >> +
> >> > > >> +	// XXX use the real kmem_cache_free_barrier() or similar thing here
> >> > > > It implies that we need to introduce kfree_rcu_barrier(), a new API, which i
> >> > > > wanted to avoid initially.
> >> > > 
> >> > > I wanted to avoid new API or flags for kfree_rcu() users and this would
> >> > > be achieved. The barrier is used internally so I don't consider that an
> >> > > API to avoid. How difficult is the implementation is another question,
> >> > > depending on how the current batching works. Once (if) we have sheaves
> >> > > proven to work and move kfree_rcu() fully into SLUB, the barrier might
> >> > > also look different and hopefully easier. So maybe it's not worth to
> >> > > invest too much into that barrier and just go for the potentially
> >> > > longer, but easier to implement?
> >> > > 
> >> > Right. I agree here. If the cache is not empty, OK, we just defer the
> >> > work, even we can use a big 21 seconds delay, after that we just "warn"
> >> > if it is still not empty and leave it as it is, i.e. emit a warning and
> >> > we are done.
> >> > 
> >> > Destroying the cache is not something that must happen right away. 
> >> 
> >> OK, I have to ask...
> >> 
> >> Suppose that the cache is created and destroyed by a module and
> >> init/cleanup time, respectively.  Suppose that this module is rmmod'ed
> >> then very quickly insmod'ed.
> >> 
> >> Do we need to fail the insmod if the kmem_cache has not yet been fully
> >> cleaned up?  If not, do we have two versions of the same kmem_cache in
> >> /proc during the overlap time?
> >> 
> > No fail :) If same cache is created several times, its s->refcount gets
> > increased, so, it does not create two entries in the "slabinfo". But i
> > agree that your point is good! We need to be carefully with removing and
> > simultaneous creating.
> 
> Note that this merging may be disabled or not happen due to various flags on
> the cache being incompatible with it. And I want to actually make sure it
> never happens for caches being already destroyed as that would lead to
> use-after-free (the workfn doesn't recheck the refcount in case a merge
> would happen during the grace period)
> 
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -150,9 +150,10 @@ int slab_unmergeable(struct kmem_cache *s)
>  #endif
> 
>         /*
> -        * We may have set a slab to be unmergeable during bootstrap.
> +        * We may have set a cache to be unmergeable during bootstrap.
> +        * 0 is for cache being destroyed asynchronously
>          */
> -       if (s->refcount < 0)
> +       if (s->refcount <= 0)
>                 return 1;
> 
>         return 0;
> 
OK, i see such flags, SLAB_NO_MERGE. Then i was wrong, it can create two
different slabs.

Thanks!

--
Uladzislau Rezki
