Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624921812;
 bh=fxoPPkezoq09U1qbqIWrKlH5vEDlaCz1ty2xT3XSrEE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=kb+wqh5fq71WIMagv4QK5G+EaDzj4O6VdYReR09+wcVSBUweL4SYfyNHjZ9f2H4JH
 U1EDB7RuU0fpXimmoMqdMXPLYwRAICtDn+KACVbQkCtXx3K74wRBJ55f0dxxPPUZs7
 pSbxYSOEM6ROFLWBEBOZ6NMIRDfDxF5Q7oLMjdQ0rdICHMSEsku5+CXIgDc4/LPJB+
 EqOkXEp8eh7Yk96f9I+qnTJCv7YLtxoMrVcae/WJdfhRtW4EddVVbrv1g4KrJcxWXh
 AeagGwN5hSqMpVQU9fbAGjtjH9KOaITX5uQvjZ7bGt8P+mWwLSFXPXgotWaU37K0ZC
 H/PX/q9/+tz5g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162492181203.29625.17848811968952266150.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jun 2021 23:10:12 +0000
References: <20210626201804.1737815-1-horatiu.vultur@microchip.com>
In-Reply-To: <20210626201804.1737815-1-horatiu.vultur@microchip.com>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: mrp: Update the Test
	frames for MRA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Sat, 26 Jun 2021 22:18:04 +0200 you wrote:
> According to the standard IEC 62439-2, in case the node behaves as MRA
> and needs to send Test frames on ring ports, then these Test frames need
> to have an Option TLV and a Sub-Option TLV which has the type AUTO_MGR.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp.c         | 27 +++++++++++++++++++++++++++
>  net/bridge/br_private_mrp.h | 11 +++++++++++
>  2 files changed, 38 insertions(+)

Here is the summary with links:
  - [net-next] net: bridge: mrp: Update the Test frames for MRA
    https://git.kernel.org/netdev/net-next/c/f7458934b079

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


