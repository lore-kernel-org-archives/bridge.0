Message-Id: <200501262052.j0QKqETV007434@fire-1.osdl.org>
From: <dan-linuxbridge@unpossible.com>
Sender: "Dan Grigsby" <dan@unpossible.com>
Date: Wed, 26 Jan 2005 14:52:13 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Benchmarking bridging vs. routing on same hardware/network
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I have been running benchmarks to compare the performance of bridging to
routing on the same hardware.  

The bridge/router system is a dual Opteron 246 (2.0Ghz); Tyan 2882
motherboard; 2 GB PC3200 memory (1 GB in each CPU's bank; 128bit
configuration); dual e1000 based NIC; PCI-X 133Mhz; 2.6.9 Kernel; NAPI
enabled in the kernel and the NIC drivers; CPU affinity ties each eth to a
specific CPU; system otherwise idle.  

My test configuration is:

Packet Generator System <--> Bridge/Router <--> Packet Recipient

The network and hosts are otherwise idle.

Using pktgen (the Linux packet generator) I can send 459,000pps through this
hardware when it is configured as a router.  I only get 252,000pps through
the hardware when configured as a bridge.  

Needless to say, I use two IP subnets when routing, and a single subnet
while bridging.  Also, when routing I set the mac addr destination for
pktgen to the router interface (otherwise it won't pick up the packets),
whereas when bridging I set it to the recipient's mac address.

Any ideas why the performance of the bridge is so bad?  


