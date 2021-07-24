Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627159804;
 bh=j6Ih0psRC49VSyGvCnlv4QrSO2iI9itjL7KoOjRaXow=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=tdfXy095Ofbtkj2Y1ibUxPLX0KlguNo7asI4YJimJb2XezXUvJ1H8P0tgVuFpDYaN
 krwAf7mjy5J2TLeMN/TzId7LyrU7BabdYNKQK8pQZRj7s3oLWH4f/5lQbnms6c7Efa
 iilORXDYij43SvlUPhLeK35179djVBsZMXQ8477IZxbxAF//LUwtOokbHJtfO3magB
 Ez7/rsRNu+4cudaq3r0t+LHZXnuFN8J5lrUj3Q0fC2hnQCLLW42Fs3ZFl1cqk1QTXb
 8fBUybWL04hxwqM8jjdL0f8e7tU4FE8r05pZ7Ms/kWNdyh67DHc55hcrKTgWxT5dYQ
 psGzX+ZDiEQUA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162715980447.18267.8661173843406406793.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jul 2021 20:50:04 +0000
References: <20210723204911.3884995-1-vladimir.oltean@nxp.com>
In-Reply-To: <20210723204911.3884995-1-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: fix build when setting
 skb->offload_fwd_mark with CONFIG_NET_SWITCHDEV=n
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: f.fainelli@gmail.com, lkp@intel.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net, tobias@waldekranz.com

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Fri, 23 Jul 2021 23:49:11 +0300 you wrote:
> Switchdev support can be disabled at compile time, and in that case,
> struct sk_buff will not contain the offload_fwd_mark field.
> 
> To make the code in br_forward.c work in both cases, we do what is done
> in other places and we create a helper function, with an empty shim
> definition, that is implemented by the br_switchdev.o translation module.
> This is always compiled if and only if CONFIG_NET_SWITCHDEV is y or m.
> 
> [...]

Here is the summary with links:
  - [net-next] net: bridge: fix build when setting skb->offload_fwd_mark with CONFIG_NET_SWITCHDEV=n
    https://git.kernel.org/netdev/net-next/c/c5381154393d

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


