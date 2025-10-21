Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9292EF66D
	for <bridge@lists.linux.dev>; Tue, 21 Oct 2025 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041141; cv=none; b=oeNMu7Hhc+baQM6lWM8Z5FuP9yVb7d2PQD5ejrfFvUKqrk8LDxvUfqLCvOFEZUtMW1mp96RSrEni5l0kIKwim6ctvZ0wsk5KqyWjrgBnHUAmwSlzGO3JqTRFstmg5aKIYbAW40gh5rOeaJucqUKI0xJazMuUJmnQvz/oeVyAJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041141; c=relaxed/simple;
	bh=FTOsFMG3yp3pBDy8xOCbJF+xRG784OPBIBrqv7Flc2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3C18ok6RyrzBDg/4kmSaRivo0Au1q5d+7ABLlDObkcDDfng0LSrfrKPg9LRwP0AtK+bCCp2sTZwQGXBoXelwJjaIyO9D+jy93l5GvDLlSmbZb12uC5h6pIl96v8ZKuA6maIdpU7hPXvnM8FCOh/YKL1pmSo+atj5mWnJMlNCG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqPBUdax; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqPBUdax"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f343231fcso3653323b3a.3
        for <bridge@lists.linux.dev>; Tue, 21 Oct 2025 03:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761041140; x=1761645940; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OK982plIE5xTlCsEWAT0p4OG+z+MqKJ2ACtf5l2iauI=;
        b=NqPBUdaxh204rcW13zppr5bjpsoLua4VD6Ujp6gelMP8Sf4pJYRax6j+NA11yjpo0P
         UkK9cvOa2pieln/CS/wDGM6lfqfI5uiBnwM0cfoe+EfaSwMFWx1KcWKRg32kAFNTRHvM
         pu90hr4IOmzXAzV2Rc9xcXp5YcbBYALXN/AHMX+LZySQAAYyPttVd2MEYz3/IytEcZ27
         GWnPmDOXLahqQBVHZgAL1BXnnrUannZ8XGrOIbrOK+U+07/7/UVS+r3y4d1P1HZ9XAYF
         2t/li+2NR5F+sdfVi4wpMfsvIrr1QCpyi2QGSEkfrx/wslY5Z/iAaRhiH6ufy4sWbSPt
         O/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041140; x=1761645940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OK982plIE5xTlCsEWAT0p4OG+z+MqKJ2ACtf5l2iauI=;
        b=iG4GOC32rbS5PEoDRr2MUPsdLKH7NeYYyU0RguEYfOOggYJIbYvqO2Yn3wzx1EsSWp
         3WBb3613QC41z7CnFzhHsvWQnsMhFlMVY4T+mGYOBC44DcTDdoNt28prDyITFT7zzHaY
         cvAZEbYVVfXZaKDVwRpl7uoI8z5kdURs7SruiHV4lgbgqZFlGjF6WRAs0WanoW9cuJxa
         TO+cSDyRxgkW1ip/MyTYoQ5yISdTC3SZWXQ8dt9m0Cy9wH1PK838gRkaNu+7dG1B+oYR
         hwbUglTPmXdCIjOoFnvcC6u21t9fP7hOBf+DpSHs5CEFW8UoQJpzGm2z+EwRj+6goCJ3
         0dUw==
X-Forwarded-Encrypted: i=1; AJvYcCXUGIdG4iyGYD7kUqVm2MiOGv6J7L7bfPJPBp68XYstUi4PR4SS5O0IhZ8POBi6uTyZWWkSVPk=@lists.linux.dev
X-Gm-Message-State: AOJu0YwkEHsZXUNG/Fwrt6Zxr+dGJhpj/GIofBOBwFcQSwa9nCSXDkst
	dX/+PWOw0ZIX3S6hX+6GYbBXhLtNSILYwSKvo5mptyUVGdzKyNT44DUb
X-Gm-Gg: ASbGnctK2fOSiU/N4J07w5jUz4cUEUr+DugHGt+LMuWdFPfLiNN6pTtAEL/vaikz9XQ
	09kYyFm9UHqw2D3Xuzv2O+VFmtO/G9pBxt5aa4mnVch6oPR9tVJ4pIr9Yq6esapDW4h6mfbd/Ox
	GqTTVi/2ZRdApvn8GTKYvjxFB6+1Aag9hIKKmOdefJ/viqxczWHf71pUsGDyzwVDKyTwt0Vs/zI
	Pzgy6mBVilzZxekrF6UrztYtNbTVlunyyhw6LtNHSaajsyFU2zO5f6Alay/LWv/xlx2HTm8yePv
	E9PhdV89FF1c5hJ+kVDfKq4h9BjC/17UEwGs8CxyHgBeLSSj09TpDn/VL9IBbC0Lft9HpAQuhBG
	CyaM9SBtQ4CYagLBSYdrHjhCAdPo9R+66akfgbANzKxPhJhK9SO53KPuo106ps9B3nFKFi5mHTi
	93co4H
X-Google-Smtp-Source: AGHT+IHJQ0BdOK4jZyJacNzTC1eK//itHFo/MOna8+vtP/DHwBgPdvCVlQ4hYf0g7EVbWtGRbkRLqg==
X-Received: by 2002:a17:90b:4c0b:b0:32e:d599:1f66 with SMTP id 98e67ed59e1d1-33bcf8fbaa0mr18152011a91.30.1761041139455;
        Tue, 21 Oct 2025 03:05:39 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7664a228sm9783349a12.4.2025.10.21.03.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:05:38 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:05:29 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev
Subject: Re: [PATCHv6 net-next 1/4] net: add a common function to compute
 features for upper devices
Message-ID: <aPda6cAl5UK1g-ze@fedora>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
 <20251017034155.61990-2-liuhangbin@gmail.com>
 <aPX8di8QX96JvIZY@krikkit>
 <a2e85a2b-58b0-4460-ae7a-b1ea01e4d7e4@redhat.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2e85a2b-58b0-4460-ae7a-b1ea01e4d7e4@redhat.com>

On Tue, Oct 21, 2025 at 10:46:22AM +0200, Paolo Abeni wrote:
> >> + *	netdev_compute_master_upper_features - compute feature from lowers
> > 
> > nit: I'm slightly annoyed (that's not quite the right word, sorry)
> > that we're adding a new function to "compute features" that doesn't
> > touch netdev->features, but I can't come up with a better name
> > (the best I got was "compute extra features" and it doesn't help).
> 
> I'm not the right person to ask a good name, and I'm ok with the current
> one, but since the question is pending... what about:
> 
> netdev_{compute,update}_offloads_from_lower()

The naming is a bit inconsistent.

We originally used netdev_compute_features_from_lowers(), but later changed it
to netdev_compute_master_upper_features() based on Jiri’s suggestion.
Following that pattern, maybe netdev_compute_master_upper_offloads() would be
a suitable name?

If you agree, I can post a new version. If not, we can just leave it as is.

Thanks
Hangbin
