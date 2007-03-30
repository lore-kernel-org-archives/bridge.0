Message-ID: <59452.84.123.233.184.1175286636.squirrel@www.arcoscom.com>
Date: Fri, 30 Mar 2007 22:30:36 +0200 (CEST)
From: "ArcosCom Linux User" <linux@arcoscom.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Why TTL is changing when sending a ping?
Reply-To: linux@arcoscom.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: LARTC@mailman.ds9a.nl, bridge@lists.linux-foundation.org

The situation is this:

INTERNET -- ROUTER -- ETHERNET+WIFI -- PC's

The conection between INTERNET and ROUTER is done with 2 LINKs with static
IP's.

The conection between ROUTER and PC's is done via ETHERNET lan with many
bridges and ACCESSPOINTS.

The PC's are in a IP subnet, the BRIDGES in another IP subnet, the AP's in
another IP subnet. The ROUTER has 1 bridge interface (2 real ethernets in
the bridge) connected to the LAN.

In the router exists then br0, br0:1, br0:2, br0:3 (PCs, APs, BRIDGEs IP
subnets) to allow IP connection over the ETHERNET+WIFI between ROUTER and
clients.

The principal purpose of the ROUTER is to allow internet acces to PC's.
The BRIDGES and AP's have got implemented STP protocol and appears to be
working fine (ap's and bridges are embedded linux boxes).

In router I have enabled rp_filter in all interfaces, default and each one.
The ip routing is enabled too (obviously).

I detected that a normal ping from ROUTER to one PC usually has a TTL=64,
but many times that TTL changes to 128.

What could be the problem? The "routing" enabled in bridge devices?
Some TCP/IP parameter I don't configured fine?
Any idea?

Thanks



