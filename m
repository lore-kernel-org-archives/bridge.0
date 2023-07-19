Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C457B81FC0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B425F81FBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689761421;
 bh=Szvpo3jPm6xFX2CjBL67LKjIExmiX39UOjbELPu04do=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=odSk7cwk85Y6E1GTrYTfQD1t32H3n/cthps7bvDWi6t9BU8kCbHvF248DGEJp5OJa
 2e+VMlRR+dzd8d/bLuuHVgh7uKBnPVJ/8hdWGqKzoDbl+YyfNgf5xEdaokISiASd3H
 B+9MYyYcx7znGy0E+pSf+7xpUDks6W4jIBrDehtwH9Qo5qKxMHP+UMo1BqeIJYjeuE
 VLn0sbvBWaVHoT0wc3wKqTU0BPV91hQLqPj9EZTHI3ukWznUWI6q+8s6mwxaUs7l+S
 5bu5+IkfiEwLHUrIFRcG1EWiXFeecPx7gD2y5qz9a+E2wcoSyzf/nKxtqM1xoxi8To
 aZcATMuwohoGg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <168976142170.5988.10461851053537614919.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 10:10:21 +0000
References: <20230717081229.81917-1-idosch@nvidia.com>
In-Reply-To: <20230717081229.81917-1-idosch@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next v2 0/4] Add backup nexthop ID support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: petrm@nvidia.com, dsahern@gmail.com, taspelund@nvidia.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jul 2023 11:12:25 +0300 you wrote:
> tl;dr
> =====
> 
> This patchset adds a new bridge port attribute specifying the nexthop
> object ID to attach to a redirected skb as tunnel metadata. The ID is
> used by the VXLAN driver to choose the target VTEP for the skb. This is
> useful for EVPN multi-homing, where we want to redirect local
> (intra-rack) traffic upon carrier loss through one of the other VTEPs
> (ES peers) connected to the target host.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] ip_tunnels: Add nexthop ID field to ip_tunnel_key
    https://git.kernel.org/netdev/net-next/c/8bb5e82589f0
  - [net-next,v2,2/4] vxlan: Add support for nexthop ID metadata
    https://git.kernel.org/netdev/net-next/c/d977e1c8e3a1
  - [net-next,v2,3/4] bridge: Add backup nexthop ID support
    https://git.kernel.org/netdev/net-next/c/29cfb2aaa442
  - [net-next,v2,4/4] selftests: net: Add bridge backup port and backup nexthop ID test
    https://git.kernel.org/netdev/net-next/c/b408453053fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


