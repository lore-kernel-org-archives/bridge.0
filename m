Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626940204;
 bh=0Pch2NHes7PJ3oRYQUDkZn5NQLnIjBv9eKYjA+g7WnA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=B/d5HmGWitg1uYfaNvwPWOq7xu4bSEHQsUxE4F6ECLcNrqF+GHBTwdF8xQAWul0K8
 P8etUTfMqMPP3JtTiVAhwq/b4QSmtKmiIRDNWyGtyYJcowsboloE4lHzcpKL+mV0El
 H9P1XqgYdf+jpJ+rWW3XMj98nofjbdy2jywbkgg8cghAWxLmbEvYWWSQksAJa59UC+
 wYuH3hOYIDxy9BV6IvS6FkZR489NrnjeJgWgb+P9L+kpq/nEuQanSfBRkojBMZ9gQu
 TVS0mcAjZkC4KkhCSy15mNikOgwedGz4+gMR0Aeeu8Eiw+3+dTEKhoQNACQwN6u2Rt
 YJtBO9DEop+jg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162694020470.16794.15498523906664334643.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jul 2021 07:50:04 +0000
References: <20210721230555.2207542-1-vladimir.oltean@nxp.com>
In-Reply-To: <20210721230555.2207542-1-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH net-next] net: switchdev: fix FDB entries
 towards foreign ports not getting propagated to us
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, ericwouds@gmail.com, dqfext@gmail.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net, tobias@waldekranz.com

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Thu, 22 Jul 2021 02:05:55 +0300 you wrote:
> The newly introduced switchdev_handle_fdb_{add,del}_to_device helpers
> solved a problem but introduced another one. They have a severe design
> bug: they do not propagate FDB events on foreign interfaces to us, i.e.
> this use case:
> 
>          br0
>         /   \
>        /     \
>       /       \
>      /         \
>    swp0       eno0
> (switchdev)  (foreign)
> 
> [...]

Here is the summary with links:
  - [net-next] net: switchdev: fix FDB entries towards foreign ports not getting propagated to us
    https://git.kernel.org/netdev/net-next/c/2b0a5688493a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


