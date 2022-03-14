Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=EhqGuJqqtp9wtuhSiVXt/o5grLaHVr4b0QqzceZCUO8=;
 b=RJa3/5K5cCDl6EjFcQwfzqk/UcKzuV733YpHO1tIlGr8G8TfvlqiLBaFw5o8IGW6Gc
 cqjOSwteauUJ5Hkth30AhD7p3H0YTs1M/kkCVVVoT2t1S0FUwVxa80JVNjNENM6dmrlq
 QIe6ZiQ1MnjuDlJ9+sjvF3I/KIV0yarwG2f0OFT3St2q7QMAX+vJE2CZuh8remUW8zT9
 sjZCJuwa65WRGm4AL6RvOiBKuKPDsgWE38hao2IROUxuHkD1v2PA7aHF/uQDwMrimK6i
 kM+/knTp4IbzmlAwqwy53A9aW/b6Ph+Sd484UGqQJ/Abn08QumzCTKznDrNi2VzWv7x9
 pc1A==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Mon, 14 Mar 2022 10:52:31 +0100
Message-Id: <20220314095231.3486931-15-tobias@waldekranz.com>
In-Reply-To: <20220314095231.3486931-1-tobias@waldekranz.com>
References: <20220314095231.3486931-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v3 net-next 14/14] net: dsa: mv88e6xxx: MST
	Offloading
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

Allocate a SID in the STU for each MSTID in use by a bridge and handle
the mapping of MSTIDs to VLANs using the SID field of each VTU entry.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 251 ++++++++++++++++++++++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h |  13 ++
 2 files changed, 257 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c14a62aa6a6c..c23dbf37aeec 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1667,24 +1667,32 @@ static int mv88e6xxx_pvt_setup(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
-static void mv88e6xxx_port_fast_age(struct dsa_switch *ds, int port)
+static void mv88e6xxx_port_fast_age_fid(struct mv88e6xxx_chip *chip, int port,
+					u16 fid)
 {
-	struct mv88e6xxx_chip *chip = ds->priv;
 	int err;
 
-	if (dsa_to_port(ds, port)->lag)
+	if (dsa_to_port(chip->ds, port)->lag)
 		/* Hardware is incapable of fast-aging a LAG through a
 		 * regular ATU move operation. Until we have something
 		 * more fancy in place this is a no-op.
 		 */
 		return;
 
-	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_g1_atu_remove(chip, 0, port, false);
-	mv88e6xxx_reg_unlock(chip);
+	err = mv88e6xxx_g1_atu_remove(chip, fid, port, false);
 
 	if (err)
-		dev_err(ds->dev, "p%d: failed to flush ATU\n", port);
+		dev_err(chip->ds->dev, "p%d: failed to flush ATU (FID %u)\n",
+			port, fid);
+}
+
+static void mv88e6xxx_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+
+	mv88e6xxx_reg_lock(chip);
+	mv88e6xxx_port_fast_age_fid(chip, port, 0);
+	mv88e6xxx_reg_unlock(chip);
 }
 
 static int mv88e6xxx_vtu_setup(struct mv88e6xxx_chip *chip)
@@ -1818,6 +1826,159 @@ static int mv88e6xxx_stu_setup(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_stu_loadpurge(chip, &stu);
 }
 
