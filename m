Message-ID: <21909438.382941306864132965.JavaMail.defaultUser@defaultHost>
Date: Tue, 31 May 2011 19:48:52 +0200 (CEST)
From: "maxd@inwind.it" <maxd@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] IGMP snooping not filtering multicast messages
Reply-To: "maxd@inwind.it" <maxd@inwind.it>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi. I have a partial mesh network composed by Linux nodes. Each linux node may 
have up to 4 ethernet interfaces, which are exploited to create point-to-point 
connections with other linux nodes. I have bridged the ethernet interfaces in 
each node, so that the whole network, which is physically composed by a set of 
network segments, appears as a single layer-2 domain. I have enabled spanning 
tree to avoid loops. In this scenario, I would like to exploit the IGMP 
snooping functionality, but it seems that it is not working properly. I am 
using iperf to set a multicast source (iperf client) and a few multicast sinks 
in the network (iperf servers). I am using tcpdump, instead, to check where 
multicast messages are received. What I notice is that there is apparently no 
filtering of the multicast messages, that are always flooded in the network. I 
tried to repeat the test varying the multicast address (paying attention not to 
get reserved addresses), with and without multicast clients set, with the 
multicast_router option set to 1 (default) and to 0. To double check that IGMP 
is working, I have also tried to disable it; the only difference I see is that 
tcpdump does not show IGMP query messages when the IGMP snooping is disabled. 
So, I am wondering if the IGMP snooping implementation currently available can 
deal with my scenario. In particular, I would stress the following points that 
I think might be relevant:
-I have no multicast router in my network (it looks like a single stand-alone 
lan)
-Each node acts as a bridge, so I have multiple bridges in my network, 
connected each other.
Any idea would be greatly appreciated!

Massimiliano
