From: Leonardo Borda <leonardo.borda@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Mar 2011 15:09:58 -0500
Message-ID: <1299787798.4801.18.camel@bordalnx>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge + bonding with arp monitoring enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello Guys,

I am trying to configure bridge + bonding with arp monitoring enabled.
Whenever I activate the bridge interface and assign bond0 to the bridge
Everything stops working. 

I am on ubuntu 10.04 LTS.

Can I have an ip address in the bond0 interface WHILE not having an IP
address in the bridge interface? In order to have bond arp monitoring I
must have an ip address in the bond interface as far as I understand.

Here it is my current configuration. 
PS: I have seen similar configurations although none of them have an ip
address configured in the bond0 interface. 

# The loopback network interface
auto lo
iface lo inet loopback

auto bond0
iface bond0 inet static
        address 10.153.107.110
        netmask 255.255.255.0
        gateway 10.153.107.1
bond-slaves none
bond-mode active-backup
bond_arp_ip_target 10.153.107.1
bond_arp_interval 500

auto eth0
iface eth0 inet manual
bond-master bond0
bond-primary eth0 eth1

auto eth1
iface eth1 inet manual
bond-master bond0
bond-primary eth0 eth1

auto br0
iface br0 inet manual
    bridge_ports bond0
    bridge_stp off
    bridge_fd 9
    bridge_hello 2
    bridge_maxage 12
    bridge_maxwait 0

Leonardo


