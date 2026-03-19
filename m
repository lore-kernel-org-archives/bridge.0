Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CB7175A8C
	for <bridge@lists.linux.dev>; Thu, 19 Mar 2026 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773885784; cv=none; b=ncdVco9/KCp3P/wcpWwMZWtgR3LH0sE7CC/xk9CVMuFoFTVaT/1ElH0ggu4mYy1E47X/rbgrL333ovN2tQScARuNvUMcGx+RPHS7PC6k6XLFbDkAGgZOm2aQD8xSD5q6a6QuECBc/iphTxaINWvbVMSwRNOjKJ0YWncCm1DRHBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773885784; c=relaxed/simple;
	bh=mKWLwc26UHp0QckseNliuojMeOSjfywUsmMLAQ3UG5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyaeL+F6q9Eba8YQA/5FZ6PJfUNFyl5fp4+CZPD94Na5NHSK0LhBGuXXgOW2B+7KBDW7Y5Z+8cOGoIularmXYk7yGAsEUlfJ4llHXdkv/vci6e+kA76duMcxT/KRc+uAd/GC/iPZ1RZ1UKdwG03V1s5+mLX6rIy6kAPUCESNGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8smt5dt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8smt5dt"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8298fad2063so96500b3a.3
        for <bridge@lists.linux.dev>; Wed, 18 Mar 2026 19:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773885783; x=1774490583; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ScNRNBIvzfApbX9SKu6wfVyGsSnrc3rMHZZR+kMrCFg=;
        b=c8smt5dtK9O4Z+lyqA4fBSfy99LQ5RiV36G5yqhlxbnA+Y2/HiIcfQx+Xs9FVbFHtk
         2p5JXsA1dpCE+5UZGvV3/aPyyenMmBRRQSPb1ydkH5QWkcBrTv7L1m3Pihd5DSozfikh
         VnkG3FaZSkR/gcSeUNbEmJNwSM/OUYwPZbqudWIwzPTvjRyXq8PB11aduVHEL9dDw1DH
         7ElPUbiqIYZ4SPc2lMgNqFSl2JKg8t7KvlEIBhGG8EbRDcUTOrTwli12JPYszJRSp1Hi
         y1JTYZTZBy4dL41RqmMzCimwXvLIv8TiHg8Okmezry2C9SNLGW4u1xLTiy4MBX3KvOpq
         8dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773885783; x=1774490583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScNRNBIvzfApbX9SKu6wfVyGsSnrc3rMHZZR+kMrCFg=;
        b=gyuN0tnNiDfjehjKQjQ9qr4XX4898geDgRuKjGIBo1GQJBnTv6yUbL5assqo8Z2xEx
         oqaei54k0FELfO7n+tEi0zBT4wYhdSh3s+iuKdCE/BUeyvj+1aJ0YbShZJ70ReQiwJ0U
         3MpdDjh0Od5z6qYibl44DFXR2Z1qcEwY//aN3R94CyF4fHalgTJYaXjgxSlacrSyLeHU
         txsV2tI0Oh01K+6mZN7MXWAjASAaSfWXP6YlLRd/uXyPAgSmeusaMxyaEWalTi2iLaFy
         R8/wU8Z72ZbpH67FE52rfFP4SOArEPpJtTeK+a9amrUHAJbUb94puwbllrM8iQ72hAFL
         2NZA==
X-Forwarded-Encrypted: i=1; AJvYcCX4+ZNuTaet3UeWVHhNtwomy3nNg9WwtpF44+YiSTcO/Y73lAIQaFKbyZvAFz9hZDmdPxPfOR4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxwmlrclcWAiDQqyEdiOHsdCYtaL6Z1xPA/VJOw2k3tjQuSHQsg
	J2/MNm0BbzmqJpuEFwDK2Bnik15GMMBlfPtmojayypdLTB3XMUO1+XRV
