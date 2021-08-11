Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628686208;
 bh=okMH6cOcp67xeZ4zRwpdQavn1PSzVxWv5rvITGDEiHw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=X5pP+kVY5cC/D9D7KWsGO5VaGMsAl9cMRGJdDYwYnFOrW+UcDc2dQ740JBDcgeKUf
 YmNUSeNV13mEKvZDxoySJmpZN8rBbu8+AjEoquT29RFOIrnDrz2Anw+qYsvtQvd5rf
 aJBkEA5+ZAuNUCygpXdplGzZXWpUb7vYLYee2SpleZ7IFHXGMRCf0BlzyyZxsgC2s8
 4xAc5H0KXV+Hl6GWEelsvtzu9qnoCVDXZ+Rw01W+3JJGybMIA9Rb0mBRZXfgrYP2YP
 lIyy3Pziqe+1qLQBLVubXq9f0CMeYB2Ms80gAm9WC4cHkGPtM34KVQN/Jay4sWZVZB
 iAeiSVs7NTXpg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162868620793.25774.11675995682393129413.git-patchwork-notify@kernel.org>
Date: Wed, 11 Aug 2021 12:50:07 +0000
References: <20210810152933.178325-1-razor@blackwall.org>
In-Reply-To: <20210810152933.178325-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next 00/15] net: bridge: vlan: add global
	mcast options
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

This series was applied to netdev/net-next.git (refs/heads/master):

On Tue, 10 Aug 2021 18:29:18 +0300 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Hi,
> This is the first follow-up set after the support for per-vlan multicast
> contexts which extends global vlan options to support bridge's multicast
> config per-vlan, it enables user-space to change and dump the already
> existing bridge vlan multicast context options. The global option patches
> (01 - 09 and 12-13) follow a similar pattern of changing current mcast
> functions to take multicast context instead of a port/bridge directly.
> Option equality checks have been added for dumping vlan range compression.
> The last 2 patches extend the mcast router dump support so it can be
> re-used when dumping vlan config.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] net: bridge: vlan: add support for mcast igmp/mld version global options
    https://git.kernel.org/netdev/net-next/c/df271cd641f1
  - [net-next,02/15] net: bridge: vlan: add support for mcast last member count global option
    https://git.kernel.org/netdev/net-next/c/931ba87d2017
  - [net-next,03/15] net: bridge: vlan: add support for mcast startup query count global option
    https://git.kernel.org/netdev/net-next/c/50725f6e6b21
  - [net-next,04/15] net: bridge: vlan: add support for mcast last member interval global option
    https://git.kernel.org/netdev/net-next/c/77f6ababa299
  - [net-next,05/15] net: bridge: vlan: add support for mcast membership interval global option
    https://git.kernel.org/netdev/net-next/c/2da0aea21f1c
  - [net-next,06/15] net: bridge: vlan: add support for mcast querier interval global option
    https://git.kernel.org/netdev/net-next/c/cd9269d46310
  - [net-next,07/15] net: bridge: vlan: add support for mcast query interval global option
    https://git.kernel.org/netdev/net-next/c/d6c08aba4f29
  - [net-next,08/15] net: bridge: vlan: add support for mcast query response interval global option
    https://git.kernel.org/netdev/net-next/c/425214508b1b
  - [net-next,09/15] net: bridge: vlan: add support for mcast startup query interval global option
    https://git.kernel.org/netdev/net-next/c/941121ee22a6
  - [net-next,10/15] net: bridge: mcast: move querier state to the multicast context
    https://git.kernel.org/netdev/net-next/c/4d5b4e84c724
  - [net-next,11/15] net: bridge: mcast: querier and query state affect only current context type
    https://git.kernel.org/netdev/net-next/c/cb486ce99576
  - [net-next,12/15] net: bridge: vlan: add support for mcast querier global option
    https://git.kernel.org/netdev/net-next/c/62938182c359
  - [net-next,13/15] net: bridge: vlan: add support for mcast router global option
    https://git.kernel.org/netdev/net-next/c/a97df080b6a8
  - [net-next,14/15] net: bridge: mcast: use the proper multicast context when dumping router ports
    https://git.kernel.org/netdev/net-next/c/e04d377ff6ce
  - [net-next,15/15] net: bridge: vlan: use br_rports_fill_info() to export mcast router ports
    https://git.kernel.org/netdev/net-next/c/dc002875c22b

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


