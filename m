Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"
Message-Id: <20090422190249.309bcec7aba70cc9ede34e91806448df.f41ec56ed5.wbe@email01.secureserver.net>
From: dwinn@QYPEA.COM
Date: Wed, 22 Apr 2009 19:02:49 -0700
Mime-Version: 1.0
Subject: [Bridge] Bridge hardware filtering vs promiscuous mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

<html><body><span style=3D"font-family:Verdana; color:#000000; font-size:10=
pt;">Hi all,<br>I'm currently working on a driver for a new network card wh=
ich supports filtering by mac address very well. I implemented set_multicas=
t_list for my driver and got some great speed improvements, due to taking a=
dvantage of the hardware filtering.<br><br>Unfortunately, when I add this d=
evice to a bridge I lose a lot of these improvements due to the bridge swit=
ching the device to promiscuous mode. I'm currently looking into how to cha=
nge the bridge code to take advantage of these optimizations. Could people =
more familiar with the bridge code take a look and let me know: a. Has this=
 been tried or talked about before? b. Are there any glaring flaws in my de=
sign?<br><br>1. Remove dev_set_promiscuity from bridge code in net/bridge/b=
r_if.c<br>2. Fill in the br_dev_set_multicast_list function found in net/br=
idge/br_device.c<br>3. In net/bridge/br_fdb.c, add code which calls set_mul=
ticast_list on each port in a bridge whenever that bridge's address databas=
e changes. I believe the two functions that will need to change are fdb_del=
ete and fdb_create.<br>&nbsp;&nbsp;&nbsp; a. We need to always receive mult=
icast traffic, so we can forward it. Set the IFF_ALLMULTI flag on all ports=
.<br>&nbsp;&nbsp;&nbsp; b. Call set_multicast_list with dev-&gt;mc_list set=
 to the list of addresses in the database for each port.<br>&nbsp;&nbsp;&nb=
sp; c. Fall back  to promiscuous mode&nbsp;if multicast filtering isn't sup=
ported on a port. This should only be for the one port which doesn't suppor=
t it. The rest can still filter.<br><br>I'll probably be implementing these=
 changes shortly. Hopefully they work how I'm thinking they will.<br>Thanks=
,<br>David<br></span></body></html>
