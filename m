Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326FF610B
	for <bridge@lists.linux.dev>; Wed, 15 Oct 2025 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497424; cv=none; b=niGQmRyZT2iIgI88rjJ7DrpD0wKN3ebAZlx3v+J+PT0J415oADQwoIid+6O1vVO8BwUXKhzcO1HTSMEAnvMeFhSXFSYmmshJMgarDsqYJ5L9tqf++6JBWIrz44t3fbOoPriYQc9JMircua/USnt7VupnIRdXrc+Yn3R7WoG+c3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497424; c=relaxed/simple;
	bh=IKc+jkIsO9mgc1GUn3H5nunONRgZo9m8m6soz3UG1+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDvtyYBcVjZVGJedpL4CY/Lhiz/bty61AJO+WWgQ5lgellD8A3pXPGsijDm1Tin9ldzybMcq5urUwHEbGhOtnSOpRagyR9+l7ywV/syW4S0B4wduuo1JiNum445jxiYM1g33z8wwiFiToa1V8TRLSCP9qhfq8ap+1oDRScYD65Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icvK3Uot; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icvK3Uot"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so81886195ad.2
        for <bridge@lists.linux.dev>; Tue, 14 Oct 2025 20:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760497422; x=1761102222; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJRtMauxgy5L7Cll4qsdqgeV1KauSjYifSS43lZLtuI=;
        b=icvK3UotdNPKda1aYgAO2QOtfU7JTPnSHYL5xmsuwuNxuHk3+s4H2BJ8ouSXl2n87e
         czoVC/Wvv88aYP95kEhwsu5WlwEWFz98y90jfyEoOc3vNbId72h/C7SP76DShc8KrgKU
         YoeuvS9wXLIOfWrqEvPwmQJnxgKdo/VfW0g3u6Sgt1uxAWJGjEC2MlyRj5ND7DnMc3op
         RNRnm+wUTlAiJKFixN6bS3pYPqO5O5PASAL2+6tHc1xAXKlaKzUmsC/NTL8tRxlLzDsR
         ZA6M4BNFg1cRw4O/HaBckPIkE78qgO9GH+el5h1iltI39/h3irqaX2BKOlr0dIK4jHh1
         2QZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760497422; x=1761102222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJRtMauxgy5L7Cll4qsdqgeV1KauSjYifSS43lZLtuI=;
        b=RcyvGKee5ZSLNAMwq5pLflzQN5s/Wr1u9TVeD/RovvEFXfGuloLon+b1T1PqvLWLXI
         cDZOkrkkOPDugxbD348yOBLx6X9kATF4ZlQpACaXBTKAnwtEIwEvnObbcbgoGFY4VKtl
         8X7hAEEMzef9RsHNEbJ2Rw58wT+9BDavoDCvmds/ITnj0qr7yt8CoDlVrrL+dd/w//S8
         fkxpI4zolup2ibnclvUYYU1cSmRz3ZiDilqpbJJsexHIGAncMVwi3AYLBgBgX+nsJzAw
         9TFNIKUNEYKUELiB3n4ZUJ/k6qBIVwhEhtV5bjBfmbJIV2U/k6t4yl0v2s9jsdgou+gX
         DIAw==
X-Forwarded-Encrypted: i=1; AJvYcCV/CSjoY0M3yRm/sgIFGe15HEnsnX+pItlgbU+y4WjzvUD9aiZi7A0yimTKIh+UeY5Be2SrzxA=@lists.linux.dev
X-Gm-Message-State: AOJu0YzU9OZ2unnXNFOdwQT7L9ZyqftV5d7BPWQqwLlC63NdLtH6DhKA
	kVsUzX+v+ABDKNHj0TKonGv0M4O1G5ArLFhFYA+PLrP7xcTGSg/EhUL2
X-Gm-Gg: ASbGnctPUeUWq87pwStdl+38UoObUGdjjDXzo3hBgG0MkZnLLUqsiQ8klR32T4P+vxE
	m7fYlnwrYpSGN/JFOW2r1PbJar4LuMw/wPIszZq6TpAdzQvPARbmDXNqCAK1t1cZKpJZpjHBU4g
	86R4k840S9WivxBvJQbq/3fSD/iiJHn3uf2Gq+xOR/jvtQQdy4E/k+0rQq1/AKd84n2anA73Ht7
	IcyU6Q5sRquGLRUu9s47hiE3bWOFNdHjMqZvfUOZsEPSdenclG4/RSAyIgIkqLHB0zzmp0Ohr5M
	+VRVTFhdsA+6MXQNHtNnFhtpXag2GWl8uR2mE2BNHQxg6O5LZcBYcxc9kJAm7Rp2zTvmDvNOqLt
	RbMwXMAPwSBZjahjsXCxR6LZPY5NhGzqsbMix8XJJZ6cYYw==
X-Google-Smtp-Source: AGHT+IGeFwOgcx2BiZRTvdSnQWCMeJtnp0M7gNlhEon3I1UQqUGSTj5fxR7SdCplRAQzjxgQdmFNIA==
X-Received: by 2002:a17:902:d58f:b0:290:2735:7285 with SMTP id d9443c01a7336-2902735728emr343125225ad.47.1760497422453;
        Tue, 14 Oct 2025 20:03:42 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08de5sm180126235ad.83.2025.10.14.20.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 20:03:41 -0700 (PDT)
Date: Wed, 15 Oct 2025 03:03:32 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <aO8PBOMk_EqyaGKN@fedora>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <aO5X7368r8veRe5J@horms.kernel.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO5X7368r8veRe5J@horms.kernel.org>

