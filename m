Date: Mon, 11 Sep 2006 10:49:28 -0700
From: David Kimdon <david.kimdon@devicescape.com>
Message-ID: <20060911174928.GA3451@devicescape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] RFC: [PATCH] bridge vlan integration
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

The attached patches enables the bridge to filter and forward packets
according to their IEEE 802.1q headers.  The goals behind this change
include :

- Enable running STP on 802.1q tagged networks.  STP packets
  must be untagged.  It isn't obvious how else to enable STP
  with the current bridge and vlan code.
- Add native support for an untagged vlan.  Currently an untagged
  vlan can be implimented using ebtables or similar.
- On devices bridging a large number of interfaces across various
  vlans this significantly simplifies configuration and, depending on
  configuration, can improve performance.

Comments appreciated,

David

From: Simon Barber <simon@devicescape.com>

Signed-off-by: Simon Barber <simon@devicescape.com>
Signed-off-by: David Kimdon <david.kimdon@devicescape.com>

Index: wireless-dev/include/linux/if_bridge.h
===================================================================
--- wireless-dev.orig/include/linux/if_bridge.h
+++ wireless-dev/include/linux/if_bridge.h
@@ -44,6 +44,10 @@
 #define BRCTL_SET_PORT_PRIORITY 16
 #define BRCTL_SET_PATH_COST 17
 #define BRCTL_GET_FDB_ENTRIES 18
+#define BRCTL_SET_PORT_UNTAGGED_VLAN 19
+#define BRCTL_ADD_PORT_VLAN 20
+#define BRCTL_DEL_PORT_VLAN 21
+#define BRCTL_GET_PORT_VLAN_INFO 22
 
 #define BR_STATE_DISABLED 0
 #define BR_STATE_LISTENING 1
@@ -91,6 +95,12 @@ struct __port_info
 	__u32 hold_timer_value;
 };
 
