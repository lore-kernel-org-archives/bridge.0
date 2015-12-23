Return-Path: <geliangtang@163.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=k4qVpP1CET1sH/s2CM
	JYvNx3jM1slZ47DwYMLntuOS0=; b=byFlEcMF6cvUS9q1qD6s16ZwV4y2VkmWqE
	JRJ5K66rf6VCaiJMvco990m1qAF3DXIkJpan8FLBDGfSY+Hpbn+ImXvCrBITRRKp
	i1fizwSDpkN5hLEPTY47n9vyjzZxAP+0qry4rrQopZsfRQW9MIGkN6yRtqheKuen
	lfzQ1rYYQ=
From: Geliang Tang <geliangtang@163.com>
Date: Wed, 23 Dec 2015 20:42:21 +0800
Message-Id: <544026a4b733db9633610b0744ec99075788157a.1450874224.git.geliangtang@163.com>
In-Reply-To: <2e7e038ba8b7872e9e510aecde073bf944924a51.1450874224.git.geliangtang@163.com>
References: <2e7e038ba8b7872e9e510aecde073bf944924a51.1450874224.git.geliangtang@163.com>
In-Reply-To: <2e7e038ba8b7872e9e510aecde073bf944924a51.1450874224.git.geliangtang@163.com>
References: <2e7e038ba8b7872e9e510aecde073bf944924a51.1450874224.git.geliangtang@163.com>
Subject: [Bridge] [PATCH 2/2] bridge: use kobj_to_dev instead of to_dev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>
Cc: Geliang Tang <geliangtang@163.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

kobj_to_dev has been defined in linux/device.h, so I replace to_dev
with it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 net/bridge/br_sysfs_br.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 8365bd5..6b80914 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -22,7 +22,6 @@
 
 #include "br_private.h"
 
-#define to_dev(obj)	container_of(obj, struct device, kobj)
 #define to_bridge(cd)	((struct net_bridge *)netdev_priv(to_net_dev(cd)))
 
 /*
@@ -814,7 +813,7 @@ static ssize_t brforward_read(struct file *filp, struct kobject *kobj,
 			      struct bin_attribute *bin_attr,
 			      char *buf, loff_t off, size_t count)
 {
-	struct device *dev = to_dev(kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct net_bridge *br = to_bridge(dev);
 	int n;
 
-- 
2.5.0


