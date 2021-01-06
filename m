Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Oyqqq/X9qdu3xx65zVGG4PWH/PNLT4F1km7kqg9CwhU=;
 b=gzddoHJOCVay1ZtwAg6gpZYehIhSRqUIQSdK4JUH+wPjfbt4c780257hgbJRUZZ0ZC
 i9KHrBmIsFtgQvFjDsTf2XoSa4rJGVoyx/WKywr3FvG1ot0/gXU9nB+lWK6l+aFqxR0R
 LvcGmC+ZWUIbjKMYyuMmV6a7Ur40nOQSw/CVGIrtgjg778xGuFveUJfmadVczelFyf0W
 M/0XtJ4D4x2wgj7yI+dTV5HRtqEtO410+bkvou21VP4UP767x4tRzG2mSrouCS+UN7Ic
 7yhz8MtN27k2KQwgU83zQiyXSq13jEdR2prrmCrKgp+BkOJML+CaYOOFNa/sWxQJ5igr
 0HvA==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed,  6 Jan 2021 11:51:31 +0200
Message-Id: <20210106095136.224739-3-olteanv@gmail.com>
In-Reply-To: <20210106095136.224739-1-olteanv@gmail.com>
References: <20210106095136.224739-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 net-next 2/7] net: dsa: be louder when a
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The dev_close() call was added in commit c9eb3e0f8701 ("net: dsa: Add
support for learning FDB through notification") "to indicate inconsistent
situation" when we could not delete an FDB entry from the port.

bridge fdb del d8:58:d7:00:ca:6d dev swp0 self master

It is a bit drastic and at the same time not helpful if the above fails
to only print with netdev_dbg log level, but on the other hand to bring
the interface down.

So increase the verbosity of the error message, and drop dev_close().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v4:
None.

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

