Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9541C71
	for <bridge@lists.linux.dev>; Wed, 15 Oct 2025 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760491571; cv=none; b=c/fxGg82/ZGLSaJHTiEYw+qe8LgSNkRUnVkUa8F9+CcVbskr8fWnhooHRHmMFmxKB+yU+4IummiOaPmC2mJisPC6opeb7dcpsdG+Q3WXVkg0j8wbw06vHUc8DpRflFcqANqb7y/c9rEn26Cj++luMui6clseph31T5tiIAAb+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760491571; c=relaxed/simple;
	bh=cjJS0G2aPBCIRiv5AjzjQblvTPPjsjWQvR5I9m1fB1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fierB8/RNj9xI0U4cerpN6Yxc7vDkVgu8i8iYquzjwZ889N+ZrNX1UUT6X+P2B49rc/iHWc1MxenNcbIvKciZNM2mjBc9UdHPtvVRFzXmAgHErSxuLRIjgaDH3JWWjfRlTy1nLoXKIhriyG8pw8MjfoxeavBsnicCfRqf73qTsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axyqht2b; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axyqht2b"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so3801024a12.0
        for <bridge@lists.linux.dev>; Tue, 14 Oct 2025 18:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760491569; x=1761096369; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q5dz5Gj88sNElZ8LH0dTxbQkaOtoFBCo1ZKVE/LXNA=;
        b=axyqht2bTYmKePwPy0axseUH4nO3xr+nCchK30VDSSLBKHKoxiY36Vy/jwJ8fBT2Vx
         0VcdB3yOaFAHvogqYmy1oi37sqGNP2I9+POttMAR157ekMnNmwQe5OdOXIjHfxTAvhPT
         StWPmYyF9/rlxgPO0M06oCaeBS+ut0BoW1lzb7W6X+U9oWjr0YxH0I7hGcAtWJRLM6Cv
         /kYx/Ku/i+YYuxaktLNlBH2iutnAR8xcBvrx5CzvHNSDnVcC3dqsgRcRg61bO6fSnbsK
         nUTQsK6AqD2Q8IqqY2j4zl5BjHdTRVRG0I4fuOCb8cTmZ7dsZWV46yPWe0dP3tThPNrS
         6BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760491569; x=1761096369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q5dz5Gj88sNElZ8LH0dTxbQkaOtoFBCo1ZKVE/LXNA=;
        b=QJJyNolu2k2Y/YbKtA588o+sKcGFttUl5d4m5EcATv4uCzqX4f1DVpuY8Wa1aCBpsy
         xMZ2B6Qa8keUqrzK+4ke9YyclmTo4CxoEx6GeiJnyO/VEMuQQBApfNZQcp+bOIxUhbOz
         B9u+Q7+vomYo5R0ZoYSAi96q7t9DkgUKugx56fkCWSWMgGusRE1ltk32XdyxcQunSw4s
         lMfKbHUI2p3/3j+FM1kkv1ljZxVDInydZJ4z9UZq+Evb0AfYRQjhBR54A2WVknw9UXGQ
         dOZ+OPA+tuHyJYqLaPHjxtdIJjDt/hlIxIFhxFKvVydVV7lr/sKKUQroOpXJV3hF0B6m
         8Gwg==
X-Forwarded-Encrypted: i=1; AJvYcCVYnI9q3/9njUTjfiKmtS6dy8rVHeDfSbe9h/1qQo1kWOGS+2aMHe3XouAlmgr7UYb28J++xeo=@lists.linux.dev
X-Gm-Message-State: AOJu0YzXAE04TSWhEuVK0KqCEJdECLTP6Fmi/GGnkQR5/AbVo2omi6lE
	4tG1WG0gOWkGrjzoZ/d6sxib8WmMElGK16WQtwUXOR0rS/eNd/Uz8H2t
X-Gm-Gg: ASbGncsbAN7t8HTFuLKpGUP8cTA+WdpCFQkSpcnLhi+Nw9+WOBOLDWKBou4QlfZyXwH
	ztNHF3qBbKJmoXi0x7/I1Swky/LvlIKdVHte5Tsuz6YIBgX70KtOHgLIAZZWFOQQbSwQUaWHPmA
	3V8FqfBMpi9fIcZ2NPrZPaX3cR+xKeV2XT7b8onTKZdxHa9gB2FwUUg+wPeUnvZZhTscQUA9xfl
	FmLtfb0+9iPNwAIHjIYXmRWOyg/81kGcTSZm/PxTQPBvztzDyngOIJ8xHNZfsVWg5E0ViaexW1V
	71mOAFel22lq4MdiGFblrM5L1HBpYX3U8S9yh20Za89S/4/JJ0UoFe6N457tnQZtl8Ek+EZQbyJ
	S1exPVW52fgXAlnpdNv/lFjNMzlO4CevzLsUEnW5carbd6Lb3TJJ6wqYoiqFJrGoDLgiiMfD+rm
	0cEViYFkFknQ==
X-Google-Smtp-Source: AGHT+IGzF5+LW53UkepzFQKI1Jzn1qFhxcSosnAtHxXYK8XVZjCibUQ1WkRpULc0fl9NPUgHG3Sndg==
X-Received: by 2002:a17:903:246:b0:27b:defc:802d with SMTP id d9443c01a7336-290272b537bmr343555765ad.28.1760491568988;
        Tue, 14 Oct 2025 18:26:08 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e4930esm176198915ad.54.2025.10.14.18.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:26:08 -0700 (PDT)
Date: Wed, 15 Oct 2025 01:25:59 +0000
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
Message-ID: <aO74J20k16L7jS15@fedora>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>

Hi Jiri,
On Tue, Oct 14, 2025 at 11:40:12AM +0200, Jiri Pirko wrote:
> >+#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> 
> I don't like the "virtual" naming. In the past, we always tried to avoid
> that for lower-upper devices like bond/team/bridge/others. Soft-device
> was the used term. Please let the "virtual" term for vitrualization,
> would that be possible?

Sure
> 
> How about "master_upper"? This is already widely used to refer to
> bond/team/bridge/other master soft devices.
> 
> MASTER_UPPER_DEV_VLAN_FEATURES?

I'm not sure if we should avoid using "master" now. Maybe just UPPER_DEV_VLAN_FEATURES?

> [..]
> 
> 
> >+void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header)
> 
> netdev_compute_master_upper_features?

netdev_compute_upper_features?

Thanks
Hangbin
