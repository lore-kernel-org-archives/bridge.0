MIME-Version: 1.0
Sender: jarrod.lowe@gmail.com
Date: Thu, 4 Feb 2010 12:26:20 +0000
Message-ID: <15f314a41002040426u74e48e8hecf5888d47599e5c@mail.gmail.com>
From: J L <lists@rrod.net>
Content-Type: text/plain; charset=UTF-8
Subject: [Bridge] Routing between bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I have an annoying problem, of the "it used to work" kind of variety.

The short version: I have two bridges on a linux box. Each bridge has
an IP address. I connect two other boxes, one to each bridge, and set
the appropriate bridge's IP address. However, my box won't route
between the bridges. How can I get it to do so?



The long version: (I know it is stupid to have just one interface per
bridge, but I am using this example as it is the simplest example of
the issue):

I have three machines - A, B, and R:

A[eth0] --- [tap0][br0] R [br1][eth1] ---- [eth0] B

A is connected to tap0 of R, which is a member of br0 on R.
B is connected to eth1 of R, which is a member of br1 on R.

A is on 192.168.1.10/24. The default gateway is 192.168.1.1 (R:br0)
B is on 192.168.2.20/24. The default gateway is 192.168.2.1 (R:br1)

R:br0 is on 192.168.1.1/24
R:br1 is on 192.168.2.1/24
R is an Ubuntu 9.10 box with kernel 2.6.31

All firewalls are disabled (no rules, policy ACCEPT), and on R ip_forward = 1.

If I sent a packet from A -> B (or B -> A), tcpdump shows it appearing
on the first bridge, with a destination MAC address of the appropriate
brX, but never on the second bridge.

I think the kernel has received the packet onto the bridge, but either
it has not accepted the packet (despite having a local destination
MAC) or it has accepted the packet, but then decided not to forward
it.

It "used to work" and I have no idea what I have done to break it.

I have modified the above setup to have '-j LOG' rules on INPUT,
OUTPUT and FORWARD (but still policy ACCEPT), and the log files show
*no* relevant entries at all, even though
/proc/sys/net/bridge/bridge-nf-call-* are all '1'.

I have tried STP on and off, rp_filter on and off.

Does anyone have any idea what I am missing?

Thanks,
-- 
Jarrod Lowe
