Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D36DDAB;
	Thu,  3 Oct 2024 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916030; cv=none; b=F0xLP725EzCdf+tC1KJTddFryLu0J0TFFF1dl4eu7tr0479zEdE6AelRQR0Tp3h4ASgfNNh36hhWD4U1uBMMnsps6Q5iUOsJZraJxnp5dDEcJSkAPlxDHOaGZRI7S9K+zde4Waha/NULqFfEdNBGz10syEqd3qA9vVQiqXoDPpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916030; c=relaxed/simple;
	bh=EYeYGpDRsjq+X6huno7OQTTtfXAmWoEKx69F4clRmu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PX/LVkt3o67OE+awQmg6jl2MSQfgCh1d1cvxEjjvYjfqYb9KsaPI/My2G06nyh8fz+KFkSLWArdk9a7O35dq/MjpcLZbqIKZSPeSsGAwuVbC+5wKxYTWtOO5XyCYOPIGtxrF+4dbj0Irmt/kTYR1dNQeE61d4zR4/6XKw0qJtcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFA/eJI5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFA/eJI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A7DC4CEC2;
	Thu,  3 Oct 2024 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727916029;
	bh=EYeYGpDRsjq+X6huno7OQTTtfXAmWoEKx69F4clRmu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TFA/eJI5+1MnSKorZguMJfeGR5HPcSf7zve7MA36ZvT2OOVn+5X+5PQ0TTlWzll1c
	 XF4wpRhudB/9PYKnKLUF9gPLIpbfL++hZor1C+/4fAiG1IZElqQHoVgGEa8AXpS+3Y
	 y+Rs6BZf266WPzBZuqsW7YWXixgTOGOb1ZJNpDeLx8Z2s2UQ/L5JJNqqycavlRO6we
	 2ULATU1Zsm60MmPshSOIlqjkg/9LoUOtoiBh5WTNhqHTRkSxLyUV0t5tfG7lNIj+JM
	 AiDh3Mva1Dg6z234t48Uh+zei40aEFs3X7W8FdytdwhuB/Rw4gkv5QTBpYG6hLsFzd
	 Tsmp04cPDEEVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFFB380DBD1;
	Thu,  3 Oct 2024 00:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bridge: mcast: Fail MDB get request on empty entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791603279.1387504.8070946238603199950.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:40:32 +0000
References: <20240929123640.558525-1-idosch@nvidia.com>
In-Reply-To: <20240929123640.558525-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, razor@blackwall.org,
 roopa@nvidia.com, bridge@lists.linux.dev, jamie.bainbridge@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Sep 2024 15:36:40 +0300 you wrote:
> When user space deletes a port from an MDB entry, the port is removed
> synchronously. If this was the last port in the entry and the entry is
> not joined by the host itself, then the entry is scheduled for deletion
> via a timer.
> 
> The above means that it is possible for the MDB get netlink request to
> retrieve an empty entry which is scheduled for deletion. This is
> problematic as after deleting the last port in an entry, user space
> cannot rely on a non-zero return code from the MDB get request as an
> indication that the port was successfully removed.
> 
> [...]

Here is the summary with links:
  - [net] bridge: mcast: Fail MDB get request on empty entry
    https://git.kernel.org/netdev/net/c/555f45d24ba7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


