Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A3E6884404
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E83E2843FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=XwRURR16o8IU6+jA9ItEJoRw2ePOvsnk2WOjALj1ZLc=;
 b=DR6GSoqK3SF1nT3MGrQtB/w9LqHLwFXcSX8bTXMJdecy6L4PTdYMHDmY60jhjLZjgR
 obsBHNDbljWwVIZ3qfIZ5cQtuLxZGJNXHdL+27mtzzC0UYujs4U2ZU+GAr1RXbfd+A1m
 1K/Byn2FoZ+PdItsh+lgCLBB0UlUAgj6vVnxXaWUysi6ZzofsFtL0/iCZhFHgrU5miWU
 NkMoIEHbrcOXCM4f16+mhM0MyszJl4Db/ywTI4U3msepTQwWoo+obpNDdaIgEKZbdg0/
 wRbSgOp8mpS7ZlqHgsTc40AqiiIGYYPP7WqQQrE3/sGDCxFn2g10x/tCYlSvb//kKk/1
 oD8A==
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Sat, 17 Sep 2022 16:17:58 -0400
Message-Id: <31aa2b6c1eb53812abeaf75f8c01017713eb3cbf.1663445339.git.sevinj.aghayeva@gmail.com>
In-Reply-To: <cover.1663445339.git.sevinj.aghayeva@gmail.com>
References: <cover.1663445339.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 2/5] net: core: introduce a new
	notifier for link-type-specific changes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: aroulin@nvidia.com, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, Sevinj Aghayeva <sevinj.aghayeva@gmail.com>, roopa@nvidia.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

The netdev notification subsystem is lacking a generic notifier than
can pass link-type-specific information alongside the device. For
example, the VLAN subsystem needs to notify the bridge of a change in
the VLAN bridge brinding flag. This flag change might result in the
bridge setting VLAN devices UP or DOWN depending on the state of the
bridge ports.

Instead of introducing one new NETDEV_* notification just for this
specific use-case, introduce a generic notifier which can pass
link-type specific information. The notification’s target can decode
the union type by checking the type of the target device.  That way,
other link types will be able to reuse this notification type to
notify with their own specific link specific struct. As this
notification is only for internal use, there’s no need to export it to
userspace.

Other NETDEV_* notifiers have also been looked at to see if it is
possible to consolidate:

 * NETDEV_CHANGEINFODATA: this notification needs to be sent to
   userspace; keep it separate from NETDEV_CHANGE_DETAILS.
 * NETDEV_CHANGE: this is to notify net_device->flags change; it is
   not link-type specific.

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 include/linux/if_vlan.h       |  4 ++++
 include/linux/netdevice.h     |  1 +
 include/linux/notifier_info.h | 21 +++++++++++++++++++++
 net/core/dev.c                |  2 +-
 4 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/notifier_info.h

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index e00c4ee81ff7..38ffd2ee5112 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -37,6 +37,10 @@ struct vlan_hdr {
 	__be16	h_vlan_encapsulated_proto;
 };
 
+struct vlan_change_details {
+	bool bridge_binding;
+};
+
 /**
  *	struct vlan_ethhdr - vlan ethernet header (ethhdr + vlan_hdr)
  *	@h_dest: destination ethernet address
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 56b96b1e4c4c..912c04b09ebb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2770,6 +2770,7 @@ enum netdev_cmd {
 	NETDEV_UNREGISTER,
 	NETDEV_CHANGEMTU,	/* notify after mtu change happened */
 	NETDEV_CHANGEADDR,	/* notify after the address change */
+	NETDEV_CHANGE_DETAILS,
 	NETDEV_PRE_CHANGEADDR,	/* notify before the address change */
 	NETDEV_GOING_DOWN,
 	NETDEV_CHANGENAME,
diff --git a/include/linux/notifier_info.h b/include/linux/notifier_info.h
new file mode 100644
index 000000000000..3e53f18c6da1
--- /dev/null
+++ b/include/linux/notifier_info.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_NOTIFIER_INFO_H_
+#define _LINUX_NOTIFIER_INFO_H_
+
+#include <linux/netdevice.h>
+#include <linux/if_vlan.h>
+
+/*
+ * This struct is used for passing link-type-specific information to
+ * the device.
+ */
+
+struct netdev_notifier_change_details_info {
+	struct netdev_notifier_info info; /* must be first */
+	union {
+		struct vlan_change_details vlan;
+	};
+};
+
+#endif /* !(_LINUX_NOTIFIER_INFO_H_) */
diff --git a/net/core/dev.c b/net/core/dev.c
index e233145d1452..b50470378994 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1622,7 +1622,7 @@ const char *netdev_cmd_to_name(enum netdev_cmd cmd)
 	N(POST_INIT) N(RELEASE) N(NOTIFY_PEERS) N(JOIN) N(CHANGEUPPER)
 	N(RESEND_IGMP) N(PRECHANGEMTU) N(CHANGEINFODATA) N(BONDING_INFO)
 	N(PRECHANGEUPPER) N(CHANGELOWERSTATE) N(UDP_TUNNEL_PUSH_INFO)
-	N(UDP_TUNNEL_DROP_INFO) N(CHANGE_TX_QUEUE_LEN)
+	N(UDP_TUNNEL_DROP_INFO) N(CHANGE_TX_QUEUE_LEN) N(CHANGE_DETAILS)
 	N(CVLAN_FILTER_PUSH_INFO) N(CVLAN_FILTER_DROP_INFO)
 	N(SVLAN_FILTER_PUSH_INFO) N(SVLAN_FILTER_DROP_INFO)
 	N(PRE_CHANGEADDR) N(OFFLOAD_XSTATS_ENABLE) N(OFFLOAD_XSTATS_DISABLE)
-- 
2.34.1

