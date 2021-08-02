Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627942205;
 bh=e5HDMNUVxVAnWFs/XGtwxzLKoFESQ+SzcrhLxmZo8zg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=InovInF8f2mareLTbC6Wt0YD97o8jR6KgUl6sKw2lvgXEdSQfKeJow7A7OV3yeeXD
 b7gvxSZtE3F2Tqnp9x71oVjtzswPEHg1YNnOYwaW+7RiKIBv+UfTVMX7gsLsZGOyNe
 VjDn7FK4FdFP//qRsXue8VJFX7EeX6WaHknB6xOyGBCxOiD5Ai0Dfyee3oLvR2CzPx
 14B8yrHBNcSjp21XzoD8HO4LI6T9d3D79hYt/B0NHa7kpfCtBZ3s3FWKMHTyPqmLIX
 bp9UKpdH6/4VayzCe5hU/cLWxBTpdpgkTbkEeaonMmrU6DjPaYAYz1wu5AzMsgTO7b
 v5mnSL8q2FASQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162794220536.7989.3987115619010185604.git-patchwork-notify@kernel.org>
Date: Mon, 02 Aug 2021 22:10:05 +0000
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
In-Reply-To: <20210801231730.7493-1-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH net] net: bridge: validate the NUD_PERMANENT
 bit when adding an extern_learn FDB entry
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Mon,  2 Aug 2021 02:17:30 +0300 you wrote:
> Currently it is possible to add broken extern_learn FDB entries to the
> bridge in two ways:
> 
> 1. Entries pointing towards the bridge device that are not local/permanent:
> 
> ip link add br0 type bridge
> bridge fdb add 00:01:02:03:04:05 dev br0 self extern_learn static
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: validate the NUD_PERMANENT bit when adding an extern_learn FDB entry
    https://git.kernel.org/netdev/net/c/0541a6293298

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


