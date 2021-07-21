Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626904204;
 bh=8tkeDtxOoppgqWkTF5198Sw+Ha/XDXYFXWHjo7kC51c=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=EosbHorcyJdiBrK0nvFn+OI1sSzhF1iVW7RPE7hAMejgdzjOoqj90ZRCQfbGGF9wS
 YQAVy5VtSPhXap6TvkZTuW9dFVUke8aDaZnhJeiUsEotaJ+u6KNHLJbiTZ2Y9A04hc
 5lPBPiAH/Q4yFZ5vO6mrBE4eYVof4Q5Nx+O9VamWC3mOg1Y+KG0TfwcyJoJ1g3Lzl1
 Yipf/NZO0vDWVys3FU/IBMvviH98f+Th/ZH4mSmqsCkDeqZ6/UcciKZ6ywdR9vlIRR
 ep5GJIFC1B9ObHjdPbKa649T3ycX1DJc+bWHw9ikRXc2wepRa87egeQBErjuHDiKo+
 DUzKMRYqdIkBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162690420436.1414.1687254067791597948.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jul 2021 21:50:04 +0000
References: <20210721140127.773194-1-razor@blackwall.org>
In-Reply-To: <20210721140127.773194-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next 0/2] net: bridge: multicast: add mdb
 and host context support
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

On Wed, 21 Jul 2021 17:01:25 +0300 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Hi,
> This is a minor context improvement which chooses the proper multicast
> context when adding user mdb entries or host-joined entries (pointing to
> the bridge device). Patch 01 adds a helper which chooses the proper
> context when user-space is adding an mdb entry, note that it requires
> the vlan to be configured on at least 1 device (port or bridge) so it
> would have a multicast context. Patch 02 changes br_multicast_host_join
> to take a bridge multicast context parameter which is passed down from
> the respective functions, currently it is used for the timer config
> value only. This set is in preparation for adding all multicast options
> for vlans.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: bridge: multicast: add mdb context support
    https://git.kernel.org/netdev/net-next/c/6567cb438a51
  - [net-next,2/2] net: bridge: multicast: add context support for host-joined groups
    https://git.kernel.org/netdev/net-next/c/58d913a32664

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


