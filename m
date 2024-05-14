Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2B26AC5
	for <bridge@lists.linux.dev>; Tue, 14 May 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689144; cv=none; b=cc4OBy+/i9n1J3hH6o8IPOSZympLXwX6ZSMgflbGuolGU+hfXq5DQ3BtJ218ixL4pmIuHG3PDGfT3/RpSAhqtiEVeGuPga3jYMn0hfX+/XdL/+feVaWO5X22i3vA+SQZxPq2nhF6DuVWth/BpFF9+ro9eP0lxqMgvz3RtJrh4XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689144; c=relaxed/simple;
	bh=SOBTkwoiFDlqkTZRK8lPUxvTkg7sOoOa00MeqX29k1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABNxPPuwq24GpGV/mv2+3jp+ZN71s0DkXSpQ5NE9eiVtUbbXTJoMF0aH9ssjf5nm5X3XrSmeLqO4S1VhBKI7bjXtFdacOtEyByKfuPiZABBhGBfLWvT7ItpOhZXDrjZ8Ms7u2f3znulTNBL3CXKkyQ6prntMzpUuQmCFRTZL4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7xjMiSO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7xjMiSO"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b346712919so3899001a91.2
        for <bridge@lists.linux.dev>; Tue, 14 May 2024 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715689143; x=1716293943; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/M6RcHxLr7rqLfy5+3tJEltYq84WQeLwXWf97w/s/4=;
        b=U7xjMiSONHlL49H4dYJNMN2v7cP0dLbYKiAY1fUCX5DCSjsnFpoz5Ez3fiK/a30wSp
         Amur8qlgOiDsCugE1FRb4PkH4bANvkQ7X8LfoopJ3qY9L8Iyw7XndiMGH7hVbmZgQih5
         TMA3eFCqNfI1RT8yllP34iYQ8Xt8VAK4eHKE77IGZGskRd0NtSSIBgA2dUYyTsPGZvuT
         EiLEjDDY2gUOIz9HTx0KXLdgCEJ5FlpaUfK99slycB+GO+EtpFsB/q1/UZMwkG3YOlbk
         E1pUJUD1L3kl9SFQ/u6JLzsqVsG+QEW2sIeLWrtqsOcePxNowUlw6KjtYmq0LnnPt6hX
         uTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715689143; x=1716293943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/M6RcHxLr7rqLfy5+3tJEltYq84WQeLwXWf97w/s/4=;
        b=eFRcV0xANNy26Rf12Sjn1gc3DPLuxvE7Me0eEMavzPUDhAvW2DloCNPiVHyvs2dsZH
         iUZqwL0+djm82vBQaLvb6Fcz7CBdup5tgI173xhPx0XUXl1SvsmF8XOMu6FnQxWaHFlq
         cFPcmgIg+4hCUDZNIFS21M5Cbr/PBaiwFE7b2MzGrLiT543TlKCDOIp/38vh+1dMYwvg
         QSEY+5Y9RQmmy1bVDxdRUSVVvVuUP0DCi/BX6/luWtApuCiH8l98TVzK8x/eyPbH6y9X
         iBDuy/Id1vliC8T/2uAcASlt+/I7U1KvVxpn3Ojz0z+IWJXA+jEtauRlXUbsDGVSTPi5
         d3mA==
X-Forwarded-Encrypted: i=1; AJvYcCXV0axRinhQDoxi7YiS+2Mby9w+qOjQd6L3UP1kQJMptOUwG6iMNJdr7XJe4PQ6xKRK4A3K15jxFcGzOpYtorx5UdP+/5jl
X-Gm-Message-State: AOJu0YwpYfuCxRQL+WGYWDk6AfIfcDaRMPz02Aj+PWBWY0+BlZzC8ss7
	UGEHRdgurUsRohLsJbcPSCsiJ45PXt6FU6burBLc5ImMBtU3HKg3
X-Google-Smtp-Source: AGHT+IFtqdhlT/FlzWhzWeejBHdaSlmdcrHWnWz+l+xcoHaLF9lHC52dvea04HREoO9qhPea5ZYmww==
X-Received: by 2002:a17:90a:d18e:b0:2b4:36d7:b6b5 with SMTP id 98e67ed59e1d1-2b6ccd85bf8mr11254959a91.34.1715689142540;
        Tue, 14 May 2024 05:19:02 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b5e02ba6dasm7288971a91.1.2024.05.14.05.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:19:02 -0700 (PDT)
Date: Tue, 14 May 2024 20:18:57 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, roopa@nvidia.com,
	bridge@lists.linux.dev, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net] selftests: net: bridge: increase IGMP/MLD exclude
 timeout membership interval
Message-ID: <ZkNWsR04SdTpjWRZ@Laptop-X1>
References: <20240513105257.769303-1-razor@blackwall.org>
 <ZkKzcJm5owdvdu6B@Laptop-X1>
 <186278b5-b2d5-408e-8d89-8cdff6efe41a@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <186278b5-b2d5-408e-8d89-8cdff6efe41a@blackwall.org>

On Tue, May 14, 2024 at 10:46:15AM +0300, Nikolay Aleksandrov wrote:
> >> diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
> >> index e2b9ff773c6b..f84ab2e65754 100755
> >> --- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
> >> +++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
> >>  
> >>  	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
> >> -	sleep 3
> >> +	sleep 5
> >>  	bridge -j -d -s mdb show dev br0 \
> >>  		| jq -e ".[].mdb[] | \
> >>  			 select(.grp == \"$TEST_GROUP\" and \
> > 
> > Maybe use a slow_wait to check the result?
> > 
> > Thanks
> > Hangbin
> 
> What would it improve? The wait is exact, we know how many seconds
> exactly so a plain sleep is enough and easier to backport if this
> is applied to -net.

I just afraid it fails on debug kernel with this exact time. If you think
the time is enough. I'm OK with it.

Thanks
Hangbin
