Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649736015;
 bh=cb2IK7ZCUYg0hCj+u3irAlPf2Mq2DTpvNrFIhw03YWc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=DQMSiuzyHCR16iZFZW04LRwCMFM6zgQ6caKxUaG8/R81nQpqtLhLkz6poEnh2R2tf
 Sg938W+z0ihaazpAHZF909HczsHCYXLPZ7w/LtVBG6FQD5Tm3KV4KetKJGmH0Sk0xV
 QycatjgzX0xUY8jw+sDejG0i9xlkLXhHiDh1BWPX4GPQ3+NC1uGQhysGUSKqIYFK9l
 LYzfTdcFT+7idcqIZ928xl7JZwo5D9Tu4/jtg5bCFnnjW1/u+XuczaU4PpkUdPsRef
 bQNWQi8lamVvonXFYYakI51/HpGcQypqAldiMPEN619pA5ycnAsnCKuklsfzML6OFZ
 YSnz9cjGnoTiQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <164973601508.30868.14748692315248046303.git-patchwork-notify@kernel.org>
Date: Tue, 12 Apr 2022 04:00:15 +0000
References: <20220410134227.18810-1-arinc.unal@arinc9.com>
In-Reply-To: <20220410134227.18810-1-arinc.unal@arinc9.com>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: offload BR_HAIRPIN_MODE,
 BR_ISOLATED, BR_MULTICAST_TO_UNICAST
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCA8YXJpbmMudW5hbEBhcmluYzkuY29tPg==?=@ci.codeaurora.org
Cc: olteanv@gmail.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 10 Apr 2022 16:42:27 +0300 you wrote:
> Add BR_HAIRPIN_MODE, BR_ISOLATED and BR_MULTICAST_TO_UNICAST port flags to
> BR_PORT_FLAGS_HW_OFFLOAD so that switchdev drivers which have an offloaded
> data plane have a chance to reject these bridge port flags if they don't
> support them yet.
> 
> It makes the code path go through the
> SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS driver handlers, which return
> -EINVAL for everything they don't recognize.
> 
> [...]

Here is the summary with links:
  - [net-next] net: bridge: offload BR_HAIRPIN_MODE, BR_ISOLATED, BR_MULTICAST_TO_UNICAST
    https://git.kernel.org/netdev/net-next/c/c3976a3f8445

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


