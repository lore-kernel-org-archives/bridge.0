Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D909E81329
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8589813C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697188230;
 bh=2NHXUmHMA0x62KWzVmj7kY/JH5/7szO6PdBuXZNYv9w=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=AGSsAv07SjmBKbXWRZv8jwZ9gUciGtaHAnyHzD1bshJwDJEwlBgkWTi3ruGVvaWzp
 gFeFgR9C5+IZ9b6A7qpQCo9klwVBCm2wBssIcCvFkGnibKn47QiIfZ+Z04Di2whMfd
 7t966Z+Xx+SP+gMe+rl+i3wxoJzMHiXS1joLttues5F67DA4ojOqeF9kJZbsUrH3ic
 iJviiaQXAo5lmJAXXFB1Ii9/2gkOiJ6uILqNejK3rfSsj8fuARbDUpAvV7smRHBc/9
 gUB0YbEhareEzHV02HvWtxJWBbTSBtHkHHRPL2XFkIrOcQ5ub/8AP0Ou9F0OcPUaTu
 zuvuctSsp+wjg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <169718823071.32613.13896691864191241955.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 09:10:30 +0000
References: <20231009100618.2911374-1-amcohen@nvidia.com>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next 00/11] Extend VXLAN driver to support
	FDB flushing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Amit Cohen <amcohen@nvidia.com>
Cc: bridge@lists.linux-foundation.org, razor@blackwall.org, netdev@vger.kernel.org, dsahern@kernel.org, roopa@nvidia.com, mlxsw@nvidia.com, linux-kselftest@vger.kernel.org, idosch@nvidia.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 9 Oct 2023 13:06:07 +0300 you wrote:
> The merge commit 92716869375b ("Merge branch 'br-flush-filtering'") added
> support for FDB flushing in bridge driver. Extend VXLAN driver to support
> FDB flushing also. Add support for filtering by fields which are relevant
> for VXLAN FDBs:
> * Source VNI
> * Nexthop ID
> * 'router' flag
> * Destination VNI
> * Destination Port
> * Destination IP
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] net: Handle bulk delete policy in bridge driver
    https://git.kernel.org/netdev/net-next/c/38985e8c278b
  - [net-next,02/11] vxlan: vxlan_core: Make vxlan_flush() more generic for future use
    https://git.kernel.org/netdev/net-next/c/bfe36bf7811c
  - [net-next,03/11] vxlan: vxlan_core: Do not skip default entry in vxlan_flush() by default
    https://git.kernel.org/netdev/net-next/c/77b613efcc81
  - [net-next,04/11] vxlan: vxlan_core: Add support for FDB flush
    https://git.kernel.org/netdev/net-next/c/d324eb9cec84
  - [net-next,05/11] vxlan: vxlan_core: Support FDB flushing by source VNI
    https://git.kernel.org/netdev/net-next/c/a0f89d5e68b6
  - [net-next,06/11] vxlan: vxlan_core: Support FDB flushing by nexthop ID
    https://git.kernel.org/netdev/net-next/c/36c111233b56
  - [net-next,07/11] vxlan: vxlan_core: Support FDB flushing by destination VNI
    https://git.kernel.org/netdev/net-next/c/c499fccb71cb
  - [net-next,08/11] vxlan: vxlan_core: Support FDB flushing by destination port
    https://git.kernel.org/netdev/net-next/c/ac0db4ddd0cb
  - [net-next,09/11] vxlan: vxlan_core: Support FDB flushing by destination IP
    https://git.kernel.org/netdev/net-next/c/2dcd22023cab
  - [net-next,10/11] selftests: Add test cases for FDB flush with VXLAN device
    https://git.kernel.org/netdev/net-next/c/96eece693330
  - [net-next,11/11] selftests: fdb_flush: Add test cases for FDB flush with bridge device
    https://git.kernel.org/netdev/net-next/c/f826f2a2ee1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


