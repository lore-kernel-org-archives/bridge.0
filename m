Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E832F28FA
	for <bridge@lists.linux.dev>; Mon,  1 Sep 2025 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719986; cv=none; b=eT+PjFVrr9ShDKeDZmnLswZJoM8o/mQc9k6345BIkUu40l6dY11m+kuEWpWW1kJLLd1xVvuH51r1URV9JBcm/nPvlSD2vZoyjUxAKiptv6ipzewJWD52mwVT/Z83bjSYjXIzvKnNjMGml9EotwY7vQncsovPlyBNjId6CmgzFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719986; c=relaxed/simple;
	bh=dy2xemg3n1W2UZPuQu+0kwkTDDPlySkA91OF4IeG2nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUZPqaqaSUvNZGfWuxUYuBRS/VYv2l1lrTuCj7KvokZTSkAuD4cHNNB8NMhL/XVpHtP+AqcZ8FOpwlwQ9kTM9ieFPSUE5gIMnoxOStYrCH2OxtUvPm6zKZethl8LwFPVNBopQk3Jv5LCuaTk89977ttwJKgptqxmG6NHqx85AoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfygWqzc; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfygWqzc"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4dc35711d9so1668497a12.0
        for <bridge@lists.linux.dev>; Mon, 01 Sep 2025 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756719984; x=1757324784; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6AN4Zya4y7dk4/kCi7m4WWgbBZr13gir++L0u0XVBNk=;
        b=VfygWqzcjhVmOPVzRGVRlz/hJve/uEBE2Zhb/zuDxSbAq33WbSAcDQQNiqSwR1E4yq
         lr6fKpMCH47BeHekih87WnAxSMNubA61YHbg9pLrr4lP9D+UFZSW39QheEAPsRGlknHS
         NCrPR9a3dM5bV1L7SlGMrIElQ4ms0DWUjMGHDxQrLwzSiHCJ2FGy09lixXYkUJ6Chw8M
         eGSWnqSRH3q63MS+XXnEg1uNAKHey2K3Bg4i24eck2s/H+UmzVdTVb4D5hZS5djatV0C
         efuaCf4rqH2wHWi+tW8QWl/7egSGc66JoUMc+P75aYH86C+8QfnSysw/x5XrthK4GOyW
         qgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756719984; x=1757324784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AN4Zya4y7dk4/kCi7m4WWgbBZr13gir++L0u0XVBNk=;
        b=QXAO+s6kKdBDx/MxpqPZ+vAaY6RDq2ARfS7GACM6oaY7416lROk2rKLdKtlUDlXpAl
         aIqWaJzT6abr3H6QPfkUyJzs1vMAu/76xdBKG00G4uO44vaBcPv6wGfCglJoe90SxmD5
         TptnK2VhY44UQBAmML0RwFXcTnobZ4B5RTBcDap+/E+k9W5EnMPv3XURsgMAHCnJkUty
         VN16kaBwmomQoC8RPH/xFDDA9eDSJlYbKKnFag0UydFR8xW+Cbpy26KLF70mgYHIiXrD
         7HUo1qLaQdCz8HH9RZu0hsoOF74gCXNNCb6pGeFvIAKvA1T6nvrPU47Z2dGLTRAnjqUd
         04JA==
X-Forwarded-Encrypted: i=1; AJvYcCW7U3hZoCejMkKsOWANUoQPURvPvSH7SY7skFzZPt+evQPP2Y3PhLVCMWeg5EEpYxXDw3nTmgQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+BR66K/hlWRVMAV7j0lANzT/Y3Ne+N8XOlwIvX5ECeQX3nNWq
	5ErFjoqgB+wppufdUezBdaHBvKjnDAuLUnw+tdbzDqwJihGvrHM52sgw
