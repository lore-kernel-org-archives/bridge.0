Message-ID: <4A32AFC9.7010000@iders.ca>
Date: Fri, 12 Jun 2009 14:43:05 -0500
From: Andrew McKay <amckay@iders.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Issue with bridge on STP enabled bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Tyler Sutherland <tyler@iders.ca>

Hi,

I'm working on setting up a bridge on with embedded Linux boards running kernel 
version 2.6.20.4.  I seem to be having some issues.  I can reliably ping from 
the root bridge to the other bridge.  However when I try and ping from the 
non-root bridge to the root bridge we get around an 83% packet loss.

Our topology is as follows:

************************************************************
*   STP Topology:
*
*  +---------+                           +---------+
*  | BR-1    |                           | BR-2    |
*  |  eth0 [=]---------[HUB]-------------[=] eth0  |
*  |         |                           |         |
*  |  eth1 [=]---------[HUB]-------------[=] eth1  |
*  |       [ ]                           [ ]       |
*  |         |                           |         |
*  +---------+                           +---------+
*
*************************************************************

In this case BR-1 ends up being our root bridge.  The bridges on the two boards 
are setup as follows:

BR-1:
----------------------------------------------------------------------------
ifconfig eth0 0.0.0.0 down
ifconfig eth1 0.0.0.0 down
/mnt/nand/currload/sbin/brctl addbr br0
/mnt/nand/currload/sbin/brctl stp br0 on
/mnt/nand/currload/sbin/brctl addif br0 eth0
/mnt/nand/currload/sbin/brctl addif br0 eth1
ifconfig eth0 up
ifconfig eth1 up
ifconfig br0 up
ifconfig br0 192.168.1.2
----------------------------------------------------------------------------

BR-2:
----------------------------------------------------------------------------
ifconfig eth0 0.0.0.0 down
ifconfig eth1 0.0.0.0 down
/mnt/nand/currload/sbin/brctl addbr br0
/mnt/nand/currload/sbin/brctl stp br0 on
/mnt/nand/currload/sbin/brctl addif br0 eth0
/mnt/nand/currload/sbin/brctl addif br0 eth1
ifconfig eth0 up
ifconfig eth1 up
ifconfig br0 up
ifconfig br0 192.168.1.1
----------------------------------------------------------------------------

Once the bridges are allowed to come up and sniff out the network using BPDU 
frames showstp reports:

BR-1:
----------------------------------------------------------------------------
# brctl showstp br0
br0
  bridge id              8000.0050c263d001
  designated root        8000.0050c263d001
  root port                 0                    path cost                  0
  max age                  20.00                 bridge max age            20.00
  hello time                2.00                 bridge hello time          2.00
  forward delay            15.00                 bridge forward delay      15.00
  ageing time             300.00
  hello timer               1.55                 tcn timer                  0.00
  topology change timer     0.00                 gc timer                   0.05
  flags


eth0 (1)
  port id                8001                    state                forwarding
  designated root        8000.0050c263d001       path cost                100
  designated bridge      8000.0050c263d001       message age timer          0.00
  designated port        8001                    forward delay timer        0.00
  designated cost           0                    hold timer                 0.54
  flags

eth1 (2)
  port id                8002                    state                forwarding
  designated root        8000.0050c263d001       path cost                100
  designated bridge      8000.0050c263d001       message age timer          0.00
  designated port        8002                    forward delay timer        0.00
  designated cost           0                    hold timer                 0.54
  flags
----------------------------------------------------------------------------

BR-2:
----------------------------------------------------------------------------
# brctl showstp br0
br0
  bridge id              8000.0050c263d065
  designated root        8000.0050c263d001
  root port                 1                    path cost                100
  max age                  20.00                 bridge max age            20.00
  hello time                2.00                 bridge hello time          2.00
  forward delay            15.00                 bridge forward delay      15.00
  ageing time             300.00
  hello timer               0.00                 tcn timer                  0.00
  topology change timer     0.00                 gc timer                   0.06
  flags


eth0 (1)
  port id                8001                    state                forwarding
  designated root        8000.0050c263d001       path cost                100
  designated bridge      8000.0050c263d001       message age timer         18.39
  designated port        8001                    forward delay timer        0.00
  designated cost           0                    hold timer                 0.00
  flags

