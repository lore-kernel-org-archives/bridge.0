Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D44240154
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 49342401B2
From: "Hans J. Schultz" <netdev@kapio-technology.com>
Date: Tue, 17 Jan 2023 19:57:14 +0100
Message-Id: <20230117185714.3058453-6-netdev@kapio-technology.com>
In-Reply-To: <20230117185714.3058453-1-netdev@kapio-technology.com>
References: <20230117185714.3058453-1-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC PATCH net-next 5/5] net: dsa: mv88e6xxx:
	implementation of dynamic ATU entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "Hans J. Schultz" <netdev@kapio-technology.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>

For 802.1X or MAB security authed hosts we want to have these hosts authed
by adding dynamic FDB entries, so that if an authed host goes silent for
a time period it's FDB entry will be removed and it must reauth when
wanting to communicate again.
In the mv88e6xxx offloaded case, we can use the HoldAt1 feature, that
gives an age out interrupt when the FDB entry is about to age out, so
that userspace can be notified of the entry being deleted with the help
of an SWITCHDEV_FDB_DEL_TO_BRIDGE event.
When adding a dynamic entry the bridge must be informed that the driver
takes care of the ageing be sending an SWITCHDEV_FDB_OFFLOADED event,
telling the bridge that this added FDB entry will be handled by the
driver.
With this implementation, trace events for age out interrupts are also
added.

note: A special case arises with the age out interrupt, as the entry
state/spid (source port id) value read from the registers will be zero.
Thus we need to extract the source port from the port vector instead.

Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c        | 18 ++++++--
 drivers/net/dsa/mv88e6xxx/global1_atu.c | 21 +++++++++
 drivers/net/dsa/mv88e6xxx/port.c        |  6 ++-
 drivers/net/dsa/mv88e6xxx/switchdev.c   | 61 +++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/switchdev.h   |  5 ++
 drivers/net/dsa/mv88e6xxx/trace.h       |  5 ++
 6 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index a9c84b92a10e..e5d64622a629 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -42,6 +42,7 @@
 #include "ptp.h"
 #include "serdes.h"
 #include "smi.h"
+#include "switchdev.h"
 
 static void assert_reg_lock(struct mv88e6xxx_chip *chip)
 {
@@ -2726,18 +2727,25 @@ static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
 				  const unsigned char *addr, u16 vid,
 				  u16 fdb_flags, struct dsa_db db)
 {
+	bool is_dynamic = !!(fdb_flags & DSA_FDB_FLAG_DYNAMIC);
 	struct mv88e6xxx_chip *chip = ds->priv;
+	u8 state;
 	int err;
 
-	/* Ignore entries with flags set */
-	if (fdb_flags)
-		return 0;
+	state = MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC;
+	if (is_dynamic)
+		state = MV88E6XXX_G1_ATU_DATA_STATE_UC_AGE_7_NEWEST;
+	else
+		if (fdb_flags)
+			return 0;
 
 	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
-					   MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);
+	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid, state);
 	mv88e6xxx_reg_unlock(chip);
 
+	if (is_dynamic && !err)
+		mv88e6xxx_set_fdb_offloaded(ds, port, addr, vid);
+
 	return err;
 }
 
diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index ce3b3690c3c0..c95f8cffba41 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -432,6 +432,27 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
 
 	spid = entry.state;
 
