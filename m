Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236809;
	b=fx7fgM+66zAKsmizbuLKspI/MtXNSq++cU8KRjo9Ncpaf8wK9GWNAJoZjUV1Pq5q+gSK
	 +fi+yk+h7NN25EQabEQ5WzmgIA59dQxe92jbOIcGNJs0u5zmnxCU4JQvkZ01+/RkexvxU
	 X5IhX1a+0S7Nw8OZHZR55aABuq4LQHf56/ErSNBxn4Xh6fQze3m8fBYZ8qWBoqWWp9vWc
	 xNn61xNyxkKg7RXlJ6R+/DFHLFYXRe6UAuI+nlxTLq4Xg2ogPyqADezKOlMHVJkqCkveV
	 4Bsg236elubbX1bYsAiSjfuxQXxeWNYvykVN6/3FYBgfb40qzJBBXPA5d84yPbbvB7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=1ae5hirPCAmTqYgNqbMOdzAmd5TYOX71X39NXWJPNOE=;
	b=x2DvKdfViq5kt/H1uVD6lX9b3NQshZD8P3BBqquBXWB3aaVTlYCmwyDqd4m9/DTOXva4
	 +knGSH/XG+bpZQksnEyKs5vZUvYD+adcdB1mddmFguIJPF/A53n2Z0JhraLAmouOErGRv
	 EE3ELGwoQh/Ds+pehmKUGNxFZoBM5Q93wlueAUzA1BsfDHXd1fVeLQ3ngeHtNLHR5KM6O
	 SAnMbL3iwlAFmLmxa2UgBEU2g9aiDYvnzVdkgELw+10U7HDJsRBgwACdO5s7digwbIpYD
	 3K6mBHho5x1pPOlHd6tu/OmRolRFHNOqtx5jA2MipIT6wQLqcudzHMnFXSxWjC+0ryQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=botLdvWr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3075D606A325;
	Thu, 29 Oct 2026 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=botLdvWr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C809A1F01825;
	Thu, 29 Oct 2026 01:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793236808;
	bh=1ae5hirPCAmTqYgNqbMOdzAmd5TYOX71X39NXWJPNOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=botLdvWrgdJv+5Kg6Ooti7GdtJfrYgwVqyqhUDw5+JWwqGCeMf/4DTovSqu312Bvd
	 R7Oj9TlwZ6CgtOY/bBpH6cLHIF2K4Stdl5YprMNcDP5mNZlwRxIho0yCIm/gu93zCW
	 iNtvgdDSYjwnILefcPztjaTe1fYVA7XKSnsYZprTdRD5UGKHsegg8xes9T4Hi7KoKM
	 4q9N3wsp7WzLZ7ohWZ4vrt4lCIR2qxlLaZYYAa0IobilG9SUR4qAhMDCeKpA7Yv6Ma
	 So+5/89KN0ESD9iGN3/cJpAXjDi9sWWEGxJlO9FTxq0QRv2QUkpFHPo3tV8Pd3WzI0
	 XtJmCsUhSxyPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE7C93AAFC4F;
	Thu, 29 Oct 2026 01:20:08 +0000 (UTC)
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
Subject: Re: [PATCH net] net: bridge: netlink: do not clear the vlan info dump
 error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179323680731.1512684.8560685611232461423.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 01:20:07 +0000
References: <20261027085200.1501599-1-xiaolinkui@126.com>
In-Reply-To: <20261027085200.1501599-1-xiaolinkui@126.com>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiaolinkui@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Oct 2026 16:52:00 +0800 you wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> br_fill_ifinfo() assigns the result of br_fill_vlan_tunnel_info() over
> the result of br_fill_ifvlaninfo() or br_fill_ifvlaninfo_compressed()
> instead of only running the second helper when the first one succeeded.
> 
> When the vlan information no longer fits in the skb but the port has no
> vlan mapped to a tunnel dst, br_fill_vlan_tunnel_info() walks the vlan
> list and returns 0 without touching the skb. The -EMSGSIZE is lost,
> br_fill_ifinfo() completes a message whose IFLA_AF_SPEC is truncated,
> and the dump carries on to the next interface instead of stopping, so
> userspace silently sees an incomplete vlan list.
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: netlink: do not clear the vlan info dump error
    https://git.kernel.org/netdev/net/c/fcc00b15cb21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


