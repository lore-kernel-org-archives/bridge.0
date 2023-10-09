Return-Path: <amcohen@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E68E782017
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8D3FD8201C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ath0yXoGX+w26Wh+M+ziarUJMEcVX0Kme1m4YZaKbFc=;
 b=gCjyhapyDjpT0yQPWISKKc+wlKbi/a4B9bY8kIGN9R2gTL1Db+7wGEJhHh4SO1xSU7qJybZ0dLrIr5YqVA89FiOZ4+p0UUwgfrj9W5zwDkqZQttHfmFCh/n2ttC2+XNHWtqt3HeBp1KAaByB5FJrKrAuzPwUPVj0fZW+r4OL8MjJ/Idz8BkNH6jIinsDBxS//qZYNDVJe8vnv5cDMNvgYM88E69f7kJilYvJh/U2ATmFoIGfXyuAZZ21Cdo7ZIst7i5SSrMLEf76FwkeoetrW50+weYygoMRirikx4XI9CzLSezT2fLFkzZFAoyJRFon4VKknPmkOqvOPNeiA+UUSg==
From: Amit Cohen <amcohen@nvidia.com>
Date: Mon, 9 Oct 2023 13:06:09 +0300
Message-ID: <20231009100618.2911374-3-amcohen@nvidia.com>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
References: <20231009100618.2911374-1-amcohen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 02/11] vxlan: vxlan_core: Make
	vxlan_flush() more generic for future use
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

The function vxlan_flush() gets a boolean called 'do_all' and in case
that it is false, it does not flush entries with state 'NUD_PERMANENT'
or 'NUD_NOARP'. The following patches will add support for FDB flush
with parameters from user space. Make the function more generic, so it
can be used later.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 5b5597073b00..1c58fddb7df4 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3022,8 +3022,23 @@ static int vxlan_open(struct net_device *dev)
 	return ret;
 }
 
+struct vxlan_fdb_flush_desc {
+	unsigned long                   state;
+	unsigned long			state_mask;
+};
+
+static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
+				    const struct vxlan_fdb_flush_desc *desc)
+{
+	if (desc->state_mask && (f->state & desc->state_mask) != desc->state)
+		return false;
+
+	return true;
+}
+
 /* Purge the forwarding table */
-static void vxlan_flush(struct vxlan_dev *vxlan, bool do_all)
+static void vxlan_flush(struct vxlan_dev *vxlan,
+			const struct vxlan_fdb_flush_desc *desc)
 {
 	unsigned int h;
 
@@ -3034,8 +3049,10 @@ static void vxlan_flush(struct vxlan_dev *vxlan, bool do_all)
 		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
 			struct vxlan_fdb *f
 				= container_of(p, struct vxlan_fdb, hlist);
-			if (!do_all && (f->state & (NUD_PERMANENT | NUD_NOARP)))
+
+			if (!vxlan_fdb_flush_matches(f, desc))
 				continue;
+
 			/* the all_zeros_mac entry is deleted at vxlan_uninit */
 			if (is_zero_ether_addr(f->eth_addr) &&
 			    f->vni == vxlan->cfg.vni)
@@ -3050,12 +3067,16 @@ static void vxlan_flush(struct vxlan_dev *vxlan, bool do_all)
 static int vxlan_stop(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_fdb_flush_desc desc = {
+		.state = 0,
+		.state_mask = NUD_PERMANENT | NUD_NOARP,
+	};
 
 	vxlan_multicast_leave(vxlan);
 
 	del_timer_sync(&vxlan->age_timer);
 
-	vxlan_flush(vxlan, false);
+	vxlan_flush(vxlan, &desc);
 	vxlan_sock_release(vxlan);
 
 	return 0;
@@ -4294,8 +4315,9 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 static void vxlan_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_fdb_flush_desc desc = {};
 
-	vxlan_flush(vxlan, true);
+	vxlan_flush(vxlan, &desc);
 
 	list_del(&vxlan->next);
 	unregister_netdevice_queue(dev, head);
-- 
2.40.1

