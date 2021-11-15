Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636985409;
 bh=SIs+iwklv8KfbyfcsPobIZu2x2aKdT3tn5NnV3mSFn4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=QSuzW6b5ffmWFK6oCQMl0O0SLjurwpJFG8GxvAO2g9Sk2Rv0TQioBmBD4sRv/AJj5
 b7D/RfbIrxEFoyJ4AzQpizyhRhcqF3pPlu66g4S1WM7CfOk1Rx6G3ID6YcEu6KlDa2
 AKLbAn/ECR677rrfE50nCkryxroRvS3GuSbWGAD7w1Z/frl+CSK/aH3645kkkXfgYn
 4Uk0kNAGciQOT1oT0IEyqXZoSpsnNEHBiV+7ehahmPMgC7AHq4+IlkUU7nH7+n6CwI
 aRotyVbz0jH9xXuebLTnPYcsj5xucJ9QfUe8Ta3LV/wsRwqAd68yr7XkMcyrUjXVBv
 caQBg3M38LjFQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163698540899.13805.10527037556945584609.git-patchwork-notify@kernel.org>
Date: Mon, 15 Nov 2021 14:10:08 +0000
References: <00c39d09c8df7ad0673bf2043f6566d6ef08b789.1636916479.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <00c39d09c8df7ad0673bf2043f6566d6ef08b789.1636916479.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [Bridge] [PATCH] net: bridge: Slightly optimize 'find_portno()'
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Sun, 14 Nov 2021 20:02:35 +0100 you wrote:
> The 'inuse' bitmap is local to this function. So we can use the
> non-atomic '__set_bit()' to save a few cycles.
> 
> While at it, also remove some useless {}.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - net: bridge: Slightly optimize 'find_portno()'
    https://git.kernel.org/netdev/net-next/c/cc0be1ad686f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


