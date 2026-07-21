Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920C480DCB;
	Tue, 21 Jul 2026 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630442; cv=none; b=NqdARGPF0arE5RMIdspWwKXfXVUALSTA4R5cHO+uMhFM/zPI+PF+xwvuONDsWKwr73TMBB68Bmp/JF0y+vE/k3w9LOg6xuzm5rc5uliC8T5OhHSy5HK80Op0XwX6DwFyqo3O/1GoxvLhIkm1FAJ8owjmt3pk6XdUfRHDVGuevQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630442; c=relaxed/simple;
	bh=pe8WyrDJaqGxPqbobj1TwLfER952ENUqAFB0IqS0KqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qLNUnmGdKt16igjILb0UI6ncarh4oXj8EdKEpwrSZv/c91rLVvEL2OWRbciEwO6SOFlMBiazAjx4Sf5ho64Oxdg9Cgh84zQnyiRs4A3bJExryBfnkH2WDb+cDKfVu+fxaZNaC/bvckIUePjZRPdIFASaJCMWq2Ya3o83Mb3Fg+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNPOyv2r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNPOyv2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7011F000E9;
	Tue, 21 Jul 2026 10:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784630441;
	bh=bX+HUtREe6dblNJCPSDvdY0BZRT5X3ZJ1fsC6M7iFMc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gNPOyv2rs12UJedrPZ0fpeQ5q7e+0k9zs0LKbCViNrwxfNkSdWYG9VWIlObXxFSzi
	 1qmwEa5G8obwVpPZHmHUh9BiiUnSBNV9A+lFzvMNwzjcN8fBa1oT5022uOHhZW6GTA
	 Xjb/E7tin7SWZCNMJNfeHsXsZbJu8DRbJF+j/ZzsC303JdZ/bZGGu+TCj+8ZF4qaak
	 +178bAPErinpTu6uIV9OCkUDGodHFukjZWW5xB95kjzDt5AiC9y99AxzQHlhBuysBP
	 1MYEccG3985xG7wyZ7ifurdtuX4XJrr2xe7VLFdwhJwBuFQ2x8mx/QoPuqmB0v9O4L
	 yUyYGTenPraCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198243924A70;
	Tue, 21 Jul 2026 10:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] bridge: mcast: Fix a false positive
 lockdep
 splat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178463041064.221494.2647422230949250489.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 10:40:10 +0000
References: <20260708122820.1298718-1-idosch@nvidia.com>
In-Reply-To: <20260708122820.1298718-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 razor@blackwall.org, petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  8 Jul 2026 15:28:18 +0300 you wrote:
> Patch #1 fixes false positive lockdep splat. See the commit message for
> more details.
> 
> Patch #2 is small cleanup following the previous patch.
> 
> Targeting at net-next since this is a false positive that is only
> visible with lockdep enabled and the change is not small / trivial.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] bridge: mcast: Fix a false positive lockdep splat
    https://git.kernel.org/netdev/net-next/c/4b0eb6fbc1fd
  - [net-next,v3,2/2] bridge: mcast: Remove unnecessary argument from br_multicast_alloc_query()
    https://git.kernel.org/netdev/net-next/c/dbda4c27bd77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


