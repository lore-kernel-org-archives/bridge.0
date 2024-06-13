Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BE44A0F
	for <bridge@lists.linux.dev>; Thu, 13 Jun 2024 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284022; cv=none; b=hIwEX/DP2o+qv4BuRvPBD1i+oMpoGpP6CFaQQRSMOcirbRUmjHkt755Dh5yaqH+DgViUmFR2T2EXDqNwmrfHLfpWSPqZS+ERx4Cx3XQ29xjM2ChecSZ2PXgM/g89tJKZAqqNSJof49i1j7vjR0h8ekme+htQk36k+T7CE4UgUR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284022; c=relaxed/simple;
	bh=xu1792XvTnU3jDP3FYbYyhez1VlS5TvvwKQ4Hm46MoY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9ioAXRGnjzSuZU8Cpr+NBwmhHjKzaLVWWQMnvaLMMC4IdGEj5JsrArtA9rAKOObVbYlK2/wHem9pszShQ1jj13qAIXq+It39wVUuHC4vX243zhf4Ml2JJfgNOTn5Sl/5e/6GwTqc6L4TaOTdbEEaCDIb4ysFLXKTjIIlGjjE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EexKZDao; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EexKZDao"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebd95f136bso10801611fa.0
        for <bridge@lists.linux.dev>; Thu, 13 Jun 2024 06:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718284018; x=1718888818; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4qMOlVAmB1+8562nApjJnNhlZQHZLqU1OXBwVXRF78=;
        b=EexKZDaoWhVtfDhXuRGDf9jpLwRJrOnRDXSE15p0f4AvhKfOttfOEFPBV8FWwSWcV2
         d1l5Ut2dN+CK31R+zG1BAWjnRsB7xSnECv2ZJJV400PECvzZ6AIcY9/eoZJ1Co6vRiKZ
         /iTL/b6yO5KYEYbVD+sg3ngzDhoRC1nWyYNGE9R89SFJY8rOtE1YsRp6UJbGVXv+5Dr1
         Z5FHqr0HTXGhLfFVZSYCXNNocOJYxUgyU8EkNSIP3+zOZVIS1ozd74+kPXdj5ySIf0gY
         du8jTQ1KXvejNlrSmCL3q0hFOwSisqxA48sVLrTuf5C1+RAbrL710MX2M9zcyfADCwGG
         SFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718284018; x=1718888818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4qMOlVAmB1+8562nApjJnNhlZQHZLqU1OXBwVXRF78=;
        b=GYWbK1viViXRdAkF2K7Od4Bq8aDM442zk6mSjzS6SQ0+2SvxJHojx8qZEjiu0zrVnm
         eLT60VRprFFPsHnX/oWlYZgmWnE7czeAX8nKO6eZiu1MY7JhliC92H4O1N+WBB4bh1Ra
         XLzKqGa6r20Z07S3o4GrjsCb0R17BPa/ZdHXA5QLhpWCkiPbwyFsnWqTZKqBApMmQozt
         uV7OGcZmlAe8wjjsTDQRdhU3axXz3P60XLu2SINx+j/d11pHtgbo0XMjsCp3pWAdDIrT
         ex5QAN2spKfk0cw7Ll49/P9Bfk6bjatR9JCI8cyFk/xWwkNZ4mG/L4E4CC86BycfCbk1
         Wmpw==
X-Forwarded-Encrypted: i=1; AJvYcCXnsv0oJDs+dXRb00AQNTfqpKPyU9t9Tal43tfLNUcOAsrGGDa+Op0TwJb1Trhroi6OG+APgKz3c9I2GhCKzabVGs4yNl8l
X-Gm-Message-State: AOJu0Yy7RvaTCqmDsICpKz8gBlIRPJQt3BEJxiaz0S8EoiyAGB6ZkBgC
	/lvdw9rbMO56aTRJvhr/SMHun4lQ1eLwSsQOQs1JcnWszxJdjgKc
