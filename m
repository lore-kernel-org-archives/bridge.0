Return-Path: <jiri@resnulli.us>
From: Jiri Pirko <jiri@resnulli.us>
Date: Wed,  2 Jan 2013 13:28:29 +0100
Message-Id: <1357129716-2450-9-git-send-email-jiri@resnulli.us>
In-Reply-To: <1357129716-2450-1-git-send-email-jiri@resnulli.us>
References: <1357129716-2450-1-git-send-email-jiri@resnulli.us>
Subject: [Bridge] [patch net-next V5 08/15] cxgb3: remove usage of
	dev->master
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
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c
index 942dace..3f1f501 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c
@@ -182,14 +182,17 @@ static struct net_device *get_iff_from_mac(struct adapter *adapter,
 		struct net_device *dev = adapter->port[i];
 
 		if (!memcmp(dev->dev_addr, mac, ETH_ALEN)) {
+			rcu_read_lock();
 			if (vlan && vlan != VLAN_VID_MASK) {
-				rcu_read_lock();
 				dev = __vlan_find_dev_deep(dev, vlan);
-				rcu_read_unlock();
 			} else if (netif_is_bond_slave(dev)) {
-				while (dev->master)
-					dev = dev->master;
+				struct net_device *upper_dev;
+
+				while ((upper_dev =
+					netdev_master_upper_dev_get_rcu(dev)))
+					dev = upper_dev;
 			}
+			rcu_read_unlock();
 			return dev;
 		}
 	}
-- 
1.8.0

