Return-Path: <jiri@resnulli.us>
From: Jiri Pirko <jiri@resnulli.us>
Date: Wed,  2 Jan 2013 13:28:33 +0100
Message-Id: <1357129716-2450-13-git-send-email-jiri@resnulli.us>
In-Reply-To: <1357129716-2450-1-git-send-email-jiri@resnulli.us>
References: <1357129716-2450-1-git-send-email-jiri@resnulli.us>
Subject: [Bridge] [patch net-next V5 12/15] nes: remove usage of dev->master
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, fbl@redhat.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, sony.chacko@qlogic.com, blaschka@linux.vnet.ibm.com, gregory.v.rose@intel.com, bhutchings@solarflare.com, xiyou.wangcong@gmail.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, linux-driver@qlogic.com, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

Signed-off-by: Jiri Pirko <jiri@resnulli.us>
---
 drivers/infiniband/hw/nes/nes.c    | 8 +++++---
 drivers/infiniband/hw/nes/nes_cm.c | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/nes/nes.c b/drivers/infiniband/hw/nes/nes.c
index 748db2d..d129c36 100644
--- a/drivers/infiniband/hw/nes/nes.c
+++ b/drivers/infiniband/hw/nes/nes.c
@@ -135,6 +135,7 @@ static int nes_inetaddr_event(struct notifier_block *notifier,
 	struct net_device *event_netdev = ifa->ifa_dev->dev;
 	struct nes_device *nesdev;
 	struct net_device *netdev;
+	struct net_device *upper_dev;
 	struct nes_vnic *nesvnic;
 	unsigned int is_bonded;
 
@@ -145,8 +146,9 @@ static int nes_inetaddr_event(struct notifier_block *notifier,
 				nesdev, nesdev->netdev[0]->name);
 		netdev = nesdev->netdev[0];
 		nesvnic = netdev_priv(netdev);
+		upper_dev = netdev_master_upper_dev_get(netdev);
 		is_bonded = netif_is_bond_slave(netdev) &&
-			    (netdev->master == event_netdev);
+			    (upper_dev == event_netdev);
 		if ((netdev == event_netdev) || is_bonded) {
 			if (nesvnic->rdma_enabled == 0) {
 				nes_debug(NES_DBG_NETDEV, "Returning without processing event for %s since"
@@ -179,9 +181,9 @@ static int nes_inetaddr_event(struct notifier_block *notifier,
 					/* fall through */
 				case NETDEV_CHANGEADDR:
 					/* Add the address to the IP table */
-					if (netdev->master)
+					if (upper_dev)
 						nesvnic->local_ipaddr =
-							((struct in_device *)netdev->master->ip_ptr)->ifa_list->ifa_address;
+							((struct in_device *)upper_dev->ip_ptr)->ifa_list->ifa_address;
 					else
 						nesvnic->local_ipaddr = ifa->ifa_address;
 
diff --git a/drivers/infiniband/hw/nes/nes_cm.c b/drivers/infiniband/hw/nes/nes_cm.c
index 22ea67e..24b9f1a 100644
--- a/drivers/infiniband/hw/nes/nes_cm.c
+++ b/drivers/infiniband/hw/nes/nes_cm.c
@@ -1340,7 +1340,7 @@ static int nes_addr_resolve_neigh(struct nes_vnic *nesvnic, u32 dst_ip, int arpi
 	}
 
 	if (netif_is_bond_slave(nesvnic->netdev))
-		netdev = nesvnic->netdev->master;
+		netdev = netdev_master_upper_dev_get(nesvnic->netdev);
 	else
 		netdev = nesvnic->netdev;
 
-- 
1.8.0

