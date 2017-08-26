Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 26 Aug 2017 22:56:09 +0200
Message-Id: <1503780970-10312-5-git-send-email-andrew@lunn.ch>
In-Reply-To: <1503780970-10312-1-git-send-email-andrew@lunn.ch>
References: <1503780970-10312-1-git-send-email-andrew@lunn.ch>
Subject: [Bridge] [PATCH RFC WIP 4/5] net: dsa: HACK: Handle MDB add/remove
	for none-switch ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev <netdev@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jiri@mellanox.com

When there is a mdb added to a port which is not in the switch, we
need the switch to forward traffic for the group to the software
bridge, so it can forward it out the none-switch port.

The current implementation is a hack and will be replaced. Currently
only the bridge soft interface is supported. When there is a
join/leave on the soft interface, switchdev calls are made on the soft
interface device, brX. This does not have a switchdev ops structure
registered, so all lower interfaces of brX get there switchdev
function called. These are switch ports, and do have switchdev ops. By
comparing the original interface to the called interface, we can
determine this is not for a switch port, and add/remove the mdb to the
CPU port.
---
 net/dsa/port.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index d6e07176df3f..d8e4bfefd97d 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -194,8 +194,15 @@ int dsa_port_mdb_add(struct dsa_port *dp,
 		.mdb = mdb,
 	};
 
-	pr_info("dsa_port_mdb_add: %d %d", info.sw_index, info.port);
-
+	if (dp->netdev != mdb->obj.orig_dev) {
+		/* Not a port for this switch, so forward
+		 * multicast out the CPU port to the bridge.
+		 */
+		struct dsa_switch_tree *dst = dp->ds->dst;
+		struct dsa_port *cpu_dp = dsa_get_cpu_port(dst);
+		info.port = cpu_dp->index;
+		return dsa_port_notify(cpu_dp, DSA_NOTIFIER_MDB_ADD, &info);
+	}
 	return dsa_port_notify(dp, DSA_NOTIFIER_MDB_ADD, &info);
 }
 
@@ -208,6 +215,14 @@ int dsa_port_mdb_del(struct dsa_port *dp,
 		.mdb = mdb,
 	};
 
+	if (dp->netdev != mdb->obj.orig_dev) {
+		struct dsa_switch_tree *dst = dp->ds->dst;
+		struct dsa_port *cpu_dp = dsa_get_cpu_port(dst);
+
+		info.port = cpu_dp->index;
+		return dsa_port_notify(cpu_dp, DSA_NOTIFIER_MDB_DEL, &info);
+	}
+
 	return dsa_port_notify(dp, DSA_NOTIFIER_MDB_DEL, &info);
 }
 
-- 
2.14.1

