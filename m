Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=9aG6JPCK/sc9cnjNg+7v1niwfwPA6zUyJ/dRYHoXrdI=;
 b=GNtYHMmflkakwZq6i29RsDao3BrZgSdMt7dT6HQzznhCZixxEG4L5+AACLMCgtmOw+
 BI9wm+/9nQOAtYxgsHh3DTWOQJ5lwf97Rv0atJp/dPjzFGbAs8yAbL/aQkJOONiwRgnh
 6LyCkyyQ11vk8AHBIL9pavnlsyGIU6b9h7oq+TjxKi65VNRfv+dHMiZ3d+uQ4ftFomEM
 hSGRuaZ3xnyUh5Hikuh0aUFit7zHWcH3XwzY1lcNN8sKT53oRFjpOPrsskfoyTB/Mv1E
 4YmEhpNXHdHnaKmoJ51SuNhAxucOm8hoC9sl2zopI+sN1eRjGUDQC2V3byXyg9cHoLxo
 +Ozw==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Wed, 16 Feb 2022 14:29:33 +0100
Message-Id: <20220216132934.1775649-9-tobias@waldekranz.com>
In-Reply-To: <20220216132934.1775649-1-tobias@waldekranz.com>
References: <20220216132934.1775649-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 8/9] net: dsa: mv88e6xxx: Export STU as
	devlink region
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

Export the raw STU data in a devlink region so that it can be
inspected from userspace and compared to the current bridge
configuration.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.h    |  1 +
 drivers/net/dsa/mv88e6xxx/devlink.c | 94 +++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index be654be69982..6d4daa24d3e5 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -287,6 +287,7 @@ enum mv88e6xxx_region_id {
 	MV88E6XXX_REGION_GLOBAL2,
 	MV88E6XXX_REGION_ATU,
 	MV88E6XXX_REGION_VTU,
+	MV88E6XXX_REGION_STU,
 	MV88E6XXX_REGION_PVT,
 
 	_MV88E6XXX_REGION_MAX,
diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6xxx/devlink.c
index 381068395c63..1266eabee086 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -503,6 +503,85 @@ static int mv88e6xxx_region_vtu_snapshot(struct devlink *dl,
 	return 0;
 }
 
+/**
+ * struct mv88e6xxx_devlink_stu_entry - Devlink STU entry
+ * @sid:   Global1/3:   SID, unknown filters and learning.
+ * @vid:   Global1/6:   Valid bit.
+ * @data:  Global1/7-9: Membership data and priority override.
+ * @resvd: Reserved. In case we forgot something.
+ *
+ * The STU entry format varies between chipset generations. Peridot
+ * and Amethyst packs the STU data into Global1/7-8. Older silicon
+ * spreads the information across all three VTU data registers -
+ * inheriting the layout of even older hardware that had no STU at
+ * all. Since this is a low-level debug interface, copy all data
+ * verbatim and defer parsing to the consumer.
+ */
+struct mv88e6xxx_devlink_stu_entry {
+	u16 sid;
+	u16 vid;
+	u16 data[3];
+	u16 resvd;
+};
+
+static int mv88e6xxx_region_stu_snapshot(struct devlink *dl,
+					 const struct devlink_region_ops *ops,
+					 struct netlink_ext_ack *extack,
+					 u8 **data)
+{
+	struct mv88e6xxx_devlink_stu_entry *table, *entry;
+	struct dsa_switch *ds = dsa_devlink_to_ds(dl);
+	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_stu_entry stu;
+	int err;
+
+	table = kcalloc(mv88e6xxx_max_sid(chip) + 1,
+			sizeof(struct mv88e6xxx_devlink_stu_entry),
+			GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+
+	entry = table;
+	stu.sid = mv88e6xxx_max_sid(chip);
+	stu.valid = false;
+
+	mv88e6xxx_reg_lock(chip);
+
+	do {
+		err = mv88e6xxx_g1_stu_getnext(chip, &stu);
+		if (err)
+			break;
+
+		if (!stu.valid)
+			break;
+
+		err = err ? : mv88e6xxx_g1_read(chip, MV88E6352_G1_VTU_SID,
+						&entry->sid);
+		err = err ? : mv88e6xxx_g1_read(chip, MV88E6XXX_G1_VTU_VID,
+						&entry->vid);
+		err = err ? : mv88e6xxx_g1_read(chip, MV88E6XXX_G1_VTU_DATA1,
+						&entry->data[0]);
+		err = err ? : mv88e6xxx_g1_read(chip, MV88E6XXX_G1_VTU_DATA2,
+						&entry->data[1]);
+		err = err ? : mv88e6xxx_g1_read(chip, MV88E6XXX_G1_VTU_DATA3,
+						&entry->data[2]);
+		if (err)
+			break;
+
+		entry++;
+	} while (stu.sid < mv88e6xxx_max_sid(chip));
+
+	mv88e6xxx_reg_unlock(chip);
+
+	if (err) {
+		kfree(table);
+		return err;
+	}
+
+	*data = (u8 *)table;
+	return 0;
+}
+
 static int mv88e6xxx_region_pvt_snapshot(struct devlink *dl,
 					 const struct devlink_region_ops *ops,
 					 struct netlink_ext_ack *extack,
@@ -605,6 +684,12 @@ static struct devlink_region_ops mv88e6xxx_region_vtu_ops = {
 	.destructor = kfree,
 };
 
+static struct devlink_region_ops mv88e6xxx_region_stu_ops = {
+	.name = "stu",
+	.snapshot = mv88e6xxx_region_stu_snapshot,
+	.destructor = kfree,
+};
+
 static struct devlink_region_ops mv88e6xxx_region_pvt_ops = {
 	.name = "pvt",
 	.snapshot = mv88e6xxx_region_pvt_snapshot,
@@ -640,6 +725,11 @@ static struct mv88e6xxx_region mv88e6xxx_regions[] = {
 		.ops = &mv88e6xxx_region_vtu_ops
 	  /* calculated at runtime */
 	},
+	[MV88E6XXX_REGION_STU] = {
+		.ops = &mv88e6xxx_region_stu_ops,
+		.cond = mv88e6xxx_has_stu,
+	  /* calculated at runtime */
+	},
 	[MV88E6XXX_REGION_PVT] = {
 		.ops = &mv88e6xxx_region_pvt_ops,
 		.size = MV88E6XXX_MAX_PVT_ENTRIES * sizeof(u16),
@@ -706,6 +796,10 @@ int mv88e6xxx_setup_devlink_regions_global(struct dsa_switch *ds)
 			size = (mv88e6xxx_max_vid(chip) + 1) *
 				sizeof(struct mv88e6xxx_devlink_vtu_entry);
 			break;
+		case MV88E6XXX_REGION_STU:
+			size = (mv88e6xxx_max_sid(chip) + 1) *
+				sizeof(struct mv88e6xxx_devlink_stu_entry);
+			break;
 		}
 
 		region = dsa_devlink_region_create(ds, ops, 1, size);
-- 
2.25.1

