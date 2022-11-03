Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9A988176C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD39281490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667448015;
 bh=37hrWeSpl3u5uDYuGFIDYqDHDgUtcWr43DcEZGl1e9Q=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=GSP4jZIHpAJl/Ho2uafCJzRibRqa1GgIlTubvMrkjKZl/PZ7Ejm9O1PJ6Na0myjE2
 LBcIXgZ/tDun9ArloP43JYhAomKBflTICZTCaGZP+5VhPdNsS71Ir6ZKjOGaPAMlcw
 cObtMFVMSdH3TXTvdoD6S1Ohu7PR5Fg7mgSis0BgjM7b3pOHfj6etIMpdE80goryki
 r93GJo8l1AvoWHwBj/QJZ5p0u2MPqP1t+8tUXqyPeKkgGOVgjZuJgtyNGW5qQieuck
 cWgOUhFEWmVV2g2gx3ONtN5xbFLb1qC4d4N+UeUEXK6AUbnAJe8x6H7mBm5rLfjQhm
 oAviMCI40zvRw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <166744801534.16768.7709737010968160926.git-patchwork-notify@kernel.org>
Date: Thu, 03 Nov 2022 04:00:15 +0000
References: <20221101185753.2120691-1-idosch@nvidia.com>
In-Reply-To: <20221101185753.2120691-1-idosch@nvidia.com>
Subject: Re: [Bridge] [PATCH net] bridge: Fix flushing of dynamic FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Nov 2022 20:57:53 +0200 you wrote:
> The following commands should result in all the dynamic FDB entries
> being flushed, but instead all the non-local (non-permanent) entries are
> flushed:
> 
>  # bridge fdb add 00:aa:bb:cc:dd:ee dev dummy1 master static
>  # bridge fdb add 00:11:22:33:44:55 dev dummy1 master dynamic
>  # ip link set dev br0 type bridge fdb_flush
>  # bridge fdb show brport dummy1
>  00:00:00:00:00:01 master br0 permanent
>  33:33:00:00:00:01 self permanent
>  01:00:5e:00:00:01 self permanent
> 
> [...]

Here is the summary with links:
  - [net] bridge: Fix flushing of dynamic FDB entries
    https://git.kernel.org/netdev/net/c/628ac04a75ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


