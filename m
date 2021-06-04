Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622843404;
 bh=wEGISPwpp3pYI5B6deH40LEMJDeq72dbo/qap1ROPiU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=idgU3/OsrjNCFhH8yC3wNfS8RrA2ooORTrOWmyGjPpJJLV6jvZXgZIuM4uKIQpcZL
 5YyBhwz9e/AzpqRmTv1kwxIa6MgiNh+n0YG7gmPGIXiGwesUYhCshdZLMnvGRFde7Z
 tLOwUqW0aCAuqMf8+aNW9smHeLoB6BjssZmkePheM6sdMB+IvaoWNpUu7VKOjs7lTB
 H+wGHOYE7dBLehTPFrrxdwLmFsVXq58/wHbSulNz4LmIUwMe4F6VxmCZfnsH1aAsjC
 sQAZfQ/5YVJ6NaN8TYmnC5XnB3yVs6xXXndVI9O8gMh6Iq2Z91bZ5uYB2/D+LSctQ9
 BPWidwJSR/9NQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162284340476.5449.16639869522186820582.git-patchwork-notify@kernel.org>
Date: Fri, 04 Jun 2021 21:50:04 +0000
References: <20210604103747.3824212-1-horatiu.vultur@microchip.com>
In-Reply-To: <20210604103747.3824212-1-horatiu.vultur@microchip.com>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: mrp: Update ring
	transitions.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Fri, 4 Jun 2021 12:37:47 +0200 you wrote:
> According to the standard IEC 62439-2, the number of transitions needs
> to be counted for each transition 'between' ring state open and ring
> state closed and not from open state to closed state.
> 
> Therefore fix this for both ring and interconnect ring.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: bridge: mrp: Update ring transitions.
    https://git.kernel.org/netdev/net-next/c/fcb34635854a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


