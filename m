Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E343ED5A9;
	Thu, 19 Mar 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936067; cv=none; b=p3C4LEK+ibEzStmgHA46lmW2dwx1Fny4uUzFOY8XoSoquhYTqJ75+2xYZmnysFFL1xJ3Krm2kcwDx+MFsdeUC1MX8CeV2mOF5fvadDMUdROPoU5/1p7rOYUHl8U6OnlEtOp0lO+ucJ1+DhB2EIgco2za8ygtLjtLIP6o2LMNW6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936067; c=relaxed/simple;
	bh=8jq/yXwyQLcJr1s2GokimrUi6kKgAOf8zIS7eLoBb50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0lDuxrBNgzuqd9apkm1xdh3eNd4XRgA7D8sVEiU9fCJNTdeJDQklGKLy3jUQ9UVQ48R35Eg0VV6JQB7/wFAFiS5W5r95nxlXhb7EzfwWNy8k+yOmxcwoLRuy2+qdcU3WUEzW6KP5Vp9YoJiB0QbCfb6qNsbwdlw+gRrsYJNrD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm+mXVYv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm+mXVYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1597FC19424;
	Thu, 19 Mar 2026 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773936066;
	bh=8jq/yXwyQLcJr1s2GokimrUi6kKgAOf8zIS7eLoBb50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hm+mXVYvPq/4MoW+Wmvz8DS3mw+oHfIf3GozQsI69H0lje4KoYQM+aVG9xyQx2gi/
	 oeE8vWcTjFZINYAoz4H8N+iy9cATpi+RaCX1zKnLJLVXqxbIGfokUjsI0lAdS0ANVH
	 a1/XeK0OYqneZu379DvM/TSblCJ+HQI2vn/fTDCiI9nR15eXLGEy65tKoTPv6roK0Z
	 xxSPatRf8CYVK8PwzkZPcIzkJH7niB9r0aeQZDHMviIZRSvYqKZ8pKL3LDsQ7VIF1d
	 i4aiJIrSx4TVCekvDDxVT6XYaXd3y2YDvylBghQmThNZGLoyyKqKRQ03MWr+rbJBQC
	 UO+/XzPoyP71g==
Date: Thu, 19 Mar 2026 09:01:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jay Vosburgh <jv@jvosburgh.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jiri Pirko <jiri@resnulli.us>, Nikolay
 Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Simon
 Horman <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH net-next v3 0/5] net: centralize master device offload
 feature computation
Message-ID: <20260319090105.3211f6dd@kernel.org>
In-Reply-To: <337a938c-8a03-43f8-8402-745020185b37@redhat.com>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
	<337a938c-8a03-43f8-8402-745020185b37@redhat.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Mar 2026 10:52:34 +0100 Paolo Abeni wrote:
> On 3/16/26 5:26 AM, Hangbin Liu wrote:
> > Currently, master devices (bonding, bridge, team) manually call
> > netdev_compute_master_upper_features() scattered throughout their port
> > add/remove operations. This approach requires each driver to remember
> > to update features at the right times and leads to code duplication.
> > 
> > The series adds a new ndo_update_offloads callback that is automatically
> > invoked during feature updates when upper/lower device relationships change.
> > This centralizes the feature computation flow and removes the burden
> > from individual drivers.  
> 
> I'm sorry for the late feedback, but I think the driver cleanup and
> simplification is not worthy the core complexity and the new NDO added.

+1 FWIW, I didn't want to be negative but I felt the same way..
We are always one step away from an inf loop propagating the features
it's a delicate space :S
