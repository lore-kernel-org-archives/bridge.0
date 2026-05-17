Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4B218845
	for <bridge@lists.linux.dev>; Sun, 17 May 2026 04:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778991197; cv=none; b=S8gBsp7tF9sclLMOBaudRwPn3M0+rkpI23itW6CHYbnSu/c8lOGGmeR1Hmm8Zn7IfeU+0yWrzXtXEPJAm4kQLLsPI3tcDh6UegAIF2P1YT8Mj9BLEVRLK12pDDVlbWxgaWzWpUD77e+Z42aGqZBJlwsO3CvUn3QB+LNMW5jRhP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778991197; c=relaxed/simple;
	bh=EkxqBq1ESRrKUlcG4UUERt4H+rUHwmVJkuVcJq7r000=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y7V0l7/iqjJKmcHQQEV2wQcuhIqLdjRO1RC3zKSLiG7KntBHObw0Azd6ubDjA0xZ/d7AgrLP0Nve/ihhXwPjK4gBypyz8CO7Worwf21B8PQtcOJRVb3DNWREwc4g+TUBiXLZWGesvve2INWNOSRjenymK8nQTxdIk+4X/wgCS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0fq1kB8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0fq1kB8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so16291025e9.2
        for <bridge@lists.linux.dev>; Sat, 16 May 2026 21:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778991193; x=1779595993; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RncswSd/3Tv0QOH/vhDuksXZWJ7y0IU0fUj6nDhK3tw=;
        b=e0fq1kB8XZyEYu7EViuxGgVgHkEdM6bwovLhqa9BOtMkqtnpUsJtmbf71zGtO7zJt9
         IkY8LnFX+9C6lY+NqlFCiVAFTdkhN2HjPAfrRETgDKsF9jHQCo5uYvFcJYXFhDWIWiKJ
         EHTeJmnv6DJEuveEgyXyW+53dYDpMzt9eXHa+94rM6noe8pksq2hDOv/3oArVIisIwqD
         UVq2v1uHdz49muqlgEGwF40sD8OQd1eNW+nn+i4ol0dsnG/gpYiWRyJ8RIJE7ZzCf6RQ
         gspn/zh5a+4B8xywgfD7yZDUzIaA2BZsyDbSP27CzVdCd36r6wqOkMNIqxnj9ZtvWYpS
         9/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778991193; x=1779595993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RncswSd/3Tv0QOH/vhDuksXZWJ7y0IU0fUj6nDhK3tw=;
        b=bHyK5ZjWfh2I6vsgAVHNurtSQsk8anN3IQxDkKRRJc1rQs1qGx6+9I4FiMPh+NtoNu
         kDYZI3W9OmeM2wmNRQQ5STsDefhch4MLxMxnjbAi6G4byE9LyowwVkVdgdd2SQCANQx3
         nVp4s5rq/DUlk/N7nFyG1DSH48g4Gnz+U4h5sKnf2gL9Pj+M1sgwpIOrk3BJfs7h++VM
         AeDzTktzQv3CUZG8izfBj7ookJx9YlQ3/69fkkeP/5JoajM5ii3+8XxJBJD8qu0GD89s
         yxI/O//StbCZU0H9BOaL734e4VOFUguu7JpbQMb5lrfTktAHJlNbU4tlRSVUJ1Q2Md8r
         NGPA==
X-Gm-Message-State: AOJu0Ywzv8OUAxH8ShKJeDOTzXNQYejk/CPeI/yGUs2MVfsrZbY0Kqqx
	cEt8+lGkZba2/3uhbn2TsaRpFn+Hd7b/XsfQCuje20BfgI8OwjDgxX00
