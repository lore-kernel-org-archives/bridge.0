Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613179209;
 bh=oNYc7M3BMkbfiaGU0JhXA5uNqthn+1gjQRUzoHS6Hts=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=hRwaAlWaJHxKIOEty8NmWnOtnt5bPMGr3WwhHsQHSEf8gUP14/lyy2Kl0qwMsePFB
 XQ7PBCzVh+wGFJXSDG6yW5Zj8+6wi025y7MRumsosTZ3VaCakyg0jMvaTX5IgUYLbm
 XB1eeceC2je+zHrJzyhauPaL1I9/+rQJMXscBse2BybHggbbzG6vhpovFJ8CGXhF3u
 dFAXErSMYm6NgAaGMkOb0k+8diaix79a8W/rBFHm2z/7+GAQOMQOQqo0XAHhv9GYUV
 p2nuBWvqOaHyqKbJEc4ZBZ4C/CngIxetT0sWMkwSVh5PKdi/QpC8hh736NyPI3nF7s
 EBJdWxNz/AKCg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161317920975.20729.8209116338649427486.git-patchwork-notify@kernel.org>
Date: Sat, 13 Feb 2021 01:20:09 +0000
References: <20210212151600.3357121-1-olteanv@gmail.com>
In-Reply-To: <20210212151600.3357121-1-olteanv@gmail.com>
Subject: Re: [Bridge] [PATCH v5 net-next 00/10] Cleanup in brport flags
 switchdev offload for DSA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: andrew@lunn.ch, alexandre.belloni@bootlin.com, vigneshr@ti.com, idosch@idosch.org, ioana.ciornei@nxp.com, ivecera@redhat.com, f.fainelli@gmail.com, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, vivien.didelot@gmail.com, grygorii.strashko@ti.com, jiri@resnulli.us, vkochan@marvell.com, claudiu.manoil@nxp.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, tchornyi@marvell.com, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Fri, 12 Feb 2021 17:15:50 +0200 you wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> The initial goal of this series was to have better support for
> standalone ports mode on the DSA drivers like ocelot/felix and sja1105.
> This turned out to require some API adjustments in both directions:
> to the information presented to and by the switchdev notifier, and to
> the API presented to the switch drivers by the DSA layer.
> 
> [...]

Here is the summary with links:
  - [v5,net-next,01/10] net: switchdev: propagate extack to port attributes
    https://git.kernel.org/netdev/net-next/c/4c08c586ff29
  - [v5,net-next,02/10] net: bridge: offload all port flags at once in br_setport
    https://git.kernel.org/netdev/net-next/c/304ae3bf1c1a
  - [v5,net-next,03/10] net: bridge: don't print in br_switchdev_set_port_flag
    https://git.kernel.org/netdev/net-next/c/078bbb851ea6
  - [v5,net-next,04/10] net: dsa: configure better brport flags when ports leave the bridge
    https://git.kernel.org/netdev/net-next/c/5e38c15856e9
  - [v5,net-next,05/10] net: switchdev: pass flags and mask to both {PRE_,}BRIDGE_FLAGS attributes
    https://git.kernel.org/netdev/net-next/c/e18f4c18ab5b
  - [v5,net-next,06/10] net: dsa: act as passthrough for bridge port flags
    https://git.kernel.org/netdev/net-next/c/a8b659e7ff75
  - [v5,net-next,07/10] net: dsa: felix: restore multicast flood to CPU when NPI tagger reinitializes
    https://git.kernel.org/netdev/net-next/c/6edb9e8d451e
  - [v5,net-next,08/10] net: mscc: ocelot: use separate flooding PGID for broadcast
    https://git.kernel.org/netdev/net-next/c/b360d94f1b86
  - [v5,net-next,09/10] net: mscc: ocelot: offload bridge port flags to device
    https://git.kernel.org/netdev/net-next/c/421741ea5672
  - [v5,net-next,10/10] net: dsa: sja1105: offload bridge port flags to device
    https://git.kernel.org/netdev/net-next/c/4d9423549501

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


