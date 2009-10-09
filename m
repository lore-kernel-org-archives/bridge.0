MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; charset=US-ASCII
Date: Fri, 09 Oct 2009 04:10:16 +0200
From: Mircea Gherzan <mircea.gherzan@rwth-aachen.de>
Message-id: <20091009041016.0f3fe1f0@beast3>
Subject: [Bridge] bridge in promiscuous mode
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

I'm pretty new to bridging and I'm stumbling upon some strange
behaviour. Please imagine the following simple topology:

    device				laptop
---------------
|br0 |  wlan0 |  (-------802.11 g------) wlan1
---------------


* layer2 between the two wlan's is working.
* all 3 interfaces are on the same subnet. 
* On the device, the only route to that subnet is via br0.
* br0 has a different MAC from the one of wlan0
* STP is disabled
* the device is running 2.6.31 vanilla

If PROMISC is NOT enabled on br0, I can't ping it from wlan1. I could
observe the following with tcpdump -p:
* br0 correctly receives ARP request and sends out replies 
* ICMP echo packet reach wlan0, but
* no ICMP packets reach br0 (the only frames that reach br0 are ARP)

On the other hand, if PROMISC is enabled on br0, pinging it from wlan1
just works. 

I've checked the bridging page from the LF wiki, and I've disabled the
bridge-nf-* entries, but the behaviour did no change.

My goals are the following:
* no IP address on wlan0
* different MACs on br0 and wlan0
* br0 reachable from wlan1

Please, can anyone help me on this one?

Thanks,
Mircea

-- 
Dipl.-Ing. Mircea Gherzan
