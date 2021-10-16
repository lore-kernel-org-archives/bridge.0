Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634393407;
 bh=erH01x84fzWNhqUeM717403Vw8lEpcsZcHJsVpbR1p4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=TBmBG7/9a71DWVSFrGlXp1g2B/gniJ5OJrlABBGHJV+5VKcgUKHkpp7Tt1UkB+tlw
 C/6f5Lq2u1PtxLY3mw/iw7RnsUB7tliqxUU7WcFDmQ4m5sxQf1ptBPj1gM9ZX3WAcs
 8OSeu6IJhfaxITpCGzYJxCEWiT9gkEU7kfooH1YGabb7jwCEkL2zAmxLkPN+uM+yVZ
 8jL/pmiuHTpEVTMz6jUNgbIc4vF1LwRKWq/4AmPeWqi9j6sfD6eQCw1nkVbtUx1Xcl
 2ziu/kawllRHzViMVM4tqMix0MTLLTaGZ8VMRchKNVJYy+eA1B4deAdvHIUcouGozD
 Kv+u+kxrCXI6g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163439340695.2147.18399180717988406191.git-patchwork-notify@kernel.org>
Date: Sat, 16 Oct 2021 14:10:06 +0000
References: <20211015090546.19967-1-razor@blackwall.org>
In-Reply-To: <20211015090546.19967-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net] net: bridge: mcast: use
 multicast_membership_interval for IGMPv3
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, liuhangbin@gmail.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Oct 2021 12:05:46 +0300 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> When I added IGMPv3 support I decided to follow the RFC for computing
> the GMI dynamically:
> " 8.4. Group Membership Interval
> 
>    The Group Membership Interval is the amount of time that must pass
>    before a multicast router decides there are no more members of a
>    group or a particular source on a network.
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: mcast: use multicast_membership_interval for IGMPv3
    https://git.kernel.org/netdev/net/c/fac3cb82a54a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


