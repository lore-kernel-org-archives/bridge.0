Return-Path: <jiri@resnulli.us>
From: Jiri Pirko <jiri@resnulli.us>
Message-Id: <1344956748-2099-8-git-send-email-jiri@resnulli.us>
In-Reply-To: <1344956748-2099-1-git-send-email-jiri@resnulli.us>
References: <1344956748-2099-1-git-send-email-jiri@resnulli.us>
Subject: [Bridge] [patch net-next v2 07/15] netpoll: remove usage of
	dev->master
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Tue, 14 Aug 2012 15:06:18 -0000
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, fbl@redhat.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, sony.chacko@qlogic.com, blaschka@linux.vnet.ibm.com, gregory.v.rose@intel.com, bhutchings@solarflare.com, xiyou.wangcong@gmail.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, linux-driver@qlogic.com, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

Signed-off-by: Jiri Pirko <jiri@resnulli.us>
---
 net/core/netpoll.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index b4c90e4..1f457a6 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -207,12 +207,16 @@ static void netpoll_poll_dev(struct net_device *dev)
 
 	if (dev->flags & IFF_SLAVE) {
 		if (dev->npinfo) {
-			struct net_device *bond_dev = dev->master;
+			struct net_device *bond_dev;
 			struct sk_buff *skb;
+
+			rcu_read_lock();
+			bond_dev = netdev_master_upper_dev_get_rcu(dev);
 			while ((skb = skb_dequeue(&dev->npinfo->arp_tx))) {
 				skb->dev = bond_dev;
 				skb_queue_tail(&bond_dev->npinfo->arp_tx, skb);
 			}
+			rcu_read_unlock();
 		}
 	}
 
@@ -795,7 +799,7 @@ int netpoll_setup(struct netpoll *np)
 		return -ENODEV;
 	}
 
-	if (ndev->master) {
+	if (netdev_master_upper_dev_get(ndev)) {
 		np_err(np, "%s is a slave device, aborting\n", np->dev_name);
 		err = -EBUSY;
 		goto put;
-- 
1.7.10.4

