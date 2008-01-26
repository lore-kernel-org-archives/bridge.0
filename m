Date: Sat, 26 Jan 2008 22:56:22 +0600
From: Oleg Serditov <zir@pinta.ws>
Message-ID: <189835152.20080126225622@pinta.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Learning BPDU source MACs in BLOCKING state => loss of IP
	connectivity
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello to all.

I'm running 2.6.12, uClinux distribution for the Blackfin processor. I
am experiencing a problem which prevents two boxes connected by a pair
of links from being able to ping each other.

The  network  setup  described  below  is presumably rather common - I
don't do anything special.

The problem arises when you have specific combination of interface MAC
addresses  (and/or  STP  bridge  priorities,  port priorities and link
costs;  if  you're  unlucky  enough,  like  in  my  case, standard STP
settings will do).

I've  read the list archive carefully, and searched the Web, wondering
if  this problem was solved in more recent kernels, but didn't find an
answer. So, please, don't blame me too much if I'll tell you something
already well known :)

The  network consists of two uClinux boxes. The boxes are connected by
two   links  to  provide  failover.  Each  of  them  has  two  network
interfaces,  grouped into a bridge. The bridges have IP addresses from
the  same  subnet,  so they should be able to ping each other. And, of
course, they run STP.

 Box 1                         Box 2

 ----- eth1               eth1 -----
|     |--------Link 1---------|     |
|     |--------Link 2---------|     |
 ----- eth2               eth2 -----

  br1                           br2
10.0.0.1                      10.0.0.2


Let's  assume  Box  1 is elected as the root bridge, and Box 2 has its
eth2  in  BLOCKING  state.  Then br2 shouldn't learn any MAC addresses
from eth2, as proposed by the IEEE Std 802.1D-2004:

> Clause 7.8 The Learning Process
> 
> The Learning Process shall create or update a Dynamic Filtering Entry
> (7.9, 7.9.2) in the Filtering Database, associating the MAC Address in
> the source address field of the frame with the receiving Port, if and
> only if
> a) The receiving Port is in the Learning State or the
> Forwarding State (7.4), and
<other conditions follow, ANDed together>

But,  in my case, it isn't so: "brctl showmacs br2" on Box 2 shows two
permanent  entries  for  the  addresses of local eth1 and eth2 and two
dynamic  entries  for  remote  eth1  and eth2, which are updated every
HELLO_TIME.  Note that if br1 floods non-STP frames (ARP requests, for
example)  out  of its ports, the source addresses get learned by br2's
ports as expected (i.e., by eth1 and not eth2 which is BLOCKING).

Let's  assume  that the MAC address of br1's eth2 is less than that of
eth1.  Then br1 will get its MAC address from eth2 (which is connected
to the link that is seen as BLOCKING by br2, remember?)

Now we've got a problem.

Symptoms.

I'm able to ping Box 2 from Box 1, but, when pinging Box 1 from Box 2,
I  get  packet  losses  about  90%  (for  the  default HELLO_TIME of 2
seconds).

Cause, as it is seen by me.

1) Consider the case when I ping Box 2 from Box 1 (successfully).
a) Box 1 floods an ARP request; Box 2 sees it on its eth1, learns that
the  source is connected to eth1 and unicasts a reply; br1 learns that
br2's MAC address is connected to eth1.
b) ICMP echo request is unicast by br1 through eth1.
c) br2  again  learns that br1's MAC address is connected to eth1 and
unicasts an echo reply.
d) Repeat b) and c) as needed.
All works OK.

2) I ping Box 1 from Box 2.
a) br2  floods  an  ARP  request  (but  its  eth2  is BLOCKING, so it
broadcasts  the request out of eth1); br1 learns that br2 is connected
to eth1 and unicasts a reply; br2 learns about br1 on eth1.
b) br2 unicasts an echo request through eth1 and gets a reply.
c) From  now, b) should have been repeated as many times as needed...
but  as  soon  as  the hello timer of br1 expires, it will send a BPDU
through  eth2.  Then  br2  (incorrectly) assumes that now br1's MAC is
connected  to eth2, which is BLOCKING. So br1 becomes unreachable, and
the following echo requests can't be sent.
d) After  some  time passes, br2 succeeds in sending up to HELLO_TIME
more pings. Maybe it is caused by NUD subsystem, which eventually ARPs
for br2's address to check if it is still can be reached? Flushing the
ARP cache of Box 2 also returns us to the step a).

Note  that  the situation doesn't depend on br2's MAC address (I mean,
is  it  equal  to  its  eth1's  or  eth2's address). However, if br1's
address equals to the address of its eth1, pinging is possible in both
directions, as expected.

I'd  like  to know if the problem is specific to the kernel version or
distribution  I'm  running. Any comments or suggestions will be highly
appreciated. Thanks.

-- 
Best regards,
Oleg

