Date: Mon, 13 Apr 2009 10:46:15 +0200
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20090413084614.GE23734@psychotron.englab.brq.redhat.com>
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090413083729.GA23734@psychotron.englab.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090413083729.GA23734@psychotron.englab.brq.redhat.com>
Subject: [Bridge] [PATCH 4/4] net: bonding: add slave device addresses in
	mode alb
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: ivecera@redhat.com, fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, mschmidt@redhat.com, bonding-devel@lists.sourceforge.net, jgarzik@pobox.com, dada1@cosmosbay.com, davem@davemloft.net

When in mode alb, add all device addresses which belong to an enslaved slave
device to the bond device. This ensures that all mac addresses will be
treated as local and bonding in this mode will work fine in bridge.

Signed-off-by: Jiri Pirko <jpirko@redhat.com>
---
 drivers/net/bonding/bond_main.c |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 99610f3..47795c7 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1385,6 +1385,11 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
 	bond->setup_by_slave = 1;
 }
 
+static inline int should_copy_dev_addrs(struct bonding *bond)
+{
+	return bond->params.mode == BOND_MODE_ALB ? 1 : 0;
+}
+
 /* enslave device <slave> to bond device <master> */
 int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev)
 {
@@ -1510,6 +1515,13 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev)
 	 */
 	new_slave->original_flags = slave_dev->flags;
 
+	if (should_copy_dev_addrs(bond)) {
+		res = dev_addr_add_multiple(bond_dev, slave_dev);
+		if (res)
+			goto err_free;
+		dev_mac_address_changed(bond_dev);
+	}
+
 	/*
 	 * Save slave's original ("permanent") mac address for modes
 	 * that need it, and for restoring it upon release, and then
@@ -1527,7 +1539,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev)
 		res = dev_set_mac_address(slave_dev, &addr);
 		if (res) {
 			pr_debug("Error %d calling set_mac_address\n", res);
-			goto err_free;
+			goto err_remove_dev_addrs;
 		}
 	}
 
@@ -1769,6 +1781,12 @@ err_restore_mac:
 		dev_set_mac_address(slave_dev, &addr);
 	}
 
+err_remove_dev_addrs:
+	if (should_copy_dev_addrs(bond)) {
+		dev_addr_del_multiple(bond_dev, slave_dev);
+		dev_mac_address_changed(bond_dev);
+	}
+
 err_free:
 	kfree(new_slave);
 
@@ -1954,6 +1972,11 @@ int bond_release(struct net_device *bond_dev, struct net_device *slave_dev)
 	/* close slave before restoring its mac address */
 	dev_close(slave_dev);
 
+	if (should_copy_dev_addrs(bond)) {
+		dev_addr_del_multiple(bond_dev, slave_dev);
+		dev_mac_address_changed(bond_dev);
+	}
+
 	if (bond->params.fail_over_mac != BOND_FOM_ACTIVE) {
 		/* restore original ("permanent") mac address */
 		memcpy(addr.sa_data, slave->perm_hwaddr, ETH_ALEN);
@@ -2090,6 +2113,9 @@ static int bond_release_all(struct net_device *bond_dev)
 		/* close slave before restoring its mac address */
 		dev_close(slave_dev);
 
+		if (should_copy_dev_addrs(bond))
+			dev_addr_del_multiple(bond_dev, slave_dev);
+
 		if (!bond->params.fail_over_mac) {
 			/* restore original ("permanent") mac address*/
 			memcpy(addr.sa_data, slave->perm_hwaddr, ETH_ALEN);
@@ -2106,6 +2132,8 @@ static int bond_release_all(struct net_device *bond_dev)
 		write_lock_bh(&bond->lock);
 	}
 
+	dev_mac_address_changed(bond_dev);
+
 	/* zero the mac address of the master so it will be
 	 * set by the application to the mac address of the
 	 * first slave
-- 
1.6.0.6

