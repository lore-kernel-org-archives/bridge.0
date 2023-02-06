Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9683F4163E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5647141608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675674019;
 bh=LbjlkWb8XyBiD1qMkYuIHIYS60S6zUEjrPIyWyRLYV4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Uo3qk4jFvFweCncj+XaVraSfXNduQQ2tBq/8Jcq++ag07szLlDtzW1T4RDHG/e6Mx
 z2xx7RAwH8LaS1Aer1HzqyFhcRqWejS57nDeLxGjuWvBF1d+JsVbLBD+MWu5+vCvDX
 wALNIEqilBJqgKRh3sUmiYwRpOi/ewoLd7PGHzcfqp7we3mJIe7ilYdLGUHHVa0ZdY
 elhrZvRtEv0zWS9y7hLpqbrK/BCOmPLz95tRQfVPBqUPY2EtrYlgZrcQvddcVgFwul
 PP1YQxddNze0IlrFwb5/7m6ZwuglXmz98HtOB+yv+wd0Q9sTKgD6Gn0xf9F2/CZtb3
 uhNfzNqw3eg4w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <167567401932.11144.3817510754379693271.git-patchwork-notify@kernel.org>
Date: Mon, 06 Feb 2023 09:00:19 +0000
References: <cover.1675359453.git.petrm@nvidia.com>
In-Reply-To: <cover.1675359453.git.petrm@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next v3 00/16] bridge: Limit number of MDB
 entries per port, port-vlan
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, idosch@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Thu, 2 Feb 2023 18:59:18 +0100 you wrote:
> The MDB maintained by the bridge is limited. When the bridge is configured
> for IGMP / MLD snooping, a buggy or malicious client can easily exhaust its
> capacity. In SW datapath, the capacity is configurable through the
> IFLA_BR_MCAST_HASH_MAX parameter, but ultimately is finite. Obviously a
> similar limit exists in the HW datapath for purposes of offloading.
> 
> In order to prevent the issue of unilateral exhaustion of MDB resources,
> introduce two parameters in each of two contexts:
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/16] net: bridge: Set strict_start_type at two policies
    https://git.kernel.org/netdev/net-next/c/c00041cf1cb8
  - [net-next,v3,02/16] net: bridge: Add extack to br_multicast_new_port_group()
    https://git.kernel.org/netdev/net-next/c/60977a0c6337
  - [net-next,v3,03/16] net: bridge: Move extack-setting to br_multicast_new_port_group()
    https://git.kernel.org/netdev/net-next/c/1c85b80b20a1
  - [net-next,v3,04/16] net: bridge: Add br_multicast_del_port_group()
    https://git.kernel.org/netdev/net-next/c/976b3858dd14
  - [net-next,v3,05/16] net: bridge: Change a cleanup in br_multicast_new_port_group() to goto
    https://git.kernel.org/netdev/net-next/c/eceb30854f6b
  - [net-next,v3,06/16] net: bridge: Add a tracepoint for MDB overflows
    https://git.kernel.org/netdev/net-next/c/d47230a3480a
  - [net-next,v3,07/16] net: bridge: Maintain number of MDB entries in net_bridge_mcast_port
    https://git.kernel.org/netdev/net-next/c/b57e8d870d52
  - [net-next,v3,08/16] net: bridge: Add netlink knobs for number / maximum MDB entries
    https://git.kernel.org/netdev/net-next/c/a1aee20d5db2
  - [net-next,v3,09/16] selftests: forwarding: Move IGMP- and MLD-related functions to lib
    https://git.kernel.org/netdev/net-next/c/344dd2c9e743
  - [net-next,v3,10/16] selftests: forwarding: bridge_mdb: Fix a typo
    https://git.kernel.org/netdev/net-next/c/f7ccf60c4ada
  - [net-next,v3,11/16] selftests: forwarding: lib: Add helpers for IP address handling
    https://git.kernel.org/netdev/net-next/c/fcf4927632ee
  - [net-next,v3,12/16] selftests: forwarding: lib: Add helpers for checksum handling
    https://git.kernel.org/netdev/net-next/c/952e0ee38c72
  - [net-next,v3,13/16] selftests: forwarding: lib: Parameterize IGMPv3/MLDv2 generation
    https://git.kernel.org/netdev/net-next/c/506a1ac9d32b
  - [net-next,v3,14/16] selftests: forwarding: lib: Allow list of IPs for IGMPv3/MLDv2
    https://git.kernel.org/netdev/net-next/c/705d4bc7b6b6
  - [net-next,v3,15/16] selftests: forwarding: lib: Add helpers to build IGMP/MLD leave packets
    https://git.kernel.org/netdev/net-next/c/9ae854697317
  - [net-next,v3,16/16] selftests: forwarding: bridge_mdb_max: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/3446dcd7df05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


