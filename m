Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FE42F60B2;
	Tue, 22 Sep 2026 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038277; cv=none; b=J9/Uf6pvjJqSbjM+yKy4tZrUTYdVnW747hxqlqCkfHqbjo9psTwgq6OOefZ2ZEYpKOMDZSzKqtbfijBa7a4VlOR7IYpUeZd65okWOsNMEXCKgD2HL/6ZzSXtPUgUqOe3OtDxCjZNXozELsXm6NyG2/Ry3LfywCvlDQeHTtocXAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038277; c=relaxed/simple;
	bh=XPnrRnmoVbYM+gANGJotvHbtyeUVC9eXk8xkBRFYyx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dH9M2gCSE5813d53kbmmYdEh0JOet55PLKq2lg4yQ5zoP6UgVJiMVs7ePwjnXjvcKgeUt3MnQbF4Yrd2kknRfO0CzR442W/ZC/l+cXCMKCtN+vwmtEt+SDsrGwOxX/4TqI6pvQ8n50pC5jo8ioXikhvL/xlgfhgmmETSLpcRTNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBCtUg8y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBCtUg8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84341F000FF;
	Tue, 22 Sep 2026 00:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038275;
	bh=M/EGhUNyOjiv69FuqXOz9IYGQ8zPdA+OLDNFtrBCCFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NBCtUg8yGk4kGud1B/APADH5JOedP7DD4DLRfSR0hFJDmLuUcTnOXMl2VmQ3Ouzqp
	 mK96JYR+uMkwepBmt3liZMLWZlMy9G6bakpfBNhLe6h9JK65RVmP9AupkV3FnVF2hY
	 kYaTElHOgrYGOTLUVQOkRWWR1Jd70ZRRCQ4BoBiGdqVMftgOMcUB4l2c0xFWNwUQOn
	 S9efc4qQ+mw8O7Uw7UXaoyrpNqNpVf4hVDeDsrI8qiv4EMXbrcGWBXTxRkw6C2xOEL
	 HBXnrgzM+idE3Or3h65PaAcOoypRRZprZG4cSE4b8kmLPxgZ/FVVpP/7XDLV6E4X77
	 jkSeDNkPZm4Qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568A03930205;
	Tue, 22 Sep 2026 00:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: bridge: vlan: broadcast fwding path
 optimizations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003820717.3312649.14212413224809356956.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 00:50:07 +0000
References: <20260918152950.1938259-1-razor@blackwall.org>
In-Reply-To: <20260918152950.1938259-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Sep 2026 18:29:41 +0300 you wrote:
> Hi,
> This patch-set is the first step to removing unnecessary VLAN hash lookups
> from the bridge fast-path and also provides additional broadcast path
> optimization by considering only the port-VLANs that actually participate
> in the VLAN instead of all bridge ports. Combined these changes bring
> considerable improvements[1] and open the path to do the same for the most
> common fdb forwarding path. As expected the pathological cases have the
> largest gain, e.g. if we have 1 client / VM facing port and 1 upstream port
> only participating in a VLAN with many other bridge ports, we consider only
> those 2 when broadcasting in that VLAN.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] net: bridge: factor out common flood completion handling
    https://git.kernel.org/netdev/net-next/c/d7fddeed325d
  - [net-next,2/9] net: bridge: factor out port flooding
    https://git.kernel.org/netdev/net-next/c/25622bef8885
  - [net-next,3/9] net: bridge: vlan: cache the pvid vlan entry directly
    https://git.kernel.org/netdev/net-next/c/b82e41db0085
  - [net-next,4/9] net: bridge: vlan: introduce a list of port-VLANs in the master VLAN
    https://git.kernel.org/netdev/net-next/c/f69acdd819b0
  - [net-next,5/9] net: bridge: consider only port-VLAN members when flooding
    https://git.kernel.org/netdev/net-next/c/d5219589e4cf
  - [net-next,6/9] net: bridge: vlan: use an RCU array for large flood sets
    https://git.kernel.org/netdev/net-next/c/9c30ccaa7327
  - [net-next,7/9] net: bridge: introduce a forwarding destination structure
    https://git.kernel.org/netdev/net-next/c/911afcbaa7cd
  - [net-next,8/9] net: bridge: avoid egress VLAN lookups when flooding
    https://git.kernel.org/netdev/net-next/c/4e0c8f54f605
  - [net-next,9/9] net: bridge: avoid VLAN lookups for flood neighbour suppression
    https://git.kernel.org/netdev/net-next/c/fee4e7663e5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


