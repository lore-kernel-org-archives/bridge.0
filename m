Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A3E8634C
	for <bridge@lists.linux.dev>; Wed, 18 Mar 2026 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796531; cv=none; b=lIcDUnbaImqgdoeZdWDOXlBU5/amhAKlwyFuFAeCy/GMLvj+VZR7L+Lk74B4dzZydncTcBe00ss0FBq+4EjWRk3MTlshk3YnPBXcWICa/Tap32MwIq7N60tL8EvPhr7Uy/s5SalZbaHsfa3s208ZeEVZ8g+Ki4I7byhhUVOXr/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796531; c=relaxed/simple;
	bh=hh57UKn9VSRdodC3JOjSt7y866f7q5fgZGr8SQQaUPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfY5ZCJ6Wrw2CmWFuzeCdbxGOwb5kKPZ32W6Ew4tQGqYXk6j/kH9ShY5x2clytXMANqf4uheY5RrpNLybOV6h2HSbbofU1Az7VqjH8GMmIIgWM0dpIgel6otyqidMyLC0cOCSTxmZf2G0DL59Mg71u3fRN4NdAb+Y31cad859TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckqv56JC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckqv56JC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad4d639db3so30640095ad.0
        for <bridge@lists.linux.dev>; Tue, 17 Mar 2026 18:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773796530; x=1774401330; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HSSXG9ti9V7P3y2+q+M4hK0U/NatY0Rkc8bPv7HEMJc=;
        b=ckqv56JCAnrrMEppGePX2DwB5QQc9iunu1wtcrXx9zh6a3SAhbQbQnArua9wgVjIfW
         6JPeasFS89Lh+96Wk1PHw78dsvczg3LovvrfXTKlQqDbaZTyuhI8Z0L5YP0O2pvV6r4K
         ElWf/TNDjHa8FbjU0aRwS/FrAO+QnAzHndi5ulxcq7W637okh7S4SuP19CQgvFuIXoZO
         y9HdRSbk2h3csQh+2TqnhyJvf73bklc0Xcozgt82/nnx9KxL/WYTHWwrxqbLSAjiUptx
         O688ppf96T5ZyWQ8cBx9i6NYceenUxSQETvVBKpOux2jlMmhaztiKMPfRxHQfWDJ8Cwm
         zkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773796530; x=1774401330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSSXG9ti9V7P3y2+q+M4hK0U/NatY0Rkc8bPv7HEMJc=;
        b=L0bXALaJl+8PivpjdAzAzp6d/BQVR/XSK5R4y90T7Yk/9Cgw47DnLUUnH9Tyd22SnL
         QDy3A14islEYzXyhpuqFAFBHA0JotjUZfiu+sz0kuyUPTIjF8z/dumU0v9OU8xfVEdmK
         ++zFiK2gzDj5hFLTHrdRCAcSDXNRjNQNnZYFt2letBUOJQrFEBShEKFbEuR4/nAaDUJk
         IGzh4H/yIz+uZTEam9y6AQyp15iUsASaXTqigaO78tjclQUMDqKJUhKa0TIUzKc9mIMi
         xYrM8z5doqeCRytesqa4jJlfvBukS81b6QJujMqxmjPAClo8jX8aeUAaRqxi2ZfHrYVo
         kQOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUluC8wwO2tA+0RQ1VgcKMGmyye5PX8vfsv+tBYTDpA+6nXqXyra2PbOq+hjPYDB2K9qZZQxrQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxSxm86SyOHhyAaCd046Am4Va8qgMi7Kr7KAoZ9Qnl6+3YB1zDh
	sYrPzJZnNDLu0wq+Uro14lDO2g7F9ZfPGJ945BwSgIMz6+QK8MBkOJty
X-Gm-Gg: ATEYQzzcvx2y6uXP2Pni8F2tVNxsv9HWe3+KjVchCQdrkKtLyqtgWz+kLypdZdnEyc1
	7f17p66cGNf2Gs05yQH/Gti5niaIDPmvpWOyM/efO3Am1UP2CK8zVyp62xUPRc/w/X2/vLLlQBN
	pOJK5ERiAxguXCcIvvizYui8RpEY3M54Qmbkxjzt0HVJ0+xUFGR7SP8G8NLQOhxyMFQsGifUevG
	nPgHLZ4A0EORWL+4wug0zuVy1QCvoc283byJnA91tTL82NE1yDigL89fiqlKYn0upGyxxP9VDNI
	8hjPiujxs8tzma3BbD6tzMdXFuLeXzSLvY8/wvbrsBbo57+7Y5ZVDORLJmFSHGud58e30gotcHt
	8k+544/BfCqUdIG5tyKmRmY6rW+31IrL0fP53a++kRobGpCHTvbVXmAUFRO/lGpWhmy+9fD1j55
	TAbCa7IGd5T7Oz1P3HXfXWHZfoQnjTiuFU1eTbAw==
X-Received: by 2002:a17:902:ec87:b0:2ae:bf32:20c8 with SMTP id d9443c01a7336-2b06e39c5admr14882505ad.31.1773796530061;
        Tue, 17 Mar 2026 18:15:30 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e445075sm8904115ad.31.2026.03.17.18.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 18:15:29 -0700 (PDT)
Date: Wed, 18 Mar 2026 01:15:20 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/5] net: add ndo_update_offloads for offload
 computation
Message-ID: <abn8qFyE7pDuM4oN@fedora>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
 <20260316-offload_compute-v3-1-a5d4a07d86d3@gmail.com>
 <ablv266AIETvJwpP@krikkit>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ablv266AIETvJwpP@krikkit>

On Tue, Mar 17, 2026 at 04:14:35PM +0100, Sabrina Dubroca wrote:
> 2026-03-16, 12:26:09 +0800, Hangbin Liu wrote:
> > Add a new ndo_update_offloads callback to net_device_ops that allows
> > devices to compute and update their offload features during feature
> > updates.
> > 
> > This callback enables master devices to recompute their features
> > based on current slave device configuration. This is particularly
> > useful for bonding, bridging, team, and failover devices that need
> > to aggregate features from their lower devices.
> > 
> > The callback is optional and only implemented by devices that need
> > dynamic offload feature computation.
> 
> Maybe a dumb idea (and sorry to suggest this quite late in your
> submissions): since all implementations of this callback are only
> calling netdev_compute_master_upper_features(), does this need to be a
> new ndo, or could this be some kind of flag within struct net_device

Ideally all dev with IFF_MASTER should re-compute the offload. But at present
some master devices do have this flag, or have their own offload
implementation.

Do you mean add a new private flag, like IFF_RECOMPUTE_OFFLOAD? For the second
parameter, maybe we can pass false for bridge specifically.

Thanks
Hangbin

> (2 flags since netdev_compute_master_upper_features takes a bool
> argument) that changes __netdev_update_features()'s behavior? Since
> the goal for the netdev_compute_master_upper_features() work was to
> make this code more common, not introducing a new ndo where random
> hacks can accumulate separately in each driver would maybe make more
> sense?
> 
> -- 
> Sabrina
