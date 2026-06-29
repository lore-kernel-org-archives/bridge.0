Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA70E408013;
	Mon, 29 Jun 2026 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739334; cv=none; b=mAH+CBBPqwRQLHg3bLp5awuLRUFn1beh5BgMkbztlwe2Ky2Pq7bdJRK//fo2EO6VwbIFuKIF/C+W+8cm2mJNVWeHhrNsN0+sWMiquwL4HqE4x9Zn4P3TyWWBVslBpFkB2KEB95V5KjT7L4GY9hL37IRtK+M5RkspUGpJ5nsffDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739334; c=relaxed/simple;
	bh=8esuHclQn2TmNlUkMOFiokUzrniEpSCwHmAvMa6AlGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csGPQdHEZ6f8d74/s+qrP8q+EBKkuhE3urEhuGGV+wAfrDL8/YMjIpknenKZLUAMjkxhS3VP7yJiN24TaJAxwJA94T15itSUb0u3iIg+PEZWRZsFscoaYK/gty4DrkrB8+ip9CZp2XeTMk+jc0guv9RbJWDQdKS/ApTHirCCDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QSD+OS2B; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QSD+OS2B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yYFpYJ+g2LXtimSsYZ5CW6pJeIZVEOYSSSKP4yuzF7Q=; b=QSD+OS2BjfQAAENwOEWJmxxbGR
	70LV2fhofGtUx+vncvyeV5M4OmFUakmhX+gehxwr9GDCK0ewQCQPi9NR0YoMr69fmWWgLV+E4HMX9
	RMwmili6X90m8JgvXWGLraw42/Pm/7VmRc7H59uKOhQv4lLYEYqFKS+5N8pDQ0SWAO2dBQvr/uCTB
	bBzf54OeuYGyQfGV0NVZZJYXdZvGcnzfKCRHYBiKO4jJZE0t8awhTj1bN2jAkcuP3jtog9gNi1Aqo
	ebiYDrgSLa/XyyA9NgUmQeMPbx0WeSzADT25Av4NVROP3jU4gKge5MsteghFBpSG2eCv3iEdZfHnx
	BGmggXlg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weBw8-006JqD-2S;
	Mon, 29 Jun 2026 13:22:08 +0000
Date: Mon, 29 Jun 2026 06:22:04 -0700
From: Breno Leitao <leitao@debian.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, razor@blackwall.org, 
	horms@kernel.org
Subject: Re: [PATCH net] bridge: stp: Fix a potential use-after-free when
 deleting a bridge
Message-ID: <akJxbo5tn7_fcCdL@gmail.com>
References: <20260629072117.497959-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629072117.497959-1-idosch@nvidia.com>
X-Debian-User: leitao

On Mon, Jun 29, 2026 at 10:21:17AM +0300, Ido Schimmel wrote:
> The three STP timers are not supposed to be armed while the bridge is
> administratively down. They are synchronously deactivated when the
> bridge is put administratively down and the various call sites check for
> 'IFF_UP' before arming them.
> 
> This check is missing from br_topology_change_detection() and it is
> possible to engineer a situation in which the topology change timer is
> armed while the bridge is administratively down, resulting in a
> use-after-free [1] when the bridge is deleted.
> 
> Fix by adding the missing check and for good measures synchronously
> shutdown the three timers when the bridge is deleted.
> 
> [1]
> ODEBUG: free active (active state 0) object: ffff88811662b9b0 object type: timer_list hint: br_topology_change_timer_expired (net/bridge/br_stp_timer.c:120)
> WARNING: lib/debugobjects.c:629 at debug_print_object+0x1bc/0x450, CPU#9: ip/359
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Noam Rathaus <noamr@ssd-disclosure.com>
> Reported-by: Neil Young <contact@ssd-disclosure.com>
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
