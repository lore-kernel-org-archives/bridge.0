Message-Id: <46FA2C17.76E4.0078.0@novell.com>
Date: Wed, 26 Sep 2007 08:53:27 +0100
From: "Jan Beulich" <jbeulich@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] Module use count must be updated as bridges are
	created/destroyed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Otherwise 'modprobe -r' on a module having a dependency on bridge will
implicitly unload bridge, bringing down all connectivity that was using
bridges.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

 net/bridge/br_if.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- linux-2.6.23-rc8/net/bridge/br_if.c	2007-09-26 09:23:54.000000000 +0200
+++ 2.6.23-rc8-bridge-module-get-put/net/bridge/br_if.c	2007-09-25 14:31:01.000000000 +0200
@@ -276,6 +276,11 @@ int br_add_bridge(const char *name)
 	if (!dev)
 		return -ENOMEM;
 
+	if (!try_module_get(THIS_MODULE)) {
+		free_netdev(dev);
+		return -ENOENT;
+	}
+
 	rtnl_lock();
 	if (strchr(dev->name, '%')) {
 		ret = dev_alloc_name(dev, dev->name);
@@ -294,6 +299,8 @@ int br_add_bridge(const char *name)
 		unregister_netdevice(dev);
  out:
 	rtnl_unlock();
+	if (ret)
+		module_put(THIS_MODULE);
 	return ret;
 }
 
@@ -321,6 +328,8 @@ int br_del_bridge(const char *name)
 		del_br(netdev_priv(dev));
 
 	rtnl_unlock();
+	if (ret == 0)
+		module_put(THIS_MODULE);
 	return ret;
 }
 




