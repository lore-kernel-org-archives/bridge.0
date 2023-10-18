Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC3C040278
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B22C7400CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697590830;
 bh=K2deq/2Shw6UljQTvW98Mv2vAHt3FhdhO48jhYtDOe0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=ieSaQVIw+2LuuWrOLgLuT6P47pVmVQWtB8kbHsCga2zN1FQ/8Rl3JpJilDrPGIPqA
 5NUO9MQ4dFBc5vNL2F6LMf75HlvClX9LqGCDaxVWOXtZKHZqonemfs7CKX3s55QLVw
 J6DOPhXgp83P39Jkzj3QQRt6ny65alLAjPSP7MdCBRXoYkhSGp1YzGfXLDi7AXkJTT
 /DVnVUXuAwJVL9gOwGF0wYqwUcwv3akELOxAum53WRBmSOA0Ndjc7mpSCCXAwbaXou
 du4HVJ+vF++TDFWu6730dICpFCQ2ja/IUnyl2baBWDn7DMbWXLdL8+yH0WC7/R+Rs7
 8iCA+NUI/quxw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <169759083043.18882.3734658950123094755.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 01:00:30 +0000
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
In-Reply-To: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
Subject: Re: [Bridge] [PATCH net-next v5 0/5] bridge: Add a limit on learned
	FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, bridge@lists.linux-foundation.org, idosch@nvidia.com, razor@blackwall.org, roopa@nvidia.com, linux-kernel@vger.kernel.org, linux@rempel-privat.de, vladimir.oltean@nxp.com, edumazet@google.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, dsahern@gmail.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Oct 2023 15:27:19 +0200 you wrote:
> Introduce a limit on the amount of learned FDB entries on a bridge,
> configured by netlink with a build time default on bridge creation in
> the kernel config.
> 
> For backwards compatibility the kernel config default is disabling the
> limit (0).
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/5] net: bridge: Set BR_FDB_ADDED_BY_USER early in fdb_add_entry
    https://git.kernel.org/netdev/net-next/c/cbf51acbc5d5
  - [net-next,v5,2/5] net: bridge: Track and limit dynamically learned FDB entries
    https://git.kernel.org/netdev/net-next/c/bdb4dfda3b41
  - [net-next,v5,3/5] net: bridge: Add netlink knobs for number / max learned FDB entries
    https://git.kernel.org/netdev/net-next/c/ddd1ad68826d
  - [net-next,v5,4/5] net: bridge: Set strict_start_type for br_policy
    https://git.kernel.org/netdev/net-next/c/19297c3ab23c
  - [net-next,v5,5/5] selftests: forwarding: bridge_fdb_learning_limit: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/6f84090333bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


