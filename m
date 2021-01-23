Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611374413;
 bh=iEhrcIZKkyq3zuL6PgORytauNw5HJAjuhrj3cKyNVJk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=BaczC1xitfhqmzIv7wZtTwyY6Pfv3ggpOi+9TCm2dvjX5NRXk2vCvMPuvckAiKMwI
 Kn+MloOzNHRy4VTf+IXlCQCc1Nq5fObVp14lq1qkWjVyUFTUnKC78C3tymy3Z6fLnf
 zpzaDRjYPbrsQi0CoKIdztws1P8p/qIle/ZwVCtPDjw9kLMSup06nEZx4aNU5EosjW
 WNMGoDqmjLPa38k4yTauRbqL0fPDXaYam31VnypleaGCx2aU/JCt+84WXmeNQE9sAG
 7QGxPsVtTOgH7/6EFiH8WJvjFxj7sG/HkDFZd80Uj9bXGweaELNPOTRIYDaFh67ZQq
 sCaYX/d5tmDhw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161137441292.10014.1698354363160808184.git-patchwork-notify@kernel.org>
Date: Sat, 23 Jan 2021 04:00:12 +0000
References: <20210120145203.1109140-1-razor@blackwall.org>
In-Reply-To: <20210120145203.1109140-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next 00/14] net: bridge: multicast: add
 initial EHT support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Wed, 20 Jan 2021 16:51:49 +0200 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Hi,
> This set adds explicit host tracking support for IGMPv3/MLDv2. The
> already present per-port fast leave flag is used to enable it since that
> is the primary goal of EHT, to track a group and its S,Gs usage per-host
> and when left without any interested hosts delete them before the standard
> timers. The EHT code is pretty self-contained and not enabled by default.
> There is no new uAPI added, all of the functionality is currently hidden
> behind the fast leave flag. In the future that will change (more below).
> The host tracking uses two new sets per port group: one having an entry for
> each host which contains that host's view of the group (source list and
> filter mode), and one set which contains an entry for each source having
> an internal set which contains an entry for each host that has reported
> an interest for that source. RB trees are used for all sets so they're
> compact when not used and fast when we need to do lookups.
> To illustrate it:
>  [ bridge port group ]
>   ` [ host set (rb) ]
>    ` [ host entry with a list of sources and filter mode ]
>   ` [ source set (rb) ]
>    ` [ source entry ]
>     ` [ source host set (rb) ]
>      ` [ source host entry with a timer ]
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] net: bridge: multicast: rename src_size to addr_size
    https://git.kernel.org/netdev/net-next/c/9e10b9e65699
  - [net-next,02/14] net: bridge: multicast: pass host src address to IGMPv3/MLDv2 functions
    https://git.kernel.org/netdev/net-next/c/54bea7219641
  - [net-next,03/14] net: bridge: multicast: __grp_src_block_incl can modify pg
    https://git.kernel.org/netdev/net-next/c/0ad57c99e857
  - [net-next,04/14] net: bridge: multicast: calculate idx position without changing ptr
    https://git.kernel.org/netdev/net-next/c/e7cfcf2c18c5
  - [net-next,05/14] net: bridge: multicast: add EHT structures and definitions
    https://git.kernel.org/netdev/net-next/c/8f07b831197e
  - [net-next,06/14] net: bridge: multicast: add EHT host handling functions
    https://git.kernel.org/netdev/net-next/c/5b1632887930
  - [net-next,07/14] net: bridge: multicast: add EHT source set handling functions
    https://git.kernel.org/netdev/net-next/c/baa74d39ca39
  - [net-next,08/14] net: bridge: multicast: add EHT host delete function
    https://git.kernel.org/netdev/net-next/c/dba6b0a5ca21
  - [net-next,09/14] net: bridge: multicast: add EHT allow/block handling
    https://git.kernel.org/netdev/net-next/c/474ddb37fa3a
  - [net-next,10/14] net: bridge: multicast: add EHT include and exclude handling
    https://git.kernel.org/netdev/net-next/c/ddc255d993d8
  - [net-next,11/14] net: bridge: multicast: optimize TO_INCLUDE EHT timeouts
    https://git.kernel.org/netdev/net-next/c/b66bf55bbc1c
  - [net-next,12/14] net: bridge: multicast: add EHT host filter_mode handling
    https://git.kernel.org/netdev/net-next/c/c9739016a032
  - [net-next,13/14] net: bridge: multicast: handle block pg delete for all cases
    https://git.kernel.org/netdev/net-next/c/e87e4b5caa5d
  - [net-next,14/14] net: bridge: multicast: mark IGMPv3/MLDv2 fast-leave deletes
    https://git.kernel.org/netdev/net-next/c/d5a1022283c3

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