+static int mv88e6xxx_sid_get(struct mv88e6xxx_chip *chip, u8 *sid)
+{
+	DECLARE_BITMAP(busy, MV88E6XXX_N_SID) = { 0 };
+	struct mv88e6xxx_mst *mst;
+
+	set_bit(0, busy);
+
+	list_for_each_entry(mst, &chip->msts, node) {
+		set_bit(mst->stu.sid, busy);
+	}
+
+	*sid = find_first_zero_bit(busy, MV88E6XXX_N_SID);
+
+	return (*sid >= mv88e6xxx_max_sid(chip)) ? -ENOSPC : 0;
+}
+
+static int mv88e6xxx_mst_put(struct mv88e6xxx_chip *chip, u8 sid)
+{
+	struct mv88e6xxx_mst *mst, *tmp;
+	int err;
+
+	if (!sid)
+		return 0;
+
+	list_for_each_entry_safe(mst, tmp, &chip->msts, node) {
+		if (mst->stu.sid != sid)
+			continue;
+
+		if (!refcount_dec_and_test(&mst->refcnt))
+			return 0;
+
+		mst->stu.valid = false;
+		err = mv88e6xxx_stu_loadpurge(chip, &mst->stu);
+		if (err)
+			return err;
+
+		list_del(&mst->node);
+		kfree(mst);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static int mv88e6xxx_mst_get(struct mv88e6xxx_chip *chip, struct net_device *br,
+			     u16 msti, u8 *sid)
+{
+	struct mv88e6xxx_mst *mst;
+	int err, i;
+
+	if (!mv88e6xxx_has_stu(chip)) {
+		err = -EOPNOTSUPP;
+		goto err;
+	}
+
+	if (!msti) {
+		*sid = 0;
+		return 0;
+	}
+
+	list_for_each_entry(mst, &chip->msts, node) {
+		if (mst->br == br && mst->msti == msti) {
+			refcount_inc(&mst->refcnt);
+			*sid = mst->stu.sid;
+			return 0;
+		}
+	}
+
+	err = mv88e6xxx_sid_get(chip, sid);
+	if (err)
+		goto err;
+
+	mst = kzalloc(sizeof(*mst), GFP_KERNEL);
+	if (!mst) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	INIT_LIST_HEAD(&mst->node);
+	refcount_set(&mst->refcnt, 1);
+	mst->br = br;
+	mst->msti = msti;
+	mst->stu.valid = true;
+	mst->stu.sid = *sid;
+
+	/* The bridge starts out all ports in the disabled state. But
+	 * a STU state of disabled means to go by the port-global
+	 * state. So we set all user port's initial state to blocking,
+	 * to match the bridge's behavior.
+	 */
+	for (i = 0; i < mv88e6xxx_num_ports(chip); i++)
+		mst->stu.state[i] = dsa_is_user_port(chip->ds, i) ?
+			MV88E6XXX_PORT_CTL0_STATE_BLOCKING :
+			MV88E6XXX_PORT_CTL0_STATE_DISABLED;
+
+	err = mv88e6xxx_stu_loadpurge(chip, &mst->stu);
+	if (err)
+		goto err_free;
+
+	list_add_tail(&mst->node, &chip->msts);
+	return 0;
+
+err_free:
+	kfree(mst);
+err:
+	return err;
+}
+
+static int mv88e6xxx_port_mst_state_set(struct dsa_switch *ds, int port,
+					const struct switchdev_mst_state *st)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_mst *mst;
+	u8 state;
+	int err;
+
+	if (!mv88e6xxx_has_stu(chip))
+		return -EOPNOTSUPP;
+
+	switch (st->state) {
+	case BR_STATE_DISABLED:
+	case BR_STATE_BLOCKING:
+	case BR_STATE_LISTENING:
+		state = MV88E6XXX_PORT_CTL0_STATE_BLOCKING;
+		break;
+	case BR_STATE_LEARNING:
+		state = MV88E6XXX_PORT_CTL0_STATE_LEARNING;
+		break;
+	case BR_STATE_FORWARDING:
+		state = MV88E6XXX_PORT_CTL0_STATE_FORWARDING;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	list_for_each_entry(mst, &chip->msts, node) {
+		if (mst->br == dsa_port_bridge_dev_get(dp) &&
+		    mst->msti == st->msti) {
+			if (mst->stu.state[port] == state)
+				return 0;
+
+			mst->stu.state[port] = state;
+			mv88e6xxx_reg_lock(chip);
+			err = mv88e6xxx_stu_loadpurge(chip, &mst->stu);
+			mv88e6xxx_reg_unlock(chip);
+			return err;
+		}
+	}
+
+	return -ENOENT;
+}
+
 static int mv88e6xxx_port_check_hw_vlan(struct dsa_switch *ds, int port,
 					u16 vid)
 {
@@ -2437,6 +2598,12 @@ static int mv88e6xxx_port_vlan_leave(struct mv88e6xxx_chip *chip,
 	if (err)
 		return err;
 
+	if (!vlan.valid && vlan.sid) {
+		err = mv88e6xxx_mst_put(chip, vlan.sid);
+		if (err)
+			return err;
+	}
+
 	return mv88e6xxx_g1_atu_remove(chip, vlan.fid, port, false);
 }
 
@@ -2482,6 +2649,72 @@ static int mv88e6xxx_port_vlan_del(struct dsa_switch *ds, int port,
 	return err;
 }
 
+static void mv88e6xxx_port_vlan_fast_age(struct dsa_switch *ds, int port, u16 vid)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_vtu_entry vlan;
+	int err;
+
+	mv88e6xxx_reg_lock(chip);
+
+	err = mv88e6xxx_vtu_get(chip, vid, &vlan);
+	if (err)
+		goto unlock;
+
+	mv88e6xxx_port_fast_age_fid(chip, port, vlan.fid);
+
+unlock:
+	mv88e6xxx_reg_unlock(chip);
+
+	if (err)
+		dev_err(ds->dev, "p%d: failed to flush ATU in VID %u\n",
+			port, vid);
+}
+
+static int mv88e6xxx_vlan_msti_set(struct dsa_switch *ds,
+				   struct dsa_bridge bridge,
+				   const struct switchdev_vlan_msti *msti)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_vtu_entry vlan;
+	u8 old_sid, new_sid;
+	int err;
+
+	mv88e6xxx_reg_lock(chip);
+
+	err = mv88e6xxx_vtu_get(chip, msti->vid, &vlan);
+	if (err)
+		goto unlock;
+
+	if (!vlan.valid) {
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	old_sid = vlan.sid;
+
+	err = mv88e6xxx_mst_get(chip, bridge.dev, msti->msti, &new_sid);
+	if (err)
+		goto unlock;
+
+	if (new_sid != old_sid) {
+		vlan.sid = new_sid;
+
+		err = mv88e6xxx_vtu_loadpurge(chip, &vlan);
+		if (err) {
+			mv88e6xxx_mst_put(chip, new_sid);
+			goto unlock;
+		}
+	}
+
+	if (old_sid)
+		err = mv88e6xxx_mst_put(chip, old_sid);
+
+unlock:
+	mv88e6xxx_reg_unlock(chip);
+	return err;
+}
+
 static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
 				  const unsigned char *addr, u16 vid,
 				  struct dsa_db db)
@@ -6008,6 +6241,7 @@ static struct mv88e6xxx_chip *mv88e6xxx_alloc_chip(struct device *dev)
 	mutex_init(&chip->reg_lock);
 	INIT_LIST_HEAD(&chip->mdios);
 	idr_init(&chip->policies);
+	INIT_LIST_HEAD(&chip->msts);
 
 	return chip;
 }
