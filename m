Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Fbfjll
 +276W8sItskCenThre81QQRVpyey7VS1hHpAU=; b=m+FsyOY6f3VZxMb3tKxRgU
 F0V7B6iG40I9jDsoa9OooiCqLEiAUJ8kWfBsDcVuatejLzhEdl5BX+D++RCHm5Ux
 4h7aTvHBfqb55SMhG7p00RrNNjUkWNt4/e04BhSttGPW7VptDX/VNZ3fFvCKW3HZ
 QyXNv0UoGz9qRHvY6zCmGLBxH6he4V0Qoql81I4fMb9gOsEDtL0KaXnPaCgTVSEE
 B47gId/lOODTaOTtCRTMlr+ZRgMYy/UXW6woknGj5hZhW7F7TxPMH2wdg/RIBOn+
 FuG5WTOiI9vkPagtJ1nrh+x02MaLb1WUd/P8Hq9Or8dmXWG/LDpywFhOiVOeZdcA
 ==
Date: Tue, 20 Jul 2021 17:01:48 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YPbXTKj4teQZ1QRi@shredder>
References: <20210720134655.892334-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720134655.892334-1-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH v5 net-next 00/10] Let switchdev drivers
 offload and unoffload bridge ports at their own convenience
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vivien Didelot <vivien.didelot@gmail.com>, DENG Qingfang <dqfext@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Marek Behun <kabel@blackhole.sk>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Tue, Jul 20, 2021 at 04:46:45PM +0300, Vladimir Oltean wrote:
> The explicit switchdev offloading API will see further extensions in the
> future.
> 
> The patches were split from a larger series for easier review:
> https://patchwork.kernel.org/project/netdevbpf/cover/20210718214434.3938850-1-vladimir.oltean@nxp.com/

This is not what I meant. I specifically suggested to get the TX
forwarding offload first and then extending the API with an argument to
opt-in for the replay / cleanup:

https://lore.kernel.org/netdev/YPbU20%2Fcjkz04s8b@shredder/

> 
> Tobias Waldekranz (2):
>   net: bridge: disambiguate offload_fwd_mark
>   net: bridge: switchdev: recycle unused hwdoms
> 
> Vladimir Oltean (8):
>   net: dpaa2-switch: use extack in dpaa2_switch_port_bridge_join
>   net: dpaa2-switch: refactor prechangeupper sanity checks
>   mlxsw: spectrum: refactor prechangeupper sanity checks
>   mlxsw: spectrum: refactor leaving an 8021q upper that is a bridge port
>   net: marvell: prestera: refactor prechangeupper sanity checks
>   net: switchdev: guard drivers against multiple obj replays on same
>     bridge port
>   net: bridge: switchdev: let drivers inform which bridge ports are
>     offloaded
>   net: bridge: switchdev object replay helpers for everybody
> 
>  .../ethernet/freescale/dpaa2/dpaa2-switch.c   |  69 +++-
>  .../ethernet/marvell/prestera/prestera_main.c |  99 +++--
>  .../marvell/prestera/prestera_switchdev.c     |  42 ++-
>  .../marvell/prestera/prestera_switchdev.h     |   7 +-
>  .../net/ethernet/mellanox/mlxsw/spectrum.c    | 347 ++++++++++++------
>  .../net/ethernet/mellanox/mlxsw/spectrum.h    |   4 +
>  .../mellanox/mlxsw/spectrum_switchdev.c       |  28 +-
>  .../microchip/sparx5/sparx5_switchdev.c       |  48 ++-
>  drivers/net/ethernet/mscc/ocelot_net.c        | 115 ++++--
>  drivers/net/ethernet/rocker/rocker.h          |   9 +-
>  drivers/net/ethernet/rocker/rocker_main.c     |  34 +-
>  drivers/net/ethernet/rocker/rocker_ofdpa.c    |  42 ++-
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  34 +-
>  drivers/net/ethernet/ti/am65-cpsw-switchdev.c |  14 +-
>  drivers/net/ethernet/ti/am65-cpsw-switchdev.h |   3 +
>  drivers/net/ethernet/ti/cpsw_new.c            |  32 +-
>  drivers/net/ethernet/ti/cpsw_switchdev.c      |   4 +-
>  drivers/net/ethernet/ti/cpsw_switchdev.h      |   3 +
>  include/linux/if_bridge.h                     |  60 +--
>  net/bridge/br_fdb.c                           |   1 -
>  net/bridge/br_if.c                            |  11 +-
>  net/bridge/br_mdb.c                           |   1 -
>  net/bridge/br_private.h                       |  61 ++-
>  net/bridge/br_switchdev.c                     | 254 +++++++++++--
>  net/bridge/br_vlan.c                          |   1 -
>  net/dsa/port.c                                |  83 ++---
>  26 files changed, 1059 insertions(+), 347 deletions(-)
> 
> -- 
> 2.25.1
> 
