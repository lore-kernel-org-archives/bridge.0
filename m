Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF103502A3
	for <bridge@lists.linux.dev>; Sun, 22 Feb 2026 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771778206; cv=none; b=bh06rxjVz+kllkYruAVA8nk4fszBIpXGoBN7j63in6Kd6nBR5IURasc857qiM2hk7HHFkyA5IM57AJjLlMwaJQvoH1n4KIwewwwQPr6WArWBsNuC6md8fo4A4d8ud/amoE0QNTGxzfNEq9bXKIGYJFncyIUNNQwGZhqSGR/5oUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771778206; c=relaxed/simple;
	bh=rnbek1Iwi7qlHWqEfo8ESEvJKxQUEY5jbcHUe6OKjvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQC6e8mhnjvCe2NLy2hgD+rknNJo1i53Gi4kvmHkjudR3fXHtK4fVDkcIerz3kDgbJfiQCkKqh4Sd8RvcGxW3sx85hiUEKNwQwXT4k0fkerPznQ7MpO3XHOBZTSYmYL6vRmx1IJH95fDoELugd2xLt7UepuoTP34oEPSZCln1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=A0z/kMgI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="A0z/kMgI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4376acce52eso2150281f8f.1
        for <bridge@lists.linux.dev>; Sun, 22 Feb 2026 08:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1771778203; x=1772383003; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yzpxqNPGSFGHysEvY3gxBQ/Fl4mK8lzti20PHekkHDw=;
        b=A0z/kMgIeeHQWK+MNTvFQ7w929mwzdkiNmPshLnsks4qjuZTN+ylb3CFI4GZNcZJGH
         PX1oess0CltafEIbEaO3vSyJjaq5qy2JKlSVboDpXJmfiYwKvn6PVC4hVtkUc5AwdHD+
         Bm5+B/O/ir+YRaXWixEFYL+IGXhYe50aT6aDnW6WmmVIgTbZXSPHM2d+Is0mOlM5eQh0
         DvrLUMoj6UOl6BxWAeRJgyp3V5ayzMfyEnoQ3PhVjpZJF3KZa3Z0KFNw723jX3bffQ/o
         CUqClSKR8qT2zzDmRnl0PkQefQesJZkgVROf9UOexa0HyALodjQes7iaDjJQvJLG92VP
         qhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771778203; x=1772383003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzpxqNPGSFGHysEvY3gxBQ/Fl4mK8lzti20PHekkHDw=;
        b=sES0Kvkv2XsPrTWEp9+/PbdclpFn21ZssEZ3LlRNZzNcF6a6lQsygyclRp4z7kIhfS
         VQZ6TKYuKNHEOKVITsGJix8a14o92E4un+7oC0F/W/jruk1/SGVskePhKd2dzNYeLO/j
         y0SCDIMtXMyl+Qkjc+pxwXPS2OYbcTU9VpMoBe/nS2aN/nk2PxszBXKXf0SJW/RJRq/T
         H7m4X6txNyRYgp1XE7J+NNZaoFr4wmWx2l0vi0iCS0MXlWigAOF5PCiEc2U5STFt6SK/
         xdq+cXtv2EHuoC/hXrRJXyQkP5mn+jh2uEegXorhMjIdgS+aOL013V0uvcDD/x2TSBpo
         f7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVxOHXkXQT5uMb4cB1ax9nsG11wgVnPMCQAzsPwoM7lD9hzhxSEl8a1A1UVLoniN0cDfH3wBqk=@lists.linux.dev
X-Gm-Message-State: AOJu0YwFquJSFDR3lbUfPsxk2f4iPMOpxbwm+X//D1pkGFMfjC+cBdKJ
	/j+wi27hYyrPqtM/qmHYaeahxZmNDSLGIOQTRxDjwBGkPy6s6bb0PLmaxWe3ZxBSips=
