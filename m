Message-ID: <44996B9E.8030704@kingsley.co.za>
Date: Wed, 21 Jun 2006 17:54:06 +0200
From: Etienne Pretorius <etiennep@kingsley.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Newbie at work - need some advise/guidence please.
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello all,

I am new to Linux Ethernet bridging. Let me first start with what I am 
trying to achieve. Well you see - I am attempting to have 2 main 
firewall running at the same time - one as a master and the other one as 
a slave. Yes, I would like to make use of Ethernet bridging in this 
scenario - as I understand it, all I need are two machines and STP 
enabled. I am running Debian Stable/Sarge and have installed Kernel 
2.6.8, and I am using brctl as my user space util, I also have ebtables 
and iptables on the same machine (the slave) running fine and well. At 
the moment I have the main firewall doing little then just a grandeur 
network switch with iptables filtering on.

My slave machine is broken into 2 logical bridge devices, br0 (internal 
network) with 2 ports and br1 (external network) with 4 ports. I needed 
to give both IP addresses as I am forwarding packets from the internal 
network (br0) though to the internal via (br1). This slave firewall 
machine is doing mail-scanning and ftp/http proxying as well.

My problem exists when I attempt to plug in the slave machine into my 
network - I assume that I am receiving masses of packets looping in our 
network:
    Jun 21 12:46:58 geminus kernel: eth4: Oversized Ethernet frame, 
status 0118c600.
    Jun 21 12:47:24 geminus kernel: eth0: received packet with  own 
address as source address
And sluggish tty response when entering into console.

I have attempted to enable STP on both network bridges and I am still 
faced with the same scenario. I am either missing something crucial - as 
it seems that BOTH seem to be trying to relay traffic...

                                               +------------[Internet]
                                                |
                                        |-[router1]-|
                                        |-[router2]-|
[Master Firewall]---------|-[router3]-|------------[Slave Firewall]
                                        |-[router4]-|
                                        |-[router5]-|
                                                 |
         [internal network]--------+

I have attempted to assign different bridge priorities to both an yet I 
am still having the same issues. Here are some configs of both machines.
-------------------[slave]--------------------
    # The internal network interface
    auto br0
    iface br0 inet static
        address 192.168.5.11
        netmask 255.255.255.0
        bridge_ports eth0 eth1

    # The external network interface
    auto br1
    iface br1 inet static
        address [public ip address]
        netmask 255.255.0.0
        bridge_ports eth2 eth3 eth4 eth5 eth6

    #Using ip route2 to do policy based routing.
<<EOF
bridge name     bridge id               STP enabled     interfaces
br0             8000.0008a17aaf17       yes              eth0
                                                        eth1
br1             8000.000d88687d2c       yes              eth2
                                                        eth3
                                                        eth4
                                                        eth5
                                                        eth6
Bridge table: filter
Bridge chain: INPUT, entries: 2, policy: DROP
-p IPv4 -j ACCEPT
-p ARP -j ACCEPT
Bridge chain: FORWARD, entries: 2, policy: DROP
-p IPv4 -j ACCEPT
-p ARP -j ACCEPT
Bridge chain: OUTPUT, entries: 2, policy: DROP
-p IPv4 -j ACCEPT
-p ARP -j ACCEPT
-------------------[master]--------------------
### bridging interface
auto br0
iface br0 inet static
    address 192.168.0.1
    netmask 255.255.255.255

    bridge_ports eth1 eth2 eth3 eth4 eth5
    bridge_maxwait 3

    post-up /sbin/ip address del dev br0 192.168.0.1/32
    post-up /sbin/ip route add dev br0 via  [public ip address] src 
[public ip address]
    post-up /sbin/ifconfig br0:1 192.168.5.1 netmask 255.255.255.0 up
    pre-down /sbin/ip address flush dev br0
<<EOF

bridge name     bridge id               STP enabled     interfaces
br0             0000.000d885348c4       yes             eth1
                                                        eth2
                                                        eth3
                                                        eth4
                                                        eth5

Bridge table: filter
Bridge chain: INPUT, entries: 0, policy: ACCEPT
Bridge chain: FORWARD, entries: 0, policy: ACCEPT
Bridge chain: OUTPUT, entries: 0, policy: ACCEPT
---------------------------------------------------------------------

If there is more you need please ask me and I'll gladly post it.

-- 
Kind Regards
Etienne


