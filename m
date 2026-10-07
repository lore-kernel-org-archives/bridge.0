Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C181B4223;
	Wed,  7 Oct 2026 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336614; cv=none; b=XkI+SWiWn20wiKgyLDxD5w1gTFDHp4iy3xdXKBufhd4HymnE45OgbyPBtIIAzDF9u2zqGZKRtFBdU1Np9qENSBD91adYNbV8J/1ENIJud7d2Eo/jooHhg6KdJPaDZweVPfmi+ri3AceEg/qKXetE1dT/aA7hxMmCAjXHoUT/fbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336614; c=relaxed/simple;
	bh=2cB+kwDdTD6hsxibhrNIjD+nJB2IWSS/Sg1uFerhwww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fcPMc08DWUZ5t6S40a4A2skw+PxTWC5NmN8CaXxfo6pEaCNeVWcKnJW0W3FbuiVEAJytS4nPJ9xtn0g5T+/MmkmJgEJBfF/ce4QSPLVgf/6x8R82zAM0ca6F9GbXqDoi9CU7F4ZuHtnsRhOFqIoYWnSGr8chGawjZEt84zgVNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iftcMXD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iftcMXD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447891F0089B;
	Wed,  7 Oct 2026 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791336613;
	bh=1wXHNWyLLRDSHABsTlC43r9Aaj4a7Oi5zgVj8eTlEJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iftcMXD92JzdyJKejX67FnEcekNzok/yCdDAccxPdv/o0JVdT7nRLCEN7wgihBikb
	 5CyWClmkNTGyn1XZ+fY9g6AYcyF3DrKREqbPZEI7k4F/BDD1vjhMD6jfbtZilktVVS
	 kQyLa9zP5zidCpZiKDy7MsUSFB3MPT87DJbyM4TDrrnbtO+TTOhB8GOs+mAH+9wQoh
	 lOW6SUota5uQ+QMTiEWbrp9Mkw/Cy3nbla3Lt4HbEP1G4BtoisYnS+NHeqvdXqCp7C
	 OCJEAZ5JiID97o7BikdMsguskvBh8Ria9W5ORyC801XEBHrPlLUbLUCKp3jLsWH8uj
	 +ZiqNSVIew6Xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4813806541;
	Wed,  7 Oct 2026 01:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: bridge: fwd optimization cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133661177.2858290.10485392290539921181.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 01:30:11 +0000
References: <20261005143937.877466-1-razor@blackwall.org>
In-Reply-To: <20261005143937.877466-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 17:39:31 +0300 you wrote:
> Hi,
> This patch-set takes care of the review comments and also does some
> additional cleanups after the recent forwarding optimizations. The first
> patch and the fourth take care of Ido's comments[1]. I have folded his
> suggestion with inlining the pvid helpers which aren't necessary anymore.
> The second patch takes care of Sashiko's comment[2]. The rest are
> additional cleanups. No functional changes intended by any of these.
> For more information please check their commit messages.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: bridge: rename dst to fwd in br_flood_vlan
    https://git.kernel.org/netdev/net-next/c/46d20a256be5
  - [net-next,2/6] net: bridge: fdb: update the comment for br_fdb_cleanup_by_dst
    https://git.kernel.org/netdev/net-next/c/6317ffc9bdd0
  - [net-next,3/6] net: bridge: vlan: share VLAN validation in br_should_learn
    https://git.kernel.org/netdev/net-next/c/33c73892eaab
  - [net-next,4/6] net: bridge: vlan: inline pvid pointer updates
    https://git.kernel.org/netdev/net-next/c/1fbe2d9d37ad
  - [net-next,5/6] net: bridge: fdb: factor out configured entry destination updates
    https://git.kernel.org/netdev/net-next/c/d65082c8bfb8
  - [net-next,6/6] net: bridge: fdb: use the entry key in __fdb_update
    https://git.kernel.org/netdev/net-next/c/8f8a20dc7bf0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


