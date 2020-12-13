Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp5VKzBanPZiLMF4KMu2uBH38U+PHeRxncpXAVmPHw4=;
 b=dpFZ7L17oVirKNnds8so1Fhkhjzu2yHQceR7WOUWYpZyF8CbXSSWK5v8g/vDpDFvnz09MU1qrpBwj4T+TisCzwsszzCdgiiT/GXyZQE/4WY+SusvlJGWxIpMohhjx3VdjEwSpRwqrQiuWyckLX93ft9uWzD9onAgIbRn6V1d0M4=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sun, 13 Dec 2020 16:07:05 +0200
Message-Id: <20201213140710.1198050-3-vladimir.oltean@nxp.com>
In-Reply-To: <20201213140710.1198050-1-vladimir.oltean@nxp.com>
References: <20201213140710.1198050-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v3 net-next 2/7] net: dsa: be louder when a
	non-legacy FDB operation fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>
Cc: Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Marek Behun <marek.behun@nic.cz>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, UNGLinuxDriver@microchip.com, Tobias Waldekranz <tobias@waldekranz.com>

The dev_close() call was added in commit c9eb3e0f8701 ("net: dsa: Add
support for learning FDB through notification") "to indicate inconsistent
situation" when we could not delete an FDB entry from the port.

bridge fdb del d8:58:d7:00:ca:6d dev swp0 self master

It is a bit drastic and at the same time not helpful if the above fails
to only print with netdev_dbg log level, but on the other hand to bring
the interface down.

So increase the verbosity of the error message, and drop dev_close().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v3:
Patch is new.

 net/dsa/slave.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 4a0498bf6c65..d5d389300124 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2072,7 +2072,9 @@ static void dsa_slave_switchdev_event_work(struct work_struct *work)
 
 		err = dsa_port_fdb_add(dp, fdb_info->addr, fdb_info->vid);
 		if (err) {
-			netdev_dbg(dev, "fdb add failed err=%d\n", err);
+			netdev_err(dev,
+				   "failed to add %pM vid %d to fdb: %d\n",
+				   fdb_info->addr, fdb_info->vid, err);
 			break;
 		}
 		fdb_info->offloaded = true;
@@ -2087,9 +2089,11 @@ static void dsa_slave_switchdev_event_work(struct work_struct *work)
 
 		err = dsa_port_fdb_del(dp, fdb_info->addr, fdb_info->vid);
 		if (err) {
-			netdev_dbg(dev, "fdb del failed err=%d\n", err);
-			dev_close(dev);
+			netdev_err(dev,
+				   "failed to delete %pM vid %d from fdb: %d\n",
+				   fdb_info->addr, fdb_info->vid, err);
 		}
+
 		break;
 	}
 	rtnl_unlock();
-- 
2.25.1