X-Gm-Gg: ATEYQzyX+tf6FSiIxRNmmJXO2QAVBo8zSbkMQhy3Ukhz5BplIFqWOH1+aEcphHohP9+
	tMmFxOriVrWz+fIYJB8Sdl4VdkyfznfFbwdwaikBgBi+GUJnZRp32+malzVG0KKGNFKbG3oBqin
	eBgDErif+0SN+d2gGMbP+4y1McwXwIiadNHVRaW4f+wTJ0q3c+KNpe7RkHu5HinhyN/VxpUuq5b
	2W8voB7mxOHZwuYbaATygXfvJn5MkjmzFol4nhs8T6aA+/qmKSelAXSlFuUdG8Bh6xWyAaZfa4U
	GtLRpKp17+Z4PZMU35TXFReme1KvjmpENVqWtTf0QwYIBlODW0MIyl58otfp3k8usBepi2ENgjT
	/GTvnknQFQspOyyGL5GQidKl21jiXD0ISrgv9RCyX4fRivoxH2UliUukQSuZrxfY3XCBu9MJGuW
	uCl4quVmKWQ9kYBdH5gKL96hspg1c=
X-Received: by 2002:a05:6a00:17a4:b0:824:36f8:346f with SMTP id d2e1a72fcca58-82a6ae213f7mr5040966b3a.25.1773885782857;
        Wed, 18 Mar 2026 19:03:02 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe1ffbsm5577164b3a.43.2026.03.18.19.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 19:03:02 -0700 (PDT)
Date: Thu, 19 Mar 2026 02:02:53 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/5] net: add ndo_update_offloads for offload
 computation
Message-ID: <abtZTceO0xHKf1F3@fedora>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
 <20260316-offload_compute-v3-1-a5d4a07d86d3@gmail.com>
 <ablv266AIETvJwpP@krikkit>
 <abn8qFyE7pDuM4oN@fedora>
 <abs1VWLQVmXcWESQ@krikkit>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abs1VWLQVmXcWESQ@krikkit>

On Thu, Mar 19, 2026 at 12:29:25AM +0100, Sabrina Dubroca wrote:
> 2026-03-18, 01:15:20 +0000, Hangbin Liu wrote:
> > On Tue, Mar 17, 2026 at 04:14:35PM +0100, Sabrina Dubroca wrote:
> > > 2026-03-16, 12:26:09 +0800, Hangbin Liu wrote:
> > > > Add a new ndo_update_offloads callback to net_device_ops that allows
> > > > devices to compute and update their offload features during feature
> > > > updates.
> > > > 
> > > > This callback enables master devices to recompute their features
> > > > based on current slave device configuration. This is particularly
> > > > useful for bonding, bridging, team, and failover devices that need
> > > > to aggregate features from their lower devices.
> > > > 
> > > > The callback is optional and only implemented by devices that need
> > > > dynamic offload feature computation.
> > > 
> > > Maybe a dumb idea (and sorry to suggest this quite late in your
> > > submissions): since all implementations of this callback are only
> > > calling netdev_compute_master_upper_features(), does this need to be a
> > > new ndo, or could this be some kind of flag within struct net_device
> > 
> > Ideally all dev with IFF_MASTER should re-compute the offload. But at present
> > some master devices do have this flag, or have their own offload
> > implementation.
> > 
> > Do you mean add a new private flag, like IFF_RECOMPUTE_OFFLOAD? For the second
> > parameter, maybe we can pass false for bridge specifically.
> 
> I hadn't thought specifically about where to store that flag. As a
> private flag, why not (this should be internal to the kernel, so not a
> uapi flag like IFF_MASTER), but priv_flags is marked as "hotpath" now,
> so maybe something similar to needs_free_netdev or
> netns_immutable. Either way, then devices are free to do their own
> magic, or request the core to call
> netdev_compute_master_upper_features() for them in some common
> locations. Does that makes sense?

This looks better than private flags. I just feel this magic hide a little
deep for a common master feature.

Thanks
Hangbin
