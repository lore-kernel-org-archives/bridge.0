Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=hRaNPPzM96oGSGlTiQdvEvb1VbhoN7y90hwdqDXlGIw=;
	b=YMspBbhkiCZVIRUzHRVdS6460kq5AxFn+bI5KvcOAFT+6deQTvZeiPcxEgCIMvneBi
	qYCSK7g4SrifAI4MfUzSN3Ia+fuu+b+xMzEziKJ4a6vh+fIAz+r6WLPbWSY712nGvo+L
	FuizCI/l2o4E4uDTumBAiIQYQR/dXX6T+MdL40RToqqiJgBScvbQttFPcH81haBW2Gn/
	wGk5KKu8Daj0CkbyeXdzGhXHP+CEaLpWegv77oRJlWo0MoWUF9QEhLKNLWWOmHm0uZb1
	ZdwYJZ6o/tbsY3DowcZQKXhJ73L79wpCGoaT0DY+qfQV5J6HA56wAkXBZGHOLi0lcGk4
	XNnQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Feb 2019 09:51:01 -0800
Message-Id: <20190210175105.31629-13-f.fainelli@gmail.com>
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 12/16] mlxsw: spectrum_switchdev:
	Handle SWITCHDEV_PORT_ATTR_SET
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

Prepare mlxsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
mlxsw_sp_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 6b09d68671cf..39a99db040bd 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3410,6 +3410,20 @@ mlxsw_sp_switchdev_handle_vxlan_obj_del(struct net_device *vxlan_dev,
 	}
 }
 
+static int
+mlxsw_sp_switchdev_port_attr_set_event(unsigned long event,
+		struct net_device *dev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = mlxsw_sp_port_attr_set(dev, port_attr_info->attr,
+				     port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 					     unsigned long event, void *ptr)
 {
@@ -3433,6 +3447,8 @@ static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 							mlxsw_sp_port_dev_check,
 							mlxsw_sp_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return mlxsw_sp_switchdev_port_attr_set_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

