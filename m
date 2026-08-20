Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164753B635F;
	Thu, 20 Aug 2026 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262060; cv=none; b=TGSgQ2d/EOij4Htv+ZuYded05vXfW8TyM3Mb9OABXJkTR/RPji5ibjLg6cHLFIxUHcddG4T11M5sRSrzX3TikE7U1Cd8VLqEcXrSW34PSZFe0m/0WSZPOj9TK5oXoXB0tLJLu0gZUlITY10Hr57biaMLjcydkyzcxWc1rXhQsdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262060; c=relaxed/simple;
	bh=exiL6wswRhdaNLKv4gWlXkWzdT3qcngBxtjdirjfBHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KdFt7bZxvHlGl/RALAX7yksdTZ1Utux06RZe9ngoYGLtlSlIaR7whkzKfLqnq1aAKCet9vLPb0x9iyr3cEJJ97z8vVrWkXW/qVj1UZe31zr99MoR+n1IFDwiG9k7YNuRkRRTFKSVv5ucnYM76+98LMzh72d6QxjXkiNF+KsSPfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0lWkqwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0lWkqwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCD31F000E9;
	Thu, 20 Aug 2026 21:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787262059;
	bh=Mcv4XeP+PwYem57cnu90VC04Jhu5bbOrnk8icEboUBA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g0lWkqwbFckdi/16uvwysio0Xwi7h50SnmuCjBDmBoeMGGPZ1EgPUMfr1TqdnFWuu
	 ls4ypkjrM9YQDH/MnSlh1liF6Y52fizPBVVjsx1AntAJmjJzPASh6YbW6IfS+ewsDh
	 4omcIdqAvB0mWNF4hKBJzCm6FO7mml6ONJD3rBV6m3BKsZMSLgIZtd4VZdQtPq9T/e
	 zL5j3XfID2dRvsmESAPqo76n5v8kH6qnUEGlf9CJKllMPs3htG/vb1FIGn8aGt99pg
	 GIJKjjxWAiwzdeoLt5I6/D7LxxHGymV6UYAlicy4gFkSixmdWq/+6FyyrJBNBpwSqd
	 pgx/0RZdkfG2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569683811A44;
	Thu, 20 Aug 2026 21:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] bridge/vxlan: fix reading neigh ha without
 synchronization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178726200889.500714.12664805984672388732.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 21:40:08 +0000
References: <20260818150756.890025-1-razor@blackwall.org>
In-Reply-To: <20260818150756.890025-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 roopa@nvidia.com, bridge@lists.linux.dev, andrew+netdev@lunn.ch,
 dlstevens@us.ibm.com, amwang@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Aug 2026 18:07:54 +0300 you wrote:
> Hi,
> Neigh ha address must be read using the seqlock to get a stable snapshot.
> Both the bridge and vxlan read it directly and can see partial updates.
> I reproduced both issues with running neigh updates and exercising these
> paths in parallel and saw partial addresses, e.g. updating between
> neigh A: 02:00:00:00:00:00 neigh B: fe:ff:ff:ff:ff:ff was able to observe
> 02:00:ff:ff:ff:ff and fe:ff:00:00:00:00 in packets. Noticed this initially
> in the bridge, then checked vxlan and its arp/neigh_reduce functions have
> the same bug, route_shortcircuit is doing the right thing already.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: bridge: arp/nd proxy: fix reading neigh ha
    https://git.kernel.org/netdev/net/c/57549ab90791
  - [net,v2,2/2] vxlan: fix reading neigh ha
    https://git.kernel.org/netdev/net/c/b824059a673b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


