Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7534316E
	for <bridge@lists.linux.dev>; Mon,  8 Sep 2025 03:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757301626; cv=none; b=dwnSYTpTdQKe11dq922AQv2OdC2yNSaXfCApyLGA5lrrjV7ea6gXOcbOyW/5GrsqAqewaIYbWIXc/Re+4gfX0Qgje6J2cdVWgEiiiCT0/lSsegrZZIGYALgevc3+NEIxmUEd70zyzIUpbLzxqb6Rt3Qc7IWc/EasJd/cBu7AUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757301626; c=relaxed/simple;
	bh=EwhzMYqe1Xj2utRfYFtfhVdLaa1Zk8lRWqZlK5EdRBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNPrkrEDLAfNpnebEG5iki0nuXsw8qrYbcWKYonYJE/584iHf7T7pVSwa1CutrpnYCf+4ahjahdHnjf8tltg7ZIAqWPi7TxyjiLH4FMy6V+xsPoGV71WkF+HsNfIRMhmkCkB5IjW1t325HScRgm0Ro2NBSeKX58DUi0sIgLDO9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXojNA8g; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXojNA8g"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4f9d61e7deso2479054a12.2
        for <bridge@lists.linux.dev>; Sun, 07 Sep 2025 20:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757301624; x=1757906424; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nQuprz9+iPOc6Hdx8EJtvsGxwZd1/+5PLT0+hvaev0=;
        b=kXojNA8gZefDYRZHe59/xzc9eDq14115wGu1ReJsL4EqaRvWAUJg9HCD6WwHoeCdQt
         hHXGFYB+HNVnNGb3kzqDQgFMQBo3Emqhv+FBm5qFXAuO40OgvLcQYfQURfkoT2xY9QuM
         Q2xk5RHGsDxMjOr1RTbkcYNKi7MwvPcAp4UjCOEIKuGi5wBX2upSukquYJYww+jKKgRc
         SG0hGDBtw+2TFd2WH8wkPys4S0WyHaAylotnSwBpxTZRh6UTaWWJ/RLqbI3+I0/+LtpW
         LV+7hnmjlkSlcVSY00lqyfYld4mpCj7rFgCzUwVvb30et7Zo8kNosOVrykJywk1rv0nW
         jYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757301624; x=1757906424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nQuprz9+iPOc6Hdx8EJtvsGxwZd1/+5PLT0+hvaev0=;
        b=p879Mwr52Ltp1c5c5r+sDSL7J64LqkmaunatlhVO/MFCN0yV9/9IDdzpKwTPfyHCov
         Os4zX6rX+Z8tejJadldsnUHabN6XuaC65qwCG52waC247ru4pgghdanJlOmgCus0A7cT
         YIhaPIdrn1YbtgcZ14Q/nXFNkGxwgBDRZmnEvhJ9kKWmcqlEvRT0MojfCXvU2iNEzq3p
         xlfjsXnbDHPL1trZVUz6iU/u7DVgDZeV9c0sKZmp8C97Ed2ITZOXyCozt3xsZkHD+Bhy
         /QgRXIg5pthIoostXCw9a1aO+NMl1XOmtxIjXK/lT4flvsT6hGB4mlXV++nCUKTyfy92
         O8GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGbG+GYQjB9bhdT7EiHYzXtvHu2+GddaVhA6Y9sCY2FWJ+ukoynt1E4XAAMKOGQ2Amc031SBU=@lists.linux.dev
X-Gm-Message-State: AOJu0YyKBe50ViGxgRpOX5rTxpHRXHE2ZmZtbcjcIZ6I9lasafv5Gbj4
	3oR9pmcixU0RQ06h98Rx3zkbXxn0CIjLQYvUY54aY/GMpyIUvlSBhKb7
X-Gm-Gg: ASbGncudSnerT32ebYJcm7IreehL2RWDNTLyT++lQuSAKbN/YzN52/zBpaILxc/xpw2
	VatKGH4nKC1CrG1qoQDFdwmlCkYePppBUtmg4Sh8wO5TZoyWn0UJTkYOmSbzi02E68yALP8NmUU
	wQFMydzUuBPdUm5J+0pnO4dfS2fjbplF/OYDmLKtX/QmIe++ZwHI0YraFD8tGuDuaC3FNE5aQNy
	WQbXOIkV6MVohmu9kgoXeDZZUAy7G+rx8GaNsJWRo0M3FZ23i74bFn/C5SqNmVK0dTy01o71v16
	FY+TEdgGw3eiVp/qzmZxA8wD0Otz/Emkbn4DzFRQ2yl+owwzaih0Dpnij8rWMNQpmeT6C0AB5BA
	6dlZkNbhWSGa2JJshMBKJiAH0b6GIRu8nEJhhrg==
X-Google-Smtp-Source: AGHT+IEoSQGXZbGinmecOf/ZXQarNjfG39uhHBUMWGfk8LR5uTWXBfvqzZzxScLZFpwuRvqXf2Wc/g==
X-Received: by 2002:a17:902:f681:b0:250:74b2:a840 with SMTP id d9443c01a7336-25172483a34mr95832515ad.44.1757301624231;
        Sun, 07 Sep 2025 20:20:24 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24af84de7a4sm176247435ad.7.2025.09.07.20.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 20:20:23 -0700 (PDT)
Date: Mon, 8 Sep 2025 03:20:14 +0000
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
Subject: Re: [PATCHv2 net-next 1/5] net: add a common function to compute
 features from lowers devices
Message-ID: <aL5LbrPejURWELEo@fedora>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
 <20250902072602.361122-2-liuhangbin@gmail.com>
 <aLxymFjpPjckFb2Q@krikkit>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLxymFjpPjckFb2Q@krikkit>

On Sat, Sep 06, 2025 at 07:42:48PM +0200, Sabrina Dubroca wrote:
> > +	dev->gso_partial_features = gso_partial_features;
> > +	dev->vlan_features = vlan_features;
> > +#ifdef CONFIG_XFRM_OFFLOAD
> > +	dev->hw_enc_features |= xfrm_features;
> > +#endif
> 
> I'm not completely sure we want xfrm_features for upper devices other
> than bonding [1], but this will get overwritten immediately
> afterwards:
> 
> > +	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
> > +				    NETIF_F_HW_VLAN_CTAG_TX |
> > +				    NETIF_F_HW_VLAN_STAG_TX;

Ah.. right. I need more careful when change the order.

> 
> 
> [1] those lines in bond_compute_features were only added alongside
> bond IPsec offload, see 18cb261afd7b ("bonding: support hardware
> encryption offload to slaves")
> 
> but AFAIU hw_enc_features is only used as a mask over dev->features so
> it shouldn't be a problem to have xfrm stuff in bridge/team as well

In this case I will keep this setting. Putting the feature compute to
another function will violate our original intention of putting
the feature compute together as much as possible.

Thanks
Hangbin
