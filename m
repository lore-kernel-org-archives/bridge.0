Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637331609;
 bh=pjpzP9H3wrBaZrYocYGO8qrHvgn5vKMBZS1Zg+A2dZs=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=lyKSqcQrOB3rmrtZvv132yaGMwMrTX9NC0PSogPTKazSaOmL0+r95F11tcQmRLfRH
 4d/jtdikxoOqGu11XMXjBy59uBpE2xSAfmFddByT17I8EnJHoHS11fB7LtZQl4QSh3
 9Nt6sHpN+v7kna/ak+Qzod2BDDrI7LkazQwp77sWbyp0haZNpoeqtAjhlBO2wDE6YV
 Vy7jdgFTCMHHc6eQeHUs5Fzx8FMEca+D1jqVatqtrbez7+VL+ElSPf3x+N6chpsvge
 eu0WRoO4zHykRQwIx5lK1M3v12wc/zFD/4XZ0T1V+f3+7wRDKUA4qlOsL2alCLUSgy
 pEgffhjkVer/w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163733160939.14640.16666157203692458688.git-patchwork-notify@kernel.org>
Date: Fri, 19 Nov 2021 14:20:09 +0000
References: <20211119020642.108397-1-bernard@vivo.com>
In-Reply-To: <20211119020642.108397-1-bernard@vivo.com>
Subject: Re: [Bridge] [PATCH] net/bridge: replace simple_strtoul to kstrtol
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bernard Zhao <bernard@vivo.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Nov 2021 18:06:42 -0800 you wrote:
> simple_strtoull is obsolete, use kstrtol instead.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  net/bridge/br_sysfs_br.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Here is the summary with links:
  - net/bridge: replace simple_strtoul to kstrtol
    https://git.kernel.org/netdev/net-next/c/520fbdf7fb19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


