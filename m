Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628077206;
 bh=XJaPec5/QHyjwGWIlKEDZ0VG4U3aPIU3P+nAsdhBwPk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=HP/JX1SCq3YkDqETXyF7AZCtdvPukk6NVtfUIYjW6isxzvFKIl+uAQKxJ03v1OAt/
 yb8oamdizt0Sq2R8NVK2GBxwstPxAqdwlQYPa03TfWszzU226F+UIiEy7v7syI7k3v
 SAomqwWNeS2hJ+xE2N4LVyEppwa/n8pwPnOR6lP8dUTJy6RW0ZDl+2eiEPO2VriKgj
 ALJlqAhAwoEyN0bXynBlPbxM/zZsvwJ8jFY0+JlWTv59HEoiv8tUccYcAqlgLqxCFY
 DdKOIEiic1CXEHUb8Gw0+kVXhYr/ag0+X2Ryhgo2alghiRynbUtqBJ3LcKHqQVUmUg
 oDkGUKzUaanEQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162807720594.23179.2687228457044533864.git-patchwork-notify@kernel.org>
Date: Wed, 04 Aug 2021 11:40:05 +0000
References: <20210803203409.1274807-1-vladimir.oltean@nxp.com>
In-Reply-To: <20210803203409.1274807-1-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH v2 net-next 0/2] Convert
 switchdev_bridge_port_{, un}offload to notifiers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, arnd@kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@idosch.org, grygorii.strashko@ti.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Tue,  3 Aug 2021 23:34:07 +0300 you wrote:
> The introduction of the explicit switchdev bridge port offloading API
> has introduced dependency regressions between switchdev drivers and the
> bridge, with some drivers where switchdev support was optional before
> being now compiled as a module when the bridge is a module, or worse.
> 
> This patch makes the switchdev bridge port offload/unoffload events
> visible on the blocking notifier call chain, so that the bridge can
> indirectly do something when those events happen, without the driver
> explicitly calling a symbol exported by the bridge driver.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] net: make switchdev_bridge_port_{,unoffload} loosely coupled with the bridge
    https://git.kernel.org/netdev/net-next/c/957e2235e526
  - [v2,net-next,2/2] Revert "net: build all switchdev drivers as modules when the bridge is a module"
    https://git.kernel.org/netdev/net-next/c/a54182b2a518

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


