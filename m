Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626939605;
 bh=Qt9jGf1qvwR8/7NnPaY0fcZx6UYk9QueAlhWllLm9VU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=aKmU7KHoRcuM1lNa5oc1sLq5mWJLyqan10WUa9AYpdWb3uI5Qli7SFhfdgI2M6iSi
 sAFbLXIA+0YZapqDjx9vht7O9k7QO59ytqwYeR0PGMZM/J1upCDluShsQfocIV0qZn
 7jAZXzkmKrG8z3N1atT15r4xy0tE/Wm69IFtmNrK3XLrNCwkiJTHkx3MQbkkq4Lw0N
 9DxPOBtEmN4V+41iUtdWst65LLe2vbyeixqBaf8NeQ3DRq8dZliJvM46eQm3Sz3vXd
 n3FrxKCmVmR+Jr6v1WWU4IgtmhtceIgi7PxNTvfR3YtX7bBV5UwJeDUYCv7TVTt7k+
 oTu8zoUV1p6JQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162693960576.10743.1328836732492291838.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jul 2021 07:40:05 +0000
References: <20210721162403.1988814-1-vladimir.oltean@nxp.com>
In-Reply-To: <20210721162403.1988814-1-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH v6 net-next 0/7] Let switchdev drivers offload
 and unoffload bridge ports at their own convenience
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, dqfext@gmail.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@idosch.org, grygorii.strashko@ti.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, kabel@blackhole.sk, davem@davemloft.net, tobias@waldekranz.com

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Wed, 21 Jul 2021 19:23:56 +0300 you wrote:
> This series introduces an explicit API through which switchdev drivers
> mark a bridge port as offloaded or not:
> - switchdev_bridge_port_offload()
> - switchdev_bridge_port_unoffload()
> 
> Currently, the bridge assumes that a port is offloaded if
> dev_get_port_parent_id(dev, &ppid, recurse=true) returns something, but
> that is just an assumption that breaks some use cases (like a
> non-offloaded LAG interface on top of a switchdev port, bridged with
> other switchdev ports).
> 
> [...]

Here is the summary with links:
  - [v6,net-next,1/7] net: dpaa2-switch: use extack in dpaa2_switch_port_bridge_join
    https://git.kernel.org/netdev/net-next/c/123338d7d41e
  - [v6,net-next,2/7] net: dpaa2-switch: refactor prechangeupper sanity checks
    https://git.kernel.org/netdev/net-next/c/45035febc495
  - [v6,net-next,3/7] net: bridge: disambiguate offload_fwd_mark
    https://git.kernel.org/netdev/net-next/c/f7cf972f9375
  - [v6,net-next,4/7] net: bridge: switchdev: recycle unused hwdoms
    https://git.kernel.org/netdev/net-next/c/8582661048eb
  - [v6,net-next,5/7] net: bridge: switchdev: let drivers inform which bridge ports are offloaded
    https://git.kernel.org/netdev/net-next/c/2f5dc00f7a3e
  - [v6,net-next,6/7] net: bridge: guard the switchdev replay helpers against a NULL notifier block
    https://git.kernel.org/netdev/net-next/c/7105b50b7eec
  - [v6,net-next,7/7] net: bridge: move the switchdev object replay helpers to "push" mode
    https://git.kernel.org/netdev/net-next/c/4e51bf44a03a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


