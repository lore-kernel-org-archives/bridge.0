Return-Path: <glenn.feunteun@orange.com>
From: <glenn.feunteun@orange.com>
Date: Wed, 13 Nov 2013 16:08:36 +0000
Message-ID: <9063_1384358917_5283A405_9063_7670_1_F30F0A0ED6964F42A271F6E9495DDBD0B2E620@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge]  [PATCH] Mirroring function
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

Hello

I am working on a school project whose goal is to implement a traffic mirro=
ring function inside bridge kernel module.

I implemented the function that lets:
- select the mirrored interface(s)
- select ingress, egress or both traffic to be mirrored
- select the output interface(s)

Examples:

a)

brctl mirror br0 eth0 ingress
brclt mirror br0 eth1 destination

All incoming traffic on eth0 will be mirrored on eth1.

b)

brctl mirror br0 eth0 egress
brclt mirror br0 eth1 destination

All outgoing traffic from eth0 will be mirrored on eth1.

c)

brctl mirror br0 eth0 both
brclt mirror br0 eth1 destination

All incoming and outgoing traffic coming on or from eth0 will be mirrored o=
n eth1.


Following is the patch against kernel v3.12.

I also implemented the userspace counterpart, I'll send the patch in anothe=
r mail.


Thank you for giving some feedback on the code and about its possible commi=
t into kernel main tree.


diff -urBb old/br_forward.c new/br_forward.c
--- old/br_forward.c	2013-11-12 14:55:59.054134721 +0100
+++ new/br_forward.c	2013-11-12 14:35:28.262134745 +0100
@@ -62,6 +62,30 @@
=20
 }
=20
+void br_mirror_xmit(const struct net_bridge_port *p, struct sk_buff *skb, =
u8 mask)
+{=20
+    struct net_bridge_port *pos;
+    struct sk_buff *clone;
+    /* See if port has mirroring activated on incoming packet
+       ,outgoing packet or both depending on mask */
+	if(p->mirror_state & mask)
+	{
+		/* Look at each bridge port if one is a mirroring destination */
+
+		list_for_each_entry(pos,&p->br->port_list,list)
+		{
+			if(pos->mirror_state & BR_MIRROR_DST)
+			{
+			    /* Set clone device so it is sent on destination port */
+			        clone =3D skb_copy(skb, GFP_ATOMIC);
+				clone->dev =3D pos->dev;
+				skb_push(clone, ETH_HLEN);
+				dev_queue_xmit(clone);
+			}
+		}
+	}
+}
+
 static void __br_deliver(const struct net_bridge_port *to, struct sk_buff =
*skb)
 {
 	skb =3D br_handle_vlan(to->br, nbp_get_vlan_info(to), skb);
@@ -70,6 +94,8 @@
=20
 	skb->dev =3D to->dev;
=20
+	br_mirror_xmit(to,skb,BR_MIRROR_TX);
+
 	if (unlikely(netpoll_tx_running(to->br->dev))) {
 		if (packet_length(skb) > skb->dev->mtu && !skb_is_gso(skb))
 			kfree_skb(skb);
diff -urBb old/br_input.c new/br_input.c
--- old/br_input.c	2013-11-12 14:55:59.054134721 +0100
+++ new/br_input.c	2013-11-12 14:35:28.262134745 +0100
@@ -216,6 +216,8 @@
 		}
 	}
=20
+	br_mirror_xmit(p,skb,BR_MIRROR_RX);
+
 forward:
 	switch (p->state) {
 	case BR_STATE_FORWARDING:
diff -urBb old/br_private.h new/br_private.h
--- old/br_private.h	2013-11-12 14:55:59.054134721 +0100
+++ new/br_private.h	2013-11-13 15:57:33.668402893 +0100
@@ -159,6 +159,12 @@
 	u32				designated_cost;
 	unsigned long			designated_age;
=20
+	/* Mirroring */
+#define BR_MIRROR_RX 0x01
+#define BR_MIRROR_TX 0x02
+#define BR_MIRROR_DST 0x04
+	u8				mirror_state;
+
 	struct timer_list		forward_delay_timer;
 	struct timer_list		hold_timer;
 	struct timer_list		message_age_timer;
@@ -424,6 +430,7 @@
 			     bool unicast);
 extern void br_flood_forward(struct net_bridge *br, struct sk_buff *skb,
 			     struct sk_buff *skb2, bool unicast);
+extern void br_mirror_xmit(const struct net_bridge_port *p, struct sk_buff=
 *skb, u8 mask);
=20
 /* br_if.c */
 extern void br_port_carrier_check(struct net_bridge_port *p);
diff -urBb old/br_sysfs_if.c new/br_sysfs_if.c
--- old/br_sysfs_if.c	2013-11-12 14:55:59.054134721 +0100
+++ new/br_sysfs_if.c	2013-11-12 14:35:28.262134745 +0100
@@ -161,6 +161,18 @@
 BRPORT_ATTR_FLAG(learning, BR_LEARNING);
 BRPORT_ATTR_FLAG(unicast_flood, BR_FLOOD);
=20
+static ssize_t show_mirror_state(struct net_bridge_port *p, char *buf)
+{
+	return sprintf(buf, "%d\n", p->mirror_state);
+}
+static int store_mirror_state(struct net_bridge_port *p, unsigned long v)
+{
+	p->mirror_state =3D v;
+	return 0;
+}
+static BRPORT_ATTR(mirror_state, S_IRUGO | S_IWUSR,
+		   show_mirror_state, store_mirror_state);
+
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 static ssize_t show_multicast_router(struct net_bridge_port *p, char *buf)
 {
@@ -199,6 +211,7 @@
 	&brport_attr_root_block,
 	&brport_attr_learning,
 	&brport_attr_unicast_flood,
+	&brport_attr_mirror_state,
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	&brport_attr_multicast_router,
 	&brport_attr_multicast_fast_leave,

___________________________________________________________________________=
______________________________________________

Ce message et ses pieces jointes peuvent contenir des informations confiden=
tielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu=
 ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les messages el=
ectroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme ou =
falsifie. Merci.

This message and its attachments may contain confidential or privileged inf=
ormation that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and dele=
te this message and its attachments.
As emails may be altered, Orange is not liable for messages that have been =
modified, changed or falsified.
Thank you.

