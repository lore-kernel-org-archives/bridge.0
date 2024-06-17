Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338220B3E
	for <bridge@lists.linux.dev>; Mon, 17 Jun 2024 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642551; cv=none; b=cqY8WcP07itqcYf2Gf060psDFdYHysBoaqeJWO5zz3x8OMQqCpppHdUc93o4bG4gasfsaWWXZh++F69YhL8iLv7utBtOfSUhzN3cilZKcy/Kj3GQwAMCnzJiBtVdGCRzv1YxUPHAGHjQFfRjQHkgZjJ78LUO03Lm1qwV227V/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642551; c=relaxed/simple;
	bh=4I3/haUM18/IbRSzFoVM3RfFFm03ff7YkrKpxiaQc8I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufmbb3IwPFI5mrdQjfNEH5AYJUfT3VXiIv9UdSU6sjaj0I9vDaaHmpqcbSED+NVh5RUmxoYz5s80LqwM0o7cSL+vhBmlQRNab42DmcL2vdBvhqIxVWzGW2HiEoSwoqnoeWsTtnp0jbo5us3H6UgGQOKp24tP5J4+cBA7jk6aBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKGL7X+C; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKGL7X+C"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52bbf73f334so4308688e87.2
        for <bridge@lists.linux.dev>; Mon, 17 Jun 2024 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718642547; x=1719247347; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nVbXAXBamX9byggpH5pf9RLnfjUsWFyotRoWWJmUCyg=;
        b=ZKGL7X+CTdjDEk/xKGuZ6237sYLpSpL+lR9WqsGtX++kbuo/hFwtp1NKaAj27J6+xH
         p4PQqGeShyKAcdy5ySo6Smf+uKa5C/0J5ui6vPM2qPy7/b3vvL8nfIHBMiXB6QBM0RlF
         revnQjzXdUL+gb7zDvpoSICsop7EXu6hpNEM2uReWoAA10+L5eLzzviuk8oeg3Fzi6QX
         3Z/ECmLsPLSv97mn/lmfCFcJmgoXeoaO6C14BIf0rqmcO5rvRSIZC+Js/M/s+jPUrKEQ
         kTJMXB+D6ivXKrfPjLvG8R3ajv9+FhPKu2s4PCxRZny+TG/FXgQKK2Tl6uHpERFLWmxm
         hiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718642547; x=1719247347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVbXAXBamX9byggpH5pf9RLnfjUsWFyotRoWWJmUCyg=;
        b=PnzqdJw0ns0bw8QIJzR8w7Z5Wlqgr94IZsjzApcVcTnnuCKWXCv5xivbK1/TQIR++J
         bidH1dBcMOAWLHxraE8PQ4yI1vrTny+2DIhxIC9zrmYW2V+qH5CJEd6JBi/Uc39jlVGb
         J/EumG0pslV+mshiFWn4sNNJtTzE+mI+ZVfzHohXs4I4IwIPP76RDbDhiRyvF9Z+hW41
         O0QvEgPL3iQrAi408yRCVz3lGc8BPQ3Yep7WjU/SnVUkYAFehDOdCB7HgYN5kzyAp5aN
         4h8KybE/3L8kUst1naH4aVvQbwNteWgAFqkIy3cQabLKdoAMCTIdRlcxdaZEaLjWblEP
         ZzLw==
X-Forwarded-Encrypted: i=1; AJvYcCWfxl7Z34kXlc8208pD9oZ9lwQ1wZT0ez+945TFBpF7b2HXR2PShLdUl8bjhOgDNvpbJ0BxwPxEFQRLRDDyuXJn5B8aCFMM
X-Gm-Message-State: AOJu0Yw+Cspzv3nwBuDHtGt/+b/Ibb2B/6gdvEajC+oCo1X9UNc/pzzf
	8hicbrmeWBoQ19NSdxvVrlDEZMF97x9IXQXr86yoQ5px0N/UjHpP
X-Google-Smtp-Source: AGHT+IEbAoHoo+cqq7GZF8p0qgsFLjS7D8dpwx0oAM5cf5weHrkVdSXGtAH7Cuol28FV9Mqr6MxQYg==
X-Received: by 2002:a19:2d48:0:b0:52c:8fba:e2a1 with SMTP id 2adb3069b0e04-52ca6e657c4mr6499193e87.18.1718642546982;
        Mon, 17 Jun 2024 09:42:26 -0700 (PDT)
Received: from pc636 (host-90-233-216-238.mobileonline.telia.com. [90.233.216.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28722e2sm1265845e87.136.2024.06.17.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 09:42:26 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 17 Jun 2024 18:42:23 +0200
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
Message-ID: <ZnBnb1WkJFXs5L6z@pc636>
References: <Zmsuswo8OPIhY5KJ@pc636>
 <cb51bc57-47b8-456a-9ac0-f8aa0931b144@paulmck-laptop>
 <ZmszOd5idhf2Cb-v@pc636>
 <b03b007f-3afa-4ad4-b76b-dea7b3aa2bc3@paulmck-laptop>
 <Zmw5FTX752g0vtlD@pc638.lan>
 <ZmybGZDbXkw7JTjc@zx2c4.com>
 <ZnA_QFvuyABnD3ZA@pc636>
 <ZnBOkZClsvAUa_5X@zx2c4.com>
 <ZnBkvYdbAWILs7qx@pc636>
 <CAHmME9r4q8erE3E-Xn61ZkSOdDDrgx6jhTAywx3ca4=G0z=wAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9r4q8erE3E-Xn61ZkSOdDDrgx6jhTAywx3ca4=G0z=wAA@mail.gmail.com>

On Mon, Jun 17, 2024 at 06:33:23PM +0200, Jason A. Donenfeld wrote:
> On Mon, Jun 17, 2024 at 6:30 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > Here if an "err" is less then "0" means there are still objects
> > whereas "is_destroyed" is set to "true" which is not correlated
> > with a comment:
> >
> > "Destruction happens when no objects"
> 
> The comment is just poorly written. But the logic of the code is right.
> 
OK.

> >
> > >  out_unlock:
> > >       mutex_unlock(&slab_mutex);
> > >       cpus_read_unlock();
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 1373ac365a46..7db8fe90a323 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -4510,6 +4510,8 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
> > >               return;
> > >       trace_kmem_cache_free(_RET_IP_, x, s);
> > >       slab_free(s, virt_to_slab(x), x, _RET_IP_);
> > > +     if (s->is_destroyed)
> > > +             kmem_cache_destroy(s);
>
Here i am not follow you. How do you see that a cache has been fully
freed? Or is it just super draft code?

Thanks!

--
Uladzislau Rezki
