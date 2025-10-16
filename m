Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319272E6116
	for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618307; cv=none; b=TYlS3YQpOkPVsGaY7VxeS2Tp5SDQ3rHBDwesg6O8fHCffre1CwGC9e1hHjSp7iOLPHc8mtHXKAF5zQIykuPTHDSvrqH1DXmwWlN0UniOCCs4QnL7gI7O9ORnT307oZuvekHICqNmicJjhxueBg19E2yqz0nTB+TElLjgKIIXxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618307; c=relaxed/simple;
	bh=Dd9bbstWTxKW6GEQKajDsyfE3C38pzh8JqnmYMwneUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noebDaYp8gyReyShlcdYqT9dIqeadimy3koGf5OxKNhVlZsI7nqrRKKmEEX8P5HnO2BHx0/Tlfa0cNCjRBsgP286sdu6hr+o2dbqMONm6ACY4CPrXv9Huvrmwd7JW6GKSwvvKtJN/hKTbZ1ztsaKqsJFpCChU64Dmn/tL8mr1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlaNi662; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlaNi662"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781997d195aso560332b3a.3
        for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 05:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760618305; x=1761223105; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzn3hIsMXxvxQH6Pl2+jyVSLI5DbYlEg7TFGTWc7hzg=;
        b=NlaNi662AGj0diJVV4EW1ySPjiEPRBz4D3RsHZPB5SO1ydEOAiXJThAAJxjZAHKVbR
         OP7zukoNbrKG2r0rcvlppqbFS888TAavlh/3foRGdxqzCB1kjsVyRzeQsvisucvVBtDq
         T3qfYfSQ6w03I6lhH8xqyQ5Yz+jtp2wnKmYzTF7m6IV0lK8XeLegUrqgDRchh/GDJbAp
         seh8r0wPcSFm5brwNsRsV/IodbdnKvH9/L1MUJYp183AGCMWBJTR2savqEAtOdeu9de8
         PnE88XayQ4BEwrSvbvLxjFzDiylXUwvjZmrAY0/yODhHts6iqycby4iXOmiWrxm72fkl
         JJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760618305; x=1761223105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzn3hIsMXxvxQH6Pl2+jyVSLI5DbYlEg7TFGTWc7hzg=;
        b=evQpeCv8w/D9mR/MbubBhycGrzsG8xprhsf3huAGSqfyOVJwxCXEqMAesB4wyXFB7e
         FZtDXpzepObdemkWf0Kz2VS1CdTiJQ84KwdYS+Nx1pJYVo0mrXcukleoAUoA/lX6yx8H
         kwEEDmc4z4K8IW41QI0dyf6LSHQxGafnIrF+JF856aJzaAJEb55BqJ1IJacQ4utSTJpL
         ltkFZQnKsRAzeipSOqhAOMpHVDSd6cGDOD2fGaAafVo4AekgsojswLHhZ1v7SNvxN2AK
         w3tKGxRmySqu8eyYgiO900OxD68RXw3ALdZhUPAzxkLve95TW0eINIuzJh17Ge8Slp/G
         DVSA==
X-Forwarded-Encrypted: i=1; AJvYcCVeDMWxheW9VfjB2rt7F0B25260TI5FGADFFOV0fORoM3/645OeFgtq0fSLMQTBroHcYNGB5yk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw53i4nsk1xKjED3L1lgR4gNDhSUaQRVMLgfI6Preg22ghn2kbd
	NXRVfBeQK2E2OlTIK1CQ92ZZ0PijbRJ+r2QmDiBZn7egM9H8YjhqwtLo
X-Gm-Gg: ASbGncsmgZcGp+9SZMB0II1ToRj9002aNFKGH53eiXIXYphYFY1JiCoJFDFtIf8JUCr
	lmuTc94z26jzQiwCoX7COtGcV2wGKbLELiprUX2SkSbAZxcpzzbaBHIXminljVkutiZ71mF7KT3
	JvFF4DQyaSPuuXJdhvPJDid0DDTWCGw0iR9crSmWyg2awxr4txdfkwo2vlzIdc1Q835P00Epzy1
	QWxFRSYV2DQGe1dpZ7BBGjgvDRaqYlC8/eG6c74au/aeOqu3olL23Zty19WfhODxQT3WC0kvbQ/
	0ho+m1tWyc8LsjfM53lIk6cQT31OcgP6cIby/7EiOQjEYw+a7KamiNE/Qnu8iT1bhwGGY0wwz8y
	GCNuPMlZdUJSkCRwNimpPM5B8uz87xTN0KekE9Vurk4/NyDLwzb+UEY/6kDmGS7W2wwxXziFkkS
	sAb+P95IYiLkkavmU=
X-Google-Smtp-Source: AGHT+IHaEAqXhlDDVHzRiYiU8r+iTf++U36IibLSmyfdTTGveuzbh0DYZipswjt8IVOLHS7FMFSoVw==
X-Received: by 2002:a05:6a00:92a2:b0:783:c2c4:9aa5 with SMTP id d2e1a72fcca58-79387d0f5aamr43386468b3a.32.1760618305303;
        Thu, 16 Oct 2025 05:38:25 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09aa20sm22165667b3a.39.2025.10.16.05.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 05:38:24 -0700 (PDT)
Date: Thu, 16 Oct 2025 12:38:15 +0000
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
Message-ID: <aPDnN072argrq23q@fedora>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
 <aO74J20k16L7jS15@fedora>
 <to4zjjo5wfd5suootcy2v7n7kuc6rym3ld4jov26nunnarji2u@2hr7jyiq36pj>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <to4zjjo5wfd5suootcy2v7n7kuc6rym3ld4jov26nunnarji2u@2hr7jyiq36pj>

On Thu, Oct 16, 2025 at 01:27:00PM +0200, Jiri Pirko wrote:
> >> How about "master_upper"? This is already widely used to refer to
> >> bond/team/bridge/other master soft devices.
> >> 
> >> MASTER_UPPER_DEV_VLAN_FEATURES?
> >
> >I'm not sure if we should avoid using "master" now. Maybe just UPPER_DEV_VLAN_FEATURES?
> 
> Why? We have "master_upper" to point exactly at this kind of device.

I mean try not use "master/slave" words. I'm OK to use UPPER_DEV_* prefix.

I will update the name if there is a next version.

Thanks
Hangbin
