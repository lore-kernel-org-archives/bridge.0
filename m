Mime-Version: 1.0
Message-Id: <p05111b01bb823e6e4a2f@[10.96.96.13]>
Date: Mon, 8 Sep 2003 16:19:02 +0200
From: Hannes Schulz <schulz@schwaar.com>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Subject: [Bridge] [SOLVED][2.4.22] bad interaction between e100 and bridge:
 BUG at dev.c:991!
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://localhost.localdomain/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: linux-net@vger.kernel.org, shemminger@osdl.org, bridge@osdl.org
Cc: jgarzik@pobox.com, scott.feldman@intel.com

This was the problem:

>setup & how to reproduce:
>HP Netserver 2000 with 2 onboard e100 NICs. Both are connected to 
>the same hub.
>Add both eth0 and eth1 to the same bridge. Pull the plug on eth0. 
>Wait till the bridge is about to enter forwarding state on eth1.
>
>I have reproduced this with earlier kernels (2.4.20+) too but they 
>were heavily patched. This is a pristine 2.4.22.
>
>Strange but true: This works when using eepro100 insted of e100.

It turned out that the IP receive checksumming on the board (which 
the e100 driver enables) triggered a bug in the bridging code.

The following patch by Stephen Hemminger fixed it:

diff -Nru a/net/bridge/br_forward.c b/net/bridge/br_forward.c
--- a/net/bridge/br_forward.c	Fri Sep  5 11:28:33 2003
+++ b/net/bridge/br_forward.c	Fri Sep  5 11:28:33 2003
@@ -59,6 +59,7 @@

  	indev = skb->dev;
  	skb->dev = to->dev;
+	skb->ip_summed = CHECKSUM_NONE;

  	NF_HOOK(PF_BRIDGE, NF_BR_FORWARD, skb, indev, skb->dev,
  			__br_forward_finish);



Thank you for solving my problem!

Hannes
