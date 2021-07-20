Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626780005;
 bh=bjCSTDsNnZcM6Rf4+njSyX2tnJwMT/TUdE6nL7Hn3mM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=LURPow1Brmq+EUDGnp0EepLdaA+525NP7HRJgQWy0TzfzbiWkOKdBK9vMnQdigL/c
 KOyB2Tn8qM1MMZW+Ivy7ZeUgLcHyj4kbEM8wlOjghQAMY4lpWWo14hj/xW9Lrd5VJP
 3mUhcwslbN/Tdb+5VuvkVTZXoCl1CwUNHUMrN+zp3iQSalpz/arLX5rLg5HTu70Rex
 ROmk07Yxx534punF6Nk38RiYfgBSTDqORPA9RFAco1XM4SYrOWRwaTL9W2dMEoqiUz
 F36K8MOXjXeQUb5PdU78siOa9xTFb1sbbx4+qa0I9mRl/mXIDsv5up4vwEllxlOCFc
 UAh+nsutWgOaA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162678000558.21231.2477207642313158352.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jul 2021 11:20:05 +0000
References: <20210719093916.4099032-1-vladimir.oltean@nxp.com>
In-Reply-To: <20210719093916.4099032-1-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH net] net: bridge: do not replay fdb entries
 pointing towards the bridge twice
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net, tobias@waldekranz.com

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Mon, 19 Jul 2021 12:39:16 +0300 you wrote:
> This simple script:
> 
> ip link add br0 type bridge
> ip link set swp2 master br0
> ip link set br0 address 00:01:02:03:04:05
> ip link del br0
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: do not replay fdb entries pointing towards the bridge twice
    https://git.kernel.org/netdev/net/c/cbb56b03ec3f

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


