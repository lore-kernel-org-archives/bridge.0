Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8061CF3FE
	for <bridge@lists.linux.dev>; Mon, 17 Jun 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632264; cv=none; b=hEl1AiBLxq9tiQ9kpg9C9evTZJfX6xij0nAHGaAXiH9kR9ZoGwkdWNvVOLEzEFmKHAqt3UiqL0d8pmFBKn32P6I8/lQCsSikU82iZCOGPdTUOuGNsG8OY35FeGkBHbSe7dC9UQiFuvPUOiizuTo5OHaTZ+KQe1ahEn8lyvEGLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632264; c=relaxed/simple;
	bh=WxO8wJJZE1Xds5hTG7TDExzo+Qsu32A6Rbf++HOL+EU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpvFiYgvD/axcnwSi4Jgr7aJ6itQPCQO8b4p/elxCZjQOoTgIddOX6Dhp9XkxoDp85qYzXMtFdDI6f0+ZRPguY2CDk97D7/Qq308weuh1K1oQazH1REZa2zTKlhjS/kAEQal6QRt/hP7zveLTbDw5JRSvWcc4ij4p0nDNATGbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrsJjhWy; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrsJjhWy"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bc29c79fdso6033055e87.1
        for <bridge@lists.linux.dev>; Mon, 17 Jun 2024 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718632261; x=1719237061; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7cjNgaPzx0K8Q2oE0VGfsHosS8QVWGPVVkZ0XS7HEDg=;
        b=IrsJjhWypNkhC0HOhnYAnQt7pIt8RtQlQMR/LCAb6CqGnqCAljaUkdQ9DxA6dk1wvp
         jstL9M6pXzWb7bigKGGWDOIaB0ztgPxT9Z3pXrNNNTyUKxM3yDx0cD0w/Td7rhCPLaDo
         EBe1Y37eMrKI36Swx+13Uz19ZUUw/NVVF6uwmzJBkPPN02e1G2XbycKs868E6x0cDdmL
         W+uXHIp9dwTetwvIzcesUWV+k7Ws6fO9VS2HRizZ3Fj2FAQ4U+kv+1NWdgq5nPxIT+0F
         w8sORakfTlMQvP21VsbEhn0KMGtukVhSs0KCm5gP1vBxbxLWjmWQXeMl/9hF1KUvwKct
         5+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632261; x=1719237061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cjNgaPzx0K8Q2oE0VGfsHosS8QVWGPVVkZ0XS7HEDg=;
        b=S+InAvnF/Z4W9LqdFOqzHAc3pydh2QIhREPleTydNkJNf8VK4Z+rbXDmlWpf1GEz3z
         NNkKYc+DGdj4d3tbz0bzyW6579hHN6OTuAlAkd9bF+lwJSt3kRpTVN882PA/XAJ5bFfn
         o6S2Oa9l9TBaoCT6Xd4xzPirFyk4l1MUczhatkxUM4fsM4YXsetz2tiGLfcF+xkS9bxS
         ppNU8ACj49hE9H3DbiUgzG4DUX3uCcL23p8gye4rGIaQoYlmAY7qcWo7TDK3rvku82Ja
         cPsT6o97k0oUiLjUrV+gHTiIdTBWbsj1cpbCkTAQrW7rbcHYV1+8ZRQZprHIyls67Wir
         kF5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5JsCxlJfbfJrzElPW075e+LCCJTu+vAlboF8yZO3lbe5zcyeGhr1JEj8ShTefxtIfEOFa7q/2OAlOrQVPJDiRAnPh1FrB
X-Gm-Message-State: AOJu0YzXXrmq+zUA6XOmy+gGpPQpoYnPC5As2umF131jCQSiFzyb2VI2
	SbKVgJOWx1dVqRKdn4A2XWjWsup+yrw7Yh4UCq/cHfYaULAecqq2
X-Google-Smtp-Source: AGHT+IHJ0CsNfqdOT8NJ8/aEvcd12bZPn1WcmZOT2dLARsLKNTs8V+RbkzjWhHb4g1pZvloY+oCxkw==
X-Received: by 2002:a19:5e15:0:b0:51d:9f10:71b7 with SMTP id 2adb3069b0e04-52ca6e6812fmr7404820e87.28.1718632260306;
        Mon, 17 Jun 2024 06:51:00 -0700 (PDT)
Received: from pc636 (host-90-233-216-238.mobileonline.telia.com. [90.233.216.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2887d56sm1239456e87.263.2024.06.17.06.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:59 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 17 Jun 2024 15:50:56 +0200
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
Message-ID: <ZnA_QFvuyABnD3ZA@pc636>
References: <ZmrfA1p2zSVIaYam@zx2c4.com>
 <80e03b02-7e24-4342-af0b-ba5117b19828@paulmck-laptop>
 <Zmru7hhz8kPDPsyz@pc636>
 <7efde25f-6af5-4a67-abea-b26732a8aca1@paulmck-laptop>
 <Zmsuswo8OPIhY5KJ@pc636>
 <cb51bc57-47b8-456a-9ac0-f8aa0931b144@paulmck-laptop>
 <ZmszOd5idhf2Cb-v@pc636>
 <b03b007f-3afa-4ad4-b76b-dea7b3aa2bc3@paulmck-laptop>
 <Zmw5FTX752g0vtlD@pc638.lan>
 <ZmybGZDbXkw7JTjc@zx2c4.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmybGZDbXkw7JTjc@zx2c4.com>

On Fri, Jun 14, 2024 at 09:33:45PM +0200, Jason A. Donenfeld wrote:
> On Fri, Jun 14, 2024 at 02:35:33PM +0200, Uladzislau Rezki wrote:
> > +	/* Should a destroy process be deferred? */
> > +	if (s->flags & SLAB_DEFER_DESTROY) {
> > +		list_move_tail(&s->list, &slab_caches_defer_destroy);
> > +		schedule_delayed_work(&slab_caches_defer_destroy_work, HZ);
> > +		goto out_unlock;
> > +	}
> 
> Wouldn't it be smoother to have the actual kmem_cache_free() function
> check to see if it's been marked for destruction and the refcount is
> zero, rather than polling every one second? I mentioned this approach
> in: https://lore.kernel.org/all/Zmo9-YGraiCj5-MI@zx2c4.com/ -
> 
>     I wonder if the right fix to this would be adding a `should_destroy`
>     boolean to kmem_cache, which kmem_cache_destroy() sets to true. And
>     then right after it checks `if (number_of_allocations == 0)
>     actually_destroy()`, and likewise on each kmem_cache_free(), it
>     could check `if (should_destroy && number_of_allocations == 0)
>     actually_destroy()`. 
> 
I do not find pooling as bad way we can go with. But your proposal
sounds reasonable to me also. We can combine both "prototypes" to
one and offer.

Can you post a prototype here?

Thanks!

--
Uladzislau Rezki
