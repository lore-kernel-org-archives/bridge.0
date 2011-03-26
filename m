From: Sasikanth V <sasikanth.v19@gmail.com>
Date: Sat, 26 Mar 2011 20:19:57 +0530
Message-Id: <1301150997-4639-1-git-send-email-sasikanth.v19@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] =?utf-8?q?=5BPATCH=5D_Bridge_allows_the_userspace_to_con?=
	=?utf-8?q?figure_the_bridge_parameters_with_values_not_defined_in_?=
	=?utf-8?q?the_IEEE_802=2E1D_std?=
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org


Signed-off-by: Sasikanth V <sasikanth.v19@gmail.com>
---
 include/linux/if_bridge.h |   28 +++++++++++++++
 net/bridge/br_ioctl.c     |   35 +++++++-----------
 net/bridge/br_private.h   |    7 +++-
 net/bridge/br_stp_if.c    |    7 +++-
 net/bridge/br_sysfs_br.c  |   83 ++++++++++++++++++++++++++++++++++++---------
 net/bridge/br_sysfs_if.c  |    3 +-
 6 files changed, 122 insertions(+), 41 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index dd3f201..9c6cc49 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -49,6 +49,34 @@
 #define BR_STATE_FORWARDING 3
 #define BR_STATE_BLOCKING 4
 
