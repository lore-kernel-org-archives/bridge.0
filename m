Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2D19DF5F
	for <bridge@lists.linux.dev>; Thu, 11 Sep 2025 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555227; cv=none; b=gcN3JuFBq4fVvFe7iJu9WtLRrvuDKBiXUo8xq4f1fyecv2MPsVAvHvw5cpBuPsNEvZlEWM+TC/XpyGCxuPLo/oRzvwLzHfixMssyNS4MFO2CcYLVrQ+FgBIFGGqBky2nbj4SMJBp46IDDHqRv5zkLQaeeOugRmjDoPXdMO9dVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555227; c=relaxed/simple;
	bh=gbU2qsb+60Hqlm6nQqHjpY15CNlC31/o71WvOU4PEuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxhMPaX4p+LvrPBcgZDl1A4pbZ+QsTSFwwCd1cyESszltbqEG4zG+QqsrRExB3TVXZVkfB0/bwLCx0czxYKGGsL3PGLJE/EHAwxY793Po1Ftb5S5RzQaqDNwX2FPOHeQFfc36bb/zsWgCAcDBjEJVF0u4n5McFCV0900SFwQJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbivQY+F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbivQY+F"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24c89867a17so1628455ad.1
        for <bridge@lists.linux.dev>; Wed, 10 Sep 2025 18:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555225; x=1758160025; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9EKHosBRxgYKkSKH5grw3haxNFNlpbShU8sS3mHvALk=;
        b=XbivQY+FZXBJ1mBDwUyuR2K44raioS50lni4cEuMjTvxgMnJpy7yncD3/QZhVehMUE
         7mwvfi2I1A2rxsoNXW3YWJEexH6qPC7gIIqJPRbsfSQJtpLqZEPyY6khMBauupDWpOBB
         OYQ7bwWsirRJH7Ym1JQFmIq4PO9rMk6wDNWqdmOxArfyi7+08XBnwt+Q7n5kQUVFEoJG
         j4uQMsuri2nGmmKDeUylFYWwsPNpWQ9eWIFUpmKrp2utCJwgyfZwZQqFPMLo8o4WH0Bn
         o2eKQt4NHKQq4NwDNitnHzCq3sDh/OUdkgzm7Ne4t0+xP5nw4nXcjVcSMP/10ol/hS7G
         6G2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555225; x=1758160025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EKHosBRxgYKkSKH5grw3haxNFNlpbShU8sS3mHvALk=;
        b=TwfUs3uPtYkarojPv9rxU3WP9A0eCXk+SB6GPRoAesXssdpaemmPfIl0LtlRm7tZke
         mD8nKAyBqhf6uUX/W7xRJaX3Tmyp56x4zIaV1w50IaBNHI/gMWta1hWI4w8SmDjEfaJu
         ZGrH1R5PkTJvRaqppRu66MaH7o8jN19ijMa0877Mtc/bKgmyArvjDdh2ti7VzOSzrlFs
         zd3QeBGC8ArE++uNHKgbL00UI1U9j2UqofZ7YCoJ0EJ5CAs5Hnyns8kfsKd1vvzO8vXM
         68aLhnciEjD0dZUR87kp4UqcC00B4ZzNgt9nWPg7kP0oF0TffXXVvYyLkYibIRiPl8eh
         ifcw==
X-Forwarded-Encrypted: i=1; AJvYcCX33pSmjY1xw+mriMjK+UfOIQVd7qZqblEJ6tzRfrRkFDuZrGrPL++FP27ULcgI1SoVc5huBbo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxzrnf7/nkbIU/1C2jjYP3Tj23bPsyWN82fwgz6FSOLkiK1+9N3
	VQ0aQDUMoMJH8Gh20agPj+oxPgiEuJjdE/PNJKiJ6mGyKCgbXpr3UJ94
X-Gm-Gg: ASbGncsuQui72K0TX6txspU9RqNqAbSBCBGYQsK1WrMm0iQ+GVObHsRkmwQM1b7gSXx
	lCBNvI6knHE0YqVAP4E7Jc5e6vRnsD/oh8gyne6dAoBGzImqfQQdCLy34O1f3KCtGq7yWs+K0YO
	EMcg2SIqaKhQodzEQxRZgu7o+xTJfDueqCtw6jMJBH6VfR17ZiYA8ec8KjC6i9xdLuCkMa60/YX
	AH4oIxnTpcjieHfublPf3kOGTVRntdnPezpkR1DJ7XorKKKCBxquLWTvM0DEgCfg2TCIM1CFX/L
	x6yL+XhVuj/Ce3LQZTaJCa6O2n+PFM/3xad2MRU1g5O+PAh95CzIGj/AZGc1/O9Im2BXDlapcQi
	1/lvr/mmy2Ii5Wyf2f7Trs/Lw+LOqu9hZ0/WDag==
X-Google-Smtp-Source: AGHT+IGUbHEB/rQLl+UqdSvAkEyeUvWOmdJPOZTNQ0SvY7LmtlnSpa1pNYdxeldQ71BciiP/DXGF5A==
X-Received: by 2002:a17:902:f78f:b0:24b:24dc:91a2 with SMTP id d9443c01a7336-251738cd8b0mr193771385ad.60.1757555225116;
        Wed, 10 Sep 2025 18:47:05 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a5d6sm1058435ad.93.2025.09.10.18.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:47:04 -0700 (PDT)
Date: Thu, 11 Sep 2025 01:46:55 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net-next 3/5] team: use common function to compute the
 features
Message-ID: <aMIqAfT__zvr32hM@fedora>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
 <20250909081853.398190-4-liuhangbin@gmail.com>
 <aMGZwEnJ943Rwf-Q@mini-arch>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMGZwEnJ943Rwf-Q@mini-arch>

On Wed, Sep 10, 2025 at 08:31:12AM -0700, Stanislav Fomichev wrote:
> > @@ -1976,27 +1919,16 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
> >  
> >  	err = team_port_add(team, port_dev, extack);
> >  
> > -	if (!err)
> > -		netdev_change_features(dev);
> > -
> >  	return err;
> 
> do the same `return team_port_add` here as you do in team_del_slave?

Oh, thanks. I forgot this one.

Hangbin
