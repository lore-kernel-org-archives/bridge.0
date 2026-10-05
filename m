Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1F547072;
	Mon,  5 Oct 2026 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791168008; cv=none; b=fUw6BBGR/kSUnIO+wnNGbDzWvdz/bsycNP2oIoAtrBcR11J9xqUW6/vETMVZ/lBK1XxvkGHW9y4bLJRqahqjrPekpvo1pS0YnnGTi+qn5RFDsAlIghE7zKBwl913RrFuQeh09vNU2uzQ7X5LRHnA7bbtx32NC70F45jNORUEJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791168008; c=relaxed/simple;
	bh=GP9fG0UMPC45mYTx62aTlXSzwe3JXU4m9vYlKXJrDqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WGgAtvONqTpq2W12mTY8ghAYgJLj+jONPI/cmBEsYb31ONGOzfeyxXHlIGDuHTsmdx3ugrFjyrefh2boVtGr1DqN2lrelRfXbuViWj3x3KFtPEMA+oosI4gw1h37s9aqqitZULlIdALw05gkn+SFZM2NS66nb3vOJtK6HhSzNwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqVEXOsy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqVEXOsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8037A1F000FF;
	Mon,  5 Oct 2026 02:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791168006;
	bh=nkjQAKyrF3kkwgnL/heq8nloDAye+FT3WOyCMCl5pMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JqVEXOsyzwSW/X5EBadCGM1KB5cGR1hw6/bvR0WYIqFkgo7+FNRMme0IylzF0dmJq
	 SPmF1f5AMZiFl6rdRydPG+eTif0choAD3pQ9QrICjh1XGbEZGcyBwymm7K/EJ+qTm9
	 fTW7UBHEbgBys52zlqZcUTMFzQCXORIydbBwV+Wf2Vvnold7i8Hgbf60xTLdUR3+fd
	 VXwYiI1lwwt0wDQcglEybizVKcp9/ezdsnxDU5Ki9KrpaERPjpTn2q0hCX06p1ZN/N
	 V4G/dGAiT+sFumVPZic+2rWmFoyybG1X+bhOzTMEJekiJ2CKpR7OJpYw5EQWkjmtYg
	 fROyfL/+tdgPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772F139253C0;
	Mon,  5 Oct 2026 02:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] net: bridge: avoid recursive multicast cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179116800528.1069246.11562984465867520213.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 02:40:05 +0000
References: <cover.1790323012.git.petalzu987@gmail.com>
In-Reply-To: <cover.1790323012.git.petalzu987@gmail.com>
To: Ren Wei <weir@nebusec.ai>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, razor@blackwall.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai, petalzu987@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 27 Sep 2026 01:04:38 +0800 you wrote:
> From: Zixuan Chai <petalzu987@gmail.com>
> 
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/bridge/br_multicast.c. The bug is
> reachable by a non-root user via user and network namespaces. We've tested
> it, and it should not affect any other bridge multicast functionality.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: bridge: avoid recursive multicast port cleanup
    https://git.kernel.org/netdev/net/c/5158353121ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


