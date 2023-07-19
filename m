Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC89841548
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92156400BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1gyKFFp7ks8gh/utde57OTWL5Is0cFKvp/lBS9d6TI=;
 b=LVtXCGx0uUj3huOlJ+U56/rROPGYkqUZ99jPeQvfJP9B4c6tT3cyU3o79xqnV22KNETIJDqAuBtr93U2jLN5Tmiu5BhIPyqxad1S8dz74uHzQkWj6XJ+JyzDIsIgwR/0VuHPSSTphISkrn5N4nYrZ7aovozeEsopghVb8zPFyxA7kaz7rscNmTv8P8f2CwNOlvYtE+EUKfkAUt42VIdFu7TF5S50fh4E0spyarNaeB4DB2LXCMEsKOYYqyXmHktp3jfRAx1F23/GmFikdtHVn5pCNLWctMAXY6zCf3+qjreKLsZDSqAotgTvelXwYVDgGHtymKuXzMA62qVysHbQUw==
From: Petr Machata <petrm@nvidia.com>
Date: Wed, 19 Jul 2023 13:01:17 +0200
Message-ID: <3145c726aa2290b82841a51590554e97f3c099b6.1689763088.git.petrm@nvidia.com>
In-Reply-To: <cover.1689763088.git.petrm@nvidia.com>
References: <cover.1689763088.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 02/17] net: switchdev: Add a helper to
	replay objects on a bridge port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, Danielle Ratson <danieller@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, mlxsw@nvidia.com

When a front panel joins a bridge via another netdevice (typically a LAG),
the driver needs to learn about the objects configured on the bridge port.
When the bridge port is offloaded by the driver for the first time, this
can be achieved by passing a notifier to switchdev_bridge_port_offload().
The notifier is then invoked for the individual objects (such as VLANs)
configured on the bridge, and can look for the interesting ones.

Calling switchdev_bridge_port_offload() when the second port joins the
bridge lower is unnecessary, but the replay is still needed. To that end,
add a new function, switchdev_bridge_port_replay(), which does only the
replay part of the _offload() function in exactly the same way as that
function.

Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Ivan Vecera <ivecera@redhat.com>
Cc: Roopa Prabhu <roopa@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bridge@lists.linux-foundation.org
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 include/net/switchdev.h   |  6 ++++++
 net/bridge/br.c           |  8 ++++++++
 net/bridge/br_private.h   | 16 ++++++++++++++++
 net/bridge/br_switchdev.c |  9 +++++++++
 net/switchdev/switchdev.c | 25 +++++++++++++++++++++++++
 5 files changed, 64 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index ca0312b78294..4d324e2a2eef 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -231,6 +231,7 @@ enum switchdev_notifier_type {
 
 	SWITCHDEV_BRPORT_OFFLOADED,
 	SWITCHDEV_BRPORT_UNOFFLOADED,
+	SWITCHDEV_BRPORT_REPLAY,
 };
 
 struct switchdev_notifier_info {
@@ -299,6 +300,11 @@ void switchdev_bridge_port_unoffload(struct net_device *brport_dev,
 				     const void *ctx,
 				     struct notifier_block *atomic_nb,
 				     struct notifier_block *blocking_nb);
+int switchdev_bridge_port_replay(struct net_device *brport_dev,
+				 struct net_device *dev, const void *ctx,
+				 struct notifier_block *atomic_nb,
+				 struct notifier_block *blocking_nb,
+				 struct netlink_ext_ack *extack);
 
 void switchdev_deferred_process(void);
 int switchdev_port_attr_set(struct net_device *dev,
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 4f5098d33a46..a6e94ceb7c9a 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -234,6 +234,14 @@ static int br_switchdev_blocking_event(struct notifier_block *nb,
 		br_switchdev_port_unoffload(p, b->ctx, b->atomic_nb,
 					    b->blocking_nb);
 		break;
+	case SWITCHDEV_BRPORT_REPLAY:
+		brport_info = ptr;
+		b = &brport_info->brport;
+
+		err = br_switchdev_port_replay(p, b->dev, b->ctx, b->atomic_nb,
+					       b->blocking_nb, extack);
+		err = notifier_from_errno(err);
+		break;
 	}
 
 out:
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a63b32c1638e..a69774131535 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2115,6 +2115,12 @@ void br_switchdev_port_unoffload(struct net_bridge_port *p, const void *ctx,
 				 struct notifier_block *atomic_nb,
 				 struct notifier_block *blocking_nb);
 
+int br_switchdev_port_replay(struct net_bridge_port *p,
+			     struct net_device *dev, const void *ctx,
+			     struct notifier_block *atomic_nb,
+			     struct notifier_block *blocking_nb,
+			     struct netlink_ext_ack *extack);
+
 bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb);
 
 void br_switchdev_frame_set_offload_fwd_mark(struct sk_buff *skb);
@@ -2165,6 +2171,16 @@ br_switchdev_port_unoffload(struct net_bridge_port *p, const void *ctx,
 {
 }
 
+static inline int
+br_switchdev_port_replay(struct net_bridge_port *p,
+			 struct net_device *dev, const void *ctx,
+			 struct notifier_block *atomic_nb,
+			 struct notifier_block *blocking_nb,
+			 struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb)
 {
 	return false;
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index e92e0338afee..ee84e783e1df 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -829,3 +829,12 @@ void br_switchdev_port_unoffload(struct net_bridge_port *p, const void *ctx,
 
 	nbp_switchdev_del(p);
 }
+
+int br_switchdev_port_replay(struct net_bridge_port *p,
+			     struct net_device *dev, const void *ctx,
+			     struct notifier_block *atomic_nb,
+			     struct notifier_block *blocking_nb,
+			     struct netlink_ext_ack *extack)
+{
+	return nbp_switchdev_sync_objs(p, ctx, atomic_nb, blocking_nb, extack);
+}
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 8cc42aea19c7..5b045284849e 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -862,3 +862,28 @@ void switchdev_bridge_port_unoffload(struct net_device *brport_dev,
 					  NULL);
 }
 EXPORT_SYMBOL_GPL(switchdev_bridge_port_unoffload);
+
+int switchdev_bridge_port_replay(struct net_device *brport_dev,
+				 struct net_device *dev, const void *ctx,
+				 struct notifier_block *atomic_nb,
+				 struct notifier_block *blocking_nb,
+				 struct netlink_ext_ack *extack)
+{
+	struct switchdev_notifier_brport_info brport_info = {
+		.brport = {
+			.dev = dev,
+			.ctx = ctx,
+			.atomic_nb = atomic_nb,
+			.blocking_nb = blocking_nb,
+		},
+	};
+	int err;
+
+	ASSERT_RTNL();
+
+	err = call_switchdev_blocking_notifiers(SWITCHDEV_BRPORT_REPLAY,
+						brport_dev, &brport_info.info,
+						extack);
+	return notifier_to_errno(err);
+}
+EXPORT_SYMBOL_GPL(switchdev_bridge_port_replay);
-- 
2.40.1

