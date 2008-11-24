Message-ID: <492A8A22.1090509@gmxpro.de>
Date: Mon, 24 Nov 2008 12:04:02 +0100
From: Andre iosT <andre.iost@gmxpro.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Using 2 Bridges Simultaneously for "Load Balancing"
Reply-To: noway@gmx.org
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

I have trouble entirely understanding the bridging concept in Linux. My 
problem:

I have a rather powerful workstation running Ubuntu 8.10 64 Bit. On this 
I want to use 4 virtual machines using VirtualBox. To split the network 
load I installed a second NIC in addition to the built-in one.

According to the VirtualBox Manual to use Host Interface Networking I 
need to create a bridge with a physical interface assigned to it. Then, 
virtual host interfaces are created and added to the bridge. These 
virtual interfaces then communicate via the bridge (and therefore, the 
physical interface) with the outside network/internet.

Now I thought it was possible to create to of those bridges, each one 
with one physical NIC. Then I could assign two virtual machines to each 
bridge/NIC in order to balance or distribute the load.

My trials weren't successful and I have the suspicion that the 
simultaneous use of two bridges is impossible. Can anyone make a 
suggestion for a working configuration or rid me of my illusions ;)?

Configuration:

Dell Precision T5400 with one built-in NIC and an additional one.

eth0: internal NIC
	should be assigned to bridge br0
	with vbox0 and vbox1 assigned (for the virtual boxes 0 and 1)
eth1: additional NIC
	should be assigned to bridge br1
	with vbox2 and vbox3 assigned (for the virtual boxes 2 and 3)

My (not working) /etc/network/interfaces configuration:

auto br0 br1

iface br0 inet static
	address xxx.xxx.xxx.1
	netmask 255.255.255.0
	gateway xxx.xxx.xxx.254
	bridge_ports eth0	

iface br1 inet static
	address xxx.xxx.xxx.2
	netmask 255.255.255.0
	gateway xxx.xxx.xxx.254
	bridge_ports eth1

The nameserver is defined in the resolv.conf. I did not alter or adapt 
the routing tables, maybe that's the whole problem? On the other hand I 
read about STP but don't know if this applies here. If br1 is down I 
have access to the internet. After the activation of br1 in addition to 
br0, I have no connections to the outside world.

Any help would be greatly appreciated!
Waldgeist
	
