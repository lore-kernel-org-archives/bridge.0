Return-Path: <lucien.xin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=Vr3fonZRZ0pfFkHMTM2qgfvEVDY3OI9B+nwb5bt6GI8=;
	b=DJCecdUHMOWGDVRsCjxNtoFGPC6dUbQUVDAIyw9N9l3wUZjIbQUyhAbKyyeGi7Uary
	CvXr54VwYFZUnhg5R/9TNrBkf6UXbAXZ0Mw1t2Qd2qgM/qcuVJg8mTC2Hrun7NNvpp8q
	Uy5Y5PqJ8IH9g1gPKikELW4vvsGS/etFPNjC1mrmHlzshFNZQr8FhL+4xIl8z1MxSUJZ
	qZQYiljN/OpinLxP8GPwlRJUg63f83pNC8KmHqKUAXhmbEqUO2ixZ++kAbk15+cC/yBA
	07/p4ZTFcCBscX1aY4NOBepcXLPaJ6bMmRksL5bh+VUHDCYXuqyXM9B8xlZ1vsQCsCUn
	lXag==
From: Xin Long <lucien.xin@gmail.com>
Date: Sat,  9 Apr 2016 00:03:29 +0800
Message-Id: <6197a35a2eb6df2caf90edcbf1b49da12077f659.1460131308.git.lucien.xin@gmail.com>
In-Reply-To: <6e2cf6821542a253904dfc7d8ec431d6bbda2b4e.1460131308.git.lucien.xin@gmail.com>
References: <cover.1460131308.git.lucien.xin@gmail.com>
	<6e2cf6821542a253904dfc7d8ec431d6bbda2b4e.1460131308.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1460131308.git.lucien.xin@gmail.com>
References: <cover.1460131308.git.lucien.xin@gmail.com>
Subject: [Bridge] [PATCHv3 net-next 2/6] bridge: simplify the
	forward_delay_store by calling store_bridge_parm
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: network dev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org
Cc: nikolay@cumulusnetworks.com, davem@davemloft.net

There are some repetitive codes in forward_delay_store, we can remove
them by calling store_bridge_parm.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/bridge/br_sysfs_br.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index c48f6b0..137cd3b 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -160,29 +160,22 @@ static ssize_t group_fwd_mask_show(struct device *d,
 	return sprintf(buf, "%#x\n", br->group_fwd_mask);
 }
 
-
-static ssize_t group_fwd_mask_store(struct device *d,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t len)
+static int set_group_fwd_mask(struct net_bridge *br, unsigned long val)
 {
-	struct net_bridge *br = to_bridge(d);
-	char *endp;
-	unsigned long val;
-
-	if (!ns_capable(dev_net(br->dev)->user_ns, CAP_NET_ADMIN))
-		return -EPERM;
-
-	val = simple_strtoul(buf, &endp, 0);
-	if (endp == buf)
-		return -EINVAL;
-
 	if (val & BR_GROUPFWD_RESTRICTED)
 		return -EINVAL;
 
 	br->group_fwd_mask = val;
 
-	return len;
+	return 0;
+}
+
+static ssize_t group_fwd_mask_store(struct device *d,
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t len)
+{
+	return store_bridge_parm(d, buf, len, set_group_fwd_mask);
 }
 static DEVICE_ATTR_RW(group_fwd_mask);
 
-- 
2.1.0