@@ -6540,10 +6774,13 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.port_pre_bridge_flags	= mv88e6xxx_port_pre_bridge_flags,
 	.port_bridge_flags	= mv88e6xxx_port_bridge_flags,
 	.port_stp_state_set	= mv88e6xxx_port_stp_state_set,
+	.port_mst_state_set	= mv88e6xxx_port_mst_state_set,
 	.port_fast_age		= mv88e6xxx_port_fast_age,
+	.port_vlan_fast_age	= mv88e6xxx_port_vlan_fast_age,
 	.port_vlan_filtering	= mv88e6xxx_port_vlan_filtering,
 	.port_vlan_add		= mv88e6xxx_port_vlan_add,
 	.port_vlan_del		= mv88e6xxx_port_vlan_del,
+	.vlan_msti_set		= mv88e6xxx_vlan_msti_set,
 	.port_fdb_add           = mv88e6xxx_port_fdb_add,
 	.port_fdb_del           = mv88e6xxx_port_fdb_del,
 	.port_fdb_dump          = mv88e6xxx_port_fdb_dump,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 6d4daa24d3e5..6a0b66354e1d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -297,6 +297,16 @@ struct mv88e6xxx_region_priv {
 	enum mv88e6xxx_region_id id;
 };
 
+struct mv88e6xxx_mst {
+	struct list_head node;
+
+	refcount_t refcnt;
+	struct net_device *br;
+	u16 msti;
+
+	struct mv88e6xxx_stu_entry stu;
+};
+
 struct mv88e6xxx_chip {
 	const struct mv88e6xxx_info *info;
 
@@ -397,6 +407,9 @@ struct mv88e6xxx_chip {
 
 	/* devlink regions */
 	struct devlink_region *regions[_MV88E6XXX_REGION_MAX];
+
+	/* Bridge MST to SID mappings */
+	struct list_head msts;
 };
 
 struct mv88e6xxx_bus_ops {
-- 
2.25.1

