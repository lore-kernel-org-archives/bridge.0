Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630674005;
 bh=AGgbOdSzpaAML4LgVInM2rkoEUdrV9Ncc/pxqjPQmE4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=a0NQcz6dswV9m90yGOVybZcuAwoS9jGhdMzDBENKcxCeMTTBED6B7ifnUgVb1U1G2
 10Th34CfDV47zgkf+cynhVZCKNZVJ0WcxL8uB0aHWe30npA6PadBXX0pAS0ZGYSxCP
 V47xK7uL/63vWOKfh+q1Hm7RIlRekuXyF+/75bn8VdzSkAEsJQe/xgYK83LYg7xVDN
 FP770EI2qxnHes7PD8tBekerM6B0a94Rh9z5QbGuXOlCOxjGhGTO4KFqecm7gMcAuU
 BRJoMMIG7ULXNGsArBvWrha/G4aUplySw68rD8eb2JTPLmcpaGGfOAtjf+l9V5XbV2
 ITB6lFh+3nCJw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163067400574.8696.628852222789312507.git-patchwork-notify@kernel.org>
Date: Fri, 03 Sep 2021 13:00:05 +0000
References: <20210903093415.1544837-1-razor@blackwall.org>
In-Reply-To: <20210903093415.1544837-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net] net: bridge: mcast: fix vlan port router
	deadlock
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

This patch was applied to netdev/net.git (refs/heads/master):

On Fri,  3 Sep 2021 12:34:15 +0300 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Before vlan/port mcast router support was added
> br_multicast_set_port_router was used only with bh already disabled due
> to the bridge port lock, but that is no longer the case and when it is
> called to configure a vlan/port mcast router we can deadlock with the
> timer, so always disable bh to make sure it can be called from contexts
> with both enabled and disabled bh.
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: mcast: fix vlan port router deadlock
    https://git.kernel.org/netdev/net/c/ddd0d5293810

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