X-Gm-Gg: Acq92OHYbBR1r4cx7MnSdXE2L8dGR+U0oHllX3X+6pJ6537StGsAc9jfkFuhRFoRevX
	T3m9HDZpEoq5/ug6uTB8RWAATJsq0wppJPZk+Xh4fYyAa4xGfmndayK3aSAwURIor/fCCZPfGPs
	k1Dcn+Y0unbxu31UzI6+M1DjDsOq+dFZIB5vzx2N4imymS2FcbKyLQfQsSIuF/wWGPJHJ/8j/rV
	ACszFs47AJLQy4dOTomdri2Vk9h9WyJcrBO6mby0mLsuDBM/4DmaFacnwWWAyl1VXvKANCDRsor
	JpxPvksFHm+Ne3bqyUaoC8cfGdV3C2iwqDSlW/gvfbZ2fdae1R+OkAdKRFwrJMzqBxIPkSk9i1K
	KRl4bb0UwaX1sZZBKOlPFW3JSB5M9Zrvo4BmBkH/Hj2sHMuMfq+WZawmQsGIrfI5n5iXE4h9Tyw
	9EB8MY30F5ZFdYimbMYGn3LFdqJqfwwuJQ8WwhsmM5gWcmfh/Z9t6uP4jivcz9nRIlWwfzsnLW4
	xhEA4Xf6pPBH96rTDMfTg==
X-Received: by 2002:a05:600c:8906:b0:48a:5501:7995 with SMTP id 5b1f17b1804b1-48fe63270f0mr118668495e9.18.1778991193240;
        Sat, 16 May 2026 21:13:13 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4862209sm170010175e9.0.2026.05.16.21.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 21:13:11 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	andrew@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next v1] net: tpmr: add Two-Port MAC Relay driver
Date: Sun, 17 May 2026 05:13:06 +0100
Message-ID: <20260517041306.24841-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a driver implementing the Two-Port MAC Relay as defined by IEEE
802.1Q-2014 §6.7.1. A TPMR is a minimal L2 relay between exactly two
member ports: no FDB, no MAC learning, no STP, and -- by
specification -- it forwards most of the 01:80:C2:00:00:0X reserved
group address range that a regular bridge would consume. This makes
it suitable as a bump-in-the-wire element that is transparent to the
control plane on both sides (LACP, LLDP, EAPOL, and so on continue
to reach the far end as if the relay were not present).

The driver is created with "ip link add type tpmr" and slaves are
attached through ndo_add_slave, with a hard cap of two members.
Forwarding is implemented as an rx_handler: a frame arriving on one
slave is sent out the other via dev_queue_xmit(), with no FDB
lookup. The IEEE-permitted subset of reserved multicasts is relayed;
the remainder is delivered to the host stack via RX_HANDLER_PASS,
preserving today's behaviour for protocols that genuinely target the
local machine. Only 01:80:C2:00:00:01 (IEEE 802.3x PAUSE) is
terminated, as required by the MAC layer.

The master's carrier follows the logical AND of both slaves'
carriers, propagated via a netdev notifier. Both slaves enter
IFF_PROMISC on enslave (and the refcount is balanced on detach) so
the relay sees all unicast on the wire. rx_handler_register()
provides exclusivity for free: a netdevice that is already a member
of a bridge, bond, team, or macvlan is rejected with -EBUSY at
enslave time.

MTU consistency is enforced at enslave: a second slave whose MTU
differs from the first is rejected. Subsequent member MTU changes
are blocked via NETDEV_PRECHANGEMTU; to change a member's MTU,
detach it first.

Inspired by OpenBSD's tpmr(4) (David Gwynne, 2019), reimplemented
against Linux's rx_handler / rtnl_link_ops infrastructure.

Signed-off-by: David Carlier <devnexen@gmail.com>
---

v1 (from RFC, addressing Andrew Lunn review):
  - Inline reserved-address check; only PAUSE is passed up,
    gated on is_multicast_ether_addr() + unlikely().
  - Fix MTU check that assumed ports[0] is always the
    surviving slot after a detach-then-add sequence;
    iterate ports[] to find the populated entry instead.
  - Reject member MTU changes via NETDEV_PRECHANGEMTU.
  - Drop driver version string; let ethtool core fill it.
  - Keep driver in drivers/net/ (precedent: veth, bonding,
    macvlan).
RFC: https://lore.kernel.org/netdev/20260516050858.23858-2-devnexen@gmail.com/

 drivers/net/Kconfig          |  14 ++
 drivers/net/Makefile         |   1 +
 drivers/net/tpmr.c           | 412 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/if_link.h |   8 +
 4 files changed, 435 insertions(+)
 create mode 100644 drivers/net/tpmr.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ff79c466712d..f23de9f097e8 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -242,6 +242,20 @@ config VXLAN
 	  To compile this driver as a module, choose M here: the module
 	  will be called vxlan.
 
