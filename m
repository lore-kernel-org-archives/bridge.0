Resent-Message-ID: <20071016160000.GA31488@rere.qmqm.pl>
Resent-To: bridge@lists.linux-foundation.org
Date: Mon, 15 Oct 2007 23:48:12 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Message-ID: <20071015214812.GA789@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] [PATCH 2.6.23.1] Kill STP hello timer if STP is not enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Quick CPU eater kill. This might be not the best fix possible.

Without this patch, hello_timer is firing 250 times/sec and eating about
8% CPU time on my an otherwise idle system (dynticks enabled). 2.6.21.5 was
even worse - 20% (HZ=3D1000). (br->hello_time was supposedly 0 when STP was
disabled).

Signed-off-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>

--- qmqm/net/bridge/br_stp_if.c.orig	2007-10-15 10:30:24.000000000 +0200
+++ qmqm/net/bridge/br_stp_if.c	2007-10-15 10:34:07.000000000 +0200
@@ -47,10 +47,12 @@
 	struct net_bridge_port *p;
=20
 	spin_lock_bh(&br->lock);
-	mod_timer(&br->hello_timer, jiffies + br->hello_time);
+	if (br->stp_enabled =3D=3D BR_KERNEL_STP)
+		mod_timer(&br->hello_timer, jiffies + br->hello_time);
 	mod_timer(&br->gc_timer, jiffies + HZ/10);
=20
-	br_config_bpdu_generation(br);
+	if (br->stp_enabled =3D=3D BR_KERNEL_STP)
+		br_config_bpdu_generation(br);
=20
 	list_for_each_entry(p, &br->port_list, list) {
 		if ((p->dev->flags & IFF_UP) && netif_carrier_ok(p->dev))
