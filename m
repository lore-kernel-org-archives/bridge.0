Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC8428FFF6;
	Wed,  9 Sep 2026 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915678; cv=none; b=pSCY3iu5yXxQ8vKKPPhh5DhpENmD0ujPYMRkthrsmnGnQjZDHai9HhqB+WeWw0ZC9/nsXYhMJnTLFYMRovVp7/CHk4TR+rsOmCPnNftsF52m3uqw/m3VTFzCsuXwKZXMqeIKq9ts08HYj2xqaldCjVuKGm4AnUd9kyC/tAljyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915678; c=relaxed/simple;
	bh=hwMV53oey6fLlh4nPB/Ulr1iCBS9iVhxioIAhiQgj7w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ub52odCkuOQqYccCEqIPqM6Z+jV1PVeoSDFyg9C2nqEmx8P8tWnkpDo5Fr9Gig9GqQl9Zod0tTLelwXp8OinmXNRS5mPoQ2ZtEBnQrzzR9EsXOqTNDqQmy8IqAGyHYJbL0FtrpCdX8/1aAB8gz4hW4SmqfKvD2IowwxWHXqbM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5/I5g+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5/I5g+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0CF1F00A3A;
	Wed,  9 Sep 2026 01:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915677;
	bh=qe0JP6nn6ScWUsODPOnevahasFQUjOtCwSbhXd4Eboc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=V5/I5g+iKigzbG/jlFVllY8vwv/+SRSCajiqdf3LbUvw8gw8+HDtoOXMBDPY9rEJm
	 X1PhDrSoCtK3M/CO9NuIcbaCCIHn4PREnpy8wcNgHBo62ygK+jm6cWkJ5RpI1KkolV
	 7ubbKzZvaVL2ElBcDnh+3dwUA/V+lM0zGRE8XDWMsWuDSuVort+AFv0R04sJ5+TYmp
	 e1I4b6y6HOn3I09pj+pS3keI7jPotKAUo/ghwDVfQdTPYf/oG3GQORBbKSkDTFlD5x
	 dHwZgcXl/g++nlVFm8p1u+Wxld9STwzljZA5SsioZE0f2Q5mVj7QnYL/uW2a4sSwuZ
	 Hjj2vZL571OUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C8C380820D;
	Wed,  9 Sep 2026 01:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/1] net: bridge: use option bits for CFM/MRP frame
 handlers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178891561534.92311.10499122115839665725.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 01:00:15 +0000
References: <cover.1788417901.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1788417901.git.zhilinz@nebusec.ai>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, henrik.bjoernlund@microchip.com,
 horatiu.vultur@microchip.com, vega@nebusec.ai, zylzyl2333@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 14:56:13 +0800 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/bridge/br_cfm.c and
> net/bridge/br_mrp.c. The bug is reachable by a non-root user via user
> and net namespace.
> 
> We've tested it, and it should not affect any other functionality.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] net: bridge: use option bits for CFM/MRP frame handlers
    https://git.kernel.org/netdev/net/c/7a49e6b16f36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


