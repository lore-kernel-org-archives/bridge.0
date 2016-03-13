Return-Path: <xerofoify@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=70M0vmcfZYlkkvdGVOqQO6dgjXZT62DHRgFSkX4RPJI=;
	b=T7T+kuXYL4wCKuwB0MjDQcpCBjaaQiY+1+UkNYBjjVuysh5mxaUOqQJYjE4U8e5706
	qn31byl+BHMpYsDqpDNGGQCENOW23SVWx/cH+eRseTeON7dwsdCmEBk6cgyoESIpe+7b
	aXP6AGQGkce79UMna1M4oJacoqEM4X7Y++XZt1RCGtEyvV752oykkx98tV6SH6xKJ0T8
	AGw0t7B7DjvwEHKeWwyoGs2UJo0TgJLo3oYGxg8y7dF3awQhCHHnFDAxP/iNRMgN37FP
	h94TbZcBzL2HpDg54NgmBcrrrqi8+FNm3i5D+Z03gE166tGkjPBlWSNSSfFV7vRIeZE/
	S1Sw==
From: Nicholas Krause <xerofoify@gmail.com>
Date: Sat, 12 Mar 2016 21:46:09 -0500
Message-Id: <1457837169-20265-1-git-send-email-xerofoify@gmail.com>
Subject: [Bridge] [PATCH] bridge:Fix incorrect variable assignment on error
	path in br_sysfs_addbr
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, linux-kernel@vger.kernel.org

This fixes the incorrect variable assignment on error path in
br_sysfs_addbr for when the call to kobject_create_and_add
fails to assign the value of -EINVAL to the returned variable of
err rather then incorrectly return zero making callers think this
function has succeededed due to the previous assignment being
assigned zero when assigning it the successful return value of
the call to sysfs_create_group which is zero.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bridge/br_sysfs_br.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 6b80914..6833d25 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -872,6 +872,7 @@ int br_sysfs_addbr(struct net_device *dev)
 	if (!br->ifobj) {
 		pr_info("%s: can't add kobject (directory) %s/%s\n",
 			__func__, dev->name, SYSFS_BRIDGE_PORT_SUBDIR);
+		err = -EINVAL;
 		goto out3;
 	}
 	return 0;
-- 
2.5.0

