From: Diego Liziero <liziero.diego@unimore.it>
Content-Type: text/plain
Message-Id: <1084467136.3083.27.camel@igno>
Mime-Version: 1.0
Date: Thu, 13 May 2004 18:52:16 +0200
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridging bluetooth bnep devices with kernel 2.6.6-*
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

It seems that switching from 2.4.x to 2.6.x
caused the bridge of more than a bnep (Bluetooth)
device to stop to work.

Details on this kind of bridging at:
http://www.cs.ucla.edu/~cclljj/interest/notes/bluez/pand_bridge_nap.html

Note that the MAC address of all these devices is the same,
as they belong to the same bluetooth device.

# ifconfig bnep0
bnep0     Link encap:Ethernet  HWaddr 00:02:72:80:1B:3B
          inet6 addr: fe80::202:72ff:fe80:1b3b/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:537 errors:0 dropped:0 overruns:0 frame:0
          TX packets:138 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:69267 (67.6 KiB)  TX bytes:24779 (24.1 KiB)

# ifconfig bnep1
bnep1     Link encap:Ethernet  HWaddr 00:02:72:80:1B:3B
          inet6 addr: fe80::202:72ff:fe80:1b3b/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:14 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:5094 (4.9 KiB)  TX bytes:356 (356.0 b)

What I did is:

# brctl addbr pan0
# ifconfig pan0 192.168.111.1
# brctl setfd pan0 0
# brctl stp pan0 disable

# brctl addif pan0 bnep0
# ifconfig bnep0 0.0.0.0

And the first bluetooth link works fine,
but when I try to add a second link I get:

# brctl addif pan0 bnep1
can't add bnep1 to bridge pan0: File exists
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

if I try to remove bnep1:
# brctl delif pan0 bnep1
device bnep1 is not a slave of pan0

With kernel 2.4.x instead everything works.
Any suggestion?

Regards,

Diego.

