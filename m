Mime-Version: 1.0
Message-Id: <p05111b00bb740b63506b@[10.96.96.13]>
In-Reply-To: <20030827132810.65010eac.shemminger@osdl.org>
References: <p05111b01bb728bc8972e@[10.96.96.13]>
 <20030827132810.65010eac.shemminger@osdl.org>
Date: Thu, 28 Aug 2003 22:24:52 +0200
From: Hannes Schulz <schulz@schwaar.com>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Subject: [Bridge] [more info] Re: [2.4.22] bad interaction between e100 and bridge:
 BUG at dev.c:991!
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: scott.feldman@intel.com, jgarzik@pobox.com, linux-net@vger.kernel.org, bridge@osdl.org

>Could the problem be that the e100 can do IP receive checksumming on 
>the board,
>but the eepro driver doesn't enable it.  When the board is doing checksum
>offload, then the csum field isn't set.
>
>Please try disabling receive checksumming on the e100 driver
>
>	modprobe e100 XsumRX=0
>
>If this is the problem, it exists both 2.4 and 2.6.

Indeed: with  XsumRX=0,0 the BUG doesn't happen. I put some debugging 
code in dev.c:

=== CUT HERE ===
--- dev.c.orig	2003-08-28 20:00:22.000000000 +0200
+++ dev.c	2003-08-28 20:59:19.000000000 +0200
@@ -987,9 +987,29 @@
  	offset = skb->tail - skb->h.raw;
  	if (offset <= 0)
  		BUG();
-	if (skb->csum+2 > offset)
+/*	if (skb->csum+2 > offset)
  		BUG();
-
+*/
+	if (skb->csum+2 > offset) {
+		printk (KERN_EMERG "skb->csum+2=%d, offset=%d, 
skb->ip_summed=%d\n", skb->csum+2, offset, (int)(skb->ip_summed));
+		printk (KERN_EMERG 
"skb->mac.ethernet->h_dest=%0.2x:%0.2x:%0.2x:%0.2x:%0.2x:%0.2x\n",
+				(unsigned int)(skb->mac.ethernet->h_dest [0]),
+				(unsigned int)(skb->mac.ethernet->h_dest [1]),
+				(unsigned int)(skb->mac.ethernet->h_dest [2]),
+				(unsigned int)(skb->mac.ethernet->h_dest [3]),
+				(unsigned int)(skb->mac.ethernet->h_dest [4]),
+				(unsigned int)(skb->mac.ethernet->h_dest [5])
+		);
+		printk (KERN_EMERG 
"skb->mac.ethernet->h_source=%0.2x:%0.2x:%0.2x:%0.2x:%0.2x:%0.2x\n",
+				(unsigned 
int)(skb->mac.ethernet->h_source [0]),
+				(unsigned 
int)(skb->mac.ethernet->h_source [1]),
+				(unsigned 
int)(skb->mac.ethernet->h_source [2]),
+				(unsigned 
int)(skb->mac.ethernet->h_source [3]),
+				(unsigned 
int)(skb->mac.ethernet->h_source [4]),
+				(unsigned int)(skb->mac.ethernet->h_source [5])
+		);
+		BUG ();
+	}
  	*(u16*)(skb->h.raw + skb->csum) = csum_fold(csum);
  	skb->ip_summed = CHECKSUM_NONE;
  	return skb;
=== CUT HERE ===

It says (just before the BUG):
skb->csum+2=33323, offset=168, skb->ip_summed=1
skb->mac.ethernet->h_dest=ff:ff:ff:ff:ff:ff
skb->mac.ethernet->h_source=00:d0:b7:3c:78:0a

I also put a few lines in e100_main.c:

=== CUT HERE ===
--- e100_main.c.orig	2003-08-28 21:01:07.000000000 +0200
+++ e100_main.c	2003-08-28 21:07:10.000000000 +0200
@@ -2051,11 +2051,14 @@
  		if (bdp->flags & DF_CSUM_OFFLOAD) {
  			if (bdp->rev_id >= D102_REV_ID) {
  				skb->ip_summed = e100_D102_check_checksum(rfd);
+				printk (KERN_ERR "e100_D102: 
skb->csum+2=%d,offset=%d, skb->ip_summed=%d\n", skb->csum+2, 
skb->tail - skb->h.raw, (int)(skb->ip_summed));
  			} else {
  				skb->ip_summed = e100_D101M_checksum(bdp, skb);
+				printk (KERN_ERR "e100_D101M: 
skb->csum+2=%d,offset=%d, skb->ip_summed=%d\n", skb->csum+2, 
skb->tail - skb->h.raw, (int)(skb->ip_summed));
  			}
  		} else {
  			skb->ip_summed = CHECKSUM_NONE;
+			printk (KERN_ERR "e100_NOOFF: 
skb->csum+2=%d,offset=%d, skb->ip_summed=%d\n", skb->csum+2, 
skb->tail - skb->h.raw, (int)(skb->ip_summed));
  		}

  		bdp->drv_stats.net_stats.rx_bytes += skb->len;
=== CUT HERE ===

and my console was flooded with these:
e100_D101M: skb->csum+2=47564,offset=-2789414, skb->ip_summed=1
e100_D101M: skb->csum+2=38865,offset=3991018, skb->ip_summed=0
e100_D101M: skb->csum+2=33998,offset=4009612, skb->ip_summed=1
e100_D101M: skb->csum+2=11471,offset=845290, skb->ip_summed=1
e100_D101M: skb->csum+2=33323,offset=4036692, skb->ip_summed=1
                         ^^^^^
this line was printed just above the BUG. The bug itself is 
essentially the same as before; just different offsets.

I think the packet in question is a broadcast of linux-ha sent out by 
a completely unrelated machine that happens to be on the same network:

uml:/usr/src/linux/drivers/net/e100# tcpdump -i br0 -e -n -q ether 
host 00:d0:b7:3c:78:0a
tcpdump: listening on br0
22:11:40.413171 0:d0:b7:3c:78:a ff:ff:ff:ff:ff:ff 182: 
10.96.96.25.1025 > 10.96.96.255.694: udp 140
22:11:42.413154 0:d0:b7:3c:78:a ff:ff:ff:ff:ff:ff 182: 
10.96.96.25.1025 > 10.96.96.255.694: udp 140
[and so on; the machine is idle at that time of the day]


Q: the 'offset' looks wrong in my code in e100_main.c [I didn't 
further investigate this]; but the skb->csum shows strong 
coincidence. What is happening here ?


Thanks in advance

Hannes
