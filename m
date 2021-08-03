Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSEdaH4cuHRWJsWtf+PMBbdHlrGh/IhGMYCeF1k9rUo=;
 b=O29udEaQ2dYjB398BcmZv8pLYqiCGhczvvDT+9/Yc5VsKApDbmuhNRjXk1IR31YkdwAlbSmJEmFzOwMxKEGgXIsQyIT++/jXgM+r3F1gtmzmLoUzVbzzpz/C8u8mheOvpXd90z63rnm7zlZEnnn/9eNEnImC1x/XloPQ49HLh3k=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue,  3 Aug 2021 23:34:09 +0300
Message-Id: <20210803203409.1274807-3-vladimir.oltean@nxp.com>
In-Reply-To: <20210803203409.1274807-1-vladimir.oltean@nxp.com>
References: <20210803203409.1274807-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v2 net-next 2/2] Revert "net: build all switchdev
	drivers as modules when the bridge is a module"
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

This reverts commit b0e81817629a496854ff1799f6cbd89597db65fd. Explicit
driver dependency on the bridge is no longer needed since
switchdev_bridge_port_{,un}offload() is no longer implemented by the
bridge driver but by switchdev.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
v1->v2: none

 drivers/net/ethernet/microchip/sparx5/Kconfig | 1 -
 drivers/net/ethernet/ti/Kconfig               | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/Kconfig b/drivers/net/ethernet/microchip/sparx5/Kconfig
index d39ae2a6fb49..7bdbb2d09a14 100644
--- a/drivers/net/ethernet/microchip/sparx5/Kconfig
+++ b/drivers/net/ethernet/microchip/sparx5/Kconfig
@@ -1,6 +1,5 @@
 config SPARX5_SWITCH
 	tristate "Sparx5 switch driver"
-	depends on BRIDGE || BRIDGE=n
 	depends on NET_SWITCHDEV
 	depends on HAS_IOMEM
 	depends on OF
diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 7ac8e5ecbe97..affcf92cd3aa 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -64,7 +64,6 @@ config TI_CPSW
 config TI_CPSW_SWITCHDEV
 	tristate "TI CPSW Switch Support with switchdev"
 	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
-	depends on BRIDGE || BRIDGE=n
 	depends on NET_SWITCHDEV
 	depends on TI_CPTS || !TI_CPTS
 	select PAGE_POOL
@@ -110,7 +109,6 @@ config TI_K3_AM65_CPSW_NUSS
 config TI_K3_AM65_CPSW_SWITCHDEV
 	bool "TI K3 AM654x/J721E CPSW Switch mode support"
 	depends on TI_K3_AM65_CPSW_NUSS
-	depends on BRIDGE || BRIDGE=n
 	depends on NET_SWITCHDEV
 	help
 	 This enables switchdev support for TI K3 CPSWxG Ethernet
-- 
2.25.1

