Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652946012;
 bh=vcohhxrcH1q4h2W5s5L2qwUQGpsxZdvn23PCPcE3/Ds=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=sS3CHmuZhKDmKTGuE6j8eJrscDRmN0OECSbe+QIdvXDeSyvl5preNm3zQvYVOstNT
 8+idXefdGIriIdtRU0rGFKBsT2M6a2KJcDQJAf+/gy8piAneh6W3Y2y4ueIsJbZ+es
 TN131VCcN5MRbr/ofIz3QlIme+Pek0+22l5p36mNEeE8iroZN/ow5rp3cUO3I3P7+P
 YLl62ob/GKf+UXSw7CU0NpFGiKccgkMkDGhaq4jIPYifpAdN2TAnS2bx4gfMI8TydM
 S+rJGZyPfwFUABTsdaxojuIjxuTVzvnZFuqWUzyoMQaSlKrR5UjumOUD7flyoBaS/D
 zE+JFHX4zF72w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <165294601206.2340.13222966776558845980.git-patchwork-notify@kernel.org>
Date: Thu, 19 May 2022 07:40:12 +0000
References: <20220518005840.771575-1-andrew@lunn.ch>
In-Reply-To: <20220518005840.771575-1-andrew@lunn.ch>
Subject: Re: [Bridge] [PATCH v2 net] net: bridge: Clear offload_fwd_mark
 when passing frame up bridge interface.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: idosch@mellanox.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 May 2022 02:58:40 +0200 you wrote:
> It is possible to stack bridges on top of each other. Consider the
> following which makes use of an Ethernet switch:
> 
>        br1
>      /    \
>     /      \
>    /        \
>  br0.11    wlan0
>    |
>    br0
>  /  |  \
> p1  p2  p3
> 
> [...]

Here is the summary with links:
  - [v2,net] net: bridge: Clear offload_fwd_mark when passing frame up bridge interface.
    https://git.kernel.org/netdev/net/c/fbb3abdf2223

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


