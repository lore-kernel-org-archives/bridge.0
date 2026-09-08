Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4F8635D;
	Tue,  8 Sep 2026 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788827469; cv=none; b=cIlsRiwKDMuMT/RG3eCjZz+R6ruge400vHLIHFp7dq/ZZcajFuAG/t6mQJMzjEgLX8aHDaspyhz7u2L21c7vz1c651zyakz4pSul1RBh63kHrfCnaayRhMtKPTccufnzktqbL7r5FBFKvfNEOW5FsbU4yk9vMSqlVPJIGLmy7B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788827469; c=relaxed/simple;
	bh=syWCtcVOhHYaWiSY2r6xWRV8bi/kSeUCptT5uSzuy2I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D2LruHB63+Z5PjBnAeaHB10QdMAFRl6hpqgUKuoYndvYmT48++n1qD84DE6e4FEebuYK54/Om36O8m2PNv09vBC/s7DRsELB+MW3nv41f3i50dw7Tp8AH1jpnLvnGyuoHcPDdTb6g9gTDnTX+eZyPMJGkDZNFzPOtF2C1rHio7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMM6SYId; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMM6SYId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274C11F00A3A;
	Tue,  8 Sep 2026 00:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788827468;
	bh=aTfpbWoPV5Ks8QvIcH2YktfVQ76DB2/MKstCU7iSUGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LMM6SYIdZ/1t3R6//X2B6bv4xVkzxPSqiUMT7qh+pyTtfbEZ+F5wpIoI+WDM/MQLU
	 BDx2MX/ewDB9NetS7cgiyKi2OM9gbRdUhgud6Tf82U/66r12XA7G6ZJs+8F4Dd/ui7
	 L9yS6QAf6pAT35I/kmjSx98yUSB9gJBC0AFKnCF9jxrjpCPiNNdqVuhuFRw7leYQBQ
	 6uEtwouybGeLX9ThohQIxmPCP+hNUWhsTMeIRgwQaNKFBGm5UpdmSOYN6mjNokuy0m
	 1rm6lr/ihcyD8TB5UbZv2hu6cdin3YdxF1jXJ0uakdnqMmNdkZwP5PercBG3YakaJP
	 mm2+b/EcXcV5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569EE39E8A5B;
	Tue,  8 Sep 2026 00:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/9] net: bridge: vlan: minor cleanups and
 annotations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178882740714.3220068.17125741698366920545.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 00:30:07 +0000
References: <20260903143138.1574598-1-razor@blackwall.org>
In-Reply-To: <20260903143138.1574598-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 17:31:29 +0300 you wrote:
> Hi,
> In preparation for a complete vlan fast-path re-work, this set cleans up
> a few minor things - removing legacy code barriers that don't help,
>                      annotating lockless accesses and using proper helpers.
> No functional changes are intended. Sashiko will find many pre-existing
> problems, none of them are related to this set. I will try to fix
> everything pre-existing separately in -net, there will probably be a few
> critical items. So if there are missed places to annotate, or if there're
> actual functional changes, these obviously should be addressed in this set.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/9] net: bridge: vlan: drop legacy memory barriers
    https://git.kernel.org/netdev/net-next/c/581850fa732a
  - [net-next,v2,2/9] net: bridge: vlan: annotate lockless pvid use
    https://git.kernel.org/netdev/net-next/c/bd1aeca09823
  - [net-next,v2,3/9] net: bridge: mst: use br_get_pvid helper
    https://git.kernel.org/netdev/net-next/c/e46efd49e05f
  - [net-next,v2,4/9] net: bridge: vlan: annotate lockless vlan flags use
    https://git.kernel.org/netdev/net-next/c/2b1f8fd3118c
  - [net-next,v2,5/9] net: bridge: vlan: annotate lockless use of private flags
    https://git.kernel.org/netdev/net-next/c/b0bb0a45ce7e
  - [net-next,v2,6/9] net: bridge: vlan: annotate lockless use of num_vlans
    https://git.kernel.org/netdev/net-next/c/5bec8f861114
  - [net-next,v2,7/9] net: bridge: vlan: annotate lockless use of msti
    https://git.kernel.org/netdev/net-next/c/120207a08fc0
  - [net-next,v2,8/9] net: bridge: vlan: add missing tinfo.tunnel_id annotations
    https://git.kernel.org/netdev/net-next/c/f20c44811531
  - [net-next,v2,9/9] net: bridge: use br_vlan_get_state to get vlan state
    https://git.kernel.org/netdev/net-next/c/9ef138b168fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


