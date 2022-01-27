Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643292010;
 bh=fuxNmULtsgNCuFSvQVh98CjexGQvH+8isVMDzy7ABpI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=lg4+xwVh1AybDV2H2RmdkJYveSRbIeDPrDrQx+n6bp/OlRW6DDpleM+5aWaNsoqTs
 NtjgOK6KxrFnXff/C8lk6yOQcfUdgSSmo6nClPoJU+r+C1l7SKFNqxYRxsXDfLiqzj
 1DBHY2GfLW3phqwZXVl41sKvnKR6o1VNtDyao8tkaBbyms9Vdmc+VCAbd5pdPE8Mzr
 ekWS8THqhkUeCfko2xD6gf4qjOX9d4ndeBfM46vJ81blxrk5EhRDZedQmuJXbXZrWX
 sZNrP3Pedy+gNz5zVIopo1k7YnDV1DaE+R2j1rzNdPDydoUj5ukUMu+r9HLd37p4a7
 Ir9iPEz4s3WVw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <164329201077.13469.5252832269191984892.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jan 2022 14:00:10 +0000
References: <20220126131025.2500274-1-nikolay@nvidia.com>
In-Reply-To: <20220126131025.2500274-1-nikolay@nvidia.com>
Subject: Re: [Bridge] [PATCH net] net: bridge: vlan: fix single net device
	option dumping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: bpoirier@nvidia.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Wed, 26 Jan 2022 15:10:25 +0200 you wrote:
> When dumping vlan options for a single net device we send the same
> entries infinitely because user-space expects a 0 return at the end but
> we keep returning skb->len and restarting the dump on retry. Fix it by
> returning the value from br_vlan_dump_dev() if it completed or there was
> an error. The only case that must return skb->len is when the dump was
> incomplete and needs to continue (-EMSGSIZE).
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: vlan: fix single net device option dumping
    https://git.kernel.org/netdev/net/c/dcb2c5c6ca9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


