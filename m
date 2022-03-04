Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646395812;
 bh=Xieg0ITcJqTt/jIZLiexhbijH6baoMOJ0W7XtQGkkzM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=qs7Adw1hN+QtMwm6shLuEst5UfUV5331LQwMSDpww+D4iEiW0ZHDRBG4khl5mwlDa
 0Tn4o1Zf6YT3OF5RQBoYo2qdYJbH744V2oAei+fgZbbNyE+bMUEfcsPMyXq2UT5+uq
 o2F+YzWtER3Dz/zkw1pqP/FJlW8pXWH0732imUCqFkoCLdIVZs/Z5MVJD2wnCCg8yx
 V9QLXQmgp3dxlc43g3J/KtcNg4xHW6441wjpR7hDrPmm8t/CNuOBI15FnLHvsU2hHW
 aEnjr3s0akp5MLgFg3DmG/ybA4itaYzoswOzjoaywsyareJs9+44/pYetEYuVYbyC7
 nW7v75Ht5o9SA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <164639581253.6905.17402968335901101140.git-patchwork-notify@kernel.org>
Date: Fri, 04 Mar 2022 12:10:12 +0000
References: <20220303171505.1604775-1-bigeasy@linutronix.de>
In-Reply-To: <20220303171505.1604775-1-bigeasy@linutronix.de>
Subject: Re: [Bridge] [PATCH net-next 0/9] net: Convert user to netif_rx().
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: andrew@lunn.ch, linux-doc@vger.kernel.org, razor@blackwall.org, kurt@linutronix.de, jcmvbkbc@gmail.com, steve.wahl@hpe.com, horatiu.vultur@microchip.com, f.fainelli@gmail.com, corbet@lwn.net, bridge@lists.linux-foundation.org, roopa@nvidia.com, kuba@kernel.org, vivien.didelot@gmail.com, linux-xtensa@linux-xtensa.org, mike.travis@hpe.com, l.stelmach@samsung.com, tglx@linutronix.de, chris@zankel.net, netdev@vger.kernel.org, robinmholt@gmail.com, UNGLinuxDriver@microchip.com, olteanv@gmail.com, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Thu,  3 Mar 2022 18:14:56 +0100 you wrote:
> This is the first batch of converting netif_rx_ni() caller to
> netif_rx(). The change making this possible is net-next and
> netif_rx_ni() is a wrapper around netif_rx(). This is a clean up in
> order to remove netif_rx_ni().
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: bridge@lists.linux-foundation.org
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Horatiu Vultur <horatiu.vultur@microchip.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kurt Kanzenbach <kurt@linutronix.de>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: Łukasz Stelmach <l.stelmach@samsung.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Mike Travis <mike.travis@hpe.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Robin Holt <robinmholt@gmail.com>
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: UNGLinuxDriver@microchip.com
> Cc: Vivien Didelot <vivien.didelot@gmail.com>
> Cc: Vladimir Oltean <olteanv@gmail.com>
> Sebastian

Here is the summary with links:
  - [net-next,1/9] docs: networking: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/21f95a88eab4
  - [net-next,2/9] net: xtensa: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/aa4e5761bff5
  - [net-next,3/9] net: sgi-xp: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/4343b866aa94
  - [net-next,4/9] net: caif: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/3fb4430e73bf
  - [net-next,5/9] net: dsa: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/db00cc9da079
  - [net-next,6/9] net: ethernet: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/90f77c1c512f
  - [net-next,7/9] net: macvlan: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/566214f44697
  - [net-next,8/9] net: bridge: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/2e83bdd5d6cf
  - [net-next,9/9] net: dev: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/ad0a043fc26c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


