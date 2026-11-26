Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704010;
	b=LjhJBnXIFhf8Jktk+A1Hbe6XU71B0BWAj9a3x9XZOV/hy7/6yHz02AOGrA4o52EsyZKI
	 BmgFAXpcMupDVjBOXsJjFve8QD7DU4x9Vwg4kngMcIyZkC1FJw7iNUDslaJKxsb25p27u
	 mvhiKP44076sdTJqb3zIUg/fq8TK4XK2ZEXwf0gDxhfG7v5BJCt4inSlj1OWYy+AJGhPs
	 7ItOBf+7hjGfr5zQJAVs16srbLeeZ+jhcDgvZez5p6x+ju1pyGSONqvMSMsy7ZztBjgkq
	 7BNAguGudxXx1piR3fPs/fj4w0NQYmbPb15kJV4fZ3g+VUqLvgexwPzNJNGAh6m6CBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704010;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Ma+fJaTyImR0PIDjBx3AtNZNkSSUq6SS/2gdqpsBcnM=;
	b=k3A1w4vGU3FzhLa4lgSr973Z8PEShfbTbg0qncX+YM4B5KXmRjrx/kAB/DlCeJ7ajaI9
	 yjWgD1KQEsDfhv1dEGwCmC0Bif/0WmIchNjlpSl8nYLB3FyzqMFiZm7IboEFKZYojOtXm
	 Sk6obmWo67DW+v/YdJjIyLfktUJYiG3LXG8/ngK36A2R3K60vihosdUlPzA165BUzn5XN
	 NZzIKKlYD4P0ggKLRkQ3PVcJhYENKPSl3nlARz9zo+c/VxUFBGhwrTCSal4677rEehFCX
	 3hgNJxEi3rTp96L5Nf3c4s9mki5WzGS2fEmgmawDQzVkTbA+E0IZr/XmjU11zwouFkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpnweTll;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699BC606A31C;
	Thu, 26 Nov 2026 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpnweTll
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B761F000C0;
	Thu, 26 Nov 2026 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704010;
	bh=Ma+fJaTyImR0PIDjBx3AtNZNkSSUq6SS/2gdqpsBcnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZpnweTllp0GAwfTzIa9SVZVerRre/bDy6ghxlr/FdNjLD8q9ui7hVaMwHBg2ou8vW
	 m3599TZa5BO3ceos8HduNeSRRcKqX7EE97sed0lSkSEMA9DSZUwjDpwrsR6IHnyYtm
	 FY68Qwq8KXVkvSxTeQnLZDHumN2tqIfojhJRTg757xvS9rhvJQ9I2WxiwgGlbhWiR6
	 uHyfotrHqNkmf/TdmKXSPTBnPY8c20aU2kJlqX4ozq0joi7GIMBMTWzTcZY180Bctj
	 xHVlWB/2Z9tIBW6JMWypoQZta6IG18Ivf1XeY/mbP4HKlo5Zz4O7NQnra+hACuxMpB
	 o1X8O3ed22zvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3D1380AA5E;
	Thu, 26 Nov 2026 14:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: bridge: optimize vlan multicast
 forwarding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179570400876.1866113.11572420928835954798.git-patchwork-notify@kernel.org>
Date: Thu, 26 Nov 2026 14:40:08 +0000
References: <20261123102833.924427-1-razor@blackwall.org>
In-Reply-To: <20261123102833.924427-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Nov 2026 12:28:30 +0200 you wrote:
> Hi,
> This is the last part of the patch-sets that optimize forwarding by caching
> VLANs. It adds the forwarding optimizations to the bridge multicast code
> and also optimizes vlan range add (see tables below).
> 
> Patch 01 - use the vlan already stored in the in per-VLAN router context
> Patch 02 - use a small hash (64 entries) to find the port vlan groups
>            without walking all
> Patch 03 - cache the port-VLAN destination in mdbs to avoid egress VLAN
>            lookups
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: bridge: avoid VLAN lookups for multicast router forwarding
    https://git.kernel.org/netdev/net-next/c/2661ecf12be7
  - [net-next,2/3] net: bridge: mdb: index port groups by VLAN
    https://git.kernel.org/netdev/net-next/c/5163021286df
  - [net-next,3/3] net: bridge: mdb: avoid VLAN lookups in listener forwarding
    https://git.kernel.org/netdev/net-next/c/d513e83cb90f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


