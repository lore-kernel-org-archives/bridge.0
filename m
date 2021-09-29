Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632883207;
 bh=Yt+Qqw2yGqDgP3vvoWuiOsVwZIpl/fcjT2xixYQjSj8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=jI4X9C46aUTRF2aDz+tdCZwMwNa0IHZEIssMeGG24VgEYEAiyn8/jg+42bjzL66+Z
 /MyPpebKHYDREveM5Q7knkA5vr0dDRVALN6hnld1tWI4wd2hZAR1SniuSPp/pnIH5G
 puKrtHEkbh6joMPwiHKjyCdc9E+/UUscj+ALxJnCqAbpmHf17CXUuIHTjas3grpt7s
 NU89asyS4dCrrQ9fMgL4F8f4+8zJLnzibSbfEpon06+K0u6bRRRPOrlHx0RDlU8btZ
 QWc7dhdowVM+gR0ShCs8kGEAVoZV/NjFFnVBRwroDYCzIAPr3cP7d64XI3+UHcDQo1
 Z+cZ26fW3fbDQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163288320705.8381.15834079982725881362.git-patchwork-notify@kernel.org>
Date: Wed, 29 Sep 2021 02:40:07 +0000
References: <20210928141049.593833-1-bigeasy@linutronix.de>
In-Reply-To: <20210928141049.593833-1-bigeasy@linutronix.de>
Subject: Re: [Bridge] [PATCH net] net: bridge: mcast: Associate the seqcount
 with its protecting lock.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: efault@gmx.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, tglx@linutronix.de, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Tue, 28 Sep 2021 16:10:49 +0200 you wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The sequence count bridge_mcast_querier::seq is protected by
> net_bridge::multicast_lock but seqcount_init() does not associate the
> seqcount with the lock. This leads to a warning on PREEMPT_RT because
> preemption is still enabled.
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: mcast: Associate the seqcount with its protecting lock.
    https://git.kernel.org/netdev/net/c/f936bb42aeb9

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


