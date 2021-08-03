Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81X+Bx2MsAfsLoRpNc+d5R3mCTnQmp7qpPlhgsGQIuE=;
 b=RPsqP5maDKwVuKe9vUJxJhQ3KpubehyC2BJcX2WzNHcE7rC7EyBir/7B8fuszGjiR8qJEcOOPRJavPmrTre6cf2XlwVjdF6wuxgYxizxVun6Jfm908cG8UPEDlvHe0oXbairsnkttJ3WHLGdRM93kXXybDG7Pj4f2JFkFAi7saU=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue,  3 Aug 2021 23:34:07 +0300
Message-Id: <20210803203409.1274807-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v2 net-next 0/2] Convert switchdev_bridge_port_{,
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

v1->v2: removed a bogus return value from a void function

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
 net/bridge/br_private.h                       | 29 +++++++++++
 net/bridge/br_switchdev.c                     | 36 ++++---------
 net/switchdev/switchdev.c                     | 48 +++++++++++++++++
 10 files changed, 184 insertions(+), 68 deletions(-)

-- 
2.25.1