+	if (val & MV88E6XXX_G1_ATU_OP_AGE_OUT_VIOLATION) {
+		unsigned long port = 0;
+		unsigned long portvec = entry.portvec;
+
+		port = find_first_bit(&portvec, MV88E6XXX_MAX_PVT_PORTS);
+		if (port >= MV88E6XXX_MAX_PVT_PORTS) {
+			dev_err(chip->dev,
+				"ATU err: mac: %pM. Port not in portvec: %x\n",
+				entry.mac, entry.portvec);
+			goto out;
+		}
+
+		spid = port;
+		trace_mv88e6xxx_atu_age_out_violation(chip->dev, spid,
+						      entry.portvec, entry.mac,
+						      fid);
+
+		err = mv88e6xxx_handle_age_out_violation(chip, spid,
+							 &entry, fid);
+	}
+
 	if (val & MV88E6XXX_G1_ATU_OP_MEMBER_VIOLATION) {
 		trace_mv88e6xxx_atu_member_violation(chip->dev, spid,
 						     entry.portvec, entry.mac,
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index f79cf716c541..5225971b9a33 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1255,7 +1255,11 @@ int mv88e6xxx_port_set_lock(struct mv88e6xxx_chip *chip, int port,
 
 	reg &= ~MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT;
 	if (locked)
-		reg |= MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT;
+		reg |= MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT |
+			MV88E6XXX_PORT_ASSOC_VECTOR_REFRESH_LOCKED |
+			MV88E6XXX_PORT_ASSOC_VECTOR_IGNORE_WRONG |
+			MV88E6XXX_PORT_ASSOC_VECTOR_INT_AGE_OUT |
+			MV88E6XXX_PORT_ASSOC_VECTOR_HOLD_AT_1;
 
 	return mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_ASSOC_VECTOR, reg);
 }
diff --git a/drivers/net/dsa/mv88e6xxx/switchdev.c b/drivers/net/dsa/mv88e6xxx/switchdev.c
index 4c346a884fb2..76f7f8cc1835 100644
--- a/drivers/net/dsa/mv88e6xxx/switchdev.c
+++ b/drivers/net/dsa/mv88e6xxx/switchdev.c
@@ -12,6 +12,25 @@
 #include "global1.h"
 #include "switchdev.h"
 
+void mv88e6xxx_set_fdb_offloaded(struct dsa_switch *ds, int port,
+				 const unsigned char *addr, u16 vid)
+{
+	struct switchdev_notifier_fdb_info info = {
+		.addr = addr,
+		.vid = vid,
+		.offloaded = true,
+	};
+	struct net_device *brport;
+	struct dsa_port *dp;
+
+	dp = dsa_to_port(ds, port);
+	brport = dsa_port_to_bridge_port(dp);
+
+	if (brport)
+		call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
+					 brport, &info.info, NULL);
+}
+
 struct mv88e6xxx_fid_search_ctx {
 	u16 fid_search;
 	u16 vid_found;
@@ -81,3 +100,45 @@ int mv88e6xxx_handle_miss_violation(struct mv88e6xxx_chip *chip, int port,
 
 	return err;
 }
+
+int mv88e6xxx_handle_age_out_violation(struct mv88e6xxx_chip *chip, int port,
+				       struct mv88e6xxx_atu_entry *entry,
+				       u16 fid)
+{
+	struct switchdev_notifier_fdb_info info = {
+		.addr = entry->mac,
+	};
+	struct net_device *brport;
+	struct dsa_port *dp;
+	u16 vid;
+	int err;
+
+	err = mv88e6xxx_find_vid(chip, fid, &vid);
+	if (err)
+		return err;
+
+	info.vid = vid;
+	entry->portvec &= ~BIT(port);
+	entry->state = MV88E6XXX_G1_ATU_DATA_STATE_UC_UNUSED;
+	entry->trunk = false;
+
+	mv88e6xxx_reg_lock(chip);
+	err = mv88e6xxx_g1_atu_loadpurge(chip, fid, entry);
+	mv88e6xxx_reg_unlock(chip);
+	if (err)
+		return err;
+
+	dp = dsa_to_port(chip->ds, port);
+
+	rtnl_lock();
+	brport = dsa_port_to_bridge_port(dp);
+	if (!brport) {
+		rtnl_unlock();
+		return -ENODEV;
+	}
+	err = call_switchdev_notifiers(SWITCHDEV_FDB_DEL_TO_BRIDGE,
+				       brport, &info.info, NULL);
+	rtnl_unlock();
+
+	return err;
+}
diff --git a/drivers/net/dsa/mv88e6xxx/switchdev.h b/drivers/net/dsa/mv88e6xxx/switchdev.h
index 62214f9d62b0..5af6ac6a490a 100644
--- a/drivers/net/dsa/mv88e6xxx/switchdev.h
+++ b/drivers/net/dsa/mv88e6xxx/switchdev.h
@@ -12,8 +12,13 @@
 
 #include "chip.h"
 
+void mv88e6xxx_set_fdb_offloaded(struct dsa_switch *ds, int port,
+				 const unsigned char *addr, u16 vid);
 int mv88e6xxx_handle_miss_violation(struct mv88e6xxx_chip *chip, int port,
 				    struct mv88e6xxx_atu_entry *entry,
 				    u16 fid);
+int mv88e6xxx_handle_age_out_violation(struct mv88e6xxx_chip *chip, int port,
+				       struct mv88e6xxx_atu_entry *entry,
+				       u16 fid);
 
 #endif /* _MV88E6XXX_SWITCHDEV_H_ */
diff --git a/drivers/net/dsa/mv88e6xxx/trace.h b/drivers/net/dsa/mv88e6xxx/trace.h
index f59ca04768e7..c6b32abf68a5 100644
--- a/drivers/net/dsa/mv88e6xxx/trace.h
+++ b/drivers/net/dsa/mv88e6xxx/trace.h
@@ -40,6 +40,11 @@ DECLARE_EVENT_CLASS(mv88e6xxx_atu_violation,
 		  __entry->addr, __entry->fid)
 );
 
+DEFINE_EVENT(mv88e6xxx_atu_violation, mv88e6xxx_atu_age_out_violation,
+	     TP_PROTO(const struct device *dev, int spid, u16 portvec,
+		      const unsigned char *addr, u16 fid),
+	     TP_ARGS(dev, spid, portvec, addr, fid));
+
 DEFINE_EVENT(mv88e6xxx_atu_violation, mv88e6xxx_atu_member_violation,
 	     TP_PROTO(const struct device *dev, int spid, u16 portvec,
 		      const unsigned char *addr, u16 fid),
-- 
2.34.1

