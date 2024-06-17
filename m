Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5229D16D320
	for <bridge@lists.linux.dev>; Mon, 17 Jun 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644801; cv=none; b=jcz8BbDZNWXgK1LIvsRM6l4EA2R05ITjGEZoyO2kR1lvzxXVqqjUhz8V0c4bidIjq3r7DcuoOSHwLZIynq/UUqFo9ujmtBfRw2279Q6eifvokejmharYQyj6oxx2g+jHuK/FW0jix/YtzSPLVFe6Gzk445FWeqCEqqGdrAgEoHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644801; c=relaxed/simple;
	bh=viLDpuJKEVzbprFQO23qfBQGXZv55FGbFpR7JPV8Aik=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2ERHr8FQPwMczO/gM2XLiFlFfYps2iT+b/WA5H0okILTJy+2uQYiCnUI2govMbs4p6X1Rep+IQAXEQ8RcWGkA3/a+ycDser2a7CN3gEkiZg0ecVWaDuSxm16uucougeCbgqyLb3PECYVxNNSfDqkUXfjaAr3ERvbMK+e6z2PTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnH2w05u; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnH2w05u"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cc1528c83so470751e87.2
        for <bridge@lists.linux.dev>; Mon, 17 Jun 2024 10:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718644797; x=1719249597; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vZ8O3vkKnV5WMsPPzukATAgUwpYfoN3xcCe/8i65jUE=;
        b=fnH2w05uKwZ4+4Bhaq1raQ2cSGE+4XUIj92PPmnvFXl0l0PG4wVY79WeCEQSwadPCm
         qQ8bOuzl0kpaAIrqc08IK9XvvInCvGUoRDay2Jv8a4wqFvR62aFNFFgkGf7JjFtlbv3f
         68LDv7JFRIPFK7rquKrhJBI6GdImFQbMEQozwZbStzcphRTNVETsnbNkcG9ugUTu4jSk
         +IsBcS89Ck8dp8qTvNSVWizgZJuU9AdKJZFTvrQKyoKOJh17vK6SUzsLriUNGsg7f43E
         BhrECh/yEVNCgn6nGZC0AFo5fX02y8Z5leUv4xw8c+S4oRNo8+TWO6beIg/Vpr+ScplJ
         IrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718644797; x=1719249597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ8O3vkKnV5WMsPPzukATAgUwpYfoN3xcCe/8i65jUE=;
        b=vnIj3gLQjjtytUO5+NcmWu3e2ohBe9uBNkzk/gpjtav2XduLxyqqUiw6vCRjmfOBul
         2Dp+gWg/H30O/mP+Lv6ET2jl82n5XklKI36jLJ5t10pgYFDU5wkQEPCys+Iooc/+LaxB
         WiviLJfaiQV13C/ZP9mwfwMmr+UHbX7MVam0vShdraCGiKLYlElO39sYr1EVBcOJ1URj
         VDV4YTsVWN2W7N4bIx3YOfiO9T0IXVHVK3TUthss0GXVG1ewHoZH8pJY0ORUGclYjLQP
         RzNLyebwUUT1TOZJhkA4xOryNKDK0qk4uaHHtMWE6mUZdgZ2NZn7DtViBHpMIxVDssiu
         LT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBax7cHBY3D2VOor2BgZ6ltUWuM3Nk8Z1mDX98SxFyfYdAlKIq/0zF5GiMih+ykyFWFSQJfUeTJCDgY6FcaILYXw4x3+aq
X-Gm-Message-State: AOJu0YxrQeI8K9EpNriDmaemLN/kBvN9hE2yvpOPHxTfBTDTY8vWBRte
	2VtTjCm/RvqOQypCg4Z0MiGASriUwGDcx3VZZ7uhxzemrC5vm4IA
X-Google-Smtp-Source: AGHT+IF+kn6orlxXNu+KbBfK5TuJ9FRTaW/E7mKFLwWnfY9/g3N+9lA943ajPi6EK1Z9MmgGKAp4XQ==
X-Received: by 2002:a19:8c5a:0:b0:52c:88d6:891d with SMTP id 2adb3069b0e04-52ca6e5637emr6427245e87.9.1718644797253;
        Mon, 17 Jun 2024 10:19:57 -0700 (PDT)
Received: from pc636 (host-90-233-216-238.mobileonline.telia.com. [90.233.216.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28722b0sm1286680e87.126.2024.06.17.10.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 10:19:56 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 17 Jun 2024 19:19:53 +0200
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <ZnBwOf3faUJMbrfW@pc636>
References: <ZmszOd5idhf2Cb-v@pc636>
 <b03b007f-3afa-4ad4-b76b-dea7b3aa2bc3@paulmck-laptop>
 <Zmw5FTX752g0vtlD@pc638.lan>
 <ZmybGZDbXkw7JTjc@zx2c4.com>
 <ZnA_QFvuyABnD3ZA@pc636>
 <ZnBOkZClsvAUa_5X@zx2c4.com>
 <ZnBkvYdbAWILs7qx@pc636>
 <CAHmME9r4q8erE3E-Xn61ZkSOdDDrgx6jhTAywx3ca4=G0z=wAA@mail.gmail.com>
 <ZnBnb1WkJFXs5L6z@pc636>
 <ZnBrCQy13jZV_hyZ@zx2c4.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnBrCQy13jZV_hyZ@zx2c4.com>

On Mon, Jun 17, 2024 at 06:57:45PM +0200, Jason A. Donenfeld wrote:
> On Mon, Jun 17, 2024 at 06:42:23PM +0200, Uladzislau Rezki wrote:
> > On Mon, Jun 17, 2024 at 06:33:23PM +0200, Jason A. Donenfeld wrote:
> > > On Mon, Jun 17, 2024 at 6:30 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > Here if an "err" is less then "0" means there are still objects
> > > > whereas "is_destroyed" is set to "true" which is not correlated
> > > > with a comment:
> > > >
> > > > "Destruction happens when no objects"
> > > 
> > > The comment is just poorly written. But the logic of the code is right.
> > > 
> > OK.
> > 
> > > >
> > > > >  out_unlock:
> > > > >       mutex_unlock(&slab_mutex);
> > > > >       cpus_read_unlock();
> > > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > > index 1373ac365a46..7db8fe90a323 100644
> > > > > --- a/mm/slub.c
> > > > > +++ b/mm/slub.c
> > > > > @@ -4510,6 +4510,8 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
> > > > >               return;
> > > > >       trace_kmem_cache_free(_RET_IP_, x, s);
> > > > >       slab_free(s, virt_to_slab(x), x, _RET_IP_);
> > > > > +     if (s->is_destroyed)
> > > > > +             kmem_cache_destroy(s);
> > >
> > Here i am not follow you. How do you see that a cache has been fully
> > freed? Or is it just super draft code?
> 
> kmem_cache_destroy() does this in shutdown_cache().
>
Right. In this scenario you invoke kmem_cache_destroy() over and over
until the last object gets freed. This potentially slowing the kmem_cache_free()
which is not OK, at least to me.

--
Uladzislau Rezki
