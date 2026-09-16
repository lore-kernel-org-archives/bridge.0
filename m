Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCFC3AD531;
	Wed, 16 Sep 2026 01:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522876; cv=none; b=t1OvbI+NTkZbPdPPjds1mTixDy59pE2C9cseWVZNChkpJMk6CLUzqkfIucbyKrkO03k2vfAJEUpNAUqiHNclXd9ShJ0TR8zAqhHLueyJt+IuBNf/sqJhQcw9GHmPX6oXSoDtG/+NpR+jg9RgXGVtgIneC0RCFe9bgp33Qr/pW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522876; c=relaxed/simple;
	bh=22SUxSzm9vvusPE+xr/CCwko9UejRwpVNps3bTWBiqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ibQUDOKF2EBWqzm/X7pYNQhMxtwyYQbSpA9tzmHsssB0xY0rJXeCeTB8oRj77Sc2H8JkiFD0FuzE4nBFZ8ZknXD4iDhuJuCI94j7edOEOz4RnhbQXkEPwxiYnr3h2Blz+/1fBR/qAsi445VnAWpbBimDmrsR+1gI/0BWPmUqyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ie+mESyY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ie+mESyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C021F00893;
	Wed, 16 Sep 2026 01:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522872;
	bh=LLg73K9WypjMqEe4/UeYonQSOml6ugIJtasY6LQ4MqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ie+mESyYWzjgumE88q9z3GuEwo7DQMUHj/OujEWJqRerzcf8NGZthIK61my7sh3r2
	 SYttseO++cZGhzrxcVtF4kTcrczO/nK047Xg9uz+l4qQ1p1PVo6Qh+dNHDUdJVhFGQ
	 cqk8mx+YFX3VcxBCFCLeuUw6wWgty2s9yj2vV0d1+Vr/LGTDNEL+y+PqdS12wJxIhk
	 Jn0WEJzTxwXwzjrPvFMIpXGYCGbKp1Gr/hTd/mcSwfJA738P/JN4DrpLbB3HxJojM+
	 qL12QUFw08GXDG4pe7TOtghStyldE33n1XH9ivgfMZ2idCRjlSd6+LD599BNLlh4fm
	 LUmYgH+fNdv+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A843927075;
	Wed, 16 Sep 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bridge: vlan: fix bugs caused by switchdev
 deletion errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178952280627.2353777.4268962467362600645.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 01:40:06 +0000
References: <20260914105258.3436918-1-razor@blackwall.org>
In-Reply-To: <20260914105258.3436918-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vivien.didelot@gmail.com, petrm@mellanox.com, jiri@resnulli.us,
 bridge@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Sep 2026 13:52:58 +0300 you wrote:
> Allowing switchdev to prevent vlan deletion and error out in __vlan_del
> could cause multiple different issues - inconsistent state, memory leaks
> when flushing, NULL pointer dereference on bridge error when flushing.
> It doesn't make sense to allow it to stop __vlan_del, so log the error
> and continue with software vlan deletion. This is also consistent with
> 8021q behaviour.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bridge: vlan: fix bugs caused by switchdev deletion errors
    https://git.kernel.org/netdev/net/c/2842ce397dd0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


