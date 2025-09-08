Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0352F546E
	for <bridge@lists.linux.dev>; Mon,  8 Sep 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326509; cv=none; b=n+XNYtPcHYlwlR166E2TW5K93hFd8CpGmMWx9cJGfX4HpC/FVqH5Ld72hfxtByUGS0SiOaGxyuVq124etukig19tBMgNc0v8CEtjuGWDuszIPk1F+46WRSZAfDBNlJfr+qN4Lzq/2iyM8YzED7dLzCcH8zBiSJ0CmGagajS3CRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326509; c=relaxed/simple;
	bh=6ozCvots/0cK/aHfBrgVA5/2SJU6ubnb7OXVsugXFlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzcnES2+Tk7K1Q4XplEfETyHZr70L/GIULQFIFDH0xipJlc/+wx4OSZpMu9ePPIodPtPw6e2xhvOSV5Rs7HN9ttYVcfirKnggGJSxdHnjS6l+SYTlSJulEeh6Z99Dmqth8hGnMsIIp3kriwV1RDW2yX78oA6/VpHtAaKuQ2WPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbpgZB4M; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbpgZB4M"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4d118e13a1so2710639a12.3
        for <bridge@lists.linux.dev>; Mon, 08 Sep 2025 03:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757326507; x=1757931307; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bzi7bxFygC+YB7gCPxaZK0/rICKpzhlPHFYh1W+q04=;
        b=EbpgZB4MjxyJvGm9RWUHZDyDn1xFjsLn0EjqxiUhcNYD+X9siLaJAw0Bki33YenAl0
         Qq5lSZtsP86ITgfta8UiTXXV52KFi4wSTNBQFfwzCyZ164eHMneQhWeFy9gsxpssnDZc
         cgWk6y21/LSJhPDK957ykzCmSF2JlS1eRggIbAzrj0DAcVfQ7oYq46SkNhktJI2TAJXb
         JCmtm/svuDmGrtDH2YPuyDFT8KngDLSheoOKQQvZj98jn+0fddivDY7J7KfAD84g6J97
         IdSqBrFwTDFDAqAz64mvseTHu8se7t9XNxeNaYuMfkEijkvhriORxbuLhvGeD7Yc5ksp
         32MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757326507; x=1757931307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bzi7bxFygC+YB7gCPxaZK0/rICKpzhlPHFYh1W+q04=;
        b=W2uT1IhvyZml/BiG4wrRkCmiq8tM6SSez6PUcLda3AitqWa5fnInQXF/vEvafXa7Hi
         8zUY5DBh134XbjQ+3WC0wavAr2b1/PhsuF0aCvlgqPut5kXjnXPRmkDaftPSwN3vQPdM
         3PR0bM1NfAt7Mf/l+itnTnvN/06JeaezA+W5yRwLF+y0Ar4vEqC92qIzPcPdeLwChTXe
         /ZllQr/2nPG4shci0z2Ywfh7DBV46NKatCDxmr37EoLcGG5AyDY8b+5axmUy5+gr447S
         67xTgxODooFxWQXlq/XWDevvHRFaJNRkexVUu3lxF32Ui0RqRvkxRT+Cu5AtFvDlg4kU
         Gz5A==
X-Forwarded-Encrypted: i=1; AJvYcCWtuakNMANDngFznuhHd+DAS+OWJ6Nddn7bbufOG22tKBlE5zWpULKKuqlVNkw3kZOst7zyOnI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzOL1i5XttbSjqgTTGU7LWXNU0n50HjYcA2Qfl+EpPjuGMI9/KL
	CzCcxT4mImnxiRtggaCyGNR2hT6lPkzeYbl6TUhrHDOzc2k+hgcOaKGE