Hi Simon,

Thanks for the comments, I will fix all of them.

Regards
Hangbin
On Tue, Oct 14, 2025 at 03:02:23PM +0100, Simon Horman wrote:
> On Tue, Oct 14, 2025 at 08:02:14AM +0000, Hangbin Liu wrote:
> 
> ...
> 
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index a64cef2c537e..54f0e792fbd2 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -12616,6 +12616,101 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
> >  }
> >  EXPORT_SYMBOL(netdev_increment_features);
> >  
> > +/**
> > + *	netdev_compute_features_from_lowers - compute feature from lowers
> > + *	@dev: the upper device
> > + *	@update_header: whether to update upper device's header_len/headroom/tailroom
> > + *
> > + *	Recompute the upper device's feature based on all lower devices.
> > + */
> > +void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header)
> > +{
> > +	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> > +	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
> > +#ifdef CONFIG_XFRM_OFFLOAD
> > +	netdev_features_t xfrm_features = VIRTUAL_DEV_XFRM_FEATURES;
> > +#endif
> 
> Hi Hangbin,
> 
> It would be nice to avoid the #ifdefs in this function.
> 
> Could xfrm_features be declared unconditoinally.
> And then used behind if(IS_ENABLED(CONFIG_XFRM_OFFLOAD)) conditions?
> This would increase compile coverage (and readability IMHO).
> 
> > +	netdev_features_t mpls_features = VIRTUAL_DEV_MPLS_FEATURES;
> > +	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
> > +	netdev_features_t enc_features = VIRTUAL_DEV_ENC_FEATURES;
> > +	unsigned short max_header_len = ETH_HLEN;
> > +	unsigned int tso_max_size = TSO_MAX_SIZE;
> > +	u16 tso_max_segs = TSO_MAX_SEGS;
> > +	struct net_device *lower_dev;
> > +	unsigned short max_headroom;
> > +	unsigned short max_tailroom;
> > +	struct list_head *iter;
> > +
> > +	mpls_features = netdev_base_features(mpls_features);
> > +	vlan_features = netdev_base_features(vlan_features);
> > +	enc_features = netdev_base_features(enc_features);
> > +
> > +	netdev_for_each_lower_dev(dev, lower_dev, iter) {
> > +		gso_partial_features = netdev_increment_features(gso_partial_features,
> > +								 lower_dev->gso_partial_features,
> > +								 VIRTUAL_DEV_GSO_PARTIAL_FEATURES);
> > +
> > +		vlan_features = netdev_increment_features(vlan_features,
> > +							  lower_dev->vlan_features,
> > +							  VIRTUAL_DEV_VLAN_FEATURES);
> > +
> > +		enc_features = netdev_increment_features(enc_features,
> > +							 lower_dev->hw_enc_features,
> > +							 VIRTUAL_DEV_ENC_FEATURES);
> > +
> > +#ifdef CONFIG_XFRM_OFFLOAD
> > +		xfrm_features = netdev_increment_features(xfrm_features,
> > +							  lower_dev->hw_enc_features,
> > +							  VIRTUAL_DEV_XFRM_FEATURES);
> > +#endif
> > +
> > +		mpls_features = netdev_increment_features(mpls_features,
> > +							  lower_dev->mpls_features,
> > +							  VIRTUAL_DEV_MPLS_FEATURES);
> > +
> > +		dst_release_flag &= lower_dev->priv_flags;
> > +
> > +		if (update_header) {
> > +			max_header_len = max_t(unsigned short, max_header_len,
> > +					lower_dev->hard_header_len);
> 
> Both the type of max_header_len and .hard_header_len is unsigned short.
> So I think max() can be used here instead of max_t(). Likewise for the
> following two lines.
> 
> > +			max_headroom = max_t(unsigned short, max_headroom,
> > +					lower_dev->needed_headroom);
> 
> Max Headroom [1] is used uninitialised the first time we reach here.
> Likewise for max_tailroom below.
> 
> [1] https://en.wikipedia.org/wiki/Max_Headroom
> 
> Flagged by Smatch.
> 
> > +			max_tailroom = max_t(unsigned short, max_tailroom,
> > +					lower_dev->needed_tailroom);
> > +		}
> > +
> > +		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
> > +		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
> > +	}
> > +
> > +	dev->gso_partial_features = gso_partial_features;
> > +	dev->vlan_features = vlan_features;
> > +	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
> > +				    NETIF_F_HW_VLAN_CTAG_TX |
> > +				    NETIF_F_HW_VLAN_STAG_TX;
> > +#ifdef CONFIG_XFRM_OFFLOAD
> > +	dev->hw_enc_features |= xfrm_features;
> > +#endif
> > +	dev->mpls_features = mpls_features;
> > +
> > +	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
> > +	if ((dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
> > +	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
> > +		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
> > +
> > +	if (update_header) {
> > +		dev->hard_header_len = max_header_len;
> > +		dev->needed_headroom = max_headroom;
> > +		dev->needed_tailroom = max_tailroom;
> 
> Also, maybe it can't happen in practice. But I think that max_headroom and
> max_tailroom will may be used uninitialised here if the previous
> 'update_header' condition is never reached/met.
> 
> Also flagged by Smatch.
> 
> > +	}
> > +
> > +	netif_set_tso_max_segs(dev, tso_max_segs);
> > +	netif_set_tso_max_size(dev, tso_max_size);
> > +
> > +	netdev_change_features(dev);
> > +}
> > +EXPORT_SYMBOL(netdev_compute_features_from_lowers);
> > +
> 
> ...
