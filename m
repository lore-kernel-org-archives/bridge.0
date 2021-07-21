Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626883806;
 bh=nme7k6Y/lI/ioM7Dba28xhZiwt+JQ/xW9HSTqvAhPQ8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=FFo0YnXreNwi36yY05r3bXFaDD7p9IPFuEfFrE99GeNolLFawwDj/VjIb7EnqTAzU
 IJucKEhLWtUHUmRD2lEPPDa9mc+g4QLyaEJAq3IHjEmhRf9fctV86kpUaAkbfuZNDo
 KX7wOtoPtZJ6TLtdI+fx9FjaSRdePpR6n6sRUl+ZVlf8O2uY5oyrQfK4g3vJsfea2y
 AzswQfYNyn5sXz5IuqKI3iEbtkV27pbVQXRsSF+ZN0QXJLnztNubUYQLWA4I6LPUS5
 A62CAkCoKsGY74oSzJDmjaycuutyYTeT+6Yn4a8zNqfGfivJjC6cJMiUApEbbzfyHN
 6uJojrCmu2zBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162688380600.30339.881378325987098397.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jul 2021 16:10:06 +0000
References: <20210721100624.704110-1-razor@blackwall.org>
In-Reply-To: <20210721100624.704110-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: multicast: fix igmp/mld
 port context null pointer dereferences
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

This patch was applied to netdev/net-next.git (refs/heads/master):

On Wed, 21 Jul 2021 13:06:24 +0300 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> With the recent change to use bridge/port multicast context pointers
> instead of bridge/port I missed to convert two locations which pass the
> port pointer as-is, but with the new model we need to verify the port
> context is non-NULL first and retrieve the port from it. The first
> location is when doing querier selection when a query is received, the
> second location is when leaving a group. The port context will be null
> if the packets originated from the bridge device (i.e. from the host).
> The fix is simple just check if the port context exists and retrieve
> the port pointer from it.
> 
> [...]

Here is the summary with links:
  - [net-next] net: bridge: multicast: fix igmp/mld port context null pointer dereferences
    https://git.kernel.org/netdev/net-next/c/54cb43199e14

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


