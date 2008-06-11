Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jun 2008 10:27:54 +0200
Message-ID: <E88155B5BD67CE4D87A3F1F70950B96A2FF8A8@berta.maurer-it.com>
From: "Dietmar Maurer" <dietmar@proxmox.com>
Subject: [Bridge] Bridge MAC selection
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all,

We provid a management plattform for virtual machines (pve.proxmox.com),
and=20
use a bridge access the network.

Currently the system choose the lowest MAC for the purposes of STP=20
and also assigns this MAC to the bridge. This is a problem because the=20
Bridge MAC changes when we start/stop virtual machines - leading to=20
Network outage for several seconds.

Using the first (insteasd of lowest) MAC would avoid the problem. So are

There any side effects with the following patch?

--- br_stp_if.c.org     2008-06-11 09:15:16.000000000 +0200
+++ br_stp_if.c 2008-06-11 09:44:53.000000000 +0200
@@ -217,10 +217,7 @@
        struct net_bridge_port *p;

        list_for_each_entry(p, &br->port_list, list) {
-               if (addr =3D=3D br_mac_zero ||
-                   memcmp(p->dev->dev_addr, addr, ETH_ALEN) < 0)
-                       addr =3D p->dev->dev_addr;
-
+               addr =3D p->dev->dev_addr;
        }

        if (compare_ether_addr(br->bridge_id.addr, addr))