eth1 (2)
  port id                8002                    state                  blocking
  designated root        8000.0050c263d001       path cost                100
  designated bridge      8000.0050c263d001       message age timer         18.39
  designated port        8002                    forward delay timer        0.00
  designated cost           0                    hold timer                 0.00
  flags
----------------------------------------------------------------------------

 From what I understand this is what should happen.  The other bridge is 
receiving BPDU frames on both interfaces and blocks one interface to prevent 
creating a loop.  We have sniffed packets externally at the hubs with other 
machines and with tcpdump on the boards directly.  STP frames are being sent by 
the root bridge, and if we change topology of the network there is a topology 
change frame sent, and the bridge starts seting BPDU frames with the topology 
change flag set for a while after.  It appears that STP is doing what it's 
supposed to do and adapting to changes in the network.  However an issue appears 
once we starting trying to ping between the bridges.

When we ping from the root bridge things seem to work fine.  Here is a TCP dump 
from the two boards.

BR-1:
----------------------------------------------------------------------------
~ # tcpdump -i eth0
tcpdump: WARNING: eth0: no IPv4 address assigned
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 68 bytes
00:41:11.211037 IP 192.168.1.2 > 192.168.1.1: ICMP echo request, id 49412, seq 
10240, length 64
00:41:11.212685 IP 192.168.1.1 > 192.168.1.2: ICMP echo reply, id 49412, seq 
10240, length 64
00:41:12.020297 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:41:12.221029 IP 192.168.1.2 > 192.168.1.1: ICMP echo request, id 49412, seq 
10496, length 64
00:41:12.222643 IP 192.168.1.1 > 192.168.1.2: ICMP echo reply, id 49412, seq 
10496, length 64
00:41:13.231001 IP 192.168.1.2 > 192.168.1.1: ICMP echo request, id 49412, seq 
10752, length 64
00:41:13.232655 IP 192.168.1.1 > 192.168.1.2: ICMP echo reply, id 49412, seq 
10752, length 64
00:41:14.020297 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:41:14.241019 IP 192.168.1.2 > 192.168.1.1: ICMP echo request, id 49412, seq 
11008, length 64
00:41:14.242641 IP 192.168.1.1 > 192.168.1.2: ICMP echo reply, id 49412, seq 
11008, length 64
00:41:15.200218 ARP, Request who-has 192.168.1.1 tell 192.168.1.2, length 28
00:41:15.201127 ARP, Reply 192.168.1.1 is-at 00:50:c2:63:d0:65 (oui Unknown), 
length 46
00:41:15.251017 IP 192.168.1.2 > 192.168.1.1: ICMP echo request, id 49412, seq 
11264, length 64
00:41:15.252624 IP 192.168.1.1 > 192.168.1.2: ICMP echo reply, id 49412, seq 
11264, length 64
00:41:16.020299 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
----------------------------------------------------------------------------

BR-2:
----------------------------------------------------------------------------
~ # tcpdump -i eth0
tcpdump: WARNING: eth0: no IPv4 address assigned
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 68 bytes
00:40:32.651507 IP 192.168.1.2 > 192.168.1.1: ICMP echo request, id 49412, seq 
1024, length 64
00:40:32.652541 IP 192.168.1.1 > 192.168.1.2: ICMP echo reply, id 49412, seq 
1024, length 64
00:40:33.661415 IP 192.168.1.2 > 192.168.1.1: ICMP echo request, id 49412, seq 
1280, length 64
00:40:33.662478 IP 192.168.1.1 > 192.168.1.2: ICMP echo reply, id 49412, seq 
1280, length 64
00:40:33.820673 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:40:34.671433 IP 192.168.1.2 > 192.168.1.1: ICMP echo request, id 49412, seq 
1536, length 64
00:40:34.672511 IP 192.168.1.1 > 192.168.1.2: ICMP echo reply, id 49412, seq 
1536, length 64
00:40:35.630208 ARP, Request who-has 192.168.1.2 tell 192.168.1.1, length 28
00:40:35.630929 ARP, Reply 192.168.1.2 is-at 00:50:c2:63:d0:01 (oui Unknown), 
length 46
00:40:35.681407 IP 192.168.1.2 > 192.168.1.1: ICMP echo request, id 49412, seq 
1792, length 64
00:40:35.682379 IP 192.168.1.1 > 192.168.1.2: ICMP echo reply, id 49412, seq 
1792, length 64
00:40:35.820659 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:40:36.691328 IP 192.168.1.2 > 192.168.1.1: ICMP echo request, id 49412, seq 
2048, length 64
00:40:36.692389 IP 192.168.1.1 > 192.168.1.2: ICMP echo reply, id 49412, seq 
2048, length 64
00:40:37.701391 IP 192.168.1.2 > 192.168.1.1: ICMP echo request, id 49412, seq 
2304, length 64
00:40:37.702417 IP 192.168.1.1 > 192.168.1.2: ICMP echo reply, id 49412, seq 
2304, length 64
----------------------------------------------------------------------------

