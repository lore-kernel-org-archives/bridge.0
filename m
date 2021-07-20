Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Y7C6JE
 GT0y2KLvuEwR+z81yYhgYip/+jR2ruzBG6+28=; b=g7o+wqGRbCUg1AX7xvQyNz
 sI+51AF00UcGODm7HpXn5pa14Zl9BwgG9IaCAI6labY44Jmil0jR5XZgFh8g6Afw
 M48ikwQV78Cuh3Aj+uB0YG82TuWwYZHOPacajczhXi19KDyAZyukuiF7iLcG/uuE
 csYrNG/IkbXehROVzZeAiJvjBRQmsl4C48MlzXPRk1jNme7+IAtgJ6S2pkUb4qDx
 Sy2HVhakAgomhJY/4ZZ1z2Yq2s6G+bVbyrR2GFTh6QHmCTw+kp6fO3xBByx9PVM/
 JGjvb8+ntBtnnPhtKTwSe2lu1uvSUthu+1A9ectDi35WNpnc0ykCpXXbsKUnEGsQ
 ==
Date: Tue, 20 Jul 2021 14:24:29 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YPaybQZE8l6mRE2l@shredder>
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH v4 net-next 00/15] Allow forwarding for the
 software bridge data path to be offloaded to capable devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Marek Behun <kabel@blackhole.sk>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Steen Hegelund <Steen.Hegelund@microchip.com>, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Lars Povlsen <lars.povlsen@microchip.com>, netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Jul 19, 2021 at 12:44:19AM +0300, Vladimir Oltean wrote:
>  drivers/net/dsa/mv88e6xxx/chip.c              |  78 +++-
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
>  include/linux/if_bridge.h                     |  63 ++--
>  include/net/dsa.h                             |  21 ++
>  net/bridge/br_fdb.c                           |   1 -
>  net/bridge/br_forward.c                       |   9 +
>  net/bridge/br_if.c                            |  11 +-
>  net/bridge/br_mdb.c                           |   1 -
>  net/bridge/br_private.h                       |  84 ++++-
>  net/bridge/br_switchdev.c                     | 287 +++++++++++++--
>  net/bridge/br_vlan.c                          |  11 +-
>  net/dsa/dsa2.c                                |   4 +
>  net/dsa/dsa_priv.h                            |   6 +
>  net/dsa/port.c                                | 192 +++++++---
>  net/dsa/tag_dsa.c                             |  52 ++-
>  32 files changed, 1406 insertions(+), 348 deletions(-)

Too many things are squashed into this one patchset. It needs to be
split. According to the title, the patchset is focused on improving
performance, but there are no performance numbers that I could see and
most of the patches deal with the replay stuff instead.

The TX forwarding offload in mv88e6xxx is not related to the replay
stuff and should be added in a separate patchset. This can be done by
first adding the switchdev_bridge_port_offload() /
switchdev_bridge_port_unoffload() APIs that only take care of setting /
unsetting the hardware domain for the bridge port. Then, in a different
patchset, these APIs can be augmented with a parameter for the replay
stuff. It should be easier to review that way and require less
unnecessary surgeries in drivers that do not require the added
functionality.

Thanks
