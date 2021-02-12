Return-Path: <vigneshr@ti.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1613140301;
 bh=lUakNV+CV5NffMQmGC2Drd4lNwe79cgtFz1V4jCRJcY=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=lbseuewDdWlwxmebUNQ0jeNXKuGvUuIfQVSJjNLEKm1S8j+KqXF7lDUpoaMmbawQt
 rkyu1MpMhaWm3RagWE/UhEIr4fK9IH6SlrSTnPvJylIoigO+WYMygLn6vOTTVByei5
 Lt3+0OIbkUVogWqSTMckQZguGd7RM9DKNpY34SXE=
References: <20210212010531.2722925-1-olteanv@gmail.com>
 <97ae293a-f59d-cc7c-21a6-f83880c69c71@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <ba7350f1-f9ff-b77e-65c9-cd5a4ae652d8@ti.com>
Date: Fri, 12 Feb 2021 20:01:33 +0530
MIME-Version: 1.0
In-Reply-To: <97ae293a-f59d-cc7c-21a6-f83880c69c71@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 0/9] Cleanup in brport flags
 switchdev offload for DSA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Grygorii Strashko <grygorii.strashko@ti.com>, Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

Hi Vladimir,

On 2/12/21 7:47 PM, Grygorii Strashko wrote:
> 
> 
> On 12/02/2021 03:05, Vladimir Oltean wrote:
>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
[...]
> 
> Sorry, but we seems just added more work for you.
> https://lore.kernel.org/patchwork/cover/1379380/
> 

Could you squash these when you post new version:
Sorry for not noticing earlier.

-- >8 --

From 69f3a1ff1ea0777f5deceefdb0e79ce625e6488a Mon Sep 17 00:00:00 2001
From: Vignesh Raghavendra <vigneshr@ti.com>
Date: Fri, 12 Feb 2021 19:34:46 +0530
Subject: [PATCH 1/2] fixup! net: switchdev: propagate extack to port
 attributes

---
 drivers/net/ethernet/ti/am65-cpsw-switchdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
index 1067e7772dbf..314825acf0a0 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
@@ -81,7 +81,8 @@ static int am65_cpsw_port_attr_br_flags_pre_set(struct net_device *netdev,
 }
 
 static int am65_cpsw_port_attr_set(struct net_device *ndev,
-				   const struct switchdev_attr *attr)
+				   const struct switchdev_attr *attr,
+				   struct netlink_ext_ack *extack)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 	int ret;


-- >8 --

From 7d7fdb79a8b255a1e9fe5d205b0ff1824a16ce56 Mon Sep 17 00:00:00 2001
From: Vignesh Raghavendra <vigneshr@ti.com>
Date: Fri, 12 Feb 2021 19:40:48 +0530
Subject: [PATCH 2/2] fixup! net: switchdev: pass flags and mask to both
 {PRE_,}BRIDGE_FLAGS attributes

---
 drivers/net/ethernet/ti/am65-cpsw-switchdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
index 314825acf0a0..03c7a012f5c5 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
@@ -55,12 +55,12 @@ static int am65_cpsw_port_stp_state_set(struct am65_cpsw_port *port, u8 state)
 
 static int am65_cpsw_port_attr_br_flags_set(struct am65_cpsw_port *port,
 					    struct net_device *orig_dev,
-					    unsigned long brport_flags)
+					    struct switchdev_brport_flags flags)
 {
 	struct am65_cpsw_common *cpsw = port->common;
 	bool unreg_mcast_add = false;
 
-	if (brport_flags & BR_MCAST_FLOOD)
+	if (flags.mask & BR_MCAST_FLOOD)
 		unreg_mcast_add = true;
 	netdev_dbg(port->ndev, "BR_MCAST_FLOOD: %d port %u\n",
 		   unreg_mcast_add, port->port_id);
@@ -72,9 +72,9 @@ static int am65_cpsw_port_attr_br_flags_set(struct am65_cpsw_port *port,
 }
 
 static int am65_cpsw_port_attr_br_flags_pre_set(struct net_device *netdev,
-						unsigned long flags)
+						struct switchdev_brport_flags flags)
 {
-	if (flags & ~(BR_LEARNING | BR_MCAST_FLOOD))
+	if (flags.mask & ~(BR_LEARNING | BR_MCAST_FLOOD))
 		return -EINVAL;
 
 	return 0;
-- 
2.30.0