Looks link a normal tcpdump of pinging interleaved with STP frames.  Note I 
didn't end up getting the ARP transaction captured at the beginning of the session.

When I bring from the non-root bridge to the root bridge around 83% of the pings 
do not work.  Looking at packets dumped by tcpdump reveals some strangeness.  As 
soon as a STP frame is received the no more ICMP echo requests are sent out, 
after a few seconds the board will ARP for the IP address it is trying to ping, 
get a few pings through, and then stop again when an STP frame is received.

Here are the tcpdumps:

BR-1:
----------------------------------------------------------------------------
00:35:55.379503 ARP, Request who-has 192.168.1.2 tell 192.168.1.1, length 46
00:35:55.380110 ARP, Reply 192.168.1.2 is-at 00:50:c2:63:d0:01 (oui Unknown), 
length 28
00:35:55.380968 IP 192.168.1.1 > 192.168.1.2: ICMP echo request, id 42500, seq 
41984, length 64
00:35:55.382151 IP 192.168.1.2 > 192.168.1.1: ICMP echo reply, id 42500, seq 
41984, length 64
00:35:56.020435 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:35:58.020299 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:00.020301 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:00.380208 ARP, Request who-has 192.168.1.1 tell 192.168.1.2, length 28
00:36:00.381120 ARP, Reply 192.168.1.1 is-at 00:50:c2:63:d0:65 (oui Unknown), 
length 46
00:36:00.429901 IP 192.168.1.1 > 192.168.1.2: ICMP echo request, id 42500, seq 
43264, length 64
00:36:00.430958 IP 192.168.1.2 > 192.168.1.1: ICMP echo reply, id 42500, seq 
43264, length 64
00:36:01.439996 IP 192.168.1.1 > 192.168.1.2: ICMP echo request, id 42500, seq 
43520, length 64
00:36:01.441037 IP 192.168.1.2 > 192.168.1.1: ICMP echo reply, id 42500, seq 
43520, length 64
00:36:02.020303 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:04.020303 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:06.020295 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:08.020299 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:10.020293 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:12.020297 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:14.020305 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:16.020297 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:18.020305 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:20.020301 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:22.020299 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:24.020289 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:26.020295 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:28.020328 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:30.020293 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:32.020297 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:34.020287 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:36.020291 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:38.020293 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:38.819580 ARP, Request who-has 192.168.1.2 tell 192.168.1.1, length 46
00:36:38.820192 ARP, Reply 192.168.1.2 is-at 00:50:c2:63:d0:01 (oui Unknown), 
length 28
00:36:38.821074 IP 192.168.1.1 > 192.168.1.2: ICMP echo request, id 42500, seq 
52992, length 64
00:36:38.822232 IP 192.168.1.2 > 192.168.1.1: ICMP echo reply, id 42500, seq 
52992, length 64
00:36:39.820108 IP 192.168.1.1 > 192.168.1.2: ICMP echo request, id 42500, seq 
53248, length 64
00:36:39.821169 IP 192.168.1.2 > 192.168.1.1: ICMP echo reply, id 42500, seq 
53248, length 64
00:36:40.020316 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:42.020297 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:43.820230 ARP, Request who-has 192.168.1.1 tell 192.168.1.2, length 28
00:36:43.821200 ARP, Reply 192.168.1.1 is-at 00:50:c2:63:d0:65 (oui Unknown), 
length 46
00:36:43.870043 IP 192.168.1.1 > 192.168.1.2: ICMP echo request, id 42500, seq 
54272, length 64
00:36:43.871023 IP 192.168.1.2 > 192.168.1.1: ICMP echo reply, id 42500, seq 
54272, length 64
00:36:44.020314 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:46.020295 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:48.020299 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
00:36:50.020291 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 35
----------------------------------------------------------------------------

