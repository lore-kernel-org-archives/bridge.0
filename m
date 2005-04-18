Message-Id: <5.2.0.9.1.20050418141522.03375db0@mailhost.csse.uwa.edu.au>
Date: Mon, 18 Apr 2005 14:40:57 +0800
From: Ryan McConigley <ryan@csse.uwa.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: [Bridge] Unexpected behaviour
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org


	Hi, I've set up a bridge using the 2.6.11.6 kernel.  The machine is 
running Debian testing with three NICs in it.  eth0 is a standard 100Mb 
Intel NIC, eth1 and eth2 are both Intel gigabit cards using the e1000 driver.

	I tested everything at 100Mb and it worked fine.  I moved the machine into 
production, eth1 plugging into a dumb 100Mb D-link switch, eth2 plugging 
into a shiney new Cisco 2950.

	eth2 connects fine, giving me messages such as:
Apr 18 13:58:39 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
Down
Apr 18 13:58:56 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
Up 100 Mbps Full Duplex
Apr 18 13:58:56 portcullis kernel: br0: port 2(eth2) entering learning state
Apr 18 13:59:11 portcullis kernel: br0: topology change detected, propagating
Apr 18 13:59:11 portcullis kernel: br0: port 2(eth2) entering forwarding state

	eth1 however is a different story.  If I plugged that into the D-Link it 
would come up for a few seconds, then down again, then up and just cycle 
between being up and down.  Example:

Apr 18 13:58:26 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
Down
Apr 18 13:58:26 portcullis kernel: br0: port 2(eth2) entering disabled state
Apr 18 13:58:27 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
Up 100 Mbps Full Duplex
Apr 18 13:58:27 portcullis kernel: br0: port 2(eth2) entering learning state
Apr 18 13:58:27 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
Down
Apr 18 13:58:28 portcullis kernel: br0: port 2(eth2) entering disabled state
Apr 18 13:58:29 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
Up 100 Mbps Full Duplex
Apr 18 13:58:29 portcullis kernel: br0: port 2(eth2) entering learning state
Apr 18 13:58:29 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
Down
Apr 18 13:58:30 portcullis kernel: br0: port 2(eth2) entering disabled state
Apr 18 13:58:32 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
Up 100 Mbps Full Duplex
Apr 18 13:58:32 portcullis kernel: br0: port 2(eth2) entering learning state

	I do have it running now by plugging it into a gigabit switch where it 
connects at 1G, then plugging the gig switch into the D-link, not an ideal 
solution, but one that appears to be working ok.

	I'm curious if anyone knows why this is happening.  Its a first for me, 
but this also is the first bridge I've made which features gigabit 
cards.  Interestingly if I swap over eth1 and eth2 (so eth1 goes into the 
Cisco and eth2 goes to the D-link) the same flipflop state occurs.

	If it helps, here is the relevant ifconfig:

br0       Link encap:Ethernet  HWaddr 00:03:47:DF:7A:61
           inet6 addr: fe80::203:47ff:fedf:7a61/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:34792 errors:0 dropped:0 overruns:0 frame:0
           TX packets:5 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:2778388 (2.6 MiB)  TX bytes:378 (378.0 b)

eth1      Link encap:Ethernet  HWaddr 00:03:47:DF:7A:7F
           inet6 addr: fe80::203:47ff:fedf:7a7f/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:737391 errors:3 dropped:0 overruns:0 frame:2
           TX packets:745309 errors:0 dropped:0 overruns:0 carrier:744737
           collisions:0 txqueuelen:1000
           RX bytes:164455079 (156.8 MiB)  TX bytes:132234584 (126.1 MiB)
           Memory:dffa0000-dffc0000

eth2      Link encap:Ethernet  HWaddr 00:03:47:DF:7A:61
           inet6 addr: fe80::203:47ff:fedf:7a61/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:780490 errors:0 dropped:0 overruns:0 frame:0
           TX packets:736398 errors:0 dropped:0 overruns:0 carrier:725057
           collisions:0 txqueuelen:1000
           RX bytes:137698592 (131.3 MiB)  TX bytes:164346713 (156.7 MiB)
           Memory:dff60000-dff80000

	As I said, everything is working now, but I'd like to know a cause and 
possibly a cure if its available.

	Cheers,
		Ryan.
--
           Ryan McConigley - Systems Administrator                  _.-,
      Computer Science   University of Western Australia        .--'  '-._
        Tel: (+61 8) 6488 7082 - Fax: (+61 8) 6488 1089       _/`-  _      '.
Ryan[@]csse.uwa.edu.au - http://www.csse.uwa.edu.au/~ryan  '----'._`.----. \
                                                                      `     \;
  "You're just jealous because the voices are talking to me"                ;_\



