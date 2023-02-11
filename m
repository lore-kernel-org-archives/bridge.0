Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 530CA41B50
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DE1E41A67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1676086820;
 bh=geDtyl2//P/lEiK7xB91DQEObY3k9tBV7LaVhtCjMUs=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=un3NAbxfww0DNzcjxB6xt7xPayrxq0OryuMfpssfv9n3ekmesRQDh8PDnN1oQUmUp
 IGLFAp21NjKFN7f3Vv5NQ+KsIHnmSKpM8uIv+WxfrCbwkZzmig0uUvdA0mij8bHCIn
 EqIDunSAoRYd/jMSjdYpEgA+fEzjmq+SVEFSTHHfE6zsceq4l+Im2KKx5Hdh0lTk5y
 wwuLolu9klWm4hpY609jqd0fhZISWZbrdOS8jPr10zIscHONBE2YsclKWIH+Oca5Fe
 nUiSJcj70ywEF2OpoQFu/82MjNCatLMP6iHj/BvHyAe2TBR5VJLo5W1Z2n/aFxt6G5
 UzMXDS2/BZueg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <167608681991.24732.16960157828156845932.git-patchwork-notify@kernel.org>
Date: Sat, 11 Feb 2023 03:40:19 +0000
References: <20230209071852.613102-1-idosch@nvidia.com>
In-Reply-To: <20230209071852.613102-1-idosch@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next 0/4] bridge: mcast: Preparations for
	VXLAN MDB
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

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Feb 2023 09:18:48 +0200 you wrote:
> This patchset contains small preparations for VXLAN MDB that were split
> from this RFC [1]. Tested using existing bridge MDB forwarding
> selftests.
> 
> [1] https://lore.kernel.org/netdev/20230204170801.3897900-1-idosch@nvidia.com/
> 
> Ido Schimmel (4):
>   bridge: mcast: Use correct define in MDB dump
>   bridge: mcast: Remove pointless sequence generation counter assignment
>   bridge: mcast: Move validation to a policy
>   selftests: forwarding: Add MDB dump test cases
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] bridge: mcast: Use correct define in MDB dump
    https://git.kernel.org/netdev/net-next/c/ccd7f25b5b04
  - [net-next,2/4] bridge: mcast: Remove pointless sequence generation counter assignment
    https://git.kernel.org/netdev/net-next/c/7ea829664d3c
  - [net-next,3/4] bridge: mcast: Move validation to a policy
    https://git.kernel.org/netdev/net-next/c/170afa71e3a2
  - [net-next,4/4] selftests: forwarding: Add MDB dump test cases
    https://git.kernel.org/netdev/net-next/c/049139126ec7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


