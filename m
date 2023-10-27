Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E64B782085
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 826A381EC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698400833;
 bh=/WkRM2i922a3Ow+G7b6etkF/sP9cPHvui0KbyLXDWEU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=AVZ/8YyO3A5t0hfO1Jna9jP2FbRvk1gcEV4M7pArJ94QmBXMgxgvBfeSHMAFf1mhF
 an5J48HoTRGx0+VXlVleKPGg3A1g7Uh/aTUnsBGcCL3IKNrgl1FdljdnxoQ5barKYn
 xd9cppL/tqOadw/xKgJL53Iz1ot9vtpM+6MqifQAeByqaOCLx2VsW9stUWUui8cC/O
 JJ7eH+2ZcQ0FclBMF9EnsNGjSZXnaw1V/rEqsbpqKysPkbGKoCvrDeshSAQutDKZx+
 bpvMVFsImTbsnskedgMLzo/Gjbj1bbEXDwvkRwuJshyL4WXrSJb2n8MRAm4+2u7BrQ
 QSsmhT7JIs9iA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <169840083306.2931.12879417140055385524.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 10:00:33 +0000
References: <20231025123020.788710-1-idosch@nvidia.com>
In-Reply-To: <20231025123020.788710-1-idosch@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next v2 00/13] Add MDB get support
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 25 Oct 2023 15:30:07 +0300 you wrote:
> This patchset adds MDB get support, allowing user space to request a
> single MDB entry to be retrieved instead of dumping the entire MDB.
> Support is added in both the bridge and VXLAN drivers.
> 
> Patches #1-#6 are small preparations in both drivers.
> 
> Patches #7-#8 add the required uAPI attributes for the new functionality
> and the MDB get net device operation (NDO), respectively.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/13] bridge: mcast: Dump MDB entries even when snooping is disabled
    https://git.kernel.org/netdev/net-next/c/b9109b5b77f0
  - [net-next,v2,02/13] bridge: mcast: Account for missing attributes
    https://git.kernel.org/netdev/net-next/c/1b6d993509c1
  - [net-next,v2,03/13] bridge: mcast: Factor out a helper for PG entry size calculation
    https://git.kernel.org/netdev/net-next/c/62ef9cba98a2
  - [net-next,v2,04/13] bridge: mcast: Rename MDB entry get function
    https://git.kernel.org/netdev/net-next/c/6d0259dd6c53
  - [net-next,v2,05/13] vxlan: mdb: Adjust function arguments
    https://git.kernel.org/netdev/net-next/c/ff97d2a956a1
  - [net-next,v2,06/13] vxlan: mdb: Factor out a helper for remote entry size calculation
    https://git.kernel.org/netdev/net-next/c/14c32a46d992
  - [net-next,v2,07/13] bridge: add MDB get uAPI attributes
    https://git.kernel.org/netdev/net-next/c/83c1bbeb864f
  - [net-next,v2,08/13] net: Add MDB get device operation
    https://git.kernel.org/netdev/net-next/c/62f47bf9e2c0
  - [net-next,v2,09/13] bridge: mcast: Add MDB get support
    https://git.kernel.org/netdev/net-next/c/68b380a395a7
  - [net-next,v2,10/13] vxlan: mdb: Add MDB get support
    https://git.kernel.org/netdev/net-next/c/32d9673e96dc
  - [net-next,v2,11/13] rtnetlink: Add MDB get support
    https://git.kernel.org/netdev/net-next/c/ddd17a54e692
  - [net-next,v2,12/13] selftests: bridge_mdb: Use MDB get instead of dump
    https://git.kernel.org/netdev/net-next/c/e8bba9e83c88
  - [net-next,v2,13/13] selftests: vxlan_mdb: Use MDB get instead of dump
    https://git.kernel.org/netdev/net-next/c/0514dd05939a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


