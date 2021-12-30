Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640829611;
 bh=r+7At58GAqPK0C4GwxpSddBgEjWnuwMGZO/F9d/1SD4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=XTfq9CqmPTS6uh+bbmOzmBwyKyN8owYn+L3qqpc/1cVICoFUDVw1gGi9pdSfKvcBs
 MGpuWSXD7yoTUHHHlswk4grQG9/UN4VFo7cfuLj1IiQc7wSLxVDQridaEDqcnXtbyE
 yI3wV/HRLhvx++tLqpWT1R1j3vGCQPjPQTY6jGDTXrrVUV92u5e3rh89/1QrX//NKq
 X7jL6lJbm9pbEyHE1LkVjJEIUWCY8IaYnjDJKN4Y8tkexprW0TGcmMZMYKKmjS7UXl
 qpUVATpsaUd7xrysDI6lUTQTPxIZrYkIyyY69aHl9xZZNrTIcQXYMpdSofNuIggi0p
 vGyJ348cO/aPA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <164082961129.30206.7745851458626854957.git-patchwork-notify@kernel.org>
Date: Thu, 30 Dec 2021 02:00:11 +0000
References: <20211228153142.536969-1-nikolay@nvidia.com>
In-Reply-To: <20211228153142.536969-1-nikolay@nvidia.com>
Subject: Re: [Bridge] [PATCH net v2] net: bridge: mcast: fix
 br_multicast_ctx_vlan_global_disabled helper
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Dec 2021 17:31:42 +0200 you wrote:
> We need to first check if the context is a vlan one, then we need to
> check the global bridge multicast vlan snooping flag, and finally the
> vlan's multicast flag, otherwise we will unnecessarily enable vlan mcast
> processing (e.g. querier timers).
> 
> Fixes: 7b54aaaf53cb ("net: bridge: multicast: add vlan state initialization and control")
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bridge: mcast: fix br_multicast_ctx_vlan_global_disabled helper
    https://git.kernel.org/netdev/net/c/168fed986b3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