BR-2:
----------------------------------------------------------------------------
00:34:26.280368 ARP, Request who-has 192.168.1.2 tell 192.168.1.1, length 28
00:34:26.281413 ARP, Reply 192.168.1.2 is-at 00:50:c2:63:d0:01 (oui Unknown), 
length 46
00:34:26.281746 IP 192.168.1.1 > 192.168.1.2: ICMP echo request, id 42500, seq 
19968, length 64
00:34:26.283187 IP 192.168.1.2 > 192.168.1.1: ICMP echo reply, id 42500, seq 
19968, length 64
00:34:27.280872 IP 192.168.1.1 > 192.168.1.2: ICMP echo request, id 42500, seq 
20224, length 64
00:34:27.282375 IP 192.168.1.2 > 192.168.1.1: ICMP echo reply, id 42500, seq 
20224, length 64
00:34:27.821850 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:29.821852 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:31.281787 ARP, Request who-has 192.168.1.1 tell 192.168.1.2, length 46
00:34:31.282204 ARP, Reply 192.168.1.1 is-at 00:50:c2:63:d0:65 (oui Unknown), 
length 28
00:34:31.320885 IP 192.168.1.1 > 192.168.1.2: ICMP echo request, id 42500, seq 
21248, length 64
00:34:31.322307 IP 192.168.1.2 > 192.168.1.1: ICMP echo reply, id 42500, seq 
21248, length 64
00:34:31.821836 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:33.821996 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:35.821988 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:37.821990 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:39.821978 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:41.821962 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:43.821960 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:45.821960 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:47.821797 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:49.821791 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:51.821789 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:53.821775 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:55.821777 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:57.821923 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:34:59.821913 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:35:01.821897 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:35:03.821895 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:35:05.821897 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:35:07.821742 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:35:09.720316 ARP, Request who-has 192.168.1.2 tell 192.168.1.1, length 28
00:35:09.721145 ARP, Reply 192.168.1.2 is-at 00:50:c2:63:d0:01 (oui Unknown), 
length 46
00:35:09.721480 IP 192.168.1.1 > 192.168.1.2: ICMP echo request, id 42500, seq 
30976, length 64
00:35:09.722966 IP 192.168.1.2 > 192.168.1.1: ICMP echo reply, id 42500, seq 
30976, length 64
00:35:09.821787 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:35:11.821736 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:35:13.821875 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:35:14.721818 ARP, Request who-has 192.168.1.1 tell 192.168.1.2, length 46
00:35:14.722244 ARP, Reply 192.168.1.1 is-at 00:50:c2:63:d0:65 (oui Unknown), 
length 28
00:35:14.770793 IP 192.168.1.1 > 192.168.1.2: ICMP echo request, id 42500, seq 
32256, length 64
00:35:14.772444 IP 192.168.1.2 > 192.168.1.1: ICMP echo reply, id 42500, seq 
32256, length 64
00:35:15.780868 IP 192.168.1.1 > 192.168.1.2: ICMP echo request, id 42500, seq 
32512, length 64
00:35:15.782596 IP 192.168.1.2 > 192.168.1.1: ICMP echo reply, id 42500, seq 
32512, length 64
00:35:15.821868 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:35:17.821864 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:35:19.821856 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
00:35:21.821836 STP 802.1d, Config, Flags [none], bridge-id 
8000.00:50:c2:63:d0:01.8001, length 43
----------------------------------------------------------------------------

Why is this happening?  Why would receiving an STP frame cause the board to stop 
sending the ICMP echo requests and then have to request ARP information again. 
Is there something that I'm missing in setting up the bridges?

I'm not sure if the drivers we are using (and ethernet devices for that matter) 
have been used in STP enabled bridges or not and if there are issues with that. 
  I'm going to add debug to the kernel to see if I can find out exactly what is 
going on.

If anyone has any information about what might be going on here I would greatly 
appreciate it.  I am new to bridges and STP, so I'm unsure where this issue 
lies.  I am also going to try to get my hands on two Linux PCs with multiple 
NICs so that I can try creating STP enabled bridges with them to see if we have 
similar issues.

Sorry for the long email.  If there is any other information that would help 
debugging this issue I can provide it.

Thanks,
Andrew McKay
Iders Inc.
