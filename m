Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613516409;
 bh=bE5OIedoHeCxppUvRDPjNpROSKM6Y/nSf8GltA3Giz4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=h+jQA7LgwHOixIR9PfSVC1HcNkvu6M/ggn/cj7v2YcFkuVB7+hNDLOEhWr8kPcfa4
 qNo6OAbXilIKFlUHRRS59GbKI+KINwwisNYKvqfzOPpzFJnoJpeRhvubz6VlP1FR3d
 iCAuYZx32L3VmickoadkgxRXDK0paFn/xk9aBwPrA+xLwdmPJTwZ4op3mAJNTWFinF
 49qb7sPwKJzW56QdAbB4qkGdaa5Bsp0vOAiGsSo10ftvGX18/mi/rmhLd5f3l0WvMd
 5OGFwOJ3A8EG9EsddVuIQE52Gdgz5g/tjkYpCUVNDEv5/Fgb4Jaw4S/DX0wxLZTKhP
 dFnm01Rr5SyEg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161351640945.9841.8930466212434176971.git-patchwork-notify@kernel.org>
Date: Tue, 16 Feb 2021 23:00:09 +0000
References: <20210216214205.32385-1-horatiu.vultur@microchip.com>
In-Reply-To: <20210216214205.32385-1-horatiu.vultur@microchip.com>
Subject: Re: [Bridge] [PATCH net-next v4 0/8] bridge: mrp: Extend
	br_mrp_switchdev_*
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: ivecera@redhat.com, andrew@lunn.ch, alexandre.belloni@bootlin.com, f.fainelli@gmail.com, jiri@resnulli.us, rasmus.villemoes@prevas.dk, vladimir.oltean@nxp.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vivien.didelot@gmail.com, UNGLinuxDriver@microchip.com, claudiu.manoil@nxp.com, netdev@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Tue, 16 Feb 2021 22:41:57 +0100 you wrote:
> This patch series extends MRP switchdev to allow the SW to have a better
> understanding if the HW can implement the MRP functionality or it needs
> to help the HW to run it. There are 3 cases:
> - when HW can't implement at all the functionality.
> - when HW can implement a part of the functionality but needs the SW
>   implement the rest. For example if it can't detect when it stops
>   receiving MRP Test frames but it can copy the MRP frames to CPU to
>   allow the SW to determine this.  Another example is generating the MRP
>   Test frames. If HW can't do that then the SW is used as backup.
> - when HW can implement completely the functionality.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/8] switchdev: mrp: Remove CONFIG_BRIDGE_MRP
    https://git.kernel.org/netdev/net-next/c/405be6b46b70
  - [net-next,v4,2/8] switchdev: mrp: Extend ring_role_mrp and in_role_mrp
    https://git.kernel.org/netdev/net-next/c/c513efa20c52
  - [net-next,v4,3/8] bridge: mrp: Add 'enum br_mrp_hw_support'
    https://git.kernel.org/netdev/net-next/c/e1bd99d07e61
  - [net-next,v4,4/8] bridge: mrp: Extend br_mrp_switchdev to detect better the errors
    https://git.kernel.org/netdev/net-next/c/1a3ddb0b7516
  - [net-next,v4,5/8] bridge: mrp: Update br_mrp to use new return values of br_mrp_switchdev
    https://git.kernel.org/netdev/net-next/c/cd605d455a44
  - [net-next,v4,6/8] net: mscc: ocelot: Add support for MRP
    https://git.kernel.org/netdev/net-next/c/d8ea7ff3995e
  - [net-next,v4,7/8] net: dsa: add MRP support
    https://git.kernel.org/netdev/net-next/c/c595c4330da0
  - [net-next,v4,8/8] net: dsa: felix: Add support for MRP
    https://git.kernel.org/netdev/net-next/c/a026c50b599f

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


