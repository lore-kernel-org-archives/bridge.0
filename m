Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F8224B1B
	for <bridge@lists.linux.dev>; Tue,  9 Sep 2025 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757386501; cv=none; b=foCmDLM0PkpHHo6UrIjhyX3Plfpy7N3Dg6dEjgrhirrm8fabxwuKypkChFc8g2OjtnwXfmVV5YFT7fHyw2qo8cw+cmYByBQXT9NmXt6anOQoZ9deDaN+UYOx91L9Gow5UCaH1mLSWdpQ70ix8IddN9h0bWXtGtpTRxWVCu0KrA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757386501; c=relaxed/simple;
	bh=SODWK8iRJW+Kd8ixS7tgSWOcjpMFP1OafTXxlBzMwMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzsNUd9gwZRwxQsK6QhLwt469GNS0Yul2/t9fujYji2rhn5ihnA+zbv80l1LFC4VxIq7bDc5Sl6tnnnyKMDzMi3FdT9jSRZXHfUkY8VH2iURpQeqs17WwY+J+WljjImoP7NQMcoZ52UoODCx+7/71CwPOdY7uBhv1NEo6LS9Jbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSylk1/8; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSylk1/8"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4f9d61e7deso3230047a12.2
        for <bridge@lists.linux.dev>; Mon, 08 Sep 2025 19:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757386499; x=1757991299; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=on/vw6koKUQbJCI+KSSCTjkF92ULMha9wVjXRly0E+U=;
        b=YSylk1/8VSuT/FiSJTw54xMw6Z8RtrH9kKCvK/RjKpyHO6nvOc6L7XmIFusnLVx373
         EC984V/g5Jzfv3F2fpz8uDHogUCns/QaMNW/Lbg08GPA+izpopkEfFeMiRAliA2T/FHq
         pllOXw/9j8skEN4b/VwWujo9/XIzZqmzkn49jhgm9BFtqLdExnuPO5waDycgYXqd8g+Y
         3qx+iZOT0GKvSMIJynCjqOK4T00BVfxMuxPQuZlCtNt36DTpv4byBKFKvWIKm8BTJHqW
         e6ag2s8jjd47RYGfZNaEOPe2xBFdPUSESQ7IljQRR/iVoDVx7QY2Vnws280nDg/TAzUY
         3h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757386499; x=1757991299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=on/vw6koKUQbJCI+KSSCTjkF92ULMha9wVjXRly0E+U=;
        b=o+9iIs2yNfV6/hdxfRafzlvdekLg+hIuXpYiegl4zS82/41QkUx46mu30lZsMmVSZQ
         LdO8iMTanTjflJqwJRk1diSwCTqHaILJVjAby45hEfWfKDOhpPoxP3bX80rlJxKg+2K7
         1BGzo6gJsc/68YIyNJFWgTuGlpTeya8xR1yU3GhBDTnOgOV5fJ9QBNIsZuNrg1/D2CuZ
         NkKE0W76tlxKOuzoqIkUSMVh8mjf1nTHjmjA9D8jAng2y2G7pPvSN+pvWaPRrdgiR5gY
         JPvBXSUBjcNURW1GGICyWxfx1Z8pkP+mcIai85z3MJYXF1MynCRFaynQ2HYrVvcXapdc
         7NQg==
X-Forwarded-Encrypted: i=1; AJvYcCX2C/EiQJWAMZuho1xan0xWA/lIfm7Zi1a7vep/Hy8m2IHX42IqEjd1/XuUfnIZyHcnY4fSbGY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzSv4uadeK5qzVzp+DlT9sktP7Hzdsj1rAUH0XJvnbkTyW5IG9W
	ocywbgEzATvvP45UovF+PtYV3n7ljyrUZ+xa/OVEoqEqQkXjaupMBHdY
