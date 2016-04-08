Return-Path: <lucien.xin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=4nnySePeFjPiRUh5Wd1gLbTaHc4RVknk83gDiojoJFo=;
	b=ELj9bBCvVsib2zuroP32aMvmXmo7EytmZgxGxJ2G5toKMl1KmFjfKDzO+p1zsJS7iH
	botyO8IEZGmPP7+Y4ksVFzpqnbAniq/JbS8QQq97W5CfWeiAs/THN2EsZSrqcpgZyIAu
	d6iQ2YqR/MDshqdNo5oK+oUuyD16xtiiyDNYxX1GTr4D+OdAqbcxhMbKXUb6kKlVAsWq
	/kkWDTUGz81wel1CKWGCg00SRLJ3ULgVQuoald3zDk1+dOboNXFS+M5GLJSffblpItcY
	OMYqYBkJeh5yVfQ+cfzGJ7vzC5i5Wb1OWgvbZN63ynMyrZps0Wy8vhh3NMFzQ/yJ3XHr
	bjuw==
From: Xin Long <lucien.xin@gmail.com>
Date: Sat,  9 Apr 2016 00:03:30 +0800
Message-Id: <8c14a891d0a8bcea071d4e5305776a5c5cd9fd17.1460131308.git.lucien.xin@gmail.com>
In-Reply-To: <6197a35a2eb6df2caf90edcbf1b49da12077f659.1460131308.git.lucien.xin@gmail.com>
References: <cover.1460131308.git.lucien.xin@gmail.com>
	<6e2cf6821542a253904dfc7d8ec431d6bbda2b4e.1460131308.git.lucien.xin@gmail.com>
	<6197a35a2eb6df2caf90edcbf1b49da12077f659.1460131308.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1460131308.git.lucien.xin@gmail.com>
References: <cover.1460131308.git.lucien.xin@gmail.com>
Subject: [Bridge] [PATCHv3 net-next 3/6] bridge: simplify the
	stp_state_store by calling store_bridge_parm
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

There are some repetitive codes in stp_state_store, we can remove
them by calling store_bridge_parm.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/bridge/br_sysfs_br.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 137cd3b..f9d484e 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -128,27 +128,21 @@ static ssize_t stp_state_show(struct device *d,
 }
 
 
-static ssize_t stp_state_store(struct device *d,
-			       struct device_attribute *attr, const char *buf,
-			       size_t len)
+static int set_stp_state(struct net_bridge *br, unsigned long val)
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
 	if (!rtnl_trylock())
 		return restart_syscall();
 	br_stp_set_enabled(br, val);
 	rtnl_unlock();
 
-	return len;
+	return 0;
+}
+
+static ssize_t stp_state_store(struct device *d,
+			       struct device_attribute *attr, const char *buf,
+			       size_t len)
+{
+	return store_bridge_parm(d, buf, len, set_stp_state);
 }
 static DEVICE_ATTR_RW(stp_state);
 
-- 
2.1.0

