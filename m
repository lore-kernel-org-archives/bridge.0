Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615932008;
 bh=dlBQQyI1j3pwN3CF6A6vVYRFLIMHHnkb3VOr9qpV3qs=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=LCD/XLrRtuj2GXQhkMi4DO5IRg68owDwT/yL388Vo6Pd8ML3/0zO1WZjxd7g4Mel6
 tmDqh4Z60bpdWGHDwRvDBTmmOsAfYpQUtb2+I6wPTzE8P8ev1rAFg5hPE4P9Kr6rud
 alPlpObOIR3U4Vqey3P6y3bHjWkf1HqYfXmqG84AG2YRrTYmxFPhukXC8co4Szws6I
 w3Vjkfu0iFsSPNM3SJXNLubzWV6r4mBWb6X3PPJOW2025VlkNAbX7cYA4a2tZsfjRR
 f08sgOgaLaey7UGshibmfbf7V2L0pkibGhmNFjyc3FoJCobj14u91t6Hw3x+vR5il7
 VvwT/RFXs+keQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161593200849.27352.15966391219237051428.git-patchwork-notify@kernel.org>
Date: Tue, 16 Mar 2021 22:00:08 +0000
References: <20210315171342.232809-1-razor@blackwall.org>
In-Reply-To: <20210315171342.232809-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next v2 0/2] net: bridge: mcast: simplify
 allow/block EHT code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Mon, 15 Mar 2021 19:13:40 +0200 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Hi,
> The set does two minor cleanups of the EHT allow/block handling code:
> patch 01 removes code which is unreachable (it was used in initial EHT
> versions, but isn't anymore) and prepares the allow/block functions to be
> factored out. Patch 02 factors out common allow/block handling code.
> There are no functional changes.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: bridge: mcast: remove unreachable EHT code
    https://git.kernel.org/netdev/net-next/c/6aa2c371c729
  - [net-next,v2,2/2] net: bridge: mcast: factor out common allow/block EHT handling
    https://git.kernel.org/netdev/net-next/c/e09cf582059e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


