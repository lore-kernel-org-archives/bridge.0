Return-Path: <Joseph.Huang@garmin.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pps1;
 bh=Dn1EcMNWZGsvJjV6KjhfFTdFjIc9V485NuIEyRCC98A=;
 b=0MYctD2v+C2H/CpmoxP+07w18h1DMWdSVCugHLRnkvI+WHhSRkJIDXX3aUhU9k0UaPoU
 RFaFpDOOMU612onaB54po7CgDjQ0t3oXcxryokwLkDPAe8Y/XG59rTXC4ndo97X3VAnC
 a7uBAcr4nXL0CEb6o+r5J3W86PYW0rZZeB3KHgcUBxnbivawMkqCW5YW9WcNR+KzDEhh
 dZXq+SiYGDemAMwSjcGFXL2dGpwydBgx6sYEkHiFKUJrDjD+jTW3Ls/3h++YSq1w3ac/
 HMnnHSHrvrvYcaz6lTAJiDqw4CZx8DXBWjoDTG6QKXHCMWuOMg4Kjw91N/YMYEtWKpvC 5A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn1EcMNWZGsvJjV6KjhfFTdFjIc9V485NuIEyRCC98A=;
 b=DnnkYM6WWDQ+Pcw+fOYu4ui1ru/5ctsUwnwJ4+QHgY8ZLIktY/xBK09PWBk1mhRQ2a8GZ4jr0wYznu9X472/ovTDx2n3gljqRQeaIqFS0K4kmQizcb/Y6kApyzGCnaGmJoVe/PmHqMhwXN+un4fz+0fOuBqUc20Gzby8y+1NVCHfJQg5nhJ1VH2eFef4TwWCpRpxs1f8sYz8+GucAOnwjLPtiIgZDhrjduA595GLvA7OeZXQptRWBLi3IWwqfVFF0HQ34rXkocEn0/Bfspx5EBOo6O2rVo73c49uia3Jt5ubFfNLj7mxbFde11YOt3yU05J3fQEvXe/RgnG4dfJnuQ==
From: Joseph Huang <Joseph.Huang@garmin.com>
Date: Tue, 4 May 2021 14:22:54 -0400
Message-ID: <20210504182259.5042-2-Joseph.Huang@garmin.com>
In-Reply-To: <20210504182259.5042-1-Joseph.Huang@garmin.com>
References: <20210504182259.5042-1-Joseph.Huang@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH 1/6] bridge: Refactor br_mdb_notify
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joseph Huang <Joseph.Huang@garmin.com>

Separate out switchdev notification to its own function in preparation
for the patch "bridge: Offload mrouter port forwarding to switchdev".

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 net/bridge/br_mdb.c     | 57 ++++++++++++++++++++++++-----------------
 net/bridge/br_private.h |  2 ++
 2 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 95fa4af0e8dd..e8684d798ec3 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -669,10 +669,9 @@ static void br_mdb_switchdev_host(struct net_device *dev,
 		br_mdb_switchdev_host_port(dev, lower_dev, mp, type);
 }
 
-void br_mdb_notify(struct net_device *dev,
-		   struct net_bridge_mdb_entry *mp,
-		   struct net_bridge_port_group *pg,
-		   int type)
+void br_mdb_switchdev_port(struct net_bridge_mdb_entry *mp,
+			   struct net_bridge_port *p,
+			   int type)
 {
 	struct br_mdb_complete_info *complete_info;
 	struct switchdev_obj_port_mdb mdb = {
@@ -681,30 +680,42 @@ void br_mdb_notify(struct net_device *dev,
 			.flags = SWITCHDEV_F_DEFER,
 		},
 	};
+
+	if (!p)
+		return;
+
+	br_switchdev_mdb_populate(&mdb, mp);
+
+	mdb.obj.orig_dev = p->dev;
+	switch (type) {
+	case RTM_NEWMDB:
+		complete_info = kmalloc(sizeof(*complete_info), GFP_ATOMIC);
+		if (!complete_info)
+			break;
+		complete_info->port = p;
+		complete_info->ip = mp->addr;
+		mdb.obj.complete_priv = complete_info;
+		mdb.obj.complete = br_mdb_complete;
+		if (switchdev_port_obj_add(p->dev, &mdb.obj, NULL))
+			kfree(complete_info);
+		break;
+	case RTM_DELMDB:
+		switchdev_port_obj_del(p->dev, &mdb.obj);
+		break;
+	}
+}
+
+void br_mdb_notify(struct net_device *dev,
+		   struct net_bridge_mdb_entry *mp,
+		   struct net_bridge_port_group *pg,
+		   int type)
+{
 	struct net *net = dev_net(dev);
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
 	if (pg) {
-		br_switchdev_mdb_populate(&mdb, mp);
-
-		mdb.obj.orig_dev = pg->key.port->dev;
-		switch (type) {
-		case RTM_NEWMDB:
-			complete_info = kmalloc(sizeof(*complete_info), GFP_ATOMIC);
-			if (!complete_info)
-				break;
-			complete_info->port = pg->key.port;
-			complete_info->ip = mp->addr;
-			mdb.obj.complete_priv = complete_info;
-			mdb.obj.complete = br_mdb_complete;
-			if (switchdev_port_obj_add(pg->key.port->dev, &mdb.obj, NULL))
-				kfree(complete_info);
-			break;
-		case RTM_DELMDB:
-			switchdev_port_obj_del(pg->key.port->dev, &mdb.obj);
-			break;
-		}
+		br_mdb_switchdev_port(mp, pg->key.port, type);
 	} else {
 		br_mdb_switchdev_host(dev, mp, type);
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 7ce8a77cc6b6..5cba9d228b9c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -829,6 +829,8 @@ br_multicast_new_port_group(struct net_bridge_port *port, struct br_ip *group,
 			    u8 filter_mode, u8 rt_protocol);
 int br_mdb_hash_init(struct net_bridge *br);
 void br_mdb_hash_fini(struct net_bridge *br);
+void br_mdb_switchdev_port(struct net_bridge_mdb_entry *mp,
+			   struct net_bridge_port *p, int type);
 void br_mdb_notify(struct net_device *dev, struct net_bridge_mdb_entry *mp,
 		   struct net_bridge_port_group *pg, int type);
 void br_rtr_notify(struct net_device *dev, struct net_bridge_port *port,
-- 
2.17.1

