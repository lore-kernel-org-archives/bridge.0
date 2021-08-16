Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629119406;
 bh=OEjXsnwr92JDA8IfjbiPkWnN00OfEKYZhQN0lmo2yBE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=tJH51f9ARfiLL7RhwEUav5Cy0AiKjsDa43+Vb5SxdNqLRXKEu7VhYv/b0cit6MtYp
 LLtbW4BFUEptNr/lQaBUJmQQ28UszWzkUOEgrMeQDeg4TsIeVYyGI6LIsFlzv4ocU8
 O1IPEmeZ8ZAi5cN60gRMLOzKfDynIX6gdnJZAXVk6n/CKV6Ct4HlrCdMjMeOCm8Hi8
 89ExygZeMFTDzPATZlqYVjQ6M5y30dipW6HTA9SsiI71iCQajFWTxOf9TfvAQFnxFA
 VWcnUC9dYCkSbfJeEEwszN4YngSs+7EE0hWYgsU18/2cCJToNfW/rMZD0ecqPrs3xX
 L86fcamltdI8A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162911940606.11903.8900804380948796171.git-patchwork-notify@kernel.org>
Date: Mon, 16 Aug 2021 13:10:06 +0000
References: <20210816101134.577413-1-razor@blackwall.org>
In-Reply-To: <20210816101134.577413-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next 0/3] net: bridge: mcast: fixes for
 mcast querier state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Mon, 16 Aug 2021 13:11:31 +0300 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Hi,
> These three fix querier state dumping. The first patch can be considered
> a minor behaviour improvement, it avoids dumping querier state when mcast
> snooping is disabled. The second patch was a report of sizeof(0) used
> for nested netlink attribute size which should be just 0, and the third
> patch accounts for IPv6 querier state size when allocating skb for
> notifications.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: bridge: mcast: don't dump querier state if snooping is disabled
    https://git.kernel.org/netdev/net-next/c/f137b7d4ecf8
  - [net-next,2/3] net: bridge: mcast: drop sizeof for nest attribute's zero size
    https://git.kernel.org/netdev/net-next/c/cdda378bd8d9
  - [net-next,3/3] net: bridge: mcast: account for ipv6 size when dumping querier state
    https://git.kernel.org/netdev/net-next/c/175e66924719

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


