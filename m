Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E0113B7AF
	for <bridge@lists.linux.dev>; Tue, 18 Jun 2024 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703068; cv=none; b=mdWW3Rt97LHDtNYUAP1wxGWJZUPcjZR3gB+/mmpm0nlOoeJ2NYuvtiOecZYlHyEDw851hnjsYjdeCwRK9hJBymhBKvx4hG+mqT6/NrdBS5alGmL7uS9Ejb6Cz8HkEFcwmCvYgyv0oZtSZ0DgPvTDmlhJZckzFXpWR78u4Q6GpF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703068; c=relaxed/simple;
	bh=g0uSCj3d+UUUWfZz4wBc8kGDKF4ITFgP+uzc7Zk6jo4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIK+KAddUbFXtngqPgPobQSk8D0mAcwQCJ3qFEcBHh7G3ccCSlQeVJjYFu+IX0jdnIoycwjm1M488HMbqj3oz6Y/qSKWuIefD1wnTy/1SqTNX7XVz7pSIAfjF04wrTATl/ryFb4D9i78chqnnFE3r8tzROglqXr6biVs29/cKd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4ndeKs2; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4ndeKs2"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52c815e8e9eso5211853e87.0
        for <bridge@lists.linux.dev>; Tue, 18 Jun 2024 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718703065; x=1719307865; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd0sb+wrja9GmMiLQT0DMWUWixEF5baH+EtRGLOjO0I=;
        b=O4ndeKs2js4hDFSVlpNol0wqZ/trbT/fycc88/54pqFth1w7dRng0uBkKkc3SfF0ey
         A9VwK6vo9dCyNnlAInogit3PbmAxFwRQU7SU6ZotMmsYYtz4+YWdrLm9GC7+OWY8gjxC
         jdbEuhF2a3cerPKNodzTriuvpah2lDnfOws648GzDwshGyS/ou6Bl77QZXAeTN30aYpg
         5RMVqIPqDnfAYEqZ0rX04f0yJB+99O4ZP0PCStyIBcAm2yJxfpEiAU05W74U/t/GQQQO
         aUcdaxl5ENm+ttr6VGVWPmWRwXOSn1zN4GlrUOyfox8uG3Gq28lLFtFAcIL3PnEf8XAp
         1s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718703065; x=1719307865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gd0sb+wrja9GmMiLQT0DMWUWixEF5baH+EtRGLOjO0I=;
        b=dEtjYzu6N4onruun8ffRO8KN/6LdLojpbH082D1bkBAZLtFgPS46bAYn1lXIgwqHvh
         4/Kr7dfbpAKns82urldk3ZYk1rKPw5K7n2yR0YjpQTh0+X5II6URBMHNT4odnEhu1OyB
         1OBhWLop4ECOQeS8G/yhtdTjWpGUuAMPoVqJxhW1QHSBrmoAoYH07sprbKrvWuRK3x+p
         OZinxmOEsX4gozXq1xw6wLpu1VbM8RQxCUxL4Hv6BGp7dNwyfJoXAOlXKZufN7RH4wTS
         Kwf4XlfYxgrzT4nZmorVH7Bwel1gC7gFF6USquHF+J4dsh/XqfpSOMMto06s5RcL3qEk
         BCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfHM6GpD1et3i+VSbSUdkxjsqxALFvkOyCqZ23D5CL8I0tdxGQfBpC51CEHa9RS8hU4VCEbW/hz9Dqj8emC1d/p07aZ6XP
X-Gm-Message-State: AOJu0YyznDXBEiGiRlWjQMyioH+UfDiQ91RMapf5Om4U3Tuzc2mgNRHN
	mVp6hPpDk3/VNJCvJIKeHUIMq7AWu9vBfVLofOgwBqwApWPmS9CL
X-Google-Smtp-Source: AGHT+IEirA7ZfcWMvk+A5QKOFGiN5irQ5RBB6sZAAJ03RtbeHM09p7vDGOoZf2DqBzAK5fdSSuz/pQ==
X-Received: by 2002:a19:9141:0:b0:52c:81d5:cf96 with SMTP id 2adb3069b0e04-52ca6e659demr6468892e87.28.1718703065080;
        Tue, 18 Jun 2024 02:31:05 -0700 (PDT)
Received: from pc636 (host-90-233-216-238.mobileonline.telia.com. [90.233.216.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2825b38sm1445362e87.24.2024.06.18.02.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 02:31:04 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 18 Jun 2024 11:31:00 +0200
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
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
Message-ID: <ZnFT1Czb8oRb0SE7@pc636>
References: <baee4d58-17b4-4918-8e45-4d8068a23e8c@paulmck-laptop>
 <Zmov7ZaL-54T9GiM@zx2c4.com>
 <Zmo9-YGraiCj5-MI@zx2c4.com>
 <08ee7eb2-8d08-4f1f-9c46-495a544b8c0e@paulmck-laptop>
 <Zmrkkel0Fo4_g75a@zx2c4.com>
 <e926e3c6-05ce-4ba6-9e2e-e5f3b37bcc23@suse.cz>
 <3b6fe525-626c-41fb-8625-3925ca820d8e@paulmck-laptop>
 <6711935d-20b5-41c1-8864-db3fc7d7823d@suse.cz>
 <ZnCDgdg1EH6V7w5d@pc636>
 <36c60acd-543e-48c5-8bd2-6ed509972d28@suse.cz>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36c60acd-543e-48c5-8bd2-6ed509972d28@suse.cz>

> On 6/17/24 8:42 PM, Uladzislau Rezki wrote:
> >> +
> >> +	s = container_of(work, struct kmem_cache, async_destroy_work);
> >> +
> >> +	// XXX use the real kmem_cache_free_barrier() or similar thing here
> > It implies that we need to introduce kfree_rcu_barrier(), a new API, which i
> > wanted to avoid initially.
> 
> I wanted to avoid new API or flags for kfree_rcu() users and this would
> be achieved. The barrier is used internally so I don't consider that an
> API to avoid. How difficult is the implementation is another question,
> depending on how the current batching works. Once (if) we have sheaves
> proven to work and move kfree_rcu() fully into SLUB, the barrier might
> also look different and hopefully easier. So maybe it's not worth to
> invest too much into that barrier and just go for the potentially
> longer, but easier to implement?
> 
Right. I agree here. If the cache is not empty, OK, we just defer the
work, even we can use a big 21 seconds delay, after that we just "warn"
if it is still not empty and leave it as it is, i.e. emit a warning and
we are done.

Destroying the cache is not something that must happen right away. 

> > Since you do it asynchronous can we just repeat
> > and wait until it a cache is furry freed?
> 
> The problem is we want to detect the cases when it's not fully freed
> because there was an actual read. So at some point we'd need to stop the
> repeats because we know there can no longer be any kfree_rcu()'s in
> flight since the kmem_cache_destroy() was called.
> 
Agree. As noted above, we can go with 21 seconds(as an example) interval
and just perform destroy(without repeating).

--
Uladzislau Rezki
