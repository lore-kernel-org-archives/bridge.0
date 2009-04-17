Message-ID: <49E8B0B2.1000900@mclink.it>
Date: Fri, 17 Apr 2009 18:39:14 +0200
From: Mauro Condarelli <mc5686@mclink.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] sanity check
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all,
I have managed to get my bridging setup working, but I'm unsure I did 
everything ok, so I would like someone to double-check what I did.

Thanks in advance.

Problem:

    * I have an upstream network connection to my ISP via VPN: I have a
      dedicate router that gives me a non routable address in the
      192.168.120.xxx subnet and that will route in th "non routable"
      range 192.168.yyy.xxx.
    * I need to open a VPN (OpenVPN) with a well defined server
      (192.168.12.74) and I will get my fixed public address (80.79.62.xxx).
    * I have a front-end machine (ubuntu) that hosts two virtualized
      clients to act as firewall and "public host" on a DMZ.
    * The firewall is IPCop.
    * The host is another ubuntu (server) installation.
    * All networking is handled via bridging.

Solution:
/etc/network/interfaces:
===============
auto lo
iface lo inet loopback

# LAN -------------------------------
auto eth0 tap0 br0

iface eth0 inet manual

iface tap0 inet manual
    up   ifconfig $IFACE 0.0.0.0 up
    down ifconfig $IFACE down
    tunctl_user mauro

iface br0 inet static
    address 192.168.0.5
    netmask 255.255.255.0
    #gateway 192.168.0.254
    bridge_ports eth0 tap0
    bridge_maxwait 0
#-----------------------------------

# WAN ------------------------------
auto eth2 tap2 tap4 br2

# physical interface to Ydea net
iface eth2 inet static
    address 192.168.120.5
    netmask 255.255.255.0

iface tap2 inet manual
    up   ifconfig $IFACE 0.0.0.0 up
    down ifconfig $IFACE down
    tunctl_user mauro

iface tap4 inet manual
    up   /root/Ydea/tap-up.sh
    down /root/Ydea/tap-down.sh
    tunctl_user mauro

iface br2 inet manual
#    address 192.168.120.5
#    netmask 255.255.255.0
    bridge_ports tap4 tap2
    bridge_maxwait 0
#-----------------------------------

# DMZ ------------------------------
auto tap1 tap3 br1

iface tap1 inet manual
    up   ifconfig $IFACE 0.0.0.0 up
    down ifconfig $IFACE down
    tunctl_user mauro

iface tap3 inet manual
    up   ifconfig $IFACE 0.0.0.0 up
    down ifconfig $IFACE down
    tunctl_user mauro

iface br1 inet static
    address 192.168.77.5
    netmask 255.255.255.0
    bridge_ports tap1 tap3
    bridge_maxwait 0
#-----------------------------------
===============
The idea is:

    * to have direct connection (using eth2) to my ISP and use that ONLY
      to setup the VPN tunnel (tap4)  connected with the RED interface
      of  IPCop (tap2).
    * to have a direct bridge between ORANGE if of IPCop (tap2) to the
      virtual if of my "server" (tap4).
    * to have the other "real" ethernet (eth0) on host connected to my
      internal home net bridged to the virtual GREEN if  of IPCop (tap0).

This *does* work, but I would like to be sure that:

    * host will only respond to his own internal address (192.168.0.5)
      and not to other addresses.
    * None can access the ISP net (192.168.120.xxx); this is currently
      not true: the cost can access it. I need it in order to setup the
      VPN. Is there any way to close this door after the VPN is up?
    * Sometimes some "internal" PC (in the GREEN net 192.168.0.xxx) gets
      a dhcp address in the range 129.168.120.xxx; probably gettingit
      from the dhacp server in the ISP's router and not from IPCop.
      Invariably a "sudo dhclient" cures the issue. What's happening there?
    * What are the security isues of such a setup?

Can someone enlighten me?
TiA
Mauro
