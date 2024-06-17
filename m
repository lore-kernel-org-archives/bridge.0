Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA50B1662EC
	for <bridge@lists.linux.dev>; Mon, 17 Jun 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642022; cv=none; b=SOXlkuCCEgw4z1cQGTJlLUG0lT8fQtqf0u94DqArs/JZrGOo7+OTwcBly7FIB1ZWrdhgtoQ2bhfG+ZUDxCLJKIs00/d1lCbFlHcDFLzVhsPbmdmF0BtgFAWiGRGNmLlDC1hQtdihjKSNN4b9ACGE75z9ahOqMZe9ms3lV7gtvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642022; c=relaxed/simple;
	bh=AqajSV0X4jhG6ZZwm0pL6IyE58bEqZ6C1lsJRn/cy6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9acn1owd7hFfyEe6QTKfndcPOBwhepA2bs7aj0C+eENTm/6ZtKPH9Di+kvDCRkf7EL3NbMGYh/iLj8/VaiwzRNDvmDqMEJVD6H8Dj7pK5F+ocfPOzFuY1UqVCiBk3A9qTqXsXRrpzBsXKIoyxbDof9Bjl1Hzj4ohMuL5caMYCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=lqmD0K57; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lqmD0K57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396F3C3277B
	for <bridge@lists.linux.dev>; Mon, 17 Jun 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lqmD0K57"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1718642017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUjKSm9UM4O1aKGbEZjvZRgCeGJk15TE1+l7iyYY+0E=;
	b=lqmD0K57cnaPOftHh2pOum828X1k5uUv0Vyx2HD1+u8cZfhtcNcmaJO3Jde0keMY78Ap/O
	TP1hCGHPmLCeXxG7ZdUXs/CPJ7wNLwf1Rwwgjd5I+wJyed+uUTgzNPiCteakfasG+gGmeX
	AZiaHQP3EqVbkxlqL/iUR3o0NHjrlw4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dfbd3205 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <bridge@lists.linux.dev>;
	Mon, 17 Jun 2024 16:33:36 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-254c8e27c80so2507305fac.2
        for <bridge@lists.linux.dev>; Mon, 17 Jun 2024 09:33:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJ2N1hNHJp96juuBtYYm9DVMyx6T41HyhkceXD5Y2fF0+BlhE68IJufPiy67+u/bfoaJal5hlnQE242jsiu97k/GVmGgdR
X-Gm-Message-State: AOJu0YwJyNCtFPNbmi6tO8bax+JfhVzK9mxpHL/bhrvgmLtEdEf04Ju3
	PSAsNB9j5wamyh7Iu5VGiqpc6hCQ0X9Jp+Sc+SqXAA6D+jdx2p/iz520Z5Oxx6iq7LUrhMk5WtZ
	Th8q62BpVG+GnoBBSznQxWdlrVFE=
X-Google-Smtp-Source: AGHT+IH73cxa8bEaSx0br+R63lisN9Zy21+jpj61L5jMj9rENcrv4EuyB2mn51tWhnn9axbMUQaQmVNUc4nOeGH0JmU=
X-Received: by 2002:a05:6870:9725:b0:254:9ba7:488b with SMTP id
 586e51a60fabf-25842ba524dmr11130088fac.40.1718642015158; Mon, 17 Jun 2024
 09:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Zmru7hhz8kPDPsyz@pc636> <7efde25f-6af5-4a67-abea-b26732a8aca1@paulmck-laptop>
 <Zmsuswo8OPIhY5KJ@pc636> <cb51bc57-47b8-456a-9ac0-f8aa0931b144@paulmck-laptop>
 <ZmszOd5idhf2Cb-v@pc636> <b03b007f-3afa-4ad4-b76b-dea7b3aa2bc3@paulmck-laptop>
 <Zmw5FTX752g0vtlD@pc638.lan> <ZmybGZDbXkw7JTjc@zx2c4.com> <ZnA_QFvuyABnD3ZA@pc636>
 <ZnBOkZClsvAUa_5X@zx2c4.com> <ZnBkvYdbAWILs7qx@pc636>
In-Reply-To: <ZnBkvYdbAWILs7qx@pc636>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 17 Jun 2024 18:33:23 +0200
X-Gmail-Original-Message-ID: <CAHmME9r4q8erE3E-Xn61ZkSOdDDrgx6jhTAywx3ca4=G0z=wAA@mail.gmail.com>
Message-ID: <CAHmME9r4q8erE3E-Xn61ZkSOdDDrgx6jhTAywx3ca4=G0z=wAA@mail.gmail.com>
Subject: Re: [PATCH 00/14] replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, linux-block@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, bridge@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kvm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>, netdev@vger.kernel.org, 
	wireguard@lists.zx2c4.com, linux-kernel@vger.kernel.org, 
	ecryptfs@vger.kernel.org, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-can@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 6:30=E2=80=AFPM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
> Here if an "err" is less then "0" means there are still objects
> whereas "is_destroyed" is set to "true" which is not correlated
> with a comment:
>
> "Destruction happens when no objects"

The comment is just poorly written. But the logic of the code is right.

>
> >  out_unlock:
> >       mutex_unlock(&slab_mutex);
> >       cpus_read_unlock();
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 1373ac365a46..7db8fe90a323 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4510,6 +4510,8 @@ void kmem_cache_free(struct kmem_cache *s, void *=
x)
> >               return;
> >       trace_kmem_cache_free(_RET_IP_, x, s);
> >       slab_free(s, virt_to_slab(x), x, _RET_IP_);
> > +     if (s->is_destroyed)
> > +             kmem_cache_destroy(s);
> >  }
> >  EXPORT_SYMBOL(kmem_cache_free);
> >
> > @@ -5342,9 +5344,6 @@ static void free_partial(struct kmem_cache *s, st=
ruct kmem_cache_node *n)
> >               if (!slab->inuse) {
> >                       remove_partial(n, slab);
> >                       list_add(&slab->slab_list, &discard);
> > -             } else {
> > -                     list_slab_objects(s, slab,
> > -                       "Objects remaining in %s on __kmem_cache_shutdo=
wn()");
> >               }
> >       }
> >       spin_unlock_irq(&n->list_lock);
> >
> Anyway it looks like it was not welcome to do it in the kmem_cache_free()
> function due to performance reason.

"was not welcome" - Vlastimil mentioned *potential* performance
concerns before I posted this. I suspect he might have a different
view now, maybe?

Vlastimil, this is just checking a boolean (which could be
unlikely()'d), which should have pretty minimal overhead. Is that
alright with you?

Jason