X-Gm-Gg: ASbGnct33CjzolYoWtolC6a2qsJKk3obLioGNuRWCIKwX9eNpvjOKg+/5lTqQgsbD6/
	1P+WXB9YQ9w2grsZK/VbwRwAYlSi0ZU5ARdINT8Wt2cgtMP15XG7eAsiTEetubCOJgKKci0fBqX
	WAOjRNTdiBnD1kq1yDgJrxkqI4T1AEppKIbzSiC1zoexj3MArc58gwphpofdLcu9Egsztvd9gfn
	LIyhejgtMK5FN0OBHAjy2n5QkD7+IVh28roslvkVq5pn2wvguhpd1UJTd7GBfshZQoBmQo8N7Qv
	YBtGleIe0TGWxr7SXZ8IfQWMtzL4A/g9Jj7fVYC+DgbZFM5BuPB02+A2UguBS/l45wVtt8RRFww
	pYJ2kRcazWcE4OmiSQ5YONvteQWzF8pSmYwm57g==
X-Google-Smtp-Source: AGHT+IG8/cSm9aQxxz4GWgIen1QXPZflkYhuxEhLBSz4BWVBymsXvWCknkmBf+Q0aGI9EiU9AzAGRQ==
X-Received: by 2002:a17:902:d483:b0:248:df64:ec6c with SMTP id d9443c01a7336-2516da052ebmr87462275ad.13.1757326506820;
        Mon, 08 Sep 2025 03:15:06 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b11833ac7sm173689185ad.55.2025.09.08.03.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:15:06 -0700 (PDT)
Date: Mon, 8 Sep 2025 10:14:57 +0000
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
Message-ID: <aL6soY3gEj-LIovi@fedora>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
 <20250902072602.361122-6-liuhangbin@gmail.com>
 <aLyoEiWnuvQ-5ODz@krikkit>
 <aL5YamjbZB5gsL30@fedora>
 <aL6jlYPhsPfDKT8C@krikkit>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL6jlYPhsPfDKT8C@krikkit>

On Mon, Sep 08, 2025 at 11:36:21AM +0200, Sabrina Dubroca wrote:
> > The esp-hw-offload is fixed on netdevsim
> > 
> > # ethtool -k eni0np1 | grep -i esp-hw-offload
> > esp-hw-offload: on [fixed]
> > 
> > There is no way to disable it.
> 
> I don't think this is intentional. nsim_ipsec_init only adds
> NSIM_ESP_FEATURES to ->features but not to ->hw_features, but I think
> it was just forgotten. I added a few in 494bd83bb519 ("netdevsim: add
> more hw_features"), extending nsim_ipsec_init (and nsim_macsec_init
> since I made the same mistake) to also add features to ->hw_features
> would make sense to me.

This could be done in another patch.

> 
> > After we add the netdevsim to bond,
> > the bond also shows "esp-hw-offload off" as the flag is inherit
> > in dev->hw_enc_features, not dev->features.
> 
> Did you mean dev->hw_features?

No, the xfrm_features in patch 01 updates dev->hw_enc_features, not
dev->hw_features. Do you think if we should update dev->hw_features in the
patch?

> 
> > It looks the only way to check if bond dev->hw_enc_features has NETIF_F_HW_ESP
> > is try set xfrm offload. As
> 
> Was this test meant to check hw_enc_features?
> 
> To check hw_enc_features, I think the only way would be sending GSO
> packets, since it's only used in those situations.

Oh.. That would make the test complex. Can we ignore this test first?

BTW, I'm a bit lost in the callbacks.gso_segment. e.g.

esp4_gso_segment
 - xfrm4_outer_mode_gso_segment
   - xfrm4_transport_gso_segment
     - ops->callbacks.gso_segment

But who calls esp4_gso_segment? I can't find where the features is assigned.

> 
> 
> > static int xfrm_api_check(struct net_device *dev)
> > {
> 
> But this doesn't get called when creating a new xfrm state. Trying to
> create a new offloaded xfrm state doesn't look at any of the
> netdev->*features (and we can't change that behavior anymore).
> 
> xfrm_api_check only gets called for NETDEV_REGISTER/NETDEV_FEAT_CHANGE
> to validate whether the netdevice is set up correctly.

Thanks for correcting me.

Regards
Hangbin
