Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E51B424F
	for <bridge@lists.linux.dev>; Fri, 17 Oct 2025 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669651; cv=none; b=kWKafJjgRT92my5icM11FqCfjH+c5XKyAekCHMazzJhECfXbo9yrgBCCxfhD5OUYcsuNYD5MCPbdD9vp7VBK8XQZsKhmfHuHgPXaDRFED7tSEs4MNP1qXg05RN/w+1EMtc36PoBTS215L+ZPZN2/dJGUvzSqlsbz5c+1FEWukEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669651; c=relaxed/simple;
	bh=8NiRwe3AAfFzQraWgyYBbLfsnHjwYW4yzgTVKceBqbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvJ9iq5SL7iIIcqs2AqExb/cgg6z7zB5NvGXgAQvpKuJHZqnMIn4aySZ3A6S3b/Szuf2qEUY/AtJ9TdveLLZ1FnJYv3262f+GHu+YNWHZD/328+O//KlztAy2ZFdzYgqRnqqs3+1Gp3knDGIA/0XFFO/RtIqwrIbBb6Uq8wy1/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDXAYdrJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDXAYdrJ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290dc630a07so1287735ad.1
        for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 19:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760669649; x=1761274449; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSQYaGp05AgjNcRCXlpxVBC+oAL0afxX158+woz27Ds=;
        b=WDXAYdrJ5TD2YZxo7ELYsiuMHZRvf+mJgrIx9WHnEgNKY/ZsxIg41n5ZO6Sjupiw1G
         f/JzuEtBC2wudEIddE/Dsvnc+c5WdbPhIMD1uKsXluvNp9I2GtHPngK/v0zwtw7D/33i
         Aq1qd2NJ/YxM50y/bzkrN76IqL0OciIG/RljhBW0t2xa05eg2jyWSt/Q8ttVrVeQUIQN
         Rr+Xx8ofuUrHZLP5j7iBncSFRSkPbpVjVWiFYNWzPtiT2uEbxvvzIJyNfZQk8HYzAE1G
         J8bExKxq9xMeAiyBx6FZksPVomkxM63kH89zIcMpucAWU34N8s0W3iRutKsYR5IRFbFy
         8syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760669649; x=1761274449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSQYaGp05AgjNcRCXlpxVBC+oAL0afxX158+woz27Ds=;
        b=E+s9z+lAj0KI7j5Ee4MdvzghqnimyX8ssAim7nMsBATWydyKFwP86+gMtngHBrq9JV
         sbmDpVm4I6SHYmAF6VzqKwcD3B380EYC7mcjWzcdK5QgWwidEhccILTUPeRHQpOjPVxr
         /5OGz8qQ9GTwWCBs8JOV4yZP2WFwWfs0kAH3hkHAX7QUSMq88UiAV+ajWmzkPk5EnFBq
         tUj9QN4mmcyjzxmJlgDEc0bh6b9STAxDB9FOcPRAWva5o+fF0p9rrrSndv61uBAHgf+X
         SwzTQH8m7KFGTwz7NGfGTYM2uhNr+u4UKKZEuRxE1M7tGvVaBfhIejpTdGtaQwCXtot3
         SVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu1WtpmThmyukb3YB0iMh6omaeH7Kd93WSkzQon4meacit+nvQj+NMDhlw9My/dcD+IvyQAFo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwFq+uNfDfDKtT56DOPXEkzTJvX27uS6EhvG26hugwQk9JgwpwL
	6BrGM5B7+nEEgLcIeyxVQfm3hbwXtW2HMPRZxgaCboDxF+6f8owgNWDm
X-Gm-Gg: ASbGncv5qwcmNvJRjG45fTPIhPR8QNJptOERLJ8+imzaMg4lW5U64EtNS0CumTfpBhl
	XVaFztEKIJkOFxwtcBzqqo3dumtqKMDCFTd1OBEB5ccsico+22o+YwhKNcmRuBrXjLZAFSAsDiM
	jNVagnnkiZ0MEgMQex6saXCZrvToO2C9FVIeIrsure+/MkpbnEUsFloMSbOfejqh5x9KfzGV5iu
	vPiu0wVRB4Xv+ZRNqUUJi13dltvmWMweyf080gcy24xEkE2T/S8YtjNQnGA7JdYiDP5nDtLazMC
	kbuSxWXpSOHraMzeSLAIl4WVfsper/n6yDEBrvuWswlRxoCLV7mEkbnHlF8KJMT5iQ9sj37Z9B7
	gT4fkCSKMqidTCnEBSRLjFjOi2svWYFnnFyvNt5v8cOlKDPVKu4Azm64Yhj5zYAh1uY4remtpqX
	VfJvA2
X-Google-Smtp-Source: AGHT+IGQi3U8O3cPAK1IhHTZZ8syKPaPbEumFj3MTl163+GXW0epQ+kNRrCWpnDLoeWcdl0oOcSMxw==
X-Received: by 2002:a17:902:d60d:b0:28e:acf2:a782 with SMTP id d9443c01a7336-290cba4edf7mr24841635ad.37.1760669648941;
        Thu, 16 Oct 2025 19:54:08 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c23fsm46176465ad.74.2025.10.16.19.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 19:54:08 -0700 (PDT)
Date: Fri, 17 Oct 2025 02:53:59 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <aPGvxybFp42UN_f5@fedora>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
 <aO74J20k16L7jS15@fedora>
 <to4zjjo5wfd5suootcy2v7n7kuc6rym3ld4jov26nunnarji2u@2hr7jyiq36pj>
 <aPDnN072argrq23q@fedora>
 <fw4pvt7morcydktpqmmotab7pyvbixhrszgdfpl4dut52rfesf@4fztqcywdwpm>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fw4pvt7morcydktpqmmotab7pyvbixhrszgdfpl4dut52rfesf@4fztqcywdwpm>

On Thu, Oct 16, 2025 at 03:24:59PM +0200, Jiri Pirko wrote:
> Thu, Oct 16, 2025 at 02:38:15PM +0200, liuhangbin@gmail.com wrote:
> >On Thu, Oct 16, 2025 at 01:27:00PM +0200, Jiri Pirko wrote:
> >> >> How about "master_upper"? This is already widely used to refer to
> >> >> bond/team/bridge/other master soft devices.
> >> >> 
> >> >> MASTER_UPPER_DEV_VLAN_FEATURES?
> >> >
> >> >I'm not sure if we should avoid using "master" now. Maybe just UPPER_DEV_VLAN_FEATURES?
> >> 
> >> Why? We have "master_upper" to point exactly at this kind of device.
> >
> >I mean try not use "master/slave" words. I'm OK to use UPPER_DEV_* prefix.
> 
> If you don't want to use that, change the existing code. But when the
> existing code uses that, new code should be consistent with it.

OK, I will update the name.

Thanks
Hangbin
