Return-Path: <tyhicks@canonical.com>
From: Tyler Hicks <tyhicks@canonical.com>
Date: Fri, 20 Jul 2018 21:56:50 +0000
Message-Id: <1532123814-1109-5-git-send-email-tyhicks@canonical.com>
In-Reply-To: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
References: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
Subject: [Bridge] [PATCH net-next v3 4/8] driver core: set up ownership of
	class devices in sysfs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, netdev@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Plumb in get_ownership() callback for devices belonging to a class so that
they can be created with uid/gid different from global root. This will
allow network devices in a container to belong to container's root and not
global root.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
---
 drivers/base/core.c    | 9 +++++++++
 include/linux/device.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index df3e1a44707a..276c7e3f754c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -866,10 +866,19 @@ static const void *device_namespace(struct kobject *kobj)
 	return ns;
 }
 
+static void device_get_ownership(struct kobject *kobj, kuid_t *uid, kgid_t *gid)
+{
+	struct device *dev = kobj_to_dev(kobj);
+
+	if (dev->class && dev->class->get_ownership)
+		dev->class->get_ownership(dev, uid, gid);
+}
+
 static struct kobj_type device_ktype = {
 	.release	= device_release,
 	.sysfs_ops	= &dev_sysfs_ops,
 	.namespace	= device_namespace,
+	.get_ownership	= device_get_ownership,
 };
 
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 055a69dbcd18..fe6ccb6dc119 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -384,6 +384,9 @@ int subsys_virtual_register(struct bus_type *subsys,
  * @shutdown_pre: Called at shut-down time before driver shutdown.
  * @ns_type:	Callbacks so sysfs can detemine namespaces.
  * @namespace:	Namespace of the device belongs to this class.
+ * @get_ownership: Allows class to specify uid/gid of the sysfs directories
+ *		for the devices belonging to the class. Usually tied to
+ *		device's namespace.
  * @pm:		The default device power management operations of this class.
  * @p:		The private data of the driver core, no one other than the
  *		driver core can touch this.
@@ -413,6 +416,8 @@ struct class {
 	const struct kobj_ns_type_operations *ns_type;
 	const void *(*namespace)(struct device *dev);
 
+	void (*get_ownership)(struct device *dev, kuid_t *uid, kgid_t *gid);
+
 	const struct dev_pm_ops *pm;
 
 	struct subsys_private *p;
-- 
2.7.4

