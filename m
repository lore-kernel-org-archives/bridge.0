Date: Mon, 8 Oct 2007 02:50:42 -0500
From: Michael Jinks <mjinks@uchicago.edu>
Message-ID: <20071008075042.GW22818@uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] Simple bridge, something's wrong
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi, list.

I'm trying to set up a bridging VPN and having trouble.  The VPN part
seems to be working well, but for some reason bridging doesn't.

To make things as simple as possible for tracking down what I'm doing
wrong, I've set up a test network with three Linux machines connected to
two ethernet segments, no VPN stuff involved:

 Host A                    Host B                   Host C
10.1.1.15--[segment 1]--[br0, no IP]--[segment 2]--10.1.1.16
                        (eth1, eth2)

On Host B:

  $ /sbin/brctl show
  bridge name     bridge id               STP enabled     interfaces
  br0             8000.000c299eefe7       no              eth1
                                                          eth2

If I try to ping Host C from Host A, I get "Destination host
unreachable".  Watching tcpdump on Host B at the same time, I see
"who-has" arp requests coming in, but nothing going back out and no
replies.  brctl shows that the bridge has learned the MAC of Host A, but
not Host C.

  $ sudo tcpdump -n -i br0
  tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
  listening on br0, link-type EN10MB (Ethernet), capture size 96 bytes
  01:46:37.542316 arp who-has 10.1.1.15 tell 10.1.1.16
  01:46:38.543744 arp who-has 10.1.1.15 tell 10.1.1.16
  01:46:39.544740 arp who-has 10.1.1.15 tell 10.1.1.16

  $ /sbin/brctl showmacs br0
  port no mac addr                is local?       ageing timer
    1     00:0c:29:9e:ef:e7       yes                0.00
    2     00:0c:29:9e:ef:f1       yes                0.00
    1     00:0c:29:d9:59:d8       no                 1.83

(00:0c:29:d9:59:d8 is correct for Host A.)

If I try to ping the other direction at the same time -- to Host A from
Host C -- ping on host C doesn't produce any output at all, I don't see
any arp traffic from Host C on Host B, and brctl doesn't show anything
new.

But, a few seconds after I stop pinging from Host A, Host B starts to
produce "host unreachable" messages, Host B sees C's arp requests, and
for a short while brctl shows both systems' MAC addresses, until the
record for A eventually times out:

  $ /sbin/brctl showmacs br0
  port no mac addr                is local?       ageing timer
    2     00:0c:29:25:1a:00       no                 0.74
    1     00:0c:29:9e:ef:e7       yes                0.00
    2     00:0c:29:9e:ef:f1       yes                0.00
    1     00:0c:29:d9:59:d8       no                10.85

So, traffic is reaching the bridge, but it seems that nothing is ever
repeated onto the other segment, and whichever host pings the bridge
first "squashes" any traffic from the other.

I've tried various combinations of settings under /proc.  ip_forward set
to both 1 and 0; /proc/sys/net/bridge/bridge-nf-* all set to 0 or all
set to 1.  That doesn't seem to make any difference.

I thought I might have a firewall rule getting in the way, and I'm not
sure I've eliminated that possibility, but I've tried lots of different
settings there too, including a complete flush of everything in iptables
and ebtables.  Nothing has helped, but I did use ebtables logging to
generate this, a three-line pattern typical of what I see on host B
(hostname "frail") when .15 is trying to ping .16:

  Oct  8 02:16:37 frail ebtables-broute IN=eth2 OUT= MAC source = 00:0c:29:25:1a:00 MAC dest = ff:ff:ff:ff:ff:ff proto = 0x0806 ARP HTYPE=1, PTYPE=0x0800, OPCODE=1 ARP MAC SRC=00:0c:29:25:1a:00  ARP IP SRC=10.1.1.15 ARP MAC DST=00:00:00:00:00:00  ARP IP DST=10.1.1.16
  Oct  8 02:16:37 frail ebtables-forward IN=eth2 OUT=eth1 MAC source = 00:0c:29:25:1a:00 MAC dest = ff:ff:ff:ff:ff:ff proto = 0x0806 ARP HTYPE=1, PTYPE=0x0800, OPCODE=1 ARP MAC SRC=00:0c:29:25:1a:00  ARP IP SRC=10.1.1.15 ARP MAC DST=00:00:00:00:00:00  ARP IP DST=10.1.1.16
  Oct  8 02:16:37 frail ebtables-in IN=eth2 OUT= MAC source = 00:0c:29:25:1a:00 MAC dest = ff:ff:ff:ff:ff:ff proto = 0x0806 ARP HTYPE=1, PTYPE=0x0800, OPCODE=1 ARP MAC SRC=00:0c:29:25:1a:00  ARP IP SRC=10.1.1.15 ARP MAC DST=00:00:00:00:00:00  ARP IP DST=10.1.1.16

That's with a broute rule set to ACCEPT everything.  If I DROP instead,
as the ebtables manpage seems to say I should in this case, the
"ebtables-forward" and "ebtables-in" lines disappear, but packets still
don't cross the bridge.

One last bit of screen output, suggested by a recent thread in the list
archive, not sure if it's helpful or not:

  $ /sbin/ip -s -s link show br0
  9: br0: <BROADCAST,MULTICAST,UP,10000> mtu 1500 qdisc noqueue 
      link/ether 00:0c:29:9e:ef:e7 brd ff:ff:ff:ff:ff:ff
      RX: bytes  packets  errors  dropped overrun mcast   
      119116     2587     0       0       0       2584   
      RX errors: length  crc     frame   fifo    missed
                 0        0       0       0       0      
      TX: bytes  packets  errors  dropped carrier collsns 
      336        4        0       0       0       0      
      TX errors: aborted fifo    window  heartbeat
                 0        0       0       0 

...and that's everything I can think of right now.  Any suggestions for
where else to look?  Useful information I've left out?

Thanks,
--Michael
