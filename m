Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3D3254B2
	for <bridge@lists.linux.dev>; Thu,  2 Apr 2026 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095289; cv=none; b=Nwyo6CntNysS99yS+5GZPeA1LZH/0ZTn7vQKlniUpwsRaM9Sl4Ygqi6ewhjsuE5m9DHBv1ZHaIl4Ee5f0OQqS/hZYpo3X+3rdwn2Las8GAy+FdviEnczQCjQ5hK8HugpCVrcoiAefGArmie4h5FXG6yZ2wkNkDkYgWgPSaIgBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095289; c=relaxed/simple;
	bh=AC2C+zE4Kg8iS4FtRlhoHak4f0xMptiMtmwtwQ5hESY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzpfXAPG8jrkIc9XHzyRdfugwPb2Pp+xGaNBsFu3TTxcTIaoJF5RrNTWiT5U56/x0s+/kLXuBG/Ld4yAE7m4rwPjAL3vEeqWe+RSXfZvmlYeSi5UPRddG7beiM9HNiTh2UX9CRx6kVHNLuwr5xhh5YE7mKqNhh6yB32FfQyqWI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raQjzmzJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raQjzmzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCD3C4CEF7;
	Thu,  2 Apr 2026 02:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775095289;
	bh=AC2C+zE4Kg8iS4FtRlhoHak4f0xMptiMtmwtwQ5hESY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=raQjzmzJqGV6KIeYp6naAbUCKSeENCoImiTcWKLabfC4Wz5pjqfFwPVKrN2tBWOHE
	 C0e3k4reAlOSk2bs5ogiUzUVGj/C6TP+8V4/S9t/XzW7MHmwu2CqRGpmgtNMBF1TTz
	 UOcTYapRI9czoB3tIS8m/SAKjtZo4eBOX8EY9LvNrn6/HbfL9AJ3CCt/jW6vs7jnXv
	 GyWQyaSWtfr0dORJfEJkejRuaXwpPLCQleG24g12bWB597YDGp+fKjuorHhHWneL96
	 Nsa38NyXYSGBM81l3eaM4EUiwptI77/kPWmiEQoQRzV7dEREAiCLUfECgHxjCS5JiK
	 k+nWiy629k5NA==
Date: Wed, 1 Apr 2026 19:01:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zijing Yin <yzjaurora@gmail.com>
Cc: bridge@lists.linux.dev, razor@blackwall.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org
Subject: Re: [PATCH net] bridge: guard local VLAN-0 FDB helpers against NULL
 vlan group
Message-ID: <20260401190125.70d3cf83@kernel.org>
In-Reply-To: <20260401154824.2905980-1-yzjaurora@gmail.com>
References: <20260401154824.2905980-1-yzjaurora@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Apr 2026 08:48:24 -0700 Zijing Yin wrote:
> When CONFIG_BRIDGE_VLAN_FILTERING is not set, br_vlan_group() and
> nbp_vlan_group() return NULL (br_private.h stub definitions). The
> BR_BOOLOPT_FDB_LOCAL_VLAN_0 toggle code is compiled unconditionally and
> reaches br_fdb_delete_locals_per_vlan_port() and
> br_fdb_insert_locals_per_vlan_port(), where the NULL vlan group pointer
> is dereferenced via list_for_each_entry(v, &vg->vlan_list, vlist).

I think you'll need to repost this once more and CC netdev.
I don't think bridge has its own tree.
