Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612831807;
 bh=M4JvpIOeBLmk0O/aUhIaXU2I/lEjDKewFQhnmsn8vYQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=RbFt5eXRevJdlTFw/yTP/5pshC6Gzj9ILLzMp60gVl0hFDdZ+x6126oMDP6j87yt2
 DYCXtnXjDK9FoJimDUkxw+ZmjMZkYpbhYwtpH1gX3FMHYTGBVb0cMgFFls3Mx1JKLR
 h+mCP6ujdwIMjVwITUHslqlVieElTT6JWGUqvgKcG8mnrf8XJbuiKy98M6mDaIp+NO
 du8IkstUIn0UKUdE+ji7yLwOtcsW5bwY/cnvgPjkWHFRxNzhYk9tksuyLdtx5hu7w4
 dieCaQZ33prbfOAW6wLeFxqq4uk81kDxropV/9pEiz9GxRyRgw5AhpQc3N6lo9STfM
 5tMrcFoDmjxAA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161283180691.7845.8705102282874367511.git-patchwork-notify@kernel.org>
Date: Tue, 09 Feb 2021 00:50:06 +0000
References: <20210206214734.1577849-1-horatiu.vultur@microchip.com>
In-Reply-To: <20210206214734.1577849-1-horatiu.vultur@microchip.com>
Subject: Re: [Bridge] [PATCH net 0/2] bridge: mrp: Fix
	br_mrp_port_switchdev_set_state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, rasmus.villemoes@prevas.dk, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Sat, 6 Feb 2021 22:47:32 +0100 you wrote:
> Based on the discussion here[1], there was a problem with the function
> br_mrp_port_switchdev_set_state. The problem was that it was called
> both with BR_STATE* and BR_MRP_PORT_STATE* types. This patch series
> fixes this issue and removes SWITCHDEV_ATTR_ID_MRP_PORT_STAT because
> is not used anymore.
> 
> [1] https://www.spinics.net/lists/netdev/msg714816.html
> 
> [...]

Here is the summary with links:
  - [net,1/2] bridge: mrp: Fix the usage of br_mrp_port_switchdev_set_state
    https://git.kernel.org/netdev/net/c/b2bdba1cbc84
  - [net,2/2] switchdev: mrp: Remove SWITCHDEV_ATTR_ID_MRP_PORT_STAT
    https://git.kernel.org/netdev/net/c/059d2a100498

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


