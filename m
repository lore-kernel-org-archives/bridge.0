Return-Path: <bianpan2016@163.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=bl2EksZqTDO6NvV30y
	koMm9/yVn6Ek8vLwYsCAGbR6o=; b=aie8R4Vmo6LL/Ae4OBtdFRN9gf93d9D4Ql
	QaYnxxkfxb1h1Z98CAsPonaZIYT8SStBhQWNh/bNf+uj2QAZKAcrEJHgua5/HUwR
	cnCyi0NEJNCUrOl8sYulzp9BL0FpDCuKGtK0g/tYwHR1mqM2zFOLfK9Fvquqk/HG
	Vvyi2YFEo=
From: Pan Bian <bianpan2016@163.com>
Date: Sat,  3 Dec 2016 19:33:23 +0800
Message-Id: <1480764803-5577-1-git-send-email-bianpan2016@163.com>
Subject: [Bridge] [PATCH 1/1] net: bridge: set error code on failure
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Pan Bian <bianpan2016@163.com>, linux-kernel@vger.kernel.org

Function br_sysfs_addbr() does not set error code when the call
kobject_create_and_add() returns a NULL pointer. It may be better to
return "-ENOMEM" when kobject_create_and_add() fails.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188781

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 net/bridge/br_sysfs_br.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index e120307..f88c4df 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -898,6 +898,7 @@ int br_sysfs_addbr(struct net_device *dev)
 	if (!br->ifobj) {
 		pr_info("%s: can't add kobject (directory) %s/%s\n",
 			__func__, dev->name, SYSFS_BRIDGE_PORT_SUBDIR);
+		err = -ENOMEM;
 		goto out3;
 	}
 	return 0;
-- 
1.9.1


