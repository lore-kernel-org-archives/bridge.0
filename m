Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97410277035
	for <bridge@lists.linux.dev>; Mon, 16 Mar 2026 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773622934; cv=none; b=pv/fv6WHVNV6xlY0Xw+uGi0JjoYSXVQEPj+3BlggCH4xEeSszmMACMWnI27L+0ff0p2X62UUUXv0I4hOLJGqmcQ52yUq6QZMcRjY1301Chp6Id9A7AOP18oeUv4dMBcUFoSvytZv879WfONBs8Xcgvg18yUTae2zhtmfny/dadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773622934; c=relaxed/simple;
	bh=Eky1nMoAs0udEY/YyYt5887/RWDwMv3LBHaMdNwTh0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8uPKj9VuKiCv7l6TPug25bl5YvdmAEqzwZmK4VlgK3k4ULAKqeVdJF34noq6kerg5vDiD6fdqunLLureXWVoE3IEW8bLVG/LRpoXW1KJ9dRUa/VO/1WxWEmT3HCejF2exRdOy5C3mGhtcfBZVBg7rPas9tkhe0Ikb2w36uQnfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLVziUxp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLVziUxp"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c736261ee8dso1304074a12.1
        for <bridge@lists.linux.dev>; Sun, 15 Mar 2026 18:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773622931; x=1774227731; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLOS+CBHAqth4oLgPzOQhkefjgoFRG3KFqew2fphAF8=;
        b=OLVziUxpaj8QwUHVsIesNFHCA60SVV5dJmHN/nYK9zmNDgn+dfx1HRVM+VDnj4k4fv
         UWAIJSkWDmvS+hqWsRKqsb+UzrhfnIjWE5I1wMrd3v0Uan29IVwvYMDhge+NFxXtnxpN
         mWvsMWdvg1vUQwD/WFIaN7EDQ+/fpK7VlbAb43cVX58hH5laZJg+xaYRrVZjedqzo7JO
         iDn8V5vCObYHb6VjR6cUnKBaaxNjAVirKsvVQu4Y/iEIzHzabfpMs19ndewf/fXKW5x2
         HaLUHDSrz/Oxf2B3T4Q+nR/P5kmA57aBQnoTqlYq6yJPZ+enE0KWjGfLmIRkl6ueIqMY
         Znyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773622931; x=1774227731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLOS+CBHAqth4oLgPzOQhkefjgoFRG3KFqew2fphAF8=;
        b=LVZkKlscgHKQqxz1LCtQXPAWe5E95aC8VJFuLVo5Ads8empBJ2Ld6iukdjuzzE+Zim
         GD01xD+/oqcyI1z/Qv7Un5n4yZicVCFTzAVwZklZHFQEifdHyaB/eSccC5Vwt4aNgXy/
         X5M1AKaHbgnHl6aH3MQWjRQb9455xiICat1qtR8bkUiyX/+4svHVsYvVc1nix1aOYEVA
         faosV/Yw2HbfFnXNkRLua7NnoZ00n6e71E0nTlLaClAlrE6VWmCbUmhvfiocoWsSRVkM
         0fVJz7BJTFdH0wCJyewN7pCw2FpN1ytbcTLHj4aVtoGnYVtBLFDJi3dOV3v3SksNusOC
         kg9w==
X-Forwarded-Encrypted: i=1; AJvYcCU6E4l7wqYQouAMElr9I4vXRcB73QS7EEFXVdsltqJNIzg6RwSQ/eZ+/iseaZ497EdyOuBm3qQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyUV3HseAYaEOdr8jnvCoJfHfmOrFYzs7YBgDbZ2oOxSgfrvVPY
	gIV4mcwC9e0HCl65VR2td7cmEfZhalv7jj2I2xaUqjx1KhpWRCkxKIVK
X-Gm-Gg: ATEYQzxtcy6+w26k/lUnO/voy7sLp7af+mjbLabuPnw3JnZVZhfSTcrk9SlVN309Wwh
	mR1bqGrLlTiaKG/so8ldkmbBxOjgwPjDkx/KJiQ7idVLdbZlWhV9aCoE5dOuVLDzkgwjC17m7nG
	Qta8z8kZsNBOC1X1hyr70fr6FI4sA/97P65Y/01p3To6m7dXHV0y2ZSGl98N8erfCvFkvq8vyp+
	j98sZcucpv5ZFDfPPInlJgQiWx65wvhu8+JK/EkIWO5jJngNtOPu53BzN7/aUepXtx7hBL14RXT
	Y2kRkHjeAxD9l5XySSV1+weXkeoI0z2PwHwQeW3h/HFqwElPqgNphrrH3jsaEO9lMuuwdfZRD2r
	Jy+qVcNYw9sqld5v/Mua/D0Fo+lIg2fBYs2DswY5YnRmVy7C5SF69nH3j3nZn89pT6gXQQ/gNwl
	8An+mHGcBy+Jf7B8FBf3mHggPvKfu+SEcR35PoRQ==
X-Received: by 2002:a05:6300:6713:b0:35d:6b4e:91f1 with SMTP id adf61e73a8af0-398ecca4e41mr10054657637.34.1773622931501;
        Sun, 15 Mar 2026 18:02:11 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74029fa6eesm1891891a12.20.2026.03.15.18.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 18:02:10 -0700 (PDT)
Date: Mon, 16 Mar 2026 01:02:01 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: jv@jvosburgh.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, sd@queasysnail.net, andrew+netdev@lunn.ch,
	pabeni@redhat.com, sridhar.samudrala@intel.com, jiri@resnulli.us,
	bridge@lists.linux.dev, edumazet@google.com, kuba@kernel.org,
	razor@blackwall.org, idosch@nvidia.com
Subject: Re: [net-next,v2,1/4] net: use ndo_set_features to set offload
 features for bonding/bridge/team
Message-ID: <abdWiYhu4IOldqtE@fedora>
References: <20260313-offload_compute-v2-1-ffbc8ce5d50c@gmail.com>
 <20260315161943.1419237-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315161943.1419237-1-horms@kernel.org>

On Sun, Mar 15, 2026 at 04:19:43PM +0000, Simon Horman wrote:
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index f48dc299e4b2..16b3fc620807 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -8920,6 +8920,9 @@ static int __netdev_upper_dev_link(struct net_device *dev,
> >  	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
> >  				    priv);
> >
> > +	/* re-compute all features after adding link */
> > +	netdev_change_features(upper_dev);
> > +
> >  	return 0;
> >
> >  rollback:
> 
> Can the feature computation skip updating ancillary fields when features
> don't change?
> 
> The new architecture routes computation through netdev_change_features() ->
> __netdev_update_features() -> ndo_set_features(). However,
> __netdev_update_features() has this check:
> 
> net/core/dev.c:__netdev_update_features() {
>     ...
>     if (dev->features == features)
>         goto sync_lower;
> 

Ah, yes. In the RFC patch set[1], I wanted to use a new ndo_update_offloads
callback to handle offload updates. But in the formal patch, I thought we
could avoid introducing a new callback and use ndo_set_features directly.
However, it looks like we need to fall back to ndo_update_offloads now.

[1] https://lore.kernel.org/netdev/20260226114208.27774-1-liuhangbin@gmail.com/

Thanks
Hangbin
