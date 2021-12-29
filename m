Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640816410;
 bh=hjQAZLb14OJobDPleSQaofwFXchb/C4eBEa+U9p+ttc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Oik0sPGUriGqzI8p2ImomrRWct0hF9V/m4lZO7KxzZ8xNX2kRj59hoPVoOhQE+lZH
 O6EEJwO2vCBOtk4wd4gVN7XgrHx3vevoIhV9jVkWMsnPLUSl2wTDFi/z+CKV1X+qbY
 H27Gv8nY2kHXvzqK1ikzUSGeRtIxLg152g1Bbwvt0LU3242MLOherO96NefOwzBCDO
 miuUQz3ODjkAT2wTX86GGL/d6Uz+D6IyZj0psqcwlw/2rI5M7LES4Pi9IUN90nKqZc
 ZJ5IKxBvta9Gg+JwVD/dfllsT6eR9xdCd8IWDvA/d8L6vHrLMCBx1dLkkjC0Dft1kN
 +axquupsYItnQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <164081641003.5072.12853974016606114194.git-patchwork-notify@kernel.org>
Date: Wed, 29 Dec 2021 22:20:10 +0000
References: <20211227172116.320768-1-nikolay@nvidia.com>
In-Reply-To: <20211227172116.320768-1-nikolay@nvidia.com>
Subject: Re: [Bridge] [PATCH net 0/2] net: bridge: mcast: add and enforce
 query interval minimum
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: herbert@gondor.apana.org.au, eric.dumazet@gmail.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, stable@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This series was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Dec 2021 19:21:14 +0200 you wrote:
> Hi,
> This set adds and enforces 1 second minimum value for bridge multicast
> query and startup query intervals in order to avoid rearming the timers
> too often which could lock and crash the host. I doubt anyone is using
> such low values or anything lower than 1 second, so it seems like a good
> minimum. In order to be compatible if the value is lower then it is
> overwritten and a log message is emitted, since we can't return an error
> at this point.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: bridge: mcast: add and enforce query interval minimum
    https://git.kernel.org/netdev/net/c/99b40610956a
  - [net,2/2] net: bridge: mcast: add and enforce startup query interval minimum
    https://git.kernel.org/netdev/net/c/f83a112bd91a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


