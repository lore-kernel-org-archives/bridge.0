Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649850615;
 bh=o2vJ0DnRy5ZEVYNOXmZBmFPGP50Ud7tKWsUfjrA5p3w=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=MVw1jAzHWNcdlnsPsMSJteexdrXXnj1FBzUfPK7zP651Fup2wgQy0Y+kDok0ES6ll
 Aq21x16zWIQC+p5W9vr0mTDXXgIPBVwZoYD4ON8Bun69DobpLNMtHr9t5eUBR3ixNx
 XGtjpddEb4PmBgR5WmyKkvUTJyp0ssBewnQTIl/yyjv3jn/qyJGqBhdNP0ftEh5eqP
 uCAKPbT4LfwcvL3ZBUiC64JlBDpzzE9r165rmv+ojbXmcQRiCBl1ETe7yy4CccMzgY
 cEXgSqm8XG7ElVEX/Zv2mGuALgx4hyDRhT9PLr++ZR4MJ+XlJ8isTpgjcjHJn6Cn5c
 lTVA94GblVG7w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <164985061551.24768.3237766842921971085.git-patchwork-notify@kernel.org>
Date: Wed, 13 Apr 2022 11:50:15 +0000
References: <20220413105202.2616106-1-razor@blackwall.org>
In-Reply-To: <20220413105202.2616106-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next v4 00/12] net: bridge: add flush
	filtering support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Apr 2022 13:51:50 +0300 you wrote:
> Hi,
> This patch-set adds support to specify filtering conditions for a bulk
> delete (flush) operation. This version uses a new nlmsghdr delete flag
> called NLM_F_BULK in combination with a new ndo_fdb_del_bulk op which is
> used to signal that the driver supports bulk deletes (that avoids
> pushing common mac address checks to ndo_fdb_del implementations and
> also has a different prototype and parsed attribute expectations, more
> info in patch 03). The new delete flag can be used for any RTM_DEL*
> type, implementations just need to be careful with older kernels which
> are doing non-strict attribute parses. A new rtnl flag
> (RTNL_FLAG_BULK_DEL_SUPPORTED) is used to show that the delete supports
> NLM_F_BULK. A proper error is returned if bulk delete is not supported.
> For old kernels I use the fact that mac address attribute (lladdr) is
> mandatory in the classic fdb del case, but it's not allowed if bulk
> deleting so older kernels will error out.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/12] net: rtnetlink: add msg kind names
    https://git.kernel.org/netdev/net-next/c/12dc5c2cb7b2
  - [net-next,v4,02/12] net: rtnetlink: add helper to extract msg type's kind
    https://git.kernel.org/netdev/net-next/c/2e9ea3e30f69
  - [net-next,v4,03/12] net: rtnetlink: use BIT for flag values
    https://git.kernel.org/netdev/net-next/c/0569e31f1bc2
  - [net-next,v4,04/12] net: netlink: add NLM_F_BULK delete request modifier
    https://git.kernel.org/netdev/net-next/c/545528d78855
  - [net-next,v4,05/12] net: rtnetlink: add bulk delete support flag
    https://git.kernel.org/netdev/net-next/c/a6cec0bcd342
  - [net-next,v4,06/12] net: add ndo_fdb_del_bulk
    https://git.kernel.org/netdev/net-next/c/1306d5362a59
  - [net-next,v4,07/12] net: rtnetlink: add NLM_F_BULK support to rtnl_fdb_del
    https://git.kernel.org/netdev/net-next/c/9e83425993f3
  - [net-next,v4,08/12] net: bridge: fdb: add ndo_fdb_del_bulk
    https://git.kernel.org/netdev/net-next/c/edaef1917224
  - [net-next,v4,09/12] net: bridge: fdb: add support for fine-grained flushing
    https://git.kernel.org/netdev/net-next/c/1f78ee14eeac
  - [net-next,v4,10/12] net: rtnetlink: add ndm flags and state mask attributes
    https://git.kernel.org/netdev/net-next/c/ea2c0f9e3fc2
  - [net-next,v4,11/12] net: bridge: fdb: add support for flush filtering based on ndm flags and state
    https://git.kernel.org/netdev/net-next/c/564445fb4f0f
  - [net-next,v4,12/12] net: bridge: fdb: add support for flush filtering based on ifindex and vlan
    https://git.kernel.org/netdev/net-next/c/0dbe886a4d8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


