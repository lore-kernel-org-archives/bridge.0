Return-Path: <lucien.xin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=KBlJVcOgPN+vADlAofLDaNv741Kr3aFVtEBaxM5YqZU=;
	b=evJzKdDiVIFJoks3VroCsIoTjaRk+aH4C4HjR5uvD0dX2REkpkAcrIHDHz4U1FNPJJ
	DA9uWZrKtprU8M6fqlKBGS+nUOXBbZMDr5VbyDSYT3UCDIUTTUUm5wjZi+eYeAWJqWZ/
	/PtlrqdJzNvAxOXO7Q3FjbJqZGsz60yYW3j/oINViLscRQ5kabspLZZCDdwnjdtNDnJG
	GUimlyTTvYRuMDUVL95OpJAlSw97+T1TqRvR+CYAeYTIE1G9f7cWcdQMqnVxwe46toty
	fU5iGw0c5aYbye2ydxzY7cyOWpgdmTg9PCMb1KaWQFIaKqJ4Aor1QodFyXLDnt84z/nq
	NH3w==
From: Xin Long <lucien.xin@gmail.com>
Date: Tue,  5 Apr 2016 11:32:38 +0800
Message-Id: <baf4788b6ac529a2132ace735fc1caf4989307da.1459827115.git.lucien.xin@gmail.com>
In-Reply-To: <6197a35a2eb6df2caf90edcbf1b49da12077f659.1459827115.git.lucien.xin@gmail.com>
References: <cover.1459827115.git.lucien.xin@gmail.com>
	<6e2cf6821542a253904dfc7d8ec431d6bbda2b4e.1459827115.git.lucien.xin@gmail.com>
	<6197a35a2eb6df2caf90edcbf1b49da12077f659.1459827115.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1459827115.git.lucien.xin@gmail.com>
References: <cover.1459827115.git.lucien.xin@gmail.com>
Subject: [Bridge] [PATCHv2 net-next 3/6] bridge: simplify the
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
 net/bridge/br_sysfs_br.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 137cd3b..9918763 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -128,27 +128,17 @@ static ssize_t stp_state_show(struct device *d,
 }
 
 
+static int set_stp_state(struct net_bridge *br, unsigned long val)
+{
+	br_stp_set_enabled(br, val);
+	return 0;
+}
+
 static ssize_t stp_state_store(struct device *d,
 			       struct device_attribute *attr, const char *buf,
 			       size_t len)
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
-	if (!rtnl_trylock())
-		return restart_syscall();
-	br_stp_set_enabled(br, val);
-	rtnl_unlock();
-
-	return len;
+	return store_bridge_parm(d, buf, len, set_stp_state);
 }
 static DEVICE_ATTR_RW(stp_state);
 
-- 
2.1.0

