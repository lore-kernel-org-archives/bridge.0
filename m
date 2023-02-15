Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC9B4415DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 64FAB40342
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1676436619;
 bh=Hpm+5UfMmGIvwWNCzlutXjEPevQMb+5N7rtPRfIxSLc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=TnvrtkLO0BE1u51lVpU6hMEeCdhI7sN66M3Cv4STcyGEo70f+bhG2gMugWs55IxfK
 1qn3jQsO2MigZo9eORhULLegtZDd1b5v7eM7wJcmEUsxUWGMBthhpwCOKskagAb01f
 d9392bDEJhPmWXpwQBxNBsyTzDQdTuLVKjjkyTu0N2pPSPr9AubKUNwMuEOAY9fOeD
 SPNoysqrf/tdkJMxc+irsKOd93ctDA7zrO7Zipdl/JxqJDF8OUrur4bwWuARPh3RPd
 RoHq36MKzwUdOfLVUC8MPVUTkBNSl1w8kC+cgyQm3r3c91AxjBFHBoo15l3JDkH/J7
 +ItFtDdiZ1R7Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <167643661914.17897.15068039752678209859.git-patchwork-notify@kernel.org>
Date: Wed, 15 Feb 2023 04:50:19 +0000
References: <20230211-kobj_type-net-v2-0-013b59e59bf3@weissschuh.net>
In-Reply-To: <20230211-kobj_type-net-v2-0-013b59e59bf3@weissschuh.net>
Subject: Re: [Bridge] [PATCH net-next v2 0/2] net: make kobj_type structures
	constant
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@ci.codeaurora.org
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Feb 2023 04:23:10 +0000 you wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: bridge: make kobj_type structure constant
    https://git.kernel.org/netdev/net-next/c/e8c6cbd7656e
  - [net-next,v2,2/2] net-sysfs: make kobj_type structures constant
    https://git.kernel.org/netdev/net-next/c/b2793517052d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


