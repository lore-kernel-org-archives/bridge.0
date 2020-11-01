Return-Path: <patchwork-bot+netdevbpf@kernel.org>
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604190604;
 bh=UEhdv3Q0+TKErpw5C66NTGav85um6DAu9uHRU7e6R3M=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=w6grmRErPARoacuU/197yOLE9l0KTVAYxfogl6Ee0uuc3WzOE6Vah7HUNEiYyvbp3
 UpeRUv15M81/INF5SOUtjzXWbkGtOvcr/F5rEP1IrnGkRqgXRYl4fgnGgP5oeeenEi
 j3+lvp8+sWdgaFNGn2iMlpM2qWAF/cqd6jWtBvB8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <160419060462.13806.6288188533680087053.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2020 00:30:04 +0000
References: <20201101000845.190009-1-vladimir.oltean@nxp.com>
In-Reply-To: <20201101000845.190009-1-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: mcast: fix stub
 definition of br_multicast_querier_exists
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: lkp@intel.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Sun,  1 Nov 2020 02:08:45 +0200 you wrote:
> The commit cited below has changed only the functional prototype of
> br_multicast_querier_exists, but forgot to do that for the stub
> prototype (the one where CONFIG_BRIDGE_IGMP_SNOOPING is disabled).
> 
> Fixes: 955062b03fa6 ("net: bridge: mcast: add support for raw L2 multicast groups")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: bridge: mcast: fix stub definition of br_multicast_querier_exists
    https://git.kernel.org/netdev/net-next/c/c43fd36f7fec

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