+struct __vlan_info
+{
+	__u32 untagged;
+	__u8 filter[4096/8];
+};
+
 struct __fdb_entry
 {
 	__u8 mac_addr[6];
Index: wireless-dev/include/linux/skbuff.h
===================================================================
--- wireless-dev.orig/include/linux/skbuff.h
+++ wireless-dev/include/linux/skbuff.h
@@ -296,6 +296,9 @@ struct sk_buff {
 #endif
 	__u32			nfmark;
 #endif /* CONFIG_NETFILTER */
+#ifdef CONFIG_BRIDGE_VLAN
+	unsigned int 		vlan;
+#endif
 #ifdef CONFIG_NET_SCHED
 	__u16			tc_index;	/* traffic control index */
 #ifdef CONFIG_NET_CLS_ACT
Index: wireless-dev/net/bridge/br_forward.c
===================================================================
--- wireless-dev.orig/net/bridge/br_forward.c
+++ wireless-dev/net/bridge/br_forward.c
@@ -24,7 +24,16 @@
 static inline int should_deliver(const struct net_bridge_port *p, 
 				 const struct sk_buff *skb)
 {
-	return (skb->dev != p->dev && p->state == BR_STATE_FORWARDING);
+	if (skb->dev == p->dev ||
+	    p->state != BR_STATE_FORWARDING)
+		return 0;
+
+#ifdef CONFIG_BRIDGE_VLAN
+	if (skb->vlan && br_vlan_filter(skb, &p->vlan))
+		return 0;
+#endif
+
+	return 1;
 }
 
 static inline unsigned packet_length(const struct sk_buff *skb)
@@ -47,6 +56,10 @@ int br_dev_queue_push_xmit(struct sk_buf
 		{
 			skb_push(skb, ETH_HLEN);
 
+	 		if (br_vlan_output_frame(&skb,
+ 						 skb->dev->br_port->vlan.untagged))
+ 				return 0;
+
 			dev_queue_xmit(skb);
 		}
 	}
Index: wireless-dev/net/bridge/br_if.c
===================================================================
--- wireless-dev.orig/net/bridge/br_if.c
+++ wireless-dev/net/bridge/br_if.c
@@ -227,6 +227,7 @@ static struct net_device *new_bridge_dev
 	INIT_LIST_HEAD(&br->age_list);
 
 	br_stp_timer_init(br);
+	br_vlan_init(&br->vlan);
 
 	return dev;
 }
@@ -278,6 +279,7 @@ static struct net_bridge_port *new_nbp(s
 	p->state = BR_STATE_DISABLED;
 	INIT_WORK(&p->carrier_check, port_carrier_check, dev);
 	br_stp_port_timer_init(p);
+	br_vlan_init(&p->vlan);
 
 	kobject_init(&p->kobj);
 	kobject_set_name(&p->kobj, SYSFS_BRIDGE_PORT_ATTR);
Index: wireless-dev/net/bridge/br_input.c
===================================================================
--- wireless-dev.orig/net/bridge/br_input.c
+++ wireless-dev/net/bridge/br_input.c
@@ -26,12 +26,20 @@ static void br_pass_frame_up(struct net_
 {
 	struct net_device *indev;
 
+	if (br_vlan_filter(skb, &br->vlan)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	br->statistics.rx_packets++;
 	br->statistics.rx_bytes += skb->len;
 
 	indev = skb->dev;
 	skb->dev = br->dev;
 
+	if (br_vlan_output_frame(&skb, br->vlan.untagged))
+		return;
+
 	NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, indev, NULL,
 		netif_receive_skb);
 }
@@ -136,6 +144,10 @@ int br_handle_frame(struct net_bridge_po
 	}
 
 	if (p->state == BR_STATE_FORWARDING || p->state == BR_STATE_LEARNING) {
+		if (br_vlan_input_frame(skb, &p->vlan)) {
+			return 1;
+		}
+
 		if (br_should_route_hook) {
 			if (br_should_route_hook(pskb)) 
 				return 0;
Index: wireless-dev/net/bridge/br_ioctl.c
===================================================================
--- wireless-dev.orig/net/bridge/br_ioctl.c
+++ wireless-dev/net/bridge/br_ioctl.c
@@ -302,6 +302,18 @@ static int old_dev_ioctl(struct net_devi
 	case BRCTL_GET_FDB_ENTRIES:
 		return get_fdb_entries(br, (void __user *)args[1], 
 				       args[2], args[3]);
+
+#ifdef CONFIG_BRIDGE_VLAN
+	case BRCTL_SET_PORT_UNTAGGED_VLAN:
+		return br_vlan_set_untagged(br, args[1], args[2]);
+
+	case BRCTL_ADD_PORT_VLAN:
+	case BRCTL_DEL_PORT_VLAN:
+		return br_vlan_set_filter(br, args[0], args[1], args[2]);
+
+	case BRCTL_GET_PORT_VLAN_INFO:
+		return br_vlan_get_info(br, (void *)args[1], args[2]);
+#endif
 	}
 
 	return -EOPNOTSUPP;
Index: wireless-dev/net/bridge/br_private.h
===================================================================
--- wireless-dev.orig/net/bridge/br_private.h
+++ wireless-dev/net/bridge/br_private.h
@@ -59,6 +59,14 @@ struct net_bridge_fdb_entry
 	unsigned char			is_static;
 };
 
+#ifdef CONFIG_BRIDGE_VLAN
+struct net_bridge_port_vlan
+{
+	int				untagged;
+	u8				filter[4096/8];
+};
+#endif
+
 struct net_bridge_port
 {
 	struct net_bridge		*br;
@@ -84,6 +92,9 @@ struct net_bridge_port
 	struct kobject			kobj;
 	struct work_struct		carrier_check;
 	struct rcu_head			rcu;
+#ifdef CONFIG_BRIDGE_VLAN
+	struct net_bridge_port_vlan 	vlan;
+#endif
 };
 
 struct net_bridge
@@ -96,6 +107,9 @@ struct net_bridge
 	struct hlist_head		hash[BR_HASH_SIZE];
 	struct list_head		age_list;
 	unsigned long			feature_mask;
+#ifdef CONFIG_BRIDGE_VLAN
+	struct net_bridge_port_vlan 	vlan;
+#endif
 
 	/* STP */
 	bridge_id			designated_root;
@@ -258,4 +272,32 @@ extern void br_sysfs_delbr(struct net_de
 #define br_sysfs_delbr(dev)	do { } while(0)
 #endif /* CONFIG_SYSFS */
 
+#ifdef CONFIG_BRIDGE_VLAN
+#include <linux/if_vlan.h>
+
+static inline int br_vlan_filter(const struct sk_buff *skb,
+				 const struct net_bridge_port_vlan *vlan)
+{
+	return !(vlan->filter[skb->vlan / 8] & (1 << (skb->vlan & 7)));
+}
+
+/* br_vlan.c */
+extern int br_vlan_input_frame(struct sk_buff *skb,
+			       struct net_bridge_port_vlan *vlan);
+extern int br_vlan_output_frame(struct sk_buff **pskb, unsigned int untagged);
+extern void br_vlan_init(struct net_bridge_port_vlan *vlan);
+extern int br_vlan_set_untagged(struct net_bridge *br,
+				unsigned int port, unsigned int vid);
+extern int br_vlan_set_filter(struct net_bridge *br,
+			      unsigned int cmd,
+			      unsigned int port, unsigned int vid);
+extern int br_vlan_get_info(struct net_bridge *br,
+			    void *user_mem, unsigned long port);
+#else
+
+#define br_vlan_filter(skb, vlan)		(0)
+#define br_vlan_input_frame(skb, vlan)		(0)
+#define br_vlan_output_frame(pskb, untagged)	(0)
+#define br_vlan_init(vlan)			do { } while(0)
+#endif /* CONFIG_BRIDGE_VLAN */
 #endif
Index: wireless-dev/net/bridge/br_vlan.c
===================================================================
--- /dev/null
+++ wireless-dev/net/bridge/br_vlan.c
@@ -0,0 +1,203 @@
+/*
+ *	VLAN support
+ *	Linux ethernet bridge
+ *
+ *	Authors:
+ *	Simon Barber			<simon@devicescape.com>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/inetdevice.h>
+#include <linux/skbuff.h>
+#include <linux/if_bridge.h>
+#include <linux/netfilter_bridge.h>
+#include <asm/uaccess.h>
+#include "br_private.h"
+
+int br_vlan_input_frame(struct sk_buff *skb, struct net_bridge_port_vlan *vlan)
+{
+	if (skb->protocol != htons(ETH_P_8021Q)) {
+		skb->vlan = vlan->untagged;
+	} else {
+		struct vlan_ethhdr *vhdr = (struct vlan_ethhdr *)(skb->mac.raw);
+		unsigned short vlan_TCI = ntohs(vhdr->h_vlan_TCI);
+		unsigned short vid = (vlan_TCI & VLAN_VID_MASK);
+
+		skb->vlan = vid ? vid : vlan->untagged;
+	}
+
+	if (skb->vlan == 0)
+		goto err;
+
+	if (br_vlan_filter(skb, vlan))
+		goto err;
+
+	return 0;
+
+err:
+	kfree_skb(skb);
+	return 1;
+}
+
+int br_vlan_output_frame(struct sk_buff **pskb, unsigned int untagged)
+{
+	struct sk_buff *skb = *pskb;
+
+	if (skb->vlan == 0)	/* don't touch the frame */
+		return 0;
+
+	if (skb->vlan == untagged) {
+		/* frame should be untagged */
+		if (eth_hdr(skb)->h_proto == htons(ETH_P_8021Q)) {
+			/* remove VLAN tag */
+			if (skb_cloned(skb) || skb_shared(skb)) {
+				struct sk_buff *new_skb;
+
+				new_skb = skb_copy(skb, GFP_ATOMIC);
+				kfree_skb(skb);
+				if (!new_skb)
+					return 1;
+				*pskb = skb = new_skb;
+			}
+
+			skb->mac.raw += VLAN_HLEN;
+			memmove(skb->mac.raw, skb->data, ETH_ALEN * 2);
+			skb_pull(skb, VLAN_HLEN);
+		}
+	} else {
+		/* frame should be tagged */
+		if (eth_hdr(skb)->h_proto != htons(ETH_P_8021Q)) {
+			/* add VLAN tag */
+			struct vlan_ethhdr *vhdr;
+			if (skb_cloned(skb) || skb_shared(skb)) {
+				struct sk_buff *new_skb;
+
+				new_skb = skb_copy(skb, GFP_ATOMIC);
+				kfree_skb(skb);
+				if (!new_skb)
+					return 1;
+				*pskb = skb = new_skb;
+			}
+
+			if (skb_headroom(skb) < VLAN_HLEN) {
+				if (pskb_expand_head(skb, VLAN_HLEN, 0,
+						     GFP_ATOMIC)) {
+					kfree_skb(skb);
+					return 1;
+				}
+			}
+
+			skb_push(skb, VLAN_HLEN);
+
+			skb->mac.raw -= VLAN_HLEN;
+			memmove(skb->mac.raw, skb->mac.raw + VLAN_HLEN,
+				ETH_ALEN * 2);
+			vhdr = (struct vlan_ethhdr *)skb->mac.raw;
+			vhdr->h_vlan_proto = htons(ETH_P_8021Q);
+			vhdr->h_vlan_TCI = htons(skb->vlan);
+		} else {
+			/* ensure VID is correct */
+			struct vlan_ethhdr *vhdr =
+				(struct vlan_ethhdr *)skb->mac.raw;
+			vhdr->h_vlan_TCI = (vhdr->h_vlan_TCI & htons(~VLAN_VID_MASK)) |
+					    htons(skb->vlan);
+		}
+		// TODO: set priority in tag correctly
+	}
+
+	return 0;
+}
+
+void br_vlan_init(struct net_bridge_port_vlan *vlan)
+{
+	vlan->untagged = 1;
+	vlan->filter[0] = 1 << 1;
+}
+
+/* ioctl functions */
+int br_vlan_set_untagged(struct net_bridge *br,
+			 unsigned int port, unsigned int vid)
+{
+	struct net_bridge_port_vlan *vlan;
+
+	if (vid > 4094)
+		return -EINVAL;
+
+	if (port) {
+		struct net_bridge_port *p = br_get_port(br, port);
+
+		if (p == NULL)
+			return -EINVAL;
+		vlan = &p->vlan;
+	} else {
+		vlan = &br->vlan;
+	}
+
+	vlan->untagged = vid;
+
+	return 0;
+}
+
+int br_vlan_set_filter(struct net_bridge *br,
+		       unsigned int cmd, unsigned int port, unsigned int vid)
+{
+	struct net_bridge_port_vlan *vlan;
+	int add = (cmd == BRCTL_ADD_PORT_VLAN);
+
+	if (vid > 4094)
+		return -EINVAL;
+
+	if (port) {
+		struct net_bridge_port *p = br_get_port(br, port);
+
+		if (p == NULL)
+			return -EINVAL;
+		vlan = &p->vlan;
+	} else {
+		vlan = &br->vlan;
+	}
+
+	if (vid == 0) {
+		/* special case - add/del for all vlans */
+		memset(vlan->filter, add ? 255 : 0, 4096 / 8);
+		if (add) {
+			vlan->filter[4095 / 8] &= ~(1 << (4095 & 7));
+		}
+	} else if (add)
+		vlan->filter[vid / 8] |= 1 << (vid & 7);
+	else
+		vlan->filter[vid / 8] &= ~(1 << (vid & 7));
+
+	return 0;
+}
+
+int br_vlan_get_info(struct net_bridge *br, void *user_mem, unsigned long port)
+{
+	struct net_bridge_port_vlan *vlan;
+	struct __vlan_info v;
+
+	if (port) {
+		struct net_bridge_port *p = br_get_port(br, port);
+
+		if (p == NULL)
+			return -EINVAL;
+		vlan = &p->vlan;
+	} else {
+		vlan = &br->vlan;
+	}
+
+	memset(&v, 0, sizeof(v));
+	v.untagged = vlan->untagged;
+	memcpy(v.filter, vlan->filter, 4096 / 8);
+
+	if (copy_to_user((void __user *)user_mem, &v, sizeof(v)))
+		return -EFAULT;
+
+	return 0;
+}
Index: wireless-dev/net/bridge/Makefile
===================================================================
--- wireless-dev.orig/net/bridge/Makefile
+++ wireless-dev/net/bridge/Makefile
@@ -12,4 +12,6 @@ bridge-$(CONFIG_SYSFS) += br_sysfs_if.o 
 
 bridge-$(CONFIG_BRIDGE_NETFILTER) += br_netfilter.o
 
+bridge-$(CONFIG_BRIDGE_VLAN) += br_vlan.o
+
 obj-$(CONFIG_BRIDGE_NF_EBTABLES) += netfilter/
Index: wireless-dev/net/core/skbuff.c
===================================================================
--- wireless-dev.orig/net/core/skbuff.c
+++ wireless-dev/net/core/skbuff.c
@@ -486,6 +486,9 @@ struct sk_buff *skb_clone(struct sk_buff
 	nf_bridge_get(skb->nf_bridge);
 #endif
 #endif /*CONFIG_NETFILTER*/
+#ifdef CONFIG_BRIDGE_VLAN
+	C(vlan);
+#endif
 #ifdef CONFIG_NET_SCHED
 	C(tc_index);
 #ifdef CONFIG_NET_CLS_ACT
@@ -550,6 +553,9 @@ static void copy_skb_header(struct sk_bu
 	nf_bridge_get(old->nf_bridge);
 #endif
 #endif
+#ifdef CONFIG_BRIDGE_VLAN
+	new->vlan	= old->vlan;
+#endif
 #ifdef CONFIG_NET_SCHED
 #ifdef CONFIG_NET_CLS_ACT
 	new->tc_verd = old->tc_verd;
Index: wireless-dev/net/bridge/Kconfig
===================================================================
--- wireless-dev.orig/net/bridge/Kconfig
+++ wireless-dev/net/bridge/Kconfig
@@ -30,3 +30,13 @@ config BRIDGE
 	  will be called bridge.
 
 	  If unsure, say N.
+
+config BRIDGE_VLAN
+	bool "802.1Q bridge support"
+	depends on BRIDGE
+	---help---
+	  If you say Y here, then your bridge will be able to filter and
+	  forward packets according to their IEEE 802.1Q headers.
+
+	  If unsure, say N.
+
Index: wireless-dev/net/bridge/br_device.c
===================================================================
--- wireless-dev.orig/net/bridge/br_device.c
+++ wireless-dev/net/bridge/br_device.c
@@ -34,6 +34,9 @@ int br_dev_xmit(struct sk_buff *skb, str
 	const unsigned char *dest = skb->data;
 	struct net_bridge_fdb_entry *dst;
 
+	if (br_vlan_input_frame(skb, &br->vlan))
+		return 0;
+
 	br->statistics.tx_packets++;
 	br->statistics.tx_bytes += skb->len;
 
