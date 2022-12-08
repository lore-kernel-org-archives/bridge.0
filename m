Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3AC0081F5A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5808181F59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670472619;
 bh=s4bA1inXYla9p7PtsuzzOXy6cf0Zl73yymnPyZJZj60=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=PiRCdQ8SYQ84tPVZCJxMAhcQNpFaVhZfeei7F6b75jF2L1c2doShvPSEKs1md0s8R
 N1QQIf6O9/d5N5l/cex+RY8ZQXHA4zgS/K3dg2PeVuie+mUH7rLGshO4mM8sDf2jQq
 CTLU/TKBVCSR5M9C620P978x4b7xsu7O4p0/4eNPN5gclLjitC8OjNfUtcvmEC/sOh
 d0p9GHI3d7JIQ7Ehm85JwlJ2wLl7TsHYEnWV+bQkVmIAaP8Sm8aAEV3HEHvUYzJ5L8
 fJLnXIfOZ43nRdBym2Mnp9zcxePMCC/kELi6CpHDbRAJ1T3FvHrRGL7IMt2Vjv+qMV
 mCpRqAISPHRFA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <167047261955.18861.1757446402375104183.git-patchwork-notify@kernel.org>
Date: Thu, 08 Dec 2022 04:10:19 +0000
References: <20221206105809.363767-1-idosch@nvidia.com>
In-Reply-To: <20221206105809.363767-1-idosch@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next v2 0/9] bridge: mcast: Preparations
 for EVPN extensions
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

On Tue,  6 Dec 2022 12:58:00 +0200 you wrote:
> This patchset was split from [1] and includes non-functional changes
> aimed at making it easier to add additional netlink attributes later on.
> Future extensions are available here [2].
> 
> The idea behind these patches is to create an MDB configuration
> structure into which netlink messages are parsed into. The structure is
> then passed in the entry creation / deletion call chain instead of
> passing the netlink attributes themselves. The same pattern is used by
> other rtnetlink objects such as routes and nexthops.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/9] bridge: mcast: Centralize netlink attribute parsing
    https://git.kernel.org/netdev/net-next/c/cb453926865e
  - [net-next,v2,2/9] bridge: mcast: Remove redundant checks
    https://git.kernel.org/netdev/net-next/c/386611681524
  - [net-next,v2,3/9] bridge: mcast: Use MDB configuration structure where possible
    https://git.kernel.org/netdev/net-next/c/f2b5aac68117
  - [net-next,v2,4/9] bridge: mcast: Propagate MDB configuration structure further
    https://git.kernel.org/netdev/net-next/c/8bd9c08e3241
  - [net-next,v2,5/9] bridge: mcast: Use MDB group key from configuration structure
    https://git.kernel.org/netdev/net-next/c/9f52a5142979
  - [net-next,v2,6/9] bridge: mcast: Remove br_mdb_parse()
    https://git.kernel.org/netdev/net-next/c/3ee5662345f2
  - [net-next,v2,7/9] bridge: mcast: Move checks out of critical section
    https://git.kernel.org/netdev/net-next/c/4c1ebc6c1f21
  - [net-next,v2,8/9] bridge: mcast: Remove redundant function arguments
    https://git.kernel.org/netdev/net-next/c/090149eaf391
  - [net-next,v2,9/9] bridge: mcast: Constify 'group' argument in br_multicast_new_port_group()
    https://git.kernel.org/netdev/net-next/c/f86c3e2c1b5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


