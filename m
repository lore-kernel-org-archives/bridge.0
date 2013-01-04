Return-Path: <jiri@resnulli.us>
From: Jiri Pirko <jiri@resnulli.us>
Message-Id: <1357289343-817-8-git-send-email-jiri@resnulli.us>
In-Reply-To: <1357289343-817-1-git-send-email-jiri@resnulli.us>
References: <1357289343-817-1-git-send-email-jiri@resnulli.us>
Subject: [Bridge] [patch net-next V6 07/15] netpoll: remove usage of
	dev->master
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 04 Jan 2013 08:49:40 -0000
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, fbl@redhat.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, sony.chacko@qlogic.com, blaschka@linux.vnet.ibm.com, gregory.v.rose@intel.com, bhutchings@solarflare.com, xiyou.wangcong@gmail.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, linux-driver@qlogic.com, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

Signed-off-by: Jiri Pirko <jiri@resnulli.us>
---
 net/core/netpoll.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 3151acf..d2bda8e 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -210,9 +210,12 @@ static void netpoll_poll_dev(struct net_device *dev)
 
 	if (dev->flags & IFF_SLAVE) {
 		if (ni) {
-			struct net_device *bond_dev = dev->master;
+			struct net_device *bond_dev;
 			struct sk_buff *skb;
-			struct netpoll_info *bond_ni = rcu_dereference_bh(bond_dev->npinfo);
+			struct netpoll_info *bond_ni;
+
+			bond_dev = netdev_master_upper_dev_get_rcu(dev);
+			bond_ni = rcu_dereference_bh(bond_dev->npinfo);
 			while ((skb = skb_dequeue(&ni->arp_tx))) {
 				skb->dev = bond_dev;
 				skb_queue_tail(&bond_ni->arp_tx, skb);
@@ -815,7 +818,7 @@ int netpoll_setup(struct netpoll *np)
 		return -ENODEV;
 	}
 
-	if (ndev->master) {
+	if (netdev_master_upper_dev_get(ndev)) {
 		np_err(np, "%s is a slave device, aborting\n", np->dev_name);
 		err = -EBUSY;
 		goto put;
-- 
1.8.0

