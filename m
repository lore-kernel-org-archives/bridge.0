Return-Path: <jiri@resnulli.us>
From: Jiri Pirko <jiri@resnulli.us>
Message-Id: <1344956748-2099-16-git-send-email-jiri@resnulli.us>
In-Reply-To: <1344956748-2099-1-git-send-email-jiri@resnulli.us>
References: <1344956748-2099-1-git-send-email-jiri@resnulli.us>
Subject: [Bridge] [patch net-next v2 15/15] net: kill dev->master
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Tue, 14 Aug 2012 15:06:43 -0000
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, fbl@redhat.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, sony.chacko@qlogic.com, blaschka@linux.vnet.ibm.com, gregory.v.rose@intel.com, bhutchings@solarflare.com, xiyou.wangcong@gmail.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, linux-driver@qlogic.com, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

Nobody uses this now. Remove it.

Signed-off-by: Jiri Pirko <jiri@resnulli.us>
---
 include/linux/netdevice.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c689593..8459f72 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1168,10 +1168,6 @@ struct net_device {
 						 * avoid dirtying this cache line.
 						 */
 
-	struct net_device	*master; /* Pointer to master device of a group,
-					  * which this device is member of.
-					  */
-
 	struct list_head	upper_dev_list; /* List of upper devices */
 
 	/* Interface address info used in eth_type_trans() */
-- 
1.7.10.4

