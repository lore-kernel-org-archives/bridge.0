Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA6332EC9;
	Fri, 27 Feb 2026 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163606; cv=none; b=M5MxRUvno6SShbqnrFVM8gMyS+qX1aS2G5ZBDwW2p2UYEi1TqVmwhYsQVbWuHDtRNRyNMvH9ZYT5O3M+/Fj/KlcO5AootJzNXxYCCl84W39A7uY2RYpoMqjO6jzJVuy36XHaoxsm8vZB4Aefaa0oGiPb45Tc8W4Z/LaLd0Iq/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163606; c=relaxed/simple;
	bh=oQWpT4KXw/jLSEL794lOUbVDdhlEjQMe+JKBmxzE4xU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ar+L4u/Sa2HFQUhjYKlEUDpe0coKGpqxiz/Wtl4Oei1Lu4GVfFM8Wt2FDSRDam7OsqduEp6EuqR+c3faymvAZRK/M+lRPHoBcfjdKeBvw09vja5GJUoQszkSqQ8J7TYM+vusrcbhttja3gAZxgn0M8WLIRzQsFg/ddoKlth9nL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz1ouvGb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz1ouvGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD76AC116C6;
	Fri, 27 Feb 2026 03:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772163605;
	bh=oQWpT4KXw/jLSEL794lOUbVDdhlEjQMe+JKBmxzE4xU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vz1ouvGboc/KSczUBHvbGEKnhAKzRQtP6QfNNF9bsFW/3YbuEjVmls7ezHKrV+mlI
	 NV589lw6p0MUhehhcAwc8td2mYK1O/bKQ+wILscWCAOK4FccQQ2DX+0bCvLcm7UZT5
	 2TVL5s/V1fSTpK0YKyvAAd53WmJsFZpkyEqt19B93GlsLLVFgVQgAXUb0QfwwMO6uP
	 76XlX4KtQvXkgVyfrnc4z0LmaespW923xM8FCCiHdDG/ug894feRJ0NSUK+OAIFI0y
	 JodwqKiHiQm/AddRqqPS2w2qeF/+rknh/EVq7FyoFHMwxYyoOP8ESqTf4F/ZvIka9C
	 lyELpPP4GUk5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF20393109B;
	Fri, 27 Feb 2026 03:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] bridge: Check relevant options in VLAN range
 grouping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177216361004.1960351.2978917328225513972.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 03:40:10 +0000
References: <20260225143956.3995415-1-danieller@nvidia.com>
In-Reply-To: <20260225143956.3995415-1-danieller@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 16:39:54 +0200 you wrote:
> The br_vlan_opts_eq_range() function determines if consecutive VLANs can
> be grouped together in a range for compact netlink notifications. It
> currently checks state, tunnel info, and multicast router configuration,
> but misses two categories of per-VLAN options that affect the output:
> 1. User-visible priv_flags (neigh_suppress, mcast_enabled)
> 2. Port multicast context options (mcast_max_groups, mcast_n_groups)
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] bridge: Check relevant per-VLAN options in VLAN range grouping
    https://git.kernel.org/netdev/net/c/93c9475c04ac
  - [net,v2,2/2] selftests: net: Add bridge VLAN range grouping tests
    https://git.kernel.org/netdev/net/c/13540021be22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