X-Gm-Gg: ASbGncvrIfF4Ygb8MYWUcD7p47drQ7NomjYu7pjs/KSGGYHSjjZUD9W5AIwu20q3H/2
	Ar9JWd/8LoeF6Sasm3coJoJn9CJjpauoaSWS2gJmCZJD7tbYDg4DwVQJIxcLEg2JWvhpo0a2OIT
	9L+nycKzG4XmNQOgQBD6SkNa+N8PBFvOx16ROOupE9enhL/l2CZJvghcqMkHQNP7dVIwLvl9oie
	ds8Bk2IHyqFSNCgDaVYKKSCKK2d1mebKLlpxwayFY/jZQ/34hpoUfjL6/E52brivmrbRlJ/w9vI
	da+KjnM7ftGZr5V6R6sD4bGARyU2ztAxeq5l+sI2qHrAYRSAfOrxsKZZhaVW41AhlXaPAGGOKYc
	HnCs399JiCByiE9qWan3/EBhgccNWOSSX9Zc3+Q==
X-Google-Smtp-Source: AGHT+IERMkBfJwVRhMRFFw1kUbN2D4UIfPImaljurjYr9dFaV8R/JM1t+5zsxDp0Z4yEgp7DybGjMw==
X-Received: by 2002:a17:903:2385:b0:246:80ef:87fc with SMTP id d9443c01a7336-24944af38c7mr83911455ad.45.1756719984257;
        Mon, 01 Sep 2025 02:46:24 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065a3b67sm99517365ad.120.2025.09.01.02.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:46:23 -0700 (PDT)
Date: Mon, 1 Sep 2025 09:46:14 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: add a common function to compute
 features from lowers devices
Message-ID: <aLVrZu6b_-mpt1Fg@fedora>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
 <20250829095430.443891-2-liuhangbin@gmail.com>
 <aLRr1W3jKRDYsRSq@shredder>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLRr1W3jKRDYsRSq@shredder>

On Sun, Aug 31, 2025 at 06:35:49PM +0300, Ido Schimmel wrote:
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 1d1650d9ecff..fcad2a9f6b65 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -12577,6 +12577,85 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
> >  }
> >  EXPORT_SYMBOL(netdev_increment_features);
> >  
> > +/**
> > + *	netdev_compute_features_from_lowers - compute feature from lowers
> > + *	@dev: the upper device
> > + *
> > + *	Recompute the upper device's feature based on all lower devices.
> > + */
> > +void netdev_compute_features_from_lowers(struct net_device *dev)
> > +{
> > +	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> > +	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
> > +#ifdef CONFIG_XFRM_OFFLOAD
> > +	netdev_features_t xfrm_features  = VIRTUAL_DEV_XFRM_FEATURES;
>                                        ^ double space (in other places as well)
> 
> > +#endif
> > +	netdev_features_t mpls_features  = VIRTUAL_DEV_MPLS_FEATURES;
> > +	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
> > +	netdev_features_t enc_features  = VIRTUAL_DEV_ENC_FEATURES;
> > +	unsigned short max_hard_header_len = ETH_HLEN;
> 
> hard_header_len is not really a feature, so does not sound like it
> belongs here. I'm pretty sure it's not needed at all.
> 
> It was added to the bond driver in 2006 by commit 54ef31371407 ("[PATCH]
> bonding: Handle large hard_header_len") citing panics with gianfar on
> xmit. In 2009 commit 93c1285c5d92 ("gianfar: reallocate skb when
> headroom is not enough for fcb") fixed the gianfar driver to stop
> assuming that it has enough room to push its custom header. Further,
> commit bee9e58c9e98 ("gianfar:don't add FCB length to hard_header_len")
> from 2012 fixed this driver to use needed_headroom instead of
> hard_header_len.

Wow, thanks a lot for the long history changes..
> 
> The team driver is also adjusting hard_header_len according to the lower
> devices, but it most likely copied it from the bond driver. On the other
> hand, the bridge driver does not mess with hard_header_len and no
> problems were reported there (that I know of).
> 
> Might be a good idea to remove this hard_header_len logic from bond and
> team and instead set their needed_headroom according to the lower device
> with the highest needed_headroom. Paolo added similar logic in bridge
> and ovs but the use case is a bit different there.

OK, I will get the highest needed_headroom for each slave and set
the minimal one to upper device.

Regards
Hangbin
