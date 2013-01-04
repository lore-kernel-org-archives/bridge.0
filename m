Return-Path: <jiri@resnulli.us>
From: Jiri Pirko <jiri@resnulli.us>
Message-Id: <1357289343-817-12-git-send-email-jiri@resnulli.us>
In-Reply-To: <1357289343-817-1-git-send-email-jiri@resnulli.us>
References: <1357289343-817-1-git-send-email-jiri@resnulli.us>
Subject: [Bridge] [patch net-next V6 11/15] vlan: remove usage of
	dev->master in __vlan_find_dev_deep()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 04 Jan 2013 08:49:58 -0000
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, fbl@redhat.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, sony.chacko@qlogic.com, blaschka@linux.vnet.ibm.com, gregory.v.rose@intel.com, bhutchings@solarflare.com, xiyou.wangcong@gmail.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, linux-driver@qlogic.com, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

Also, since all users call __vlan_find_dev_deep() with rcu_read_lock,
make no possibility to call this with rtnl mutex held only.

Signed-off-by: Jiri Pirko <jiri@resnulli.us>
---
 net/8021q/vlan_core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index 65e06ab..380440b 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -60,21 +60,25 @@ bool vlan_do_receive(struct sk_buff **skbp)
 	return true;
 }
 
-/* Must be invoked with rcu_read_lock or with RTNL. */
-struct net_device *__vlan_find_dev_deep(struct net_device *real_dev,
+/* Must be invoked with rcu_read_lock. */
+struct net_device *__vlan_find_dev_deep(struct net_device *dev,
 					u16 vlan_id)
 {
-	struct vlan_info *vlan_info = rcu_dereference_rtnl(real_dev->vlan_info);
+	struct vlan_info *vlan_info = rcu_dereference(dev->vlan_info);
 
 	if (vlan_info) {
 		return vlan_group_get_device(&vlan_info->grp, vlan_id);
 	} else {
 		/*
-		 * Bonding slaves do not have grp assigned to themselves.
-		 * Grp is assigned to bonding master instead.
+		 * Lower devices of master uppers (bonding, team) do not have
+		 * grp assigned to themselves. Grp is assigned to upper device
+		 * instead.
 		 */
-		if (netif_is_bond_slave(real_dev))
-			return __vlan_find_dev_deep(real_dev->master, vlan_id);
+		struct net_device *upper_dev;
+
+		upper_dev = netdev_master_upper_dev_get_rcu(dev);
+		if (upper_dev)
+			return __vlan_find_dev_deep(upper_dev, vlan_id);
 	}
 
 	return NULL;
-- 
1.8.0

