Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650666012;
 bh=zGGEdPIjAESTGghxl2+i/vefsBQOdeJfq4cy+l6eReo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=u15rco15cZ+7+uEEjvLIzCA6R9ZD0Gy4abMM61dxnT6p5dKGjrsLwOzGP4t1jwiM8
 k6tvIJGuyxGRI+hik7bHBzOvqzjRaMK7as9KDsuEbjcvFJvwOieZpFn+KrhAbURU/P
 yit2vdFCE/TqQOmPQ1RtxkdmFHbGFcLlIEZI0sU57xkTbTuxXkTlFGLEcbTQY4yjoE
 UltUKGG7ZQbOdtf2cfBb0VDg8aIzbZi5RRc3npZGoYtOG+nO9EmEDVVBxuquMOfekf
 hmB0lZ3eRLlEe2F5tZ7vmTvEK/JFJ3AIbVgDCrfOUuetJSlp0BU8BfqH4XIfeOBXhd
 B7P3d3g1lmTzQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <165066601248.17746.1567097686981466441.git-patchwork-notify@kernel.org>
Date: Fri, 22 Apr 2022 22:20:12 +0000
References: <20220421101247.121896-1-clement.leger@bootlin.com>
In-Reply-To: <20220421101247.121896-1-clement.leger@bootlin.com>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: switchdev: check
 br_vlan_group() return value
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVtZW50LmxlZ2VyQGJvb3RsaW4uY29tPg==?=@ci.codeaurora.org
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, tobias@waldekranz.com

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Apr 2022 12:12:47 +0200 you wrote:
> br_vlan_group() can return NULL and thus return value must be checked
> to avoid dereferencing a NULL pointer.
> 
> Fixes: 6284c723d9b9 ("net: bridge: mst: Notify switchdev drivers of VLAN MSTI migrations")
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  net/bridge/br_switchdev.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net-next] net: bridge: switchdev: check br_vlan_group() return value
    https://git.kernel.org/netdev/net/c/7f40ea2145d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


