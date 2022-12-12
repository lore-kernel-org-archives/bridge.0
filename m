Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F6B481383
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D437E8131D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670888419;
 bh=xsCcvgJQhWDNSljlVfe8OtCKbisyBLH9xrPyC+bNdL0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=XkhVWAFCNAe/f27EuGFA9HPO7HmDcIryl2jbgVZCL0SA3a8q0TBc9k9DZIbFtOR5k
 /3B+y/WN2ns9LjGgDVmtc92Sk6WCzP4kJvxESj7N5OUgN/GNiZh5mZ0GaKcZjA2DNn
 1pjfu9jW9cUGhx8eh8zye5jP4b/JZqXW3Te/gCQQvgqNvXx6cWmGxVVpO0G3icI4bU
 luUwQyMA9H5/AqfhUmmdcgPQfxdXcszxAjwVLBFxtSEwPqi3WuotCZnB6IN6xkNMUS
 sWiamiscEaHC85cWG3fBXk881bZno8Bbf1LZVfnjK99WuCqgONyM/L9+oP2JPTd0l3
 eoDlUt3Q2cNWQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <167088841900.5876.16567042596931057102.git-patchwork-notify@kernel.org>
Date: Mon, 12 Dec 2022 23:40:19 +0000
References: <20221210145633.1328511-1-idosch@nvidia.com>
In-Reply-To: <20221210145633.1328511-1-idosch@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next v2 00/14] bridge: mcast: Extensions
	for EVPN
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Dec 2022 16:56:19 +0200 you wrote:
> tl;dr
> =====
> 
> This patchset creates feature parity between user space and the kernel
> and allows the former to install and replace MDB port group entries with
> a source list and associated filter mode. This is required for EVPN use
> cases where multicast state is not derived from snooped IGMP/MLD
> packets, but instead derived from EVPN routes exchanged by the control
> plane in user space.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/14] bridge: mcast: Do not derive entry type from its filter mode
    https://git.kernel.org/netdev/net-next/c/b63e30651c59
  - [net-next,v2,02/14] bridge: mcast: Split (*, G) and (S, G) addition into different functions
    https://git.kernel.org/netdev/net-next/c/6ff1e68eb215
  - [net-next,v2,03/14] bridge: mcast: Place netlink policy before validation functions
    https://git.kernel.org/netdev/net-next/c/1870a2d35abb
  - [net-next,v2,04/14] bridge: mcast: Add a centralized error path
    https://git.kernel.org/netdev/net-next/c/160dd93114dd
  - [net-next,v2,05/14] bridge: mcast: Expose br_multicast_new_group_src()
    https://git.kernel.org/netdev/net-next/c/fd0c696164cf
  - [net-next,v2,06/14] bridge: mcast: Expose __br_multicast_del_group_src()
    https://git.kernel.org/netdev/net-next/c/083e353482b4
  - [net-next,v2,07/14] bridge: mcast: Add a flag for user installed source entries
    https://git.kernel.org/netdev/net-next/c/a01ecb1712dd
  - [net-next,v2,08/14] bridge: mcast: Avoid arming group timer when (S, G) corresponds to a source
    https://git.kernel.org/netdev/net-next/c/079afd66161b
  - [net-next,v2,09/14] bridge: mcast: Add support for (*, G) with a source list and filter mode
    https://git.kernel.org/netdev/net-next/c/b1c8fec8d459
  - [net-next,v2,10/14] bridge: mcast: Allow user space to add (*, G) with a source list and filter mode
    https://git.kernel.org/netdev/net-next/c/6afaae6d12f5
  - [net-next,v2,11/14] bridge: mcast: Allow user space to specify MDB entry routing protocol
    https://git.kernel.org/netdev/net-next/c/1d7b66a7d975
  - [net-next,v2,12/14] bridge: mcast: Support replacement of MDB port group entries
    https://git.kernel.org/netdev/net-next/c/61f2183512a7
  - [net-next,v2,13/14] selftests: forwarding: Rename bridge_mdb test
    https://git.kernel.org/netdev/net-next/c/f9923a67ab62
  - [net-next,v2,14/14] selftests: forwarding: Add bridge MDB test
    https://git.kernel.org/netdev/net-next/c/b6d00da08610

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


