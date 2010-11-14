Message-Id: <20101114211515.305479590@vyatta.com>
Date: Sun, 14 Nov 2010 13:12:04 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
References: <20101114211201.678755903@vyatta.com>
Content-Disposition: inline; filename=rx_handler_rcu.patch
Subject: [Bridge] [PATCH 3/5] netdev: add rcu annotations to receive handler
	hook
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>, Eric Dumazet <eric.dumazet@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Suggested by Eric's bridge RCU changes.

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

---
 include/linux/netdevice.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/netdevice.h	2010-11-14 11:41:53.224298362 -0800
+++ b/include/linux/netdevice.h	2010-11-14 11:42:42.546359900 -0800
@@ -995,8 +995,8 @@ struct net_device {
 	unsigned int		real_num_rx_queues;
 #endif
 
-	rx_handler_func_t	*rx_handler;
-	void			*rx_handler_data;
+	rx_handler_func_t __rcu	*rx_handler;
+	void __rcu		*rx_handler_data;
 
 	struct netdev_queue __rcu *ingress_queue;
 


