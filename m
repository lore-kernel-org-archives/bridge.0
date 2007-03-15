Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 15 Mar 2007 17:59:34 -0000
Message-ID: <BB501CE635E5144CA5E30956E5E32C52271F0F@exchange-be5.lancs.local>
References: <BB501CE635E5144CA5E30956E5E32C52271F0E@exchange-be5.lancs.local>
From: "Egi, Norbert" <n.egi@lancaster.ac.uk>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Performance loss with bridging+routing.
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Egi, Norbert" <n.egi@lancaster.ac.uk>, bridge@lists.osdl.org

Sorry, it looks like the spaces have different sizes in my mailing system. I hope the graphs are more readable now.
 
Hi,
 
I have a machine with 4 Ethernet intefaces and I set up the configuration you can see below (only the first "figure"). There are two subnetworks each having a bridge with 2 interfaces and both of the bridges have an IP address for packet forwarding between the two subnetworks.
 
HOST1 --------------- ETH0                ETH2 --------------- HOST3
10.1.1.3               |                   |                 10.2.2.3
                      BR0 --- ROUTING --- BR1
                    10.1.1.1            10.2.2.1
                       |                   |
HOST2 --------------- ETH1                ETH3 --------------- HOST4
10.1.1.2                                                      10.2.2.2
 
My problem is that if I forward packets (64byte minimum size packets) between two machines on the same network (i.e. only bridging is done) I get ~700.000 pps throughput, while if packets are going from one subnetwork to the other, so packets are also routed between the two subnetwork, the forwarded packet rate is only ~525.000 pps, so ~25% worse.
 
To find out how bridging and routing perform on their own with only 2 interfaces I set up the following to topologies and forwarded packets from HOST1 to HOST2.
 
                       --- BRIDGING ---
                       |              |
HOST1 --------------- ETH0           ETH1 --------------- HOST2
10.1.1.1       Promisc(0.0.0.0)   Promisc(0.0.0.0)      10.1.1.2
 
 
                       --- ROUTING ---
                       |             |
HOST1 --------------- ETH0          ETH1 --------------- HOST2
10.1.1.2             10.1.1.1      10.2.2.1            10.2.2.2
 
With the bridged setup I get ~700.000 pps like before and in the routed setup ~685.000 pps, just a little bit below the bridged setup. This is good, exactly what I would have expect. However when I set up the configuration below, which is very similar to the first one above, only two interfaces are missing, I only get ~525.000 pps again.
 
                       --- ROUTING ---
                       |             |
                      BR0           BR1
                   10.1.1.1       10.2.2.1
                       |             |
HOST1 --------------- ETH0          ETH1 --------------- HOST2
10.1.1.2       Promisc(0.0.0.0)  Promisc(0.0.0.0)      10.2.2.2
 
I have expected a little performance degradation compared to plain routing as a packet traverses two bridges besides being routed as well, but I think ~175.000 pps is too much.
 
I checked the MAC addresses learnt by both bridges and everything seemed alright. My assumption is that the bottleneck is in the bridge when it has to pass the packets up to the IP layer as opposed to when it has to send the packet out on another port, but I wouldn't expect such a big difference as it looks to me that very similar things should go on inside the bridge in both cases.
 
Has anyone had similar experience or I'm doing something wrong when combining bridging and routing?
If this is a normal behaviour could anyone tell me where and why the packets got dropped? Or why the performance loss occurs?
 
Any suggestions are very welcome.
 
Norbert

________________________________

From: bridge-bounces@lists.osdl.org on behalf of Egi, Norbert
Sent: Thu 3/15/2007 17:05
To: bridge@lists.osdl.org
Subject: [Bridge] Performance loss with bridging+routing.



Hi,

I have a machine with 4 Ethernet intefaces and I set up the configuration you can see below (only the first "figure"). There are two subnetworks each having a bridge with 2 interfaces and both of the bridges have an IP address for packet forwarding between the two subnetworks.

HOST1 --------------- ETH0                            ETH2 --------------- HOST3
10.1.1.3                           |                                     |                             10.2.2.3
                                     BR0 --- ROUTING --- BR1
                                  10.1.1.1                         10.2.2.1
                                        |                                     |
HOST2 --------------- ETH1                            ETH3 --------------- HOST4
10.1.1.2                                                                                              10.2.2.2

My problem is that if I forward packets (64byte minimum size packets) between two machines on the same network (i.e. only bridging is done) I get ~700.000 pps throughput, while if packets are going from one subnetwork to the other, so packets are also routed between the two subnetwork, the forwarded packet rate is only ~525.000 pps, so ~25% worse.

To find out how bridging and routing perform on their own with only 2 interfaces I set up the following to topologies and forwarded packets from HOST1 to HOST2.

                                        --- BRIDGING ---
                                        |                            |
HOST1 --------------- ETH0                    ETH1 --------------- HOST2
10.1.1.1                Promisc(0.0.0.0)       Promisc(0.0.0.0)            10.1.1.2


                                        --- ROUTING ---
                                        |                           |
HOST1 --------------- ETH0                   ETH1 --------------- HOST2
10.1.1.2                      10.1.1.1                10.2.2.1                      10.2.2.2

With the bridged setup I get ~700.000 pps like before and in the routed setup ~685.000 pps, just a little bit below the bridged setup. This is good, exactly what I would have expect. However when I set up the configuration below, which is very similar to the first one above, only two interfaces are missing, I only get ~525.000 pps again.

                                        --- ROUTING ---
                                        |                           |
                                     BR0                     BR1
                                  10.1.1.1               10.2.2.1
                                        |                           |
HOST1 --------------- ETH0                   ETH1 --------------- HOST2
10.1.1.2                Promisc(0.0.0.0)       Promisc(0.0.0.0)           10.2.2.2

I have expected a little performance degradation compared to plain routing as a packet traverses two bridges besides being routed as well, but I think ~175.000 pps is too much.

I checked the MAC addresses learnt by both bridges and everything seemed alright. My assumption is that the bottleneck is in the bridge when it has to pass the packets up to the IP layer as opposed to when it has to send the packet out on another port, but I wouldn't expect such a big difference as it looks to me that very similar things should go on inside the bridge in both cases.

Has anyone had similar experience or I'm doing something wrong when combining bridging and routing?
If this is a normal behaviour could anyone tell me where and why the packets got dropped? Or why the performance loss occurs?

Any suggestions are very welcome.

Norbert

_______________________________________________
Bridge mailing list
Bridge@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/bridge



