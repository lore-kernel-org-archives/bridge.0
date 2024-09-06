Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A81C8FA1
	for <bridge@lists.linux.dev>; Fri,  6 Sep 2024 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623886; cv=none; b=XZI/rGRo4iUnV4K+3IONz3BNvEGc4HPCjoUzw0oy50UWDvD3QJEzbFR1GLMyAQublx4caH9jUzKYB5XF81IFmGsoML3DB/tUgrlX2gAj6zrHerBex//4Ou++k/qFjKzuMHCBDyDwUI9e+Wl/4y6eXMmsPbbVVRR1djQsrtRwR4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623886; c=relaxed/simple;
	bh=gwhd6YSUYn0QtaTSPyGtnWCa/URckQRSKwJmnGcYxmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=q+6W9b65Tr87ICJzmzERefMCCDaZFums/2fPcZJCiYwDwMa6hMgHoVnnEgWjNfIUczaSMj01tbbCBVrnOwonrUFISQdnhVQeuG9dleMJw8AFX8blJHWWe3cUuEXJerseyRlpSXOaEqrAPwH4QRu8nP13Pn/sNI4Xi35cfFdq55s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Epu9TZ4Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Epu9TZ4Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725623884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gwhd6YSUYn0QtaTSPyGtnWCa/URckQRSKwJmnGcYxmQ=;
	b=Epu9TZ4YRHmDdJgKP8SUIOL7cXVRxYocM+m8lJ3h5DmbGsCLycv28kPiURvQQuDqA3vj8r
	62/F8nWWa68o3zNy3kyrTnlHTaV83Wq4xcYSZ+C4YV344q9gL4LJ7vHeCtEUiHfNqOSJ6O
	J9oFYzhMdL46iHCExM49M6fk5pQx/WA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-ADUVmfzkMcmS2m1h9688NQ-1; Fri, 06 Sep 2024 07:58:02 -0400
X-MC-Unique: ADUVmfzkMcmS2m1h9688NQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42bb6f7e7adso16209175e9.0
        for <bridge@lists.linux.dev>; Fri, 06 Sep 2024 04:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623881; x=1726228681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwhd6YSUYn0QtaTSPyGtnWCa/URckQRSKwJmnGcYxmQ=;
        b=nNM7X/k0OrQzn045hIlPJeIWZB0Qt63/cPcnfL++MecWOveGq3nAugj2B8wRVdEiEF
         bytTr8lswk4OdM8XmuPJbM5PZHhSgJum6BwTun7ox4PS5PsTve5gT9Ov/R53U7+ZdjvA
         9G/hP65Dn1+RYKIoAH4mTdJCF67LXjXlr8DCKVYmTrJxOGKFmO9BKCIyKfuY/Fk8+Hbb
         R5IK5kJUxPVqiW9Yn1LFWHN9wo2/viH8d+0tlIiyGQowcg8NjAnri5fo5X8T7G6rrl/x
         v67migKc6YU4xLbUVsf9srYiz/V+Jyw1PS8QqdaBB/3762FLO6WZG+wz2KKS5GyBBBE2
         oAjg==
X-Forwarded-Encrypted: i=1; AJvYcCVwOCZMybDubhuHfM0XiBVR/d4QE2gvxQ9QxGx9LzunmTymPnia/NuBtaXLumcVsfwGeAkZfHI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxcilmjFsbRpJOxz65dh8v++PrVsPKvepJM+ZjDxvL7Cw+1fW3q
	YNU29tLp6B0Bb1IB13V4mtOhQlJWVjm9Zi/lIpm8qz2pNL4PE0JWt6pdgLB7O4osVUMU+a/7jUK
	mLlUHcDF0e3cC59zQ1HZM2YW9kaDZVX46LVGoI7xhGAV5LBygEc0tFQ==
X-Received: by 2002:a05:600c:1911:b0:426:5c9b:dee6 with SMTP id 5b1f17b1804b1-42c9f9d2fb3mr17165745e9.26.1725623881173;
        Fri, 06 Sep 2024 04:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyiezqnLnx60jEifhUTR30wzAxyOM3WxR1xMKMuwhfruZ0dS+mmwcm4hHOxDzegTtb9NCsoQ==
X-Received: by 2002:a05:600c:1911:b0:426:5c9b:dee6 with SMTP id 5b1f17b1804b1-42c9f9d2fb3mr17165555e9.26.1725623880591;
        Fri, 06 Sep 2024 04:58:00 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c9bb7d3c6sm31634815e9.1.2024.09.06.04.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:58:00 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:57:58 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 09/12] netfilter: nft_flow_offload: Unmask upper
 DSCP bits in nft_flow_route()
Message-ID: <ZtruRrAazfhcwHJs@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-10-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-10-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:37PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling nf_route() which eventually
> calls ip_route_output_key() so that in the future it could perform the
> FIB lookup according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

