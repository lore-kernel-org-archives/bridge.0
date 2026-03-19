Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC64375F99
	for <bridge@lists.linux.dev>; Thu, 19 Mar 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913962; cv=none; b=utfXi0X1PLNWJUzaV0hD9FB6cy+GPvtXXxbc4eiQXLnI33U8jhaJcMSrcERxAClePNKHrduC2ySZwUztxiqrwLStPXGbnmV8YyERrw8tb3Aa15DIGrjPFTH5SETcfX97S2T1hEeNtAbV6wIj1cj+aIY4vy/kPe5pXKwjEOyNWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913962; c=relaxed/simple;
	bh=7uA/BCBTVJ94Aaj2XviPEUjuMABWk6OC0mXxBgWG+pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxVd6Q2xRtPojyy6aeEzCKwak3zQFw9DdZ3i+Un+fprbelb+VxRbMMyBfal8b6A3MSTQv8MLMooETEzmfUOank3Uvg9mIzFdtpDy6l53Og29o4cBO4eHZb4Na9NlGlO+EPD6otdncocmBX776eoAhtvQl8PjVP1N2nPaticFSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RY9zQ2Yr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RY9zQ2Yr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773913959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AWVI4IPyZgF76R5k9iVZditqSOUJj0IJ9hCQO83Ez8E=;
	b=RY9zQ2YrxYt+QYKsBwkMOMbA8k0XOQbyIEqrdYNU55KEfWKeo3TwThPBAI2rUV/6e88IEv
	AhTgFsXaI0T9Re6FrbbUmB8d2SeWnBLnwwvPzd3zLd0syi82IzSdUSnVqg9reg4PuyXn4R
	pma2zpakDDgJ/33OGsMFqZk2si3OXbI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-BDi3pRmjNyyF5dFd19CiAw-1; Thu, 19 Mar 2026 05:52:38 -0400
X-MC-Unique: BDi3pRmjNyyF5dFd19CiAw-1
X-Mimecast-MFC-AGG-ID: BDi3pRmjNyyF5dFd19CiAw_1773913957
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-485397788b3so3863465e9.2
        for <bridge@lists.linux.dev>; Thu, 19 Mar 2026 02:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773913957; x=1774518757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWVI4IPyZgF76R5k9iVZditqSOUJj0IJ9hCQO83Ez8E=;
        b=GQjS8XJuQcGF+WWWjHcbRsah83uj842YY7Vn9tk7SxC/2Ym/F2aBb5LJ8CVJ8CZaRQ
         V/ZHIw/xfjI/XvyaZxtZ7cp++XsSRO+jINB2DRtT0r+x/QtLzSOIprnPNelml3g6hFN1
         qcGS9EHUKjPZxLtRvHGQV88aKwhHE4SIlFUTPyEx0kNlCdnfbrJmnyPYLH9gT8ipScSz
         kwJVOk9oALF653DK0gOcVz2U7TV91U+yAP2N2pzP+VdJo7P0CuRu4HUvJ9yyETtQx5gR
         p0BMpj6K9sYkfpttUdroublIK/LFr6pkB7KIYquhd6Gxao3iiiBE4TPcjQeXFGDaXKkW
         2tmw==
X-Forwarded-Encrypted: i=1; AJvYcCUm6JFknJbk/+yx/RbYzPseV/K12bGXwFBWIIJt+DPcDZ8FXBzVTSXdPyLLWGIdFRqk5jHidts=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5ZkW7uPECMAp/DTQ14SboTn6uJWR+8y6k94G7usbmGGnskl4g
	k/V1rV+Pbhyo/+B+2zsC4fmdcENMFkgvoVdr05bxBJsBhDOlpBcobRn3W5mfsb8E634v1N2VzQH
	X2sNMsWMXXNjuXirZ02zqwHwnDSJfYUJnJXBzTBjVBvlxvs0sJ3H5grDbD0Bk3jGdZA==
X-Gm-Gg: ATEYQzyNHV8ydgFKG5CZC/8m019lTJD070vUOYWRW1nNU+4XQMQQdzlo25fD9sL54el
	Klo5xb3sPeWd6Eyrrt6BeqhstwxFGx4Mqsbs63L6B0sksYLU4gfHj9mSNewNotn3LYnddDLXXd9
	LqqdshE3psEItBqEOiM4DEzSNExQvM8hoozLS9W3ZoO/IQjMgi6JQtNMpvIb/KYhRbmAfmtfhRx
	JYco3iyhHy+8YhS0M+BoCzmGeaKtN0VtGK9O6LqOH4nk8WeAyf4N6LRyucv4ngdQvnVOVdRZfsz
	MXnCUpG9YdtXVDdJJKfG76QIIl5Xs2DHP1GHXUEJX6gcFyGAD2MHYaoFtrpQYaUeEWKzd4bPMvg
	YlJYtCX4NRpbeTeSmA8Z02mkyWnkGCAdT6WG0nSBhv3sQ/3JHJNxnxv86
X-Received: by 2002:a05:600c:4e46:b0:485:3c8f:e4c5 with SMTP id 5b1f17b1804b1-486f44485b3mr101908045e9.17.1773913957179;
        Thu, 19 Mar 2026 02:52:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4e46:b0:485:3c8f:e4c5 with SMTP id 5b1f17b1804b1-486f44485b3mr101907615e9.17.1773913956651;
        Thu, 19 Mar 2026 02:52:36 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4e48ad5sm170628175e9.1.2026.03.19.02.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 02:52:36 -0700 (PDT)
Message-ID: <337a938c-8a03-43f8-8402-745020185b37@redhat.com>
Date: Thu, 19 Mar 2026 10:52:34 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/5] net: centralize master device offload
 feature computation
To: Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 Simon Horman <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6HKJpX0xABdyPZxS4gftvO0NJGkkjlMIiKpPV3OSPaU_1773913957
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 5:26 AM, Hangbin Liu wrote:
> Currently, master devices (bonding, bridge, team) manually call
> netdev_compute_master_upper_features() scattered throughout their port
> add/remove operations. This approach requires each driver to remember
> to update features at the right times and leads to code duplication.
> 
> The series adds a new ndo_update_offloads callback that is automatically
> invoked during feature updates when upper/lower device relationships change.
> This centralizes the feature computation flow and removes the burden
> from individual drivers.

I'm sorry for the late feedback, but I think the driver cleanup and
simplification is not worthy the core complexity and the new NDO added.

The AI reported issue would probably need very non trivial changes to
both team and bond driver to be addressed.

Most of the cleanups belong to netdev_compute_master_upper_features()
introduction in the failover driver. Factoring out that single change
would be IMHO a better option, if possible.

The new ndo looks controversial. We already have 2 different ndo at
__netdev_update_features() time, with slightly different semantic.
Adding another one feels like a design issue.

/P

