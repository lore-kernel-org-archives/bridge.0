Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643303409;
 bh=pQ9TQhH/zfvT4t/ngXp1Qvqr0CwHUKwkOyGw+KL0Poc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=AeICuIR1X4/4Yb/dvF4124tcCZYPjJ5Gfnbwedn/qxktOGf3pN19E55pKKykUwXl6
 FbB0aVKp7Bt0LUuMMx8CheBnvd7pXHKjcX/SW5e4SCsgaZFayjNKWvq8AeWnIgWyL8
 Kp4yENYSkM3tLgEhZihA/OS61Zhc0RRbXeh4/2cTju83Qb4tZi6j3XLgh9znj0ww1D
 HHSspTTNt/0n3WDlV/nGtSBVi6/EmA1FtTXYIexW9uStXW8AmaCWa3Cp/+yRJxPbiR
 H7D6L2/QOPax/pjby1Oni3K1mNpRdI1BJOcfVz5y+eLk7AmOstxE2rMKMPSxqyhnhL
 ILzEt0OG1rFEg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <164330340982.19448.11235674242390336417.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jan 2022 17:10:09 +0000
References: <20220127074953.12632-1-tim.yi@pica8.com>
In-Reply-To: <20220127074953.12632-1-tim.yi@pica8.com>
Subject: Re: [Bridge] [PATCH] net: bridge: vlan: fix memory leak in
	__allowed_ingress
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tim Yi <tim.yi@pica8.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jan 2022 15:49:53 +0800 you wrote:
> When using per-vlan state, if vlan snooping and stats are disabled,
> untagged or priority-tagged ingress frame will go to check pvid state.
> If the port state is forwarding and the pvid state is not
> learning/forwarding, untagged or priority-tagged frame will be dropped
> but skb memory is not freed.
> Should free skb when __allowed_ingress returns false.
> 
> [...]

Here is the summary with links:
  - net: bridge: vlan: fix memory leak in __allowed_ingress
    https://git.kernel.org/netdev/net/c/fd20d9738395

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


