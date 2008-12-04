From: Matthew Kent <matt@bravenet.com>
Content-Type: text/plain
Date: Wed, 03 Dec 2008 16:20:57 -0800
Message-Id: <1228350057.4344.141.camel@fuego>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] received packet with own address as source address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: bonding-devel@lists.sourceforge.net

Trying to determine if I have a misconfiguration, misunderstanding or
have stumbled on a bug.

Have a CentOS 5.2 server with 2 e1000e nics in a balance-xor bond, check
this out: 


Test 1 - arping the bond device @ 172.16.0.117 from a second machine
---
root@foo [/root]# arping -c 1 -b -I eth0 172.16.0.117
ARPING 172.16.0.117 from 172.16.0.116 eth0
Unicast reply from 172.16.0.117 [00:15:17:70:A3:88]  0.607ms
Unicast reply from 172.16.0.117 [00:15:17:70:A3:88]  0.648ms
Sent 1 probes (1 broadcast(s))
Received 2 response(s)

Nothing logged to the kernel ring buffer on the server. All looks good
and happy.


Test 2 - now add a bridge @ 172.16.0.117 with the bond as a port:
---
root@foo [/root]# arping -c 1 -b -I eth0 172.16.0.117
ARPING 172.16.0.117 from 172.16.0.116 eth0
Unicast reply from 172.16.0.117 [00:15:17:70:A3:88]  0.603ms
Unicast reply from 172.16.0.117 [00:15:17:70:A3:88]  0.642ms
Sent 1 probes (1 broadcast(s))
Received 2 response(s)

Looks good, traffic moves, etc but now the following gets logged on the
server for every broadcast packet:

[26489.040112] bond0: received packet with  own address as source
address


Capturing the traffic for both tests and comparing, they look identical,
but the bridge wants to throw the warning level message in
net/bridge/br_fdb.c br_fdb_update(). The printk warning, being rate
limited, seems to add a noticable lag. Disabling the warning with a
patch made things happy again.

Couple questions from this for the more knowledgeable folks:

1) Are the two arp replies from a balance-xor bond normal?

2) Should the bridge handle this or should I just not be tying an ip to
the bridge in balance-xor mode?

Thanks for your time!
-- 
Matthew Kent \ SA \ bravenet.com

