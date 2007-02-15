Message-ID: <BAY131-F1857AFF907BF1716A253BBE2960@phx.gbl>
From: "saravanan chanemouganandam" <saravanan_sprt@hotmail.com>
Date: Thu, 15 Feb 2007 22:06:44 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: [Bridge] bridge problem
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org
Cc: netfilter@lists.netfilter.org

Hi,

I am a newbie to use the bridge utils and after some serious tests I am 
posting this issue. Actually, I am fascing packet forwarding problem in the 
following network setup under linux 2.6.16. The 2.6.16 kernel is also 
configured to include 802.1d Ethernet bridging, Network packet filtering, IP 
netfilter configuration and Bridge netfilter configuration.

The target ARM board is made to act as a bridge between the Host and the 
Router as shown below.

10.1.111.3 Host(eth0)<---->{ eth0 bridge(10.1.111.1) eth1 }<--->Router( 
10.1.111.254)

On the target board

ifconfig eth0 0.0.0.0
ifconfig eth1 0.0.0.0
brctl addbr br0
brctl addif br0 eth0
brctl addif br0 eth1
ifconfig br0 10.1.111.1 netmask 255.255.255.0 up
echo 1 > /proc/sys/net/ipv4/ip_forward

are configured. The problem is that, I can't ping the Router from the Host. 
But from the bridge, I can ping Router and Host. The "arp reply" from the 
Router is not reaching the Host as there's a problem in the bridge 
(bridge-utils 1.2) interface.

I have cross checked the kernel configuration to include all the packet 
forwarding and bridging. But still panic.

Can any one please precise what could cause this packet forward problem ?

Thanks
Sara

_________________________________________________________________
Gossips, movie reviews, photogallery and more 
http://content.msn.co.in/Entertainment/Default

