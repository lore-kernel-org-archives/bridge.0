Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B14F60F41
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD0FF60BED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679041821;
 bh=cbl/8kY59m0VJBtiWs1fFUFoxkXKmWi7XtVc3FRjM5Q=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Dg5vl+q4w0KSsLyQ7H3KLJ0yT3HK/NFNZwrnJx22uO521jyy/7WkWgPIQdV+cBdsW
 nSgpbbvZfM1mDIk5EBvZaZSv2WWAkEozhpbEPzNQS+Ptg1QaoPf6A6FJHc7L2+MlrR
 wL0lGgin3YRvWQNJG++d/1wumutsR7m9BQJKhKWHHL31pmwTD97Wir9b4llW2GLGZd
 w0FCiZ8Z15+lP29U+TYh1SICxAaIJJXvr/AOL1IKkfbeM8HDTqrYls8nClFp1jZiVM
 wfZy/hrmJzJD4glvwC7SMm9KK723R3TT1jAZDNsQ1PH0yHrYXCs/7FLyhUyExs7RLJ
 yEwe2dfVTsm5Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <167904182146.13932.7277544520750366068.git-patchwork-notify@kernel.org>
Date: Fri, 17 Mar 2023 08:30:21 +0000
References: <20230315131155.4071175-1-idosch@nvidia.com>
In-Reply-To: <20230315131155.4071175-1-idosch@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next v2 00/11] vxlan: Add MDB support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: petrm@nvidia.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 15 Mar 2023 15:11:44 +0200 you wrote:
> tl;dr
> =====
> 
> This patchset implements MDB support in the VXLAN driver, allowing it to
> selectively forward IP multicast traffic to VTEPs with interested
> receivers instead of flooding it to all the VTEPs as BUM. The motivating
> use case is intra and inter subnet multicast forwarding using EVPN
> [1][2], which means that MDB entries are only installed by the user
> space control plane and no snooping is implemented, thereby avoiding a
> lot of unnecessary complexity in the kernel.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/11] net: Add MDB net device operations
    https://git.kernel.org/netdev/net-next/c/8c44fa12c8fa
  - [net-next,v2,02/11] bridge: mcast: Implement MDB net device operations
    https://git.kernel.org/netdev/net-next/c/c009de1061b5
  - [net-next,v2,03/11] rtnetlink: bridge: mcast: Move MDB handlers out of bridge driver
    https://git.kernel.org/netdev/net-next/c/cc7f5022f810
  - [net-next,v2,04/11] rtnetlink: bridge: mcast: Relax group address validation in common code
    https://git.kernel.org/netdev/net-next/c/da654c80a0eb
  - [net-next,v2,05/11] vxlan: Move address helpers to private headers
    https://git.kernel.org/netdev/net-next/c/f307c8bf37a3
  - [net-next,v2,06/11] vxlan: Expose vxlan_xmit_one()
    https://git.kernel.org/netdev/net-next/c/6ab271aaad25
  - [net-next,v2,07/11] vxlan: mdb: Add MDB control path support
    https://git.kernel.org/netdev/net-next/c/a3a48de5eade
  - [net-next,v2,08/11] vxlan: mdb: Add an internal flag to indicate MDB usage
    https://git.kernel.org/netdev/net-next/c/bc6c6b013ffe
  - [net-next,v2,09/11] vxlan: Add MDB data path support
    https://git.kernel.org/netdev/net-next/c/0f83e69f44bf
  - [net-next,v2,10/11] vxlan: Enable MDB support
    https://git.kernel.org/netdev/net-next/c/08f876a7d79e
  - [net-next,v2,11/11] selftests: net: Add VXLAN MDB test
    https://git.kernel.org/netdev/net-next/c/62199e3f1658

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


