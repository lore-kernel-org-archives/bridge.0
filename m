Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635512407;
 bh=EjgqJvYcxzTW4ZFSj8a1Nqzq1SYLWuXllXv8KvZGmr8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=hRWdlxWFL/R3pDTGk9bPc7Q4DdE6CXpvwNgH6qe6iGgDHhvZ/NRzbtbwG151cPySS
 aTypMFFIRdw52+uPB2Er7BI4Ab/zOhFfTlsb9eyMjs27nYyiHHdDO5nXfbeO6eHCwx
 cZBX/CPgedYQqzTInZNhUdrR9o7F538PROmfvOIrKavCUghBKjAcmC/xKn9FQa8p76
 KH7taMk3aD5bE/XXlJ+khY7HyXRlFZM6cNy84lJH2qktVlcS+EOs26FabH9pjspdre
 ffZ9L3ILnuI/5AYn7TydPkEPqLJ3BZL16emUmaMqV+eCDnHVGXP0IPuCRC9otkNSYb
 iMfQfwlEuNIww==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163551240692.5054.16014732669098206950.git-patchwork-notify@kernel.org>
Date: Fri, 29 Oct 2021 13:00:06 +0000
References: <20211029120527.2716884-1-razor@blackwall.org>
In-Reply-To: <20211029120527.2716884-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net v2] selftests: net: bridge: update IGMP/MLD
 membership interval value
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 29 Oct 2021 15:05:27 +0300 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> When I fixed IGMPv3/MLDv2 to use the bridge's multicast_membership_interval
> value which is chosen by user-space instead of calculating it based on
> multicast_query_interval and multicast_query_response_interval I forgot
> to update the selftests relying on that behaviour. Now we have to
> manually set the expected GMI value to perform the tests correctly and get
> proper results (similar to IGMPv2 behaviour).
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests: net: bridge: update IGMP/MLD membership interval value
    https://git.kernel.org/netdev/net/c/34d7ecb3d4f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


