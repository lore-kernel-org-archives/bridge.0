Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C492814B6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92EDD81498
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695128424;
 bh=io+ftfpQvg06fIDKmyqURafsvt5q7qt204CiUaXIDaw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=eZm79v6gA5CJtbgpugwqz0ydh+DJNDJpnOXlqkdiWm+2Rp6/KYzdF37Ny2zZCDqYG
 FSA5wWotjEFujCSmdYciisiWR3J/h/F5VxVHMwgtzlJY5Ve82yF0U0CP3xpAStaxGl
 nQDkp+4h22nger1NbN/Vy64Anapm9/joI2tTsO2qHcFhl2TTOwH22DL8swzop4gG/t
 0Hfj5Sh2eflYQ1RpxvkZ2XNjcF7rVXRl5XSHvNQsll6k+punGFD0HoPGlDxOUri1bK
 ZXSlMSi5+BbK31ZR+/stDAZ5geiwiroWt33/JnknJ03pRsmb4Qjjj8wFWkVqadCuwF
 KYQ4UJYfNpaow==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <169512842290.4172.7265017257182697521.git-patchwork-notify@kernel.org>
Date: Tue, 19 Sep 2023 13:00:22 +0000
References: <20230918091351.1356153-1-edumazet@google.com>
In-Reply-To: <20230918091351.1356153-1-edumazet@google.com>
Subject: Re: [Bridge] [PATCH net] net: bridge: use DEV_STATS_INC()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Dumazet <edumazet@google.com>
Cc: eric.dumazet@gmail.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, syzkaller@googlegroups.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Sep 2023 09:13:51 +0000 you wrote:
> syzbot/KCSAN reported data-races in br_handle_frame_finish() [1]
> This function can run from multiple cpus without mutual exclusion.
> 
> Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.
> 
> Handles updates to dev->stats.tx_dropped while we are at it.
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: use DEV_STATS_INC()
    https://git.kernel.org/netdev/net/c/44bdb313da57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


