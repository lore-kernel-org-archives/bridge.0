Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634559011;
 bh=HqaSPhUMlFlcfNoprF3LE///eSpUVIhd/IiotTyQ6o4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=lNk3VSo6ST1EAX8d4naHiv4PcjmuiBL57/1MdRtVgD7TbouYUP39Vpq49Kye9Xy3Z
 MU9nso5x0zCzVmXkWgqgUHwttllaNAfhyTMT2lHxtsdZYdEf+V4hs9BtqCSUKmei8D
 4ItRpDCRo56EtBYbwfG2jjvKakDUCqHWp42FTtBbUgusyvJOv6Ds54oM6yyjzEZKSx
 MtoDJeRoGFa1z8j3rS5q5h/6HMrLOz02OLcXVSFMCt51gnhljdrrZXwMkb/b6pdLeo
 xlvJ4RmqV+F9YipzHKdvRFNmFFNWYMlSvMgWR3XU0CjYAvtCp3w+jrzZS5p2uVd093
 jCsDbtQ0BtXKw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163455901121.7340.10701802688930426386.git-patchwork-notify@kernel.org>
Date: Mon, 18 Oct 2021 12:10:11 +0000
References: <20211016112137.18858-1-acadx0@gmail.com>
In-Reply-To: <20211016112137.18858-1-acadx0@gmail.com>
Subject: Re: [Bridge] [PATCH v3 net-next] net: make use of helper
	netif_is_bridge_master()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kyungrok Chung <acadx0@gmail.com>
Cc: bridge@lists.linux-foundation.org, pablo@netfilter.org, coreteam@netfilter.org, mareklindner@neomailbox.ch, sw@simonwunderlich.de, fw@strlen.de, b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc, linux-kernel@vger.kernel.org, kadlec@netfilter.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net, sven@narfation.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Sat, 16 Oct 2021 20:21:36 +0900 you wrote:
> Make use of netdev helper functions to improve code readability.
> Replace 'dev->priv_flags & IFF_EBRIDGE' with netif_is_bridge_master(dev).
> 
> Signed-off-by: Kyungrok Chung <acadx0@gmail.com>
> ---
> 
> v1->v2:
>   - Apply fixes to batman-adv, core too.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: make use of helper netif_is_bridge_master()
    https://git.kernel.org/netdev/net-next/c/254ec036db11

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


