Date: Mon, 13 Oct 2003 09:15:33 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] hw checksum problems
Message-Id: <20031013091533.20296086.shemminger@osdl.org>
In-Reply-To: <20031013121901.GM8160@thunderchild.debian.net>
References: <20031013111647.GK8160@thunderchild.debian.net>
	<20031013121901.GM8160@thunderchild.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Gergely Madarasz <gorgo@thunderchild.debian.net>
Cc: bridge@lists.osdl.org

On Mon, 13 Oct 2003 14:19:01 +0200
Gergely Madarasz <gorgo@thunderchild.debian.net> wrote:

> On Mon, Oct 13, 2003 at 01:16:47PM +0200, Gergely Madarasz wrote:
> > Hello,
> > 
> > I'm trying to make a bridge between a Broadcom BCM5703 gigabit ethernet
> > and a sun happy meal fastethernet interface. The sunhme card supports hw
> > checksums (and cannot be turned off in the driver). I applied the patch
> > (to set CHECKSUM_NONE on forwarded packets), but I still get kernel oopses
> > (though it seems less often than before). I cannot tell exactly what
> > triggers it, sometimes it seems a large ping, sometimes a broadcast ping,
> > sometimes just normal network traffic. Any ideas?
> 
> Oh, I forgot :) The kernel is 2.4.22 with the execshield patch. The cards
> work nicely when there is no bridge. One more specific info: when bridged,
> under normal circumstances the hme port is in blocking state (it should
> start forwarding only if the tg3 link is down). 

Fixed in 2.6.0-test6 or 2.4.23 or use this patch posted earlier to the list...
--------------

The hardware checksumming flags need to be cleared when forwarding packets.
Bridging just needs to forward what ever checksum is in the existing skbuff,
it doesn't want or need the packet to be resummed.

Without this fix, forwarding between smart/dumb interfaces causes an oops.

diff -Nru a/net/bridge/br_forward.c b/net/bridge/br_forward.c
--- a/net/bridge/br_forward.c	Mon Sep  8 09:29:44 2003
+++ b/net/bridge/br_forward.c	Mon Sep  8 09:29:44 2003
@@ -59,6 +59,7 @@
 
 	indev = skb->dev;
 	skb->dev = to->dev;
+	skb->ip_summed = CHECKSUM_NONE;
 
 	NF_HOOK(PF_BRIDGE, NF_BR_FORWARD, skb, indev, skb->dev,
 			__br_forward_finish);
