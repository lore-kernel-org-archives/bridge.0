Date: Mon, 12 Jan 2004 13:46:45 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040112134645.461f125e.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge use read_lock when scanning device list
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, bridge@osdl.org

On 2.6.1, bridge is using rtnl_shlock which is equivalent to rtnl_lock when
all it really needs to do is read_lock(&dev_base_lock).


diff -Nru a/net/bridge/br_if.c b/net/bridge/br_if.c
--- a/net/bridge/br_if.c	Mon Jan 12 13:45:44 2004
+++ b/net/bridge/br_if.c	Mon Jan 12 13:45:44 2004
@@ -252,12 +252,12 @@
 	struct net_device *dev;
 	int i = 0;
 
-	rtnl_shlock();
+	read_lock(&dev_base_lock);
 	for (dev = dev_base; dev && i < num; dev = dev->next) {
 		if (dev->priv_flags & IFF_EBRIDGE) 
 			indices[i++] = dev->ifindex;
 	}
-	rtnl_shunlock();
+	read_unlock(&dev_base_lock);
 
 	return i;
 }
