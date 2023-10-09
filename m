Return-Path: <amcohen@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E96A82043
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 117EE82010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFy74T5CAUfq3WEbbbWoXFN/ggpbuL7yyPD344US7mY=;
 b=NXTap1T1L7CxVwKxnYm8FCvrW1WHdCVH1AlfsgKtq6JybJH+3FSWYMhNuAElMgBwRM1AihvlnQW+sRcJ+S7CC9U6ZqBOZhw0+B0yinItuqnoUgY3d5RTUEXKFzPVoWbIzqhWxoZ0L1mUIfsOZCOP3hyWzQBHMdiLdoPI/JqPwuQk3xn3MC+K9RV9DsJRuV+mwBKz9gPgLLyWqCMWOszcn9Aq0rpyYYbGRgCHbNu3BXAQpEeUWncKGSA00eKwhgm2pFPe4WWD9aTTf7HGNkvel0ptL96bMMDAw8CgELzm/JkVh3yhXHRHGbWD6oAJiwz/H1oYhntS+RFi4HBLcxEeYQ==
From: Amit Cohen <amcohen@nvidia.com>
Date: Mon, 9 Oct 2023 13:06:10 +0300
Message-ID: <20231009100618.2911374-4-amcohen@nvidia.com>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
References: <20231009100618.2911374-1-amcohen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 03/11] vxlan: vxlan_core: Do not skip
	default entry in vxlan_flush() by default
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, razor@blackwall.org, Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com, dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@nvidia.com, linux-kselftest@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, davem@davemloft.net

Currently, the function vxlan_flush() does not flush the default FDB entry
(an entry with all_zeros_mac and default VNI), as it is deleted at
vxlan_uninit(). When this function will be used for flushing FDB entries
from user space, it will have to flush also the default entry in case that
other parameters match (e.g., VNI, flags).

Extend 'struct vxlan_fdb_flush_desc' to include an indication whether
the default entry should be flushed or not. The default value (false)
indicates to flush it, adjust all the existing callers to set
'.ignore_default_entry' to true, so the current behavior will not be
changed.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1c58fddb7df4..958960fdc011 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3023,16 +3023,27 @@ static int vxlan_open(struct net_device *dev)
 }
 
 struct vxlan_fdb_flush_desc {
+	bool				ignore_default_entry;
 	unsigned long                   state;
 	unsigned long			state_mask;
 };
 
+static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
+				       const struct vxlan_dev *vxlan)
+{
+	return is_zero_ether_addr(f->eth_addr) && f->vni == vxlan->cfg.vni;
+}
+
 static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
+				    const struct vxlan_dev *vxlan,
 				    const struct vxlan_fdb_flush_desc *desc)
 {
 	if (desc->state_mask && (f->state & desc->state_mask) != desc->state)
 		return false;
 
+	if (desc->ignore_default_entry && vxlan_fdb_is_default_entry(f, vxlan))
+		return false;
+
 	return true;
 }
 
@@ -3050,13 +3061,9 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 			struct vxlan_fdb *f
 				= container_of(p, struct vxlan_fdb, hlist);
 
-			if (!vxlan_fdb_flush_matches(f, desc))
+			if (!vxlan_fdb_flush_matches(f, vxlan, desc))
 				continue;
 
-			/* the all_zeros_mac entry is deleted at vxlan_uninit */
-			if (is_zero_ether_addr(f->eth_addr) &&
-			    f->vni == vxlan->cfg.vni)
-				continue;
 			vxlan_fdb_destroy(vxlan, f, true, true);
 		}
 		spin_unlock_bh(&vxlan->hash_lock[h]);
@@ -3068,6 +3075,8 @@ static int vxlan_stop(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_fdb_flush_desc desc = {
+		/* Default entry is deleted at vxlan_uninit. */
+		.ignore_default_entry = true,
 		.state = 0,
 		.state_mask = NUD_PERMANENT | NUD_NOARP,
 	};
@@ -4315,7 +4324,10 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 static void vxlan_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_fdb_flush_desc desc = {};
+	struct vxlan_fdb_flush_desc desc = {
+		/* Default entry is deleted at vxlan_uninit. */
+		.ignore_default_entry = true,
+	};
 
 	vxlan_flush(vxlan, &desc);
 
-- 
2.40.1