X-Gm-Gg: AZuq6aK23cDNOOzk9QDbANrHqgC78P47XUcwg5l7OXCd4ZRJgTSzb/iX4HXkMl1soFp
	F+2h6XPJxG4i60GdP4Ik0C9zrR//QVWeVZlv8XdWvgXH+aQE3nAS/NdUp2LRerEtgv2lZmDSe6m
	zFs9dzTI7gKUYUg+aMncXveYDSSpMcxMbI1mPTg3NC+jvBWykx/WKg071XfeeFqoEtl35qbF5fz
	8lsvxoK/s7aaGsJzGRqytR5aT8H01gL77PHqe+frEF16MZlojJZgNBPpSDcy3h1dfxsCpQQj4z2
	SlrSHzyv+y9S/K7XsNZpM7Rrq0JSbtkRd607kC1f2fGJBp8rkVVqebRAJ21zlk0BtsJyT0byfPb
	yQTuo0foZ4V+LPwKIRcXQRowLm3uhcGQq+k8ZOQofs3liA0Oa4mmCnUUQO1uA33PjBDaOmt0XWt
	sulR265yZUA4B1d4uDyFhkctj1fa9OtZkH6H8X4t2zrak35z6WCYVWcSxc+yFllSTmKL/t
X-Received: by 2002:a5d:64e5:0:b0:435:e47b:e746 with SMTP id ffacd0b85a97d-4396f17a9c6mr10832074f8f.36.1771778203092;
        Sun, 22 Feb 2026 08:36:43 -0800 (PST)
Received: from localhost (176.111.181.192.kyiv.nat.volia.net. [176.111.181.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fff9sm13229307f8f.18.2026.02.22.08.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 08:36:42 -0800 (PST)
Date: Sun, 22 Feb 2026 18:36:41 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH net 1/2] bridge: Check relevant per-VLAN options in VLAN
 range grouping
Message-ID: <aZswmWqzeZTkEFmO@penguin>
References: <20260222085338.3143823-1-danieller@nvidia.com>
 <20260222085338.3143823-2-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222085338.3143823-2-danieller@nvidia.com>

On Sun, Feb 22, 2026 at 10:53:37AM +0200, Danielle Ratson wrote:
> The br_vlan_opts_eq_range() function determines if consecutive VLANs can
> be grouped together in a range for compact netlink notifications. It
> currently checks state, tunnel info, and multicast router configuration,
> but misses two categories of per-VLAN options that affect the output:
> 1. User-visible priv_flags (neigh_suppress, mcast_enabled)
> 2. Port multicast context (mcast_max_groups, mcast_n_groups)
> 
> When VLANs have different settings for these options, they are incorrectly
> grouped into ranges, causing netlink notifications to report only one
> VLAN's settings for the entire range.
> 
> Fix by checking priv_flags equality, but only for flags that affect netlink
> output (BR_VLFLAG_NEIGH_SUPPRESS_ENABLED and BR_VLFLAG_MCAST_ENABLED),
> and comparing multicast context (mcast_max_groups and mcast_n_groups).
> 
> Example showing the bugs before the fix:
> 
> $ bridge vlan set vid 10 dev dummy1 neigh_suppress on
> $ bridge vlan set vid 11 dev dummy1 neigh_suppress off
> $ bridge -d vlan show dev dummy1
>   port             vlan-id
>   dummy1           10-11
>                       ... neigh_suppress on
> 
> $ bridge vlan set vid 10 dev dummy1 mcast_max_groups 100
> $ bridge vlan set vid 11 dev dummy1 mcast_max_groups 200
> $ bridge -d vlan show dev dummy1
>   port             vlan-id
>   dummy1           10-11
>                       ... mcast_max_groups 100
> 
> After the fix, VLANs 10 and 11 are shown as separate entries with their
> correct individual settings.
> 
> Fixes: a1aee20d5db2 ("net: bridge: Add netlink knobs for number / maximum MDB entries")
> Fixes: 83f6d600796c ("bridge: vlan: Allow setting VLAN neighbor suppression state")
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_private.h      | 10 ++++++++++
>  net/bridge/br_vlan_options.c | 26 +++++++++++++++++++++++---
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 
 
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
