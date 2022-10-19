Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 47757418F7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC16A41A58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666185019;
 bh=zC9XA18YC6b4UQw3YuHcfGSILD1ps1/Q+PfUXGFqrkc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=SpR3p+oRqpIE0RT6JN4dDKObbuG899v4Uz+1u93yDXO4skeJ/DfZDmpfz98jAg3Ry
 ZekPFnlok7zbwuPenPOZTtAXnHHEW77qkkU19FwTsNsftr6fisAZjnDkxziDNEKlkp
 oi/qC84737aIJyna898FEsMjMJBBiCcV37NxII1FRBzzgUzm9qL4uNw3zdWJfFkaL1
 SzsG9J13v7BIeOLtzLuXA/u9PAxxkrfhw0qBRfFAsREKgIcmLvmGYXdtEDsVGtppke
 eoaGqWQjoi7CvYbYRcnUv55TC0467UMKxStnKpcVRMqVCcz5O5Zc3FdPWswWyno1VS
 1lnXxx1SAJtzg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <166618501944.21602.8884811342175634772.git-patchwork-notify@kernel.org>
Date: Wed, 19 Oct 2022 13:10:19 +0000
References: <20221018064001.518841-1-idosch@nvidia.com>
In-Reply-To: <20221018064001.518841-1-idosch@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next 0/4] bridge: A few multicast cleanups
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
by David S. Miller <davem@davemloft.net>:

On Tue, 18 Oct 2022 09:39:57 +0300 you wrote:
> Clean up a few issues spotted while working on the bridge multicast code
> and running its selftests.
> 
> Ido Schimmel (4):
>   selftests: bridge_vlan_mcast: Delete qdiscs during cleanup
>   selftests: bridge_igmp: Remove unnecessary address deletion
>   bridge: mcast: Use spin_lock() instead of spin_lock_bh()
>   bridge: mcast: Simplify MDB entry creation
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] selftests: bridge_vlan_mcast: Delete qdiscs during cleanup
    https://git.kernel.org/netdev/net-next/c/6fb1faa1b92b
  - [net-next,2/4] selftests: bridge_igmp: Remove unnecessary address deletion
    https://git.kernel.org/netdev/net-next/c/b526b2ea1454
  - [net-next,3/4] bridge: mcast: Use spin_lock() instead of spin_lock_bh()
    https://git.kernel.org/netdev/net-next/c/262985fad1bd
  - [net-next,4/4] bridge: mcast: Simplify MDB entry creation
    https://git.kernel.org/netdev/net-next/c/d1942cd47dbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