X-Google-Smtp-Source: AGHT+IFNjIqLDbiiJvyVQ+CTYUUPuuKLx47d3/3uk6kw1RXtVGPymnVcCEA7pTqKhgYonTHLU10trQ==
X-Received: by 2002:a2e:878f:0:b0:2eb:ecba:444a with SMTP id 38308e7fff4ca-2ebfc9fac80mr27236611fa.23.1718284018170;
        Thu, 13 Jun 2024 06:06:58 -0700 (PDT)
Received: from pc636 (host-90-233-218-141.mobileonline.telia.com. [90.233.218.141])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c05f56sm2099851fa.42.2024.06.13.06.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:06:57 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 13 Jun 2024 15:06:54 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 00/14] replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <Zmru7hhz8kPDPsyz@pc636>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240612143305.451abf58@kernel.org>
 <baee4d58-17b4-4918-8e45-4d8068a23e8c@paulmck-laptop>
 <ZmrfA1p2zSVIaYam@zx2c4.com>
 <80e03b02-7e24-4342-af0b-ba5117b19828@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80e03b02-7e24-4342-af0b-ba5117b19828@paulmck-laptop>

On Thu, Jun 13, 2024 at 05:47:08AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 13, 2024 at 01:58:59PM +0200, Jason A. Donenfeld wrote:
> > On Wed, Jun 12, 2024 at 03:37:55PM -0700, Paul E. McKenney wrote:
> > > On Wed, Jun 12, 2024 at 02:33:05PM -0700, Jakub Kicinski wrote:
> > > > On Sun,  9 Jun 2024 10:27:12 +0200 Julia Lawall wrote:
> > > > > Since SLOB was removed, it is not necessary to use call_rcu
> > > > > when the callback only performs kmem_cache_free. Use
> > > > > kfree_rcu() directly.
> > > > > 
> > > > > The changes were done using the following Coccinelle semantic patch.
> > > > > This semantic patch is designed to ignore cases where the callback
> > > > > function is used in another way.
> > > > 
> > > > How does the discussion on:
> > > >   [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks"
> > > >   https://lore.kernel.org/all/20240612133357.2596-1-linus.luessing@c0d3.blue/
> > > > reflect on this series? IIUC we should hold off..
> > > 
> > > We do need to hold off for the ones in kernel modules (such as 07/14)
> > > where the kmem_cache is destroyed during module unload.
> > > 
> > > OK, I might as well go through them...
> > > 
> > > [PATCH 01/14] wireguard: allowedips: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
> > > 	Needs to wait, see wg_allowedips_slab_uninit().
> > 
> > Also, notably, this patch needs additionally:
> > 
> > diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
> > index e4e1638fce1b..c95f6937c3f1 100644
> > --- a/drivers/net/wireguard/allowedips.c
> > +++ b/drivers/net/wireguard/allowedips.c
> > @@ -377,7 +377,6 @@ int __init wg_allowedips_slab_init(void)
> > 
> >  void wg_allowedips_slab_uninit(void)
> >  {
> > -	rcu_barrier();
> >  	kmem_cache_destroy(node_cache);
> >  }
> > 
> > Once kmem_cache_destroy has been fixed to be deferrable.
> > 
> > I assume the other patches are similar -- an rcu_barrier() can be
> > removed. So some manual meddling of these might be in order.
> 
> Assuming that the deferrable kmem_cache_destroy() is the option chosen,
> agreed.
>
<snip>
void kmem_cache_destroy(struct kmem_cache *s)
{
	int err = -EBUSY;
	bool rcu_set;

	if (unlikely(!s) || !kasan_check_byte(s))
		return;

	cpus_read_lock();
	mutex_lock(&slab_mutex);

	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;

	s->refcount--;
	if (s->refcount)
		goto out_unlock;

	err = shutdown_cache(s);
	WARN(err, "%s %s: Slab cache still has objects when called from %pS",
	     __func__, s->name, (void *)_RET_IP_);
...
	cpus_read_unlock();
	if (!err && !rcu_set)
		kmem_cache_release(s);
}
<snip>

so we have SLAB_TYPESAFE_BY_RCU flag that defers freeing slab-pages
and a cache by a grace period. Similar flag can be added, like
SLAB_DESTROY_ONCE_FULLY_FREED, in this case a worker rearm itself
if there are still objects which should be freed.

Any thoughts here?

--
Uladzislau Rezki
