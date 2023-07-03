Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48AEA409FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 174DE40935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688372422;
 bh=GAdkZrdoKWD7YyzDP8ANymefO04wUe7jKXHOYI0JvAo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=JOvpxdIGeaV0pdDRSr0O5u0avi/sD+ggbLk1bJO5icXqWRlhcCGWiUmErpMum5SN2
 UmenbWL94IdusSUdkoxIcOmb8uFVJVDSvRrFWDFyvfuKGj4+UkEdb4O3cBOZ67sFOs
 X4k0VsnwUdlE7L4UN+C8F0yolhb5FkqbVPq8VmNtHUDZ/4LiOlYT0BbrXwvjut4iM/
 4b8kECPQ41MhyrEat0zPWUnaBjOG4pdlfO5HN36CjEZqu2SFZVWKbS0mZOLsJjF1u+
 N3qbafx/sjDRzdgsXrMPXwWN+uhFVVLMVKjGBV08nyDdUK55oh2E/ECNlxWn8+0PaN
 V2s7G2bqmU4OA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <168837242257.9798.3078714826638477204.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jul 2023 08:20:22 +0000
References: <20230630164118.1526679-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230630164118.1526679-1-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH net] net: bridge: keep ports without
 IFF_UNICAST_FLT in BR_PROMISC mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: vyasevic@redhat.com, mst@redhat.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 30 Jun 2023 19:41:18 +0300 you wrote:
> According to the synchronization rules for .ndo_get_stats() as seen in
> Documentation/networking/netdevices.rst, acquiring a plain spin_lock()
> should not be illegal, but the bridge driver implementation makes it so.
> 
> After running these commands, I am being faced with the following
> lockdep splat:
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode
    https://git.kernel.org/netdev/net/c/6ca3c005d060

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


