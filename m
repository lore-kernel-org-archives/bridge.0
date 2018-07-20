Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=wZzkggQBWgd4x5MpL3P80zp5hPDY1fUhFXWj2pYEVKs=;
	b=A+HFG6iihmhijJyt/V9sXDmpwla55R1aS6rFlm/ysZZ+XDYKyX/A5orgrWh12EW+1v
	mGnp0JGYm9aRyyXC8SwAW9f6oMcInqSMSLNNsoRxFFeNYndw5tD2qmxMJywiF2L0EHM3
	6EKfBz3uxDlkPVJgoZrq6sefrihSH7lXFhWC8=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 20 Jul 2018 17:48:25 +0300
Message-Id: <20180720144826.29892-2-nikolay@cumulusnetworks.com>
In-Reply-To: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
References: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 1/2] net: bridge: add support for raw
	sysfs port options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

This patch adds a new alternative store callback for port sysfs options
which takes a raw value (buf) and can use it directly. It is needed for the
backup port sysfs support since we have to pass the device by its name.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
There are a few checkpatch warnings here because of the old code, I've
noted them in my todo and will send separate patch for simple_strtoul
and the function prototypes.

 net/bridge/br_sysfs_if.c | 49 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index f99c5bf5c906..38c58879423d 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -25,6 +25,15 @@ struct brport_attribute {
 	struct attribute	attr;
 	ssize_t (*show)(struct net_bridge_port *, char *);
 	int (*store)(struct net_bridge_port *, unsigned long);
+	int (*store_raw)(struct net_bridge_port *, char *);
+};
+
+#define BRPORT_ATTR_RAW(_name, _mode, _show, _store)			\
+const struct brport_attribute brport_attr_##_name = {			\
+	.attr		= {.name = __stringify(_name),			\
+			   .mode = _mode },				\
+	.show		= _show,					\
+	.store_raw	= _store,					\
 };
 
 #define BRPORT_ATTR(_name, _mode, _show, _store)		\
@@ -270,27 +279,37 @@ static ssize_t brport_store(struct kobject *kobj,
 	struct brport_attribute *brport_attr = to_brport_attr(attr);
 	struct net_bridge_port *p = to_brport(kobj);
 	ssize_t ret = -EINVAL;
-	char *endp;
 	unsigned long val;
+	char *endp;
 
 	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
 
-	val = simple_strtoul(buf, &endp, 0);
-	if (endp != buf) {
-		if (!rtnl_trylock())
-			return restart_syscall();
-		if (p->dev && p->br && brport_attr->store) {
-			spin_lock_bh(&p->br->lock);
-			ret = brport_attr->store(p, val);
-			spin_unlock_bh(&p->br->lock);
-			if (!ret) {
-				br_ifinfo_notify(RTM_NEWLINK, NULL, p);
-				ret = count;
-			}
-		}
-		rtnl_unlock();
+	if (!rtnl_trylock())
+		return restart_syscall();
+
+	if (!p->dev || !p->br)
+		goto out_unlock;
+
+	if (brport_attr->store_raw) {
+		spin_lock_bh(&p->br->lock);
+		ret = brport_attr->store_raw(p, (char *)buf);
+		spin_unlock_bh(&p->br->lock);
+	} else if (brport_attr->store) {
+		val = simple_strtoul(buf, &endp, 0);
+		if (endp == buf)
+			goto out_unlock;
+		spin_lock_bh(&p->br->lock);
+		ret = brport_attr->store(p, val);
+		spin_unlock_bh(&p->br->lock);
+	}
+	if (!ret) {
+		br_ifinfo_notify(RTM_NEWLINK, NULL, p);
+		ret = count;
 	}
+out_unlock:
+	rtnl_unlock();
+
 	return ret;
 }
 
-- 
2.11.0

