MIME-Version: 1.0
Date: Sat, 05 Dec 2009 17:30:33 +0100
From: Sander Klein <roedie@roedie.nl>
Message-ID: <7a0b4b1b5dc484f5e0c2f619d4bfb804@localhost>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Subject: [Bridge] Bridge - vlan - bond
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge <bridge@lists.linux-foundation.org>

Hi list,

I have a problem with using bonding, with vlans and bridging. I'm trying
to create the following situation:

Network overview:

               +------+
+--------+     |blade |
|        |-----|switch| eth0 +------+
|        |     |      |------|      |
|        |     +------+      |      |
| switch |                   | host |
|        |     +------+      |      |
|        |     |blade |------|      |
|        |-----|switch| eth1 +------+
+--------+     |      |
               +------+

Situation on the host:

+----+
|eth0|------+
+----+      |
         +-----+   +---------+   +-----+
         |bond0|---|bond0.101|---|br101|
         +-----+   +---------+   +-----+
+----+      |
|eth1|------+
+----+


Now, as soon as the bridge comes up I get the error 'bond0.101: received
packet with  own address as source address'. This happens every time I
start a new sessioen to a host. Sniffing with tcpdump and wireshark on
br101 show all arp packets 2 times. I cannot figure out why this is
happening. When I create this situation without the bridge I do not get
duplicate traffic, so it's not coming from the network.

My config is:

auto bond0
iface bond0 inet manual
        slaves eth0 eth1
        bond_primary eth0
        bond_mode active-backup
        bond_miimon 100

auto bond0.101
iface bond0.101 inet manual

auto br0
iface br0 inet static
        bridge_ports bond0.101
        bridge_stp off
        address 192.168.1.25
        netmask 255.255.255.0
        gateway 192.168.1.1

I've tried this with the stock Debian Lenny kernel (2.6.26) and 2.6.32. Am
I doing something wrong here?

Greets,

Sander Klein

