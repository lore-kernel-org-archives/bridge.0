Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=k/C9YDjzWUnfDK8QTrJ0AVjX6bfBNUa/peWn5GAK4qI=;
	b=C5aot4yoBJfmE2rrmqYxZwxlpFlTGaBD4KbZlXR9mVT1sIremjl4y6P5vuBzRwyZVnWYDNFXUK7m2fJYPNAOdrcO8DPz0p925GC/EAgRhvaoZ3lK6LZg4WKFwd2Wkr1xqVTtPzmlmDMaJKqJVcM/uGUTNbQpFQAvpVp4fGq/zLY=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1527503302.git.petrm@mellanox.com>
References: <cover.1527503302.git.petrm@mellanox.com>
Message-Id: <639d05f6b03ea0c86996e5a25308106897741871.1527503302.git.petrm@mellanox.com>
Date: Mon, 28 May 2018 12:50:15 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 4/7] dsa: port: Ignore bridge VLAN
	events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net

Ignore VLAN events where the orig_dev is the bridge device itself.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 net/dsa/port.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 2413beb..ed05954 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -252,6 +252,9 @@ int dsa_port_vlan_add(struct dsa_port *dp,
 		.vlan = vlan,
 	};
 
+	if (netif_is_bridge_master(vlan->obj.orig_dev))
+		return -EOPNOTSUPP;
+
 	if (br_vlan_enabled(dp->bridge_dev))
 		return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_ADD, &info);
 
@@ -267,6 +270,9 @@ int dsa_port_vlan_del(struct dsa_port *dp,
 		.vlan = vlan,
 	};
 
+	if (netif_is_bridge_master(vlan->obj.orig_dev))
+		return -EOPNOTSUPP;
+
 	if (br_vlan_enabled(dp->bridge_dev))
 		return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_DEL, &info);
 
-- 
2.4.11

