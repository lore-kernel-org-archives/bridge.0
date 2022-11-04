Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19C3040332
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E57EA4030C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667538027;
 bh=L6pGhT4K1VahEFtueGJCgnf8u+IzStsSlBQ3uVCR6sI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=i/5JdLsNvTCTx7CfN0Cnna3/b7aupU1z11GKQKJBxEXYOYJZt4SUdQX3W6Iu90xBF
 IbEVdMe3/VpRoFQ5f+ibuUHEpGYAcNWrsJ8jmMVUge66R/oojU5V7jav/LgWLtRQYW
 4O5qX3fKtVgD2tbghBsovQ84BkqBZHA3pveRrxBBMiTY75tL+cey8oufrxI2ef1VIO
 24ZJ/Hy8FKa6Yh7U7jytoYsLkb214akrwrbXfkPTElX8j/MDQ+Y97DwIqXcCeMvlrZ
 z+UeaBE88Zd/zuz0VyUhUe6gDnBeAmhsuuS1X0nvvCfyMWnCLD7xMqzvjkZ1NDD4XH
 XZw7ROk46i74g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <166753802715.27738.6160625606606714662.git-patchwork-notify@kernel.org>
Date: Fri, 04 Nov 2022 05:00:27 +0000
References: <20221101193922.2125323-1-idosch@nvidia.com>
In-Reply-To: <20221101193922.2125323-1-idosch@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next 0/2] bridge: Add MAC Authentication
 Bypass (MAB) support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@kapio-technology.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Nov 2022 21:39:20 +0200 you wrote:
> Patch #1 adds MAB support in the bridge driver. See the commit message
> for motivation, design choices and implementation details.
> 
> Patch #2 adds corresponding test cases.
> 
> Follow-up patchsets will add offload support in mlxsw and mv88e6xxx.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] bridge: Add MAC Authentication Bypass (MAB) support
    https://git.kernel.org/netdev/net-next/c/a35ec8e38cdd
  - [net-next,2/2] selftests: forwarding: Add MAC Authentication Bypass (MAB) test cases
    https://git.kernel.org/netdev/net-next/c/4a331d346996

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


