Message-Id: <4DBA830A020000780003ED5D@vpn.id2.novell.com>
Date: Fri, 29 Apr 2011 08:21:14 +0100
From: "Jan Beulich" <JBeulich@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Bridge] [PATCH] bridge: Module use count must be updated as
	bridges	 are created/destroyed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Jeff Mahoney <jeffm@suse.com>

Otherwise 'modprobe -r' on a module having a dependency on bridge will
implicitly unload bridge, bringing down all connectivity that was using
bridges.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Jeff Mahoney <jeffm@suse.com>

---
 net/bridge/br_if.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 2.6.39-rc5/net/bridge/br_if.c
+++ 2.6.39-rc5-bridge-module-get-put/net/bridge/br_if.c
@@ -290,6 +290,11 @@ int br_add_bridge(struct net *net, const
 	if (!dev)
 		return -ENOMEM;
=20
+	if (!try_module_get(THIS_MODULE)) {
+		free_netdev(dev);
+		return -ENOENT;
+	}
+
 	rtnl_lock();
 	if (strchr(dev->name, '%')) {
 		ret =3D dev_alloc_name(dev, dev->name);
@@ -308,6 +313,8 @@ int br_add_bridge(struct net *net, const
 		unregister_netdevice(dev);
  out:
 	rtnl_unlock();
+	if (ret)
+		module_put(THIS_MODULE);
 	return ret;
=20
 out_free:
@@ -339,6 +346,8 @@ int br_del_bridge(struct net *net, const
 		del_br(netdev_priv(dev), NULL);
=20
 	rtnl_unlock();
+	if (ret =3D=3D 0)
+		module_put(THIS_MODULE);
 	return ret;
 }
=20