+/*802.1D STP compatibility Range*/
+#define BR_DEFAULT_BRIDGE_PRIORITY 32768 
+#define BR_MIN_BRIDGE_PRIORITY 0
+#define BR_MAX_BRIDGE_PRIORITY 65535
+
+#define BR_DEFAULT_PORT_PRIORITY 128
+#define BR_MIN_PORT_PRIORITY 0
+#define BR_MAX_PORT_PRIORITY 240
+
+#define BR_MIN_PATH_COST 1
+#define BR_MAX_PATH_COST 200000000
+
+#define BR_DEFAULT_HELLO_TIME 2
+#define BR_MIN_HELLO_TIME 1
+#define BR_MAX_HELLO_TIME 10
+
+#define BR_DEFAULT_MAX_AGE  20
+#define BR_MIN_MAX_AGE  6
+#define BR_MAX_MAX_AGE  40
+
+#define BR_DEFAULT_FORWARD_DELAY  15
+#define BR_MIN_FORWARD_DELAY  2
+#define BR_MAX_FORWARD_DELAY 30 
+
+#define BR_DEFAULT_AGEING_TIME 300
+#define BR_MIN_AGEING_TIME 10
+#define BR_MAX_AGEING_TIME 1000000
+
 struct __bridge_info {
 	__u64 designated_root;
 	__u64 bridge_id;
diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index cb43312..72cf6b6 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -112,6 +112,7 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct net_bridge *br = netdev_priv(dev);
 	unsigned long args[4];
+	int rval = 0;
 
 	if (copy_from_user(args, rq->ifr_data, sizeof(args)))
 		return -EFAULT;
@@ -182,27 +183,19 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 			return -EPERM;
 
 		spin_lock_bh(&br->lock);
-		br->bridge_forward_delay = clock_t_to_jiffies(args[1]);
-		if (br_is_root_bridge(br))
-			br->forward_delay = br->bridge_forward_delay;
+		rval = set_forward_delay (br, args[1]);
 		spin_unlock_bh(&br->lock);
-		return 0;
+		return rval;
 
 	case BRCTL_SET_BRIDGE_HELLO_TIME:
 	{
-		unsigned long t = clock_t_to_jiffies(args[1]);
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (t < HZ)
-			return -EINVAL;
-
 		spin_lock_bh(&br->lock);
-		br->bridge_hello_time = t;
-		if (br_is_root_bridge(br))
-			br->hello_time = br->bridge_hello_time;
+		rval = set_hello_time (br, args[1]);
 		spin_unlock_bh(&br->lock);
-		return 0;
+		return rval;
 	}
 
 	case BRCTL_SET_BRIDGE_MAX_AGE:
@@ -210,18 +203,18 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 			return -EPERM;
 
 		spin_lock_bh(&br->lock);
-		br->bridge_max_age = clock_t_to_jiffies(args[1]);
-		if (br_is_root_bridge(br))
-			br->max_age = br->bridge_max_age;
+		rval = set_max_age (br, args[1]);
 		spin_unlock_bh(&br->lock);
-		return 0;
+		return rval;
 
 	case BRCTL_SET_AGEING_TIME:
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		br->ageing_time = clock_t_to_jiffies(args[1]);
-		return 0;
+		spin_lock_bh(&br->lock);
+		rval = set_ageing_time (br, args[1]);
+		spin_unlock_bh(&br->lock);
+		return rval;
 
 	case BRCTL_GET_PORT_INFO:
 	{
@@ -268,9 +261,9 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 			return -EPERM;
 
 		spin_lock_bh(&br->lock);
-		br_stp_set_bridge_priority(br, args[1]);
+		rval = set_priority (br, args[1]);
 		spin_unlock_bh(&br->lock);
-		return 0;
+		return rval;
 
 	case BRCTL_SET_PORT_PRIORITY:
 	{
@@ -303,7 +296,7 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		if ((p = br_get_port(br, args[1])) == NULL)
 			ret = -EINVAL;
 		else
-			br_stp_set_path_cost(p, args[2]);
+			ret = br_stp_set_path_cost(p, args[2]);
 
 		return ret;
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 19e2f46..87dd054 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -503,7 +503,7 @@ extern void br_stp_set_bridge_priority(struct net_bridge *br,
 				       u16 newprio);
 extern void br_stp_set_port_priority(struct net_bridge_port *p,
 				     u8 newprio);
-extern void br_stp_set_path_cost(struct net_bridge_port *p,
+extern int br_stp_set_path_cost(struct net_bridge_port *p,
 				 u32 path_cost);
 extern ssize_t br_show_bridge_id(char *buf, const struct bridge_id *id);
 
@@ -536,6 +536,11 @@ extern int br_sysfs_renameif(struct net_bridge_port *p);
 /* br_sysfs_br.c */
 extern int br_sysfs_addbr(struct net_device *dev);
 extern void br_sysfs_delbr(struct net_device *dev);
+extern int set_forward_delay(struct net_bridge *br, unsigned long val);
+extern int set_max_age(struct net_bridge *br, unsigned long val);
+extern int set_hello_time(struct net_bridge *br, unsigned long val);
+extern int set_priority(struct net_bridge *br, unsigned long val);
+extern int set_ageing_time(struct net_bridge *br, unsigned long val);
 
 #else
 
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 79372d4..6b9923c 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -269,11 +269,16 @@ void br_stp_set_port_priority(struct net_bridge_port *p, u8 newprio)
 }
 
 /* called under bridge lock */
-void br_stp_set_path_cost(struct net_bridge_port *p, u32 path_cost)
+int br_stp_set_path_cost(struct net_bridge_port *p, u32 path_cost)
 {
+	if (path_cost < BR_MIN_PATH_COST &&
+	    path_cost > BR_MAX_PATH_COST)
+		return -ERANGE;
+
 	p->path_cost = path_cost;
 	br_configuration_update(p->br);
 	br_port_state_selection(p->br);
+	return 0;
 }
 
 ssize_t br_show_bridge_id(char *buf, const struct bridge_id *id)
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 5c1e555..31a09c5 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -57,12 +57,25 @@ static ssize_t show_forward_delay(struct device *d,
 	return sprintf(buf, "%lu\n", jiffies_to_clock_t(br->forward_delay));
 }
 
-static int set_forward_delay(struct net_bridge *br, unsigned long val)
+int set_forward_delay(struct net_bridge *br, unsigned long val)
 {
-	unsigned long delay = clock_t_to_jiffies(val);
-	br->forward_delay = delay;
+	unsigned long fwd_dly = clock_t_to_jiffies(val) / HZ;
+	unsigned long max_age = br->max_age / HZ;
+
+	if ((fwd_dly < BR_MIN_FORWARD_DELAY) ||
+	    (fwd_dly > BR_MAX_FORWARD_DELAY))
+		return -ERANGE;
+
+	/*2 × (Bridge_Forward_Delay – 1.0 seconds) >= Bridge_Max_Age*/
+	if ((2 * (fwd_dly - 1) < (max_age))) {
+		return -EINVAL;
+	}
+
+	fwd_dly *= HZ;
+
+	br->forward_delay = fwd_dly;
 	if (br_is_root_bridge(br))
-		br->bridge_forward_delay = delay;
+		br->bridge_forward_delay = fwd_dly;
 	return 0;
 }
 
@@ -82,16 +95,25 @@ static ssize_t show_hello_time(struct device *d, struct device_attribute *attr,
 		       jiffies_to_clock_t(to_bridge(d)->hello_time));
 }
 
-static int set_hello_time(struct net_bridge *br, unsigned long val)
+int set_hello_time(struct net_bridge *br, unsigned long val)
 {
-	unsigned long t = clock_t_to_jiffies(val);
+	unsigned long hello_time = clock_t_to_jiffies(val) / HZ;
+	unsigned long max_age = br->max_age / HZ;
+
+	if ((hello_time < BR_MIN_HELLO_TIME) ||
+   	    (hello_time > BR_MAX_HELLO_TIME))
+		return -ERANGE;
 
-	if (t < HZ)
+	/*Bridge_Max_Age >= 2 × (Bridge_Hello_Time + 1.0 seconds)*/
+
+	if (max_age < ( 2 * (hello_time + 1)))
 		return -EINVAL;
 
-	br->hello_time = t;
+	hello_time *= HZ;
+
+	br->hello_time = hello_time;
 	if (br_is_root_bridge(br))
-		br->bridge_hello_time = t;
+		br->bridge_hello_time = hello_time;
 	return 0;
 }
 
@@ -111,12 +133,31 @@ static ssize_t show_max_age(struct device *d, struct device_attribute *attr,
 		       jiffies_to_clock_t(to_bridge(d)->max_age));
 }
 
-static int set_max_age(struct net_bridge *br, unsigned long val)
+int set_max_age(struct net_bridge *br, unsigned long val)
 {
-	unsigned long t = clock_t_to_jiffies(val);
-	br->max_age = t;
+	unsigned long max_age = clock_t_to_jiffies(val) / HZ;
+	unsigned long hello_time = br->hello_time / HZ;
+	unsigned long fwd_dly = br->forward_delay / HZ;
+
+	if ((max_age < BR_MIN_MAX_AGE) ||
+	    (max_age > BR_MAX_MAX_AGE)) 
+		return -ERANGE;
+
+	/* To support interoperability with legacy Bridges, 
+   	   a Bridge shall enforce the following relationships
+  	   2 × (Bridge_Forward_Delay – 1.0 seconds) >= Bridge_Max_Age
+	   Bridge_Max_Age >= 2 × (Bridge_Hello_Time + 1.0 seconds)
+	*/
+
+       if ((max_age < ( 2 * (hello_time + 1))) || 
+	   (2 * (fwd_dly - 1) < (max_age)))
+                return -EINVAL;
+
+	max_age *= HZ;
+
+	br->max_age = max_age;
 	if (br_is_root_bridge(br))
-		br->bridge_max_age = t;
+		br->bridge_max_age = max_age;
 	return 0;
 }
 
@@ -134,9 +175,15 @@ static ssize_t show_ageing_time(struct device *d,
 	return sprintf(buf, "%lu\n", jiffies_to_clock_t(br->ageing_time));
 }
 
-static int set_ageing_time(struct net_bridge *br, unsigned long val)
+int set_ageing_time(struct net_bridge *br, unsigned long val)
 {
-	br->ageing_time = clock_t_to_jiffies(val);
+	val = clock_t_to_jiffies(val) / HZ;
+
+	if (val < BR_MIN_AGEING_TIME ||
+	    val > BR_MAX_AGEING_TIME)
+		return -ERANGE;
+
+	br->ageing_time = val * HZ;
 	return 0;
 }
 
@@ -190,8 +237,12 @@ static ssize_t show_priority(struct device *d, struct device_attribute *attr,
 		       (br->bridge_id.prio[0] << 8) | br->bridge_id.prio[1]);
 }
 
-static int set_priority(struct net_bridge *br, unsigned long val)
+int set_priority(struct net_bridge *br, unsigned long val)
 {
+	if ((val < BR_MIN_BRIDGE_PRIORITY) ||
+	    (val > BR_MAX_BRIDGE_PRIORITY)) 
+		return -ERANGE;
+
 	br_stp_set_bridge_priority(br, (u16) val);
 	return 0;
 }
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index fd5799c..6bd4520 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -40,8 +40,7 @@ static ssize_t show_path_cost(struct net_bridge_port *p, char *buf)
 }
 static ssize_t store_path_cost(struct net_bridge_port *p, unsigned long v)
 {
-	br_stp_set_path_cost(p, v);
-	return 0;
+	return br_stp_set_path_cost(p, v);
 }
 static BRPORT_ATTR(path_cost, S_IRUGO | S_IWUSR,
 		   show_path_cost, store_path_cost);
-- 
1.7.3.4

