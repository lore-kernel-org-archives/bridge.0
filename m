Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623361805;
 bh=kCzItAmTLsiHdFwEFKm5Ppo3StfgizN4eZjE3m2lYGw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=NIjniqn/uPeNV2AcWuLpn1J3CpyfquEgz4SwL+pH0IKErFS9iFjtbYZndi9Vr+iD9
 w/PdVkFVqLU0pMUd3wAMro1wo9M2rsh7d7ySf7sIxB8zLo3aZ8uhGseBGdoSQbi7ZW
 tPziyVbcATeZw9J3IbWjLZ4vtMbdj79zL3ZNlvWhDPpbG8haKNE4wdumypDowNuRZS
 Fp+cv/QdZJtflfVbk7XH6L/D7ffhl8A0CFxHDQ9DBVp1OJV+ZlPZbukx9POMjc5PNn
 sSf1Pm1zfXxbkChHXgtcv9gpG7qu4e7JQ1S9xFuGDCMUfbVKpHmbqk2N3ZbRuSnS5e
 zvljplWCsacFA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162336180582.29138.17882840843997204380.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jun 2021 21:50:05 +0000
References: <20210610120411.128339-1-razor@blackwall.org>
In-Reply-To: <20210610120411.128339-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net 0/2 v2] net: bridge: vlan tunnel egress
	path fixes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: nikolay@nvidia.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Thu, 10 Jun 2021 15:04:09 +0300 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Hi,
> These two fixes take care of tunnel_dst problems in the vlan tunnel egress
> path. Patch 01 fixes a null ptr deref due to the lockless use of tunnel_dst
> pointer without checking it first, and patch 02 fixes a use-after-free
> issue due to wrong dst refcounting (dst_clone() -> dst_hold_safe()).
> 
> [...]

Here is the summary with links:
  - [net,1/2,v2] net: bridge: fix vlan tunnel dst null pointer dereference
    https://git.kernel.org/netdev/net/c/58e2071742e3
  - [net,2/2,v2] net: bridge: fix vlan tunnel dst refcnt when egressing
    https://git.kernel.org/netdev/net/c/cfc579f9d89a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


