Message-Id: <200501281800.j0SI0UTV025365@fire-1.osdl.org>
From: <dan-linuxbridge@unpossible.com>
Sender: "Dan Grigsby" <dan@unpossible.com>
Subject: RE: [Bridge] Benchmarking bridging vs. routing on same
	hardware/network
Date: Fri, 28 Jan 2005 12:00:31 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050128093733.09d44e2e@dxpl.pdx.osdl.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Stephen Hemminger' <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Thanks for the reply.  

> You could check by dumping the forwarding table with 'br showmacs br0'

Before I start the packet generator, I make sure that the mac addresses get
put into the forwarding table.  It may be simple minded, but I do this by
pinging from the packet generator to the destination, and the destination to
the packet generator (this is probably redundant, but server the purpose of
also making sure that everything is "up" on both machines).

I can confirm that they are in the table:

[root@localhost ~]# brctl showmacs br0
port no mac addr                is local?       ageing timer
  1     00:07:e9:0c:fd:07       no                 2.02 <-- destination
  2     00:07:e9:0c:fd:35       no                 2.02 <-- packet generator
  2     00:0c:41:8a:50:b6       no                50.86
  1     00:0c:bd:00:69:cc       yes                0.00
  2     00:0c:bd:00:69:cd       yes                0.00
  2     00:90:96:f4:ce:2b       no                 0.00
  2     00:e0:81:2d:08:01       no               198.57

> How are you testing?

After I seed the table, I run the packet generator.  It is one-way traffic,
but the destination mac address is fixed (00:07:e9:0c:fd:07).

I am trying to understand the code -- I misspoke earlier -- I meant
"something I do *in*frequently" in my last email -- so this isn't a strong
skill with me, though I'm learning.  

The data I sent last time was the bridge functioning at max-capacity without
dropping packets or producing errors.  I've since run it with the packet
generator producing more packets that it can handle to see where the
differences are.  The results:

# opreport -p /lib/modules/2.6.9-1.667smp/kernel/  --symbols |grep bridge

2496     15.0679  bridge.ko      bridge             fdb_insert
1424      8.5964  bridge.ko      bridge             br_nf_pre_routing
866       5.2279  bridge.ko      bridge             br_handle_frame
856       5.1675  bridge.ko      bridge             br_nf_post_routing
566       3.4168  bridge.ko      bridge             br_nf_forward_ip
560       3.3806  bridge.ko      bridge             br_nf_pre_routing_finish
521       3.1452  bridge.ko      bridge             ip_sabotage_out
462       2.7890  bridge.ko      bridge             br_nf_forward_finish
437       2.6381  bridge.ko      bridge             br_flood
430       2.5958  bridge.ko      bridge             br_fdb_insert
404       2.4389  bridge.ko      bridge             __br_fdb_get
383       2.3121  bridge.ko      bridge             br_handle_frame_finish
288       1.7386  bridge.ko      bridge             setup_pre_routing
285       1.7205  bridge.ko      bridge             __br_forward
284       1.7145  bridge.ko      bridge             br_dev_queue_push_xmit
235       1.4187  bridge.ko      bridge             br_forward_finish
210       1.2677  bridge.ko      bridge             ip_sabotage_in
163       0.9840  bridge.ko      bridge             br_flood_forward

I'm looking at the differences.

For what it's worth, when I test using the router setup I have to set the
destination mac address to the router's mac address on the segment of the
packet generator.  Otherwise the router doesn't see the packets.  This got
me to thinking about performance differences between promiscuous mode and
not promiscuous mode.  Would you expect that this could make a difference?

Thanks,

Dan

