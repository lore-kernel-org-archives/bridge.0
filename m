Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB80C842B8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B99BF842B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664538018;
 bh=IKQvAUjVVe1ZMOX9oFnDoAiO//gd9z/bUiOy6VuwVMI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Q4q2PYnk3qFvWGMO03ERrMA2N7PbBSOzQWTXSGGfXf0dNcY8321kG7c5Whw+tM5T+
 0glNm18fb0CqmiF+MszPH3lQudGn3ZvDqbt4OQB5FHAsVh42kQrDYS4TdWpj2gcIau
 0ENfhNFUI8pWUQDQJQ5taP0YN7LnWlr7flXZ7FYvyy/zzlopC0z1p0tFzqmn/H7kip
 lc8I2ShMw3TaENFA+MEVjLhW3FbPSYDgiak8Gah1MggHhfyo1LJSz67PKHtFEifUFH
 zI5unapzBJdxgjP3rW3Ie2tWu+XSKtwDOD8yJzNM+VotXUXA7mDagxKUDrUAOmN5mS
 VL8ryoDJptKwg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <166453801829.4225.8647161065788331137.git-patchwork-notify@kernel.org>
Date: Fri, 30 Sep 2022 11:40:18 +0000
References: <20220928175758.2106806-1-steven.hsieh@broadcom.com>
In-Reply-To: <20220928175758.2106806-1-steven.hsieh@broadcom.com>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: assign path_cost for
 2.5G and 5G link speed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Steven Hsieh <steven.hsieh@broadcom.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Wed, 28 Sep 2022 10:57:58 -0700 you wrote:
> As 2.5G, 5G ethernet ports are more common and affordable,
> these ports are being used in LAN bridge devices.
> STP port_cost() is missing path_cost assignment for these link speeds,
> causes highest cost 100 being used.
> This result in lower speed port being picked
> when there is loop between 5G and 1G ports.
> 
> [...]

Here is the summary with links:
  - [net-next] net: bridge: assign path_cost for 2.5G and 5G link speed
    https://git.kernel.org/netdev/net-next/c/bd1393815319

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


