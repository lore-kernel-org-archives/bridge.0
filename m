Date: Fri, 2 May 2008 11:01:38 +0200
From: Bernhard Fischer <rep.dot.nop@gmail.com>
Message-ID: <20080502090138.GA15508@mx.loc>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
Subject: [Bridge] [RFA,
	PATCH] enable transition to sysfs-only bridge manipulation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: buytenh@gnu.org, rep.dot.nop@gmail.com, bridge@lists.linux-foundation.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

It was rumored that the ioctl interface for bridges is deprecated.
There is, however, one crucial gap when trying to implement brctl
without using any ioctl: AFAICS it is impossible to create a bridge via
sysfs.

The attached quick.. erm patch strives to fill this gap.
Some further details are at the top of the patchlet which received only
cursory testing, fwiw.

Thanks and cheers,
Bernhard

--x+6KMIRAuhnl3hBn
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.25-brctrl-sysfs-fixup.01.diff"

enable transition to sysfs-only bridge manipulation

  All bridge-operations except the creation of a bridge are
  already operable via sysfs. The attached patchlet provides means to fill
  this gap in order to completely deprecate the ioctl interface to bridges.
  $ echo add mybr0 > /sys/class/bridge/ctrl
  $ echo add mybr1 > /sys/class/bridge/ctrl
  $ echo del mybr1 > /sys/class/bridge/ctrl


add/remove: 3/0 grow/shrink: 4/0 up/down: 490/0 (490)
function                                     old     new   delta
brctl                                          -     230    +230
init_module                                  186     265     +79
br_init                                      186     265     +79
cleanup_module                               103     142     +39
br_deinit                                    103     142     +39
class_attr_ctrl                                -      20     +20
br_class                                       -       4      +4

Signed-off-by:  Bernhard Fischer <rep.dot.nop@gmail.com>

diff -rdup linux-2.6.25.oorig/net/bridge/br.c linux-2.6.25/net/bridge/br.c
--- linux-2.6.25.oorig/net/bridge/br.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.25/net/bridge/br.c	2008-05-02 10:28:40.000000000 +0200
@@ -20,11 +20,91 @@
 #include <linux/init.h>
 #include <linux/llc.h>
 #include <net/llc.h>
+#include <linux/ctype.h> /* isspace() */
 
 #include "br_private.h"
 
 int (*br_should_route_hook)(struct sk_buff *skb);
 
+#ifdef CONFIG_SYSFS
+static ssize_t brctl(struct class *cls, const char *buf, size_t buf_len)
+{
+	unsigned op_add;
+	size_t sz = buf_len;
+	char *br;
+	int ret;
+
+	if (sz < 3)
+		goto err;
+
+	if (buf[0] == 'a')
+		op_add = 1;
+	else if (buf[0] == 'd')
+		op_add = 0;
+	else
+		goto err;
+
+	if (buf[buf_len - 1] == '\n')
+		--sz;
+
+	/* skip to bridge name */
+	while (!isspace(*buf)) {
+		++buf;
+		--sz;
+	}
+	while (isspace(*buf)) {
+		++buf;
+		--sz;
+	}
+	if (!buf || !sz)
+		goto err;
+	br = kzalloc(sz, GFP_KERNEL);
+	if (!br)
+		return -ENOMEM;
+	strncpy(br, buf, sz);
+
+	if (op_add)
+		ret = br_add_bridge(br);
+	else
+		ret = br_del_bridge(br);
+	kfree(br);
+	return (ret < 0) ? ret : buf_len;
+err:
+	return -EINVAL;
+}
+static struct class *br_class;
+static CLASS_ATTR(ctrl, 0200, NULL, brctl);
+static inline int br_sysfs_init(void)
+{
+	int ret;
+
+	br_class = class_create(THIS_MODULE, "bridge");
+	if (IS_ERR(br_class))
+		return PTR_ERR(br_class);
+
+	ret = class_create_file(br_class, &class_attr_ctrl);
+	if (ret < 0) {
+		class_destroy(br_class);
+		br_class = NULL;
+	}
+	return ret;
+}
+static inline void br_sysfs_fini(void)
+{
+	if (br_class) {
+		class_remove_file(br_class, &class_attr_ctrl);
+		class_destroy(br_class);
+		br_class = NULL;
+	}
+}
+#else
+static inline int br_sysfs_init(void)
+{
+	return 0;
+}
+static inline void br_sysfs_fini(void) {;}
+#endif
+
 static struct llc_sap *br_stp_sap;
 
 static int __init br_init(void)
@@ -53,6 +133,10 @@ static int __init br_init(void)
 	if (err)
 		goto err_out3;
 
+	err = br_sysfs_init();
+	if (err)
+		goto err_out3;
+
 	brioctl_set(br_ioctl_deviceless_stub);
 	br_handle_frame_hook = br_handle_frame;
 
@@ -73,6 +157,7 @@ err_out:
 
 static void __exit br_deinit(void)
 {
+	br_sysfs_fini();
 	rcu_assign_pointer(br_stp_sap->rcv_func, NULL);
 
 	br_netlink_fini();

--x+6KMIRAuhnl3hBn--