X-Gm-Gg: ASbGncuafH1Z/SIhll6Jn+wFyH6rB2wifRDMcj2pENadL89CZ2dfDT5M+CboYfYNr9h
	4LGROtdTn3jDdGh4rfY25+BkUYxBPMEg/t8u2w5vDAB01GLpbbnX+AiI06LRjTa4fV6wZFuQm9S
	Goe3TMfoyG1SjVqFy3DyjUUpd8DX57Rr9YR+gkqxbBZPyY1jSpiezwLE0dZYssRccGEXei8RVfV
	YTlkZw1ElO/+pV/dFhvQJnuDohWsKPQG7/6JYH64lXEWcjLinjloOE8e/RC6vC3zmIu+l1H+2qC
	Qaqv2DdY/FNYuAAV1iMbLcqPIwFVcdRSUCpTnn4dVvbjSZ87l51ltjBwODV9aDgLc2pxB9wxbce
	5SyXBeQ5H1m1IkMA9GOwOKxVRphIcceZxL4HM/g==
X-Google-Smtp-Source: AGHT+IG6fQEprMYRmastVBiiyh6tI+QaloXPCDm6oS/Iuu8O/6MRoczfFOWee08VD0/s5rJFKkaB+w==
X-Received: by 2002:a17:902:d510:b0:24e:9e47:2327 with SMTP id d9443c01a7336-25170f37b63mr143674305ad.30.1757386499327;
        Mon, 08 Sep 2025 19:54:59 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cccba6624sm127708925ad.99.2025.09.08.19.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 19:54:58 -0700 (PDT)
Date: Tue, 9 Sep 2025 02:54:49 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aL-W-YdGWOxgpPar@fedora>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
 <20250902072602.361122-6-liuhangbin@gmail.com>
 <aLyoEiWnuvQ-5ODz@krikkit>
 <aL5YamjbZB5gsL30@fedora>
 <aL6jlYPhsPfDKT8C@krikkit>
 <aL6soY3gEj-LIovi@fedora>
 <aL9PSoTwhn-HFWrH@krikkit>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL9PSoTwhn-HFWrH@krikkit>

On Mon, Sep 08, 2025 at 11:48:58PM +0200, Sabrina Dubroca wrote:
> > > > After we add the netdevsim to bond,
> > > > the bond also shows "esp-hw-offload off" as the flag is inherit
> > > > in dev->hw_enc_features, not dev->features.
> > > 
> > > Did you mean dev->hw_features?
> > 
> > No, the xfrm_features in patch 01 updates dev->hw_enc_features, not
> > dev->hw_features.
> 
> Ok. But hw_enc_features is not the reason ethtool shows
> "esp-hw-offload off". This line is:
> 
> 	bond_dev->hw_features |= BOND_XFRM_FEATURES;
> 
> (from bond_setup)

Ah, there it is. You remind me that I have a bonding xfrm feature patch
not posted yet.

> 
> > Do you think if we should update dev->hw_features in the
> > patch?
> 
> For dev->hw_features (and dev->features) maybe not, since that depends
> on the upper device's features and implementation. I'm not sure we can
> have a common function without changing the behavior on at least one
> type of device.
> 
> But maybe ndo_fix_features could use a common
> netdev_fix_features_from_lowers? bond/team/bridge have very similar
> implementations.

Thanks, will add this to my todo list.

> 
> > > > It looks the only way to check if bond dev->hw_enc_features has NETIF_F_HW_ESP
> > > > is try set xfrm offload. As
> > > 
> > > Was this test meant to check hw_enc_features?
> > > 
> > > To check hw_enc_features, I think the only way would be sending GSO
> > > packets, since it's only used in those situations.
> > 
> > Oh.. That would make the test complex. Can we ignore this test first?
> 
> Ok for me.
> 
> > BTW, I'm a bit lost in the callbacks.gso_segment. e.g.
> > 
> > esp4_gso_segment
> >  - xfrm4_outer_mode_gso_segment
> >    - xfrm4_transport_gso_segment
> >      - ops->callbacks.gso_segment
> > 
> > But who calls esp4_gso_segment? I can't find where the features is assigned.
> 
> inet_gso_segment via inet_offloads[] (ESP is a L4 proto like UDP etc).

Ah, I only saw ipip_gso_segment calls inet_gso_segment, didn't notice
ipv4_offload_init() also init the callback with inet_gso_segment.

Thanks
Hangbin
