Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF1338584;
	Tue, 17 Feb 2026 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771330218; cv=none; b=h2hC+vFIKT98WM+vt3jwKwuhqaKTNQnNoVnVlJlvWaZxWpOkzgBPHIUzRHmuqGu4wrMdkVF22w1TlgcYwmkrOgK8nC+wfjZK0Umk9EJRALYv1n63zFlSsySVZsNL7bRjWT98c1GmO+6ELP2KbviYTXswKYLtgGnJzq6FP3jbTyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771330218; c=relaxed/simple;
	bh=zO/5AjSr7L57JMW9SFPO8FSwfRar3Pqza5QICyZloRA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mMWErsDp1gcBoylEiLHRSDGzUABFGA8xRoDcAXPWbPDbSmAwYrDSDzxNbltzwIEjbL7MXU9ngrJD3OX7KBrAAd3nhkEgheKZP3Rn9bbzfF6w1Y8/+ARpUs0J04reftQaHujxL1BUyqXE0LpleZfsDsvyEuEaUkO9cJFXImUoNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYS8QrJM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYS8QrJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F908C4CEF7;
	Tue, 17 Feb 2026 12:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771330218;
	bh=zO/5AjSr7L57JMW9SFPO8FSwfRar3Pqza5QICyZloRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QYS8QrJMH4qUklowNQ2PXAiNXq+SFaW6xJtrLaRJfitRr3nkn0nF0OGYi7IV8lTPF
	 cODceGXCrjNLfHuIzfvZBibM0Xr5ptCnhPYB73W/4QPA6YB4h2jwM1GCxazDooyrHA
	 mgfUGyRX9DRx44hYA4tRgv9/0ZILWjTdhImlByShBjfeqnkfojESfi2ieJGBaFG0/6
	 yAphQlFTr/DkkCSN8qSuy1f9nw8Uy6+gCMG9lInJT38mbWO8yCGHBct/H9crnYD9ZL
	 kMs5V11+Az6v7m5fzkZFTmlLDA1NeUT7xtLXr5RoBsx2De8DQGjs0R8RDK2KgGlC0D
	 6S2B8BGbR4t2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 480E0380AAD0;
	Tue, 17 Feb 2026 12:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: bridge: mcast: fix mdb_n_entries counting
 warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177133020982.47903.3693855101556171993.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 12:10:09 +0000
References: <20260213070031.1400003-1-nikolay@nvidia.com>
In-Reply-To: <20260213070031.1400003-1-nikolay@nvidia.com>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 petrm@nvidia.com, bridge@lists.linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Feb 2026 09:00:29 +0200 you wrote:
> Hi,
> The first patch fixes a warning in the mdb_n_entries code which was
> reported by syzbot, the second patch adds tests for different ways
> which used to trigger said warning. For more information please check
> the individual commit messages.
> 
> v2: fix 2 typos in the selftest, no changes to the fix
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: bridge: mcast: always update mdb_n_entries for vlan contexts
    https://git.kernel.org/netdev/net/c/8b769e311a86
  - [net,v2,2/2] selftests: forwarding: bridge_mdb_max: add tests for mdb_n_entries warning
    https://git.kernel.org/netdev/net/c/a8470953b4ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


