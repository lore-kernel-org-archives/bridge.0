Return-Path: <jiri@resnulli.us>
From: Jiri Pirko <jiri@resnulli.us>
Date: Wed,  2 Jan 2013 13:28:30 +0100
Message-Id: <1357129716-2450-10-git-send-email-jiri@resnulli.us>
In-Reply-To: <1357129716-2450-1-git-send-email-jiri@resnulli.us>
References: <1357129716-2450-1-git-send-email-jiri@resnulli.us>
Subject: [Bridge] [patch net-next V5 09/15] qlcnic: guard
	__vlan_find_dev_deep() by rcu_read_lock
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

rcu_read_lock was missing here

Signed-off-by: Jiri Pirko <jiri@resnulli.us>
Acked-by: Sony Chacko <sony.chacko@qlogic.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index e1a3625..d4170a0 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -3204,12 +3204,14 @@ void qlcnic_restore_indev_addr(struct net_device *netdev, unsigned long event)
 
 	qlcnic_config_indev_addr(adapter, netdev, event);
 
+	rcu_read_lock();
 	for_each_set_bit(vid, adapter->vlans, VLAN_N_VID) {
 		dev = __vlan_find_dev_deep(netdev, vid);
 		if (!dev)
 			continue;
 		qlcnic_config_indev_addr(adapter, dev, event);
 	}
+	rcu_read_unlock();
 }
 
 static int qlcnic_netdev_event(struct notifier_block *this,
-- 
1.8.0

