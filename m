Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CIInQFhUIvGc9Fp/wsZr+6F94nSrzs2toRlY80F5hE=;
 b=TdNpMqCvPK1mP8/hSBj/kPSIzETcm+P3+iwpr06VKgRq9pdGOWOIJWlsUK3mMlh6L3ixf+MViej326MEMy87gt8KB/SuDWIhiH8s+0ODxqtawEvrvkYZAKCjHVu9JswgmbOrti56AsdpKq829yZi3wRB/M77nlQ83UkR1klZC1Q=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue,  3 Aug 2021 17:36:22 +0300
Message-Id: <20210803143624.1135002-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 0/2] Convert switchdev_bridge_port_{,
	un}offload to notifiers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Arnd Bergmann <arnd@kernel.org>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>

The introduction of the explicit switchdev bridge port offloading API
has introduced dependency regressions between switchdev drivers and the
bridge, with some drivers where switchdev support was optional before
being now compiled as a module when the bridge is a module, or worse.

This patch makes the switchdev bridge port offload/unoffload events
visible on the blocking notifier call chain, so that the bridge can
indirectly do something when those events happen, without the driver
explicitly calling a symbol exported by the bridge driver.

Vladimir Oltean (2):
  net: make switchdev_bridge_port_{,unoffload} loosely coupled with the
    bridge
  Revert "net: build all switchdev drivers as modules when the bridge is
    a module"

 drivers/net/ethernet/microchip/sparx5/Kconfig |  1 -
 drivers/net/ethernet/ti/Kconfig               |  2 -
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  2 +-
 drivers/net/ethernet/ti/cpsw_new.c            |  2 +-
 include/linux/if_bridge.h                     | 35 -------------
 include/net/switchdev.h                       | 46 +++++++++++++++++
 net/bridge/br.c                               | 51 ++++++++++++++++++-
 net/bridge/br_private.h                       | 30 +++++++++++
 net/bridge/br_switchdev.c                     | 36 ++++---------
 net/switchdev/switchdev.c                     | 48 +++++++++++++++++
 10 files changed, 185 insertions(+), 68 deletions(-)

-- 
2.25.1