+config TPMR
+        tristate "Two-Port MAC Relay (TPMR) driver"
+        help
+          This driver provides an IEEE 802.1Q-2014 §6.7.1 Two-Port MAC
+          Relay netdevice: a stripped-down L2 relay between exactly two
+          member ports, with no MAC learning, no FDB and no STP. Unlike
+          the bridge driver it forwards the IEEE-reserved
+          01:80:c2:00:00:0x group (LACPDUs, LLDP, EAPOL/802.1X, ...),
+          which makes it suitable as a transparent bump-in-the-wire in
+          deployments using link aggregation, MACsec, or 802.1X.
+
+          To compile this driver as a module, choose M here: the module
+          will be called tpmr.
+
 config GENEVE
 	tristate "Generic Network Virtualization Encapsulation"
 	depends on INET
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 88e4c485d6b2..9e9c84614b09 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_TUN) += tun.o
 obj-$(CONFIG_TAP) += tap.o
 obj-$(CONFIG_VETH) += veth.o
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
+obj-$(CONFIG_TPMR) += tpmr.o
 obj-$(CONFIG_VXLAN) += vxlan/
 obj-$(CONFIG_GENEVE) += geneve.o
 obj-$(CONFIG_BAREUDP) += bareudp.o
diff --git a/drivers/net/tpmr.c b/drivers/net/tpmr.c
new file mode 100644
index 000000000000..6af1e12d7363
--- /dev/null
+++ b/drivers/net/tpmr.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * IEEE 802.1Q-2014 §6.7.1 Two-Port MAC Relay driver
+ *
+ * A TPMR is a minimal L2 relay between exactly two member ports: no FDB,
+ * no MAC learning, no STP. Frames received on one member are forwarded
+ * unconditionally out the other, including the IEEE-reserved
+ * 01:80:c2:00:00:0x group (LACPDUs, LLDP, EAPOL, ...) except for
+ * 01:80:c2:00:00:01 (PAUSE), which is MAC-terminated by spec.
+ *
+ * Inspired by OpenBSD's tpmr(4) (dlg@, 2019), reimplemented against
+ * Linux's rx_handler / rtnl_link_ops infrastructure.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/if_arp.h>
+#include <linux/if_link.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
+#include <linux/u64_stats_sync.h>
+#include <net/rtnetlink.h>
+
+#define TPMR_DRV_NAME         "tpmr"
+#define TPMR_MAX_PORTS                2
+
+struct tpmr_priv;
+
+struct tpmr_port {
+	struct net_device __rcu         *dev;
+	struct tpmr_priv                *tpmr;
+	unsigned int                    slot; /* valid when dev != NULL */
+};
+
+struct tpmr_priv {
+	struct net_device               *dev;
+	struct tpmr_port                ports[TPMR_MAX_PORTS];
+	unsigned int                    n_ports;
+};
+
+static const struct net_device_ops tpmr_netdev_ops;
+static struct rtnl_link_ops tpmr_link_ops __read_mostly;
+static int tpmr_device_event(struct notifier_block *nb,
+			     unsigned long event, void *ptr);
+
+static struct notifier_block tpmr_notifier_block __read_mostly = {
+	.notifier_call = tpmr_device_event,
+};
+
+static rx_handler_result_t tpmr_handle_frame(struct sk_buff **pskb)
+{
+	struct sk_buff *skb = *pskb;
+	struct net_device *peer_dev;
+	struct tpmr_port *p;
+	struct ethhdr *eh;
+	unsigned int len;
+
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (unlikely(!skb))
+		return RX_HANDLER_CONSUMED;
+	*pskb = skb;
+
+	p = rcu_dereference(skb->dev->rx_handler_data);
+	if (unlikely(!p))
+		return RX_HANDLER_PASS;
+
+	peer_dev = rcu_dereference(p->tpmr->ports[!p->slot].dev);
+	if (!peer_dev || !netif_running(peer_dev) ||
+	    !netif_carrier_ok(peer_dev))
+		goto drop;
+
+	/* IEEE 802.1Q-2014 §8.6.3 Table 8-1: a TPMR forwards every reserved
+	 * 01:80:c2:00:00:0x address (LACPDU 02, 802.1X 03, LLDP 0e, ...)
+	 * except 01:80:c2:00:00:01 (IEEE 802.3x PAUSE), which is
+	 * MAC-terminated by spec. PAUSE is normally consumed by the NIC MAC
+	 * before reaching us; pass it up defensively if it slips through.
+	 */
+	eh = eth_hdr(skb);
+	if (unlikely(is_multicast_ether_addr(eh->h_dest))) {
+		static const u8 pause_mac[ETH_ALEN] __aligned(2) = {
+			0x01, 0x80, 0xc2, 0x00, 0x00, 0x01
+		};
+
+		if (ether_addr_equal(eh->h_dest, pause_mac))
+			return RX_HANDLER_PASS;
+	}
+
+	/* eth_type_trans() pulled the L2 header on receive; push it back
+	 * before dev_queue_xmit().
+	 */
+	skb_push(skb, ETH_HLEN);
+	skb->dev = peer_dev;
+
+	len = skb->len;
+	dev_sw_netstats_rx_add(p->tpmr->dev, len);
+
+	if (dev_queue_xmit(skb) == NET_XMIT_SUCCESS)
+		dev_sw_netstats_tx_add(p->tpmr->dev, 1, len);
+
+	return RX_HANDLER_CONSUMED;
+
+drop:
+	kfree_skb(skb);
+	return RX_HANDLER_CONSUMED;
+}
+
+/* Master carrier is the logical AND of both slaves' carriers, and we only
+ * advertise it when both slots are populated. Called with RTNL held.
+ */
+static void tpmr_update_carrier(struct tpmr_priv *tpmr)
+{
+	struct net_device *a, *b;
+	bool up;
+
+	ASSERT_RTNL();
+
+	a = rtnl_dereference(tpmr->ports[0].dev);
+	b = rtnl_dereference(tpmr->ports[1].dev);
+
+	up = a && b && netif_carrier_ok(a) && netif_carrier_ok(b);
+
+	if (up)
+		netif_carrier_on(tpmr->dev);
+	else
+		netif_carrier_off(tpmr->dev);
+}
+
+static int tpmr_add_slave(struct net_device *dev, struct net_device *slave_dev,
+			  struct netlink_ext_ack *extack)
+{
+	struct tpmr_priv *tpmr = netdev_priv(dev);
+	struct tpmr_port *port = NULL;
+	unsigned int slot;
+	int err;
+
+	ASSERT_RTNL();
+
+	if (slave_dev->type != ARPHRD_ETHER) {
+		NL_SET_ERR_MSG(extack, "Only Ethernet devices can be TPMR members");
+		return -EINVAL;
+	}
+	if (slave_dev->flags & IFF_LOOPBACK) {
+		NL_SET_ERR_MSG(extack, "Loopback cannot be a TPMR member");
+		return -EINVAL;
+	}
+	if (netdev_is_rx_handler_busy(slave_dev)) {
+		NL_SET_ERR_MSG(extack,
+			       "Device already has an rx_handler (bridge/bond/etc.)");
+		return -EBUSY;
+	}
+	if (tpmr->n_ports >= TPMR_MAX_PORTS) {
+		NL_SET_ERR_MSG(extack, "TPMR already has two members");
+		return -EBUSY;
+	}
+
+	/* Enforce MTU consistency between the two members. */
+	if (tpmr->n_ports == 1) {
+		struct net_device *first = NULL;
+		unsigned int i;
+
+		for (i = 0; i < TPMR_MAX_PORTS; i++) {
+			first = rtnl_dereference(tpmr->ports[i].dev);
+			if (first)
+				break;
+		}
+		if (first && first->mtu != slave_dev->mtu) {
+			NL_SET_ERR_MSG(extack,
+				       "Member MTU must match the other member's");
+			return -EINVAL;
+		}
+	}
+
+	for (slot = 0; slot < TPMR_MAX_PORTS; slot++) {
+		if (!rtnl_dereference(tpmr->ports[slot].dev)) {
+			port = &tpmr->ports[slot];
+			break;
+		}
+	}
+	if (!port)
+		return -EBUSY;  /* should not happen given n_ports check */
+
+	port->tpmr = tpmr;
+	port->slot = slot;
+
+	err = dev_set_promiscuity(slave_dev, 1);
+	if (err)
+		return err;
+
+	err = netdev_master_upper_dev_link(slave_dev, dev, NULL, NULL, extack);
+	if (err)
+		goto err_promisc;
+
+	err = netdev_rx_handler_register(slave_dev, tpmr_handle_frame, port);
+	if (err)
+		goto err_upper;
+
+	rcu_assign_pointer(port->dev, slave_dev);
+	tpmr->n_ports++;
+
+	/* Match dev->mtu to the members once a first one attaches. */
+	if (tpmr->n_ports == 1)
+		dev->mtu = slave_dev->mtu;
+
+	tpmr_update_carrier(tpmr);
+	return 0;
+
+err_upper:
+	netdev_upper_dev_unlink(slave_dev, dev);
+err_promisc:
+	dev_set_promiscuity(slave_dev, -1);
+	return err;
+}
+
+static int tpmr_del_slave(struct net_device *dev, struct net_device *slave_dev)
+{
+	struct tpmr_priv *tpmr = netdev_priv(dev);
+	struct tpmr_port *port = NULL;
+	unsigned int slot;
+
+	ASSERT_RTNL();
+
+	for (slot = 0; slot < TPMR_MAX_PORTS; slot++) {
+		if (rtnl_dereference(tpmr->ports[slot].dev) == slave_dev) {
+			port = &tpmr->ports[slot];
+			break;
+		}
+	}
+	if (!port)
+		return -ENOENT;
+
+	netdev_rx_handler_unregister(slave_dev);
+	RCU_INIT_POINTER(port->dev, NULL);
+	netdev_upper_dev_unlink(slave_dev, dev);
+	dev_set_promiscuity(slave_dev, -1);
+
+	tpmr->n_ports--;
+	tpmr_update_carrier(tpmr);
+	return 0;
+}
+
+static int tpmr_device_event(struct notifier_block *nb,
+			     unsigned long event, void *ptr)
+{
+	struct net_device *slave_dev = netdev_notifier_info_to_dev(ptr);
+	struct net_device *master;
+	struct tpmr_priv *tpmr;
+
+	if (slave_dev->reg_state == NETREG_REGISTERED) {
+		master = netdev_master_upper_dev_get(slave_dev);
+		if (!master || master->rtnl_link_ops != &tpmr_link_ops)
+			return NOTIFY_DONE;
+	} else {
+		return NOTIFY_DONE;
+	}
+
+	tpmr = netdev_priv(master);
+
+	switch (event) {
+	case NETDEV_CHANGE:
+	case NETDEV_UP:
+	case NETDEV_DOWN:
+		tpmr_update_carrier(tpmr);
+		break;
+	case NETDEV_UNREGISTER:
+		tpmr_del_slave(master, slave_dev);
+		break;
+	case NETDEV_PRECHANGEMTU:
+		/* TPMR requires equal MTU on both members. Block per-member
+		 * MTU changes; users should detach, change, and reattach.
+		 */
+		return notifier_from_errno(-EBUSY);
+	}
+	return NOTIFY_DONE;
+}
+
+static netdev_tx_t tpmr_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	/* Master itself doesn't transmit; frames enter via slave rx and
+	 * exit via the peer slave's tx. Drop and count.
+	 */
+	kfree_skb(skb);
+	dev_core_stats_tx_dropped_inc(dev);
+	return NETDEV_TX_OK;
+}
+
+static void tpmr_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *drvinfo)
+{
+	strscpy(drvinfo->driver, TPMR_DRV_NAME, sizeof(drvinfo->driver));
+}
+
+static const struct ethtool_ops tpmr_ethtool_ops = {
+	.get_drvinfo    = tpmr_get_drvinfo,
+	.get_link       = ethtool_op_get_link,
+};
+
+static void tpmr_setup(struct net_device *dev)
+{
+	ether_setup(dev);
+
+	dev->netdev_ops         = &tpmr_netdev_ops;
+	dev->ethtool_ops        = &tpmr_ethtool_ops;
+	dev->needs_free_netdev  = true;
+
+	/* No qdisc/queue on the master — we never xmit through it. */
+	dev->priv_flags         |= IFF_NO_QUEUE;
+	dev->priv_flags         |= IFF_NO_RX_HANDLER;
+
+	/* Cosmetic: a relay is not a multicast endpoint of its own. */
+	dev->flags              &= ~IFF_MULTICAST;
+
+	dev->lltx               = true;
+	dev->hw_features        = 0;
+
+	eth_hw_addr_random(dev);
+}
+
+static int tpmr_newlink(struct net_device *dev,
+			struct rtnl_newlink_params *params,
+		struct netlink_ext_ack *extack)
+{
+	struct tpmr_priv *tpmr = netdev_priv(dev);
+
+	tpmr->dev = dev;
+	tpmr->n_ports = 0;
+
+	return register_netdevice(dev);
+}
+
+static const struct nla_policy tpmr_policy[IFLA_TPMR_MAX + 1] = {
+	/* reserved for future per-instance flags */
+};
+
+static int __init tpmr_module_init(void)
+{
+	int err;
+
+	err = register_netdevice_notifier(&tpmr_notifier_block);
+	if (err)
+		return err;
+
+	err = rtnl_link_register(&tpmr_link_ops);
+	if (err)
+		unregister_netdevice_notifier(&tpmr_notifier_block);
+	return err;
+}
+
+static void __exit tpmr_module_exit(void)
+{
+	rtnl_link_unregister(&tpmr_link_ops);
+	unregister_netdevice_notifier(&tpmr_notifier_block);
+}
+
+static int tpmr_dev_init(struct net_device *dev)
+{
+	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!dev->tstats)
+		return -ENOMEM;
+	return 0;
+}
+
+static void tpmr_dev_uninit(struct net_device *dev)
+{
+	free_percpu(dev->tstats);
+}
+
+static void tpmr_dellink(struct net_device *dev, struct list_head *head)
+{
+	struct tpmr_priv *tpmr = netdev_priv(dev);
+	unsigned int slot;
+
+	for (slot = 0; slot < TPMR_MAX_PORTS; slot++) {
+		struct net_device *slave = rtnl_dereference(tpmr->ports[slot].dev);
+
+		if (slave)
+			tpmr_del_slave(dev, slave);
+	}
+	unregister_netdevice_queue(dev, head);
+}
+
+static struct rtnl_link_ops tpmr_link_ops __read_mostly = {
+	.kind           = TPMR_DRV_NAME,
+	.priv_size      = sizeof(struct tpmr_priv),
+	.setup          = tpmr_setup,
+	.newlink        = tpmr_newlink,
+	.dellink        = tpmr_dellink,
+	.policy         = tpmr_policy,
+	.maxtype        = IFLA_TPMR_MAX,
+};
+
+static const struct net_device_ops tpmr_netdev_ops = {
+	.ndo_init               = tpmr_dev_init,
+	.ndo_uninit             = tpmr_dev_uninit,
+	.ndo_start_xmit         = tpmr_start_xmit,
+	.ndo_get_stats64        = dev_get_tstats64,
+	.ndo_add_slave          = tpmr_add_slave,
+	.ndo_del_slave          = tpmr_del_slave,
+	.ndo_set_mac_address    = eth_mac_addr,
+	.ndo_validate_addr      = eth_validate_addr,
+};
+
+module_init(tpmr_module_init);
+module_exit(tpmr_module_exit);
+
+MODULE_AUTHOR("David Carlier <devnexen@gmail.com>");
+MODULE_DESCRIPTION("IEEE 802.1Q Two-Port MAC Relay (TPMR) driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_RTNL_LINK(TPMR_DRV_NAME);
+
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 46413392b402..98241bfcb6c7 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -456,6 +456,14 @@ enum {
 
 #define IFLA_INET6_MAX	(__IFLA_INET6_MAX - 1)
 
+/* TPMR section */
+enum {
+	IFLA_TPMR_UNSPEC,
+	__IFLA_TPMR_MAX,
+};
+
+#define IFLA_TPMR_MAX (__IFLA_TPMR_MAX - 1)
+
 enum in6_addr_gen_mode {
 	IN6_ADDR_GEN_MODE_EUI64,
 	IN6_ADDR_GEN_MODE_NONE,
-- 
2.53.0

