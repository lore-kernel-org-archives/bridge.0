Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1587907460; x=1619443460;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=GkxxeqQ24TWiadpvn3U20m5pP0ySpQmBPr9P9328e2w=;
 b=Gg6g3uPl8jNo59pTB19+ss7BeYWnzYiRKsk9vkzT9u8xu3YM3WQQg85+
 42n4eLsXO8zFpWGJ7zTHZWnsQW85gPFJJSifnCQveSecSeaaLGw1nKRTv
 vhC68HE4zDi8p8j3aM/r/qJryxOgN1sn3wjhkw2SiMXsiza97RNtRLtjC
 SnbG11dQagADlxof7vKFa5YauLd4l73xakOCzWkqq8WVjt/PwUDw0Me/a
 JjwTuXcyduj5xVDF8wZmvNNskNiebzfrdKkW/NKz+1Lkygcc4LSudGqSW
 6OLMJdL4OLn6+eFgZ5HEpjcaMQh6yg3ltntV1H4fynUlA6Q3CjzIAM6Rc g==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sun, 26 Apr 2020 15:22:08 +0200
Message-ID: <20200426132208.3232-12-horatiu.vultur@microchip.com>
In-Reply-To: <20200426132208.3232-1-horatiu.vultur@microchip.com>
References: <20200426132208.3232-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v4 11/11] net: bridge: Add checks for
	enabling the STP.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

It is not possible to have the MRP and STP running at the same time on the
bridge, therefore add check when enabling the STP to check if MRP is already
enabled. In that case return error.

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_ioctl.c    |  3 +--
 net/bridge/br_netlink.c  |  4 +++-
 net/bridge/br_private.h  |  3 ++-
 net/bridge/br_stp.c      |  6 ++++++
 net/bridge/br_stp_if.c   | 11 ++++++++++-
 net/bridge/br_sysfs_br.c |  4 +---
 6 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index ae22d784b88a..5e71fc8b826f 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -242,8 +242,7 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		if (!ns_capable(dev_net(dev)->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 
-		br_stp_set_enabled(br, args[1]);
-		ret = 0;
+		ret = br_stp_set_enabled(br, args[1], NULL);
 		break;
 
 	case BRCTL_SET_BRIDGE_PRIORITY:
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 1a5e681a626a..a774e19c41bb 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1109,7 +1109,9 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 	if (data[IFLA_BR_STP_STATE]) {
 		u32 stp_enabled = nla_get_u32(data[IFLA_BR_STP_STATE]);
 
-		br_stp_set_enabled(br, stp_enabled);
+		err = br_stp_set_enabled(br, stp_enabled, extack);
+		if (err)
+			return err;
 	}
 
 	if (data[IFLA_BR_PRIORITY]) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 5835828320b6..c35647cb138a 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1283,7 +1283,8 @@ int br_set_ageing_time(struct net_bridge *br, clock_t ageing_time);
 /* br_stp_if.c */
 void br_stp_enable_bridge(struct net_bridge *br);
 void br_stp_disable_bridge(struct net_bridge *br);
-void br_stp_set_enabled(struct net_bridge *br, unsigned long val);
+int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
+		       struct netlink_ext_ack *extack);
 void br_stp_enable_port(struct net_bridge_port *p);
 void br_stp_disable_port(struct net_bridge_port *p);
 bool br_stp_recalculate_bridge_id(struct net_bridge *br);
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index 1f14b8455345..3e88be7aa269 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -36,6 +36,12 @@ void br_set_state(struct net_bridge_port *p, unsigned int state)
 	};
 	int err;
 
+	/* Don't change the state of the ports if they are driven by a different
+	 * protocol.
+	 */
+	if (p->flags & BR_MRP_AWARE)
+		return;
+
 	p->state = state;
 	err = switchdev_port_attr_set(p->dev, &attr);
 	if (err && err != -EOPNOTSUPP)
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index d174d3a566aa..a42850b7eb9a 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -196,10 +196,17 @@ static void br_stp_stop(struct net_bridge *br)
 	br->stp_enabled = BR_NO_STP;
 }
 
-void br_stp_set_enabled(struct net_bridge *br, unsigned long val)
+int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
+		       struct netlink_ext_ack *extack)
 {
 	ASSERT_RTNL();
 
+	if (br_mrp_enabled(br)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "STP can't be enabled if MRP is already enabled\n");
+		return -EINVAL;
+	}
+
 	if (val) {
 		if (br->stp_enabled == BR_NO_STP)
 			br_stp_start(br);
@@ -207,6 +214,8 @@ void br_stp_set_enabled(struct net_bridge *br, unsigned long val)
 		if (br->stp_enabled != BR_NO_STP)
 			br_stp_stop(br);
 	}
+
+	return 0;
 }
 
 /* called under bridge lock */
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 9ab0f00b1081..7db06e3f642a 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -126,9 +126,7 @@ static ssize_t stp_state_show(struct device *d,
 
 static int set_stp_state(struct net_bridge *br, unsigned long val)
 {
-	br_stp_set_enabled(br, val);
-
-	return 0;
+	return br_stp_set_enabled(br, val, NULL);
 }
 
 static ssize_t stp_state_store(struct device *d,
-- 
2.17.1

