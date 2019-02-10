Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=H+qa45j97TVXUzWcSqT4ciJ6lwUcGt6+aO3V+0751xI=;
	b=qbh1qNujKyGmbNz+1T9Nr6c9HSQkjUaarSeCf/9YLVdDqinl/qBWvJjo2sNIkOEPkZ
	uvBRvnjFH4RLzhEtJ2ikcxVmdQPf71HM2T7XZbnE9ATdvYHY8QOsMDd3sSA+TYr95XpH
	/LiIo+jWgR/tLt8FffOqyK18qxBGk/g+BHqy2jPRGNKyfzHrVhxg5YjKLFYQE0z9+Q3h
	TKuvAwVBIhq91CRQsQlQw8fbDmM7P1Sx738dKVtmDcfGYf1H2SpW2ylFQV0kpWeVJJ17
	IPoxnKGxcBr2JwDElcobZ7+yZeC+lJBOwDkL0plplNAb0yt31wdU2ymwVNhvYAuNjxKe
	OUFw==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Feb 2019 15:40:05 -0800
Message-Id: <20190210234007.16173-8-f.fainelli@gmail.com>
In-Reply-To: <20190210234007.16173-1-f.fainelli@gmail.com>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 7/9] net: dsa: Handle
	SWITCHDEV_PORT_ATTR_GET/SET
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare DSA to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
dsa_slave_port_attr_{set,get} calls.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 2e5e7c04821b..2a14a38f5f93 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1558,6 +1558,27 @@ dsa_slave_switchdev_port_obj_event(unsigned long event,
 	return notifier_from_errno(err);
 }
 
+static int
+dsa_slave_switchdev_port_attr_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = dsa_slave_port_attr_set(netdev, port_attr_info->attr,
+					      port_attr_info->trans);
+		break;
+	case SWITCHDEV_PORT_ATTR_GET:
+		err = dsa_slave_port_attr_get(netdev, port_attr_info->attr);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 					      unsigned long event, void *ptr)
 {
@@ -1570,6 +1591,9 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return dsa_slave_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET: /* fallthrough */
+	case SWITCHDEV_PORT_ATTR_GET:
+		return dsa_slave_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

