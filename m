Date: Thu, 03 Jun 2004 18:41:43 +0200
From: Derek Ditch <derek.ditch@us.army.mil>
Message-id: <E5838291-B57C-11D8-800E-000A95BC99E4@us.army.mil>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: [Bridge] Wireless Bridge problems
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org


I am using the madwifi driver with the patch to allow changing of the 
MAC address
and I have two other ethernet interfaces plus a pppoe interface.  My 
outbound
connection is ppp0.  I have ath0, eth1, eth2 for internal interfaces.  
I have
added these three interfaces to br0. Once the traffic leaves the linux 
router, it gets
NAT'd and goes out through ppp0.  All traffic on all segments works
to reach the internet.  Traffic cannot pass between the physical
bridge interfaces. eth1 cannot talk to eth2 or ath0 and so on.

I need some suggestions.  Below is my debian interfaces file. Below 
that is my
iptables configuration script.

Derek Ditch

Please CC: me in your answers as I just subscribed and awaiting 
moderator approval.



# /etc/network/interfaces -- configuration file for ifup(8), ifdown(8)

# The loopback interface
auto lo
iface lo inet loopback

# The first network card - this entry was created during the Debian 
installation
# (network, broadcast and gateway are optional)
# Via-Rhine Built-in 10/100 Card
auto eth0
iface eth0 inet static
         address 192.168.0.254
         netmask 255.255.255.0
         network 192.168.0.0
         broadcast 192.168.0.255

# Atheos Wireless Card and virtual interface
auto ath0 eth1 eth2 br0

iface ath0 inet static
         address 0.0.0.0
         netmask 255.255.255.0
         wireless_essid CannonCops
         wireless_mode Master
         wireless_rate 54Mb
         wireless_enc off
         wireless_channel 1

# Second Internal Net
iface eth1 inet static
         address 0.0.0.0
         netmask 255.255.255.0

# Third Internal Net
iface eth2 inet static
         address 0.0.0.0
         netmask 255.255.255.0

iface br0 inet static
         pre-up brctl addbr br0
         pre-up brctl addif br0 ath0
         pre-up brctl addif br0 eth1
         pre-up brctl addif br0 eth2
         pre-up brctl stp br0 on
         post-down brctl delbr br0
         address 10.0.100.1
         netmask 255.255.255.0
         network 10.0.100.0

#====================End of 
/etc/network/interfaces===========================


#!/bin/sh
#
# This script will initialize the firewall when executed.
# Created on 11 Mar 2004
#

echo -e "\n\nLoading firewall..\n"

# Location of iptables and kernel module programs

IPTABLES=/sbin/iptables
DEPMOD=/sbin/depmod
MODPROBE=/sbin/modprobe
IFCONFIG=/sbin/ifconfig

# Set external and internal interfaces
EXTIF="ppp0"
INTIF="br0"

FILTER_NET="192.168.0.0/16"

echo "  External Interface:  $EXTIF"
echo "  Internal Interface:  $INTIF"

#--------------------------------------------------
#----- No editing is required below this line -----

echo -en "  loading modules: "

# Load the general IPTABLES NAT code - "iptable_nat"

echo -en " iptable_nat,"
$MODPROBE iptable_nat

# Load the FTP NAT functionality into the core IPTABLES code
# Allows use of non-PASV FTP.
echo -en " ip_nat_ftp,"
$MODPROBE ip_nat_ftp

# Load the IRC NAT functionality into the core IPTABLES code
# Allows support of NAT of IRC DCC requests
echo -en " ip_nat_irc"
$MODPROBE ip_nat_irc

#---------------- End of prep ----------------------
#---------- Let the tables begin -------------------

# Turn on forwarding
echo "1" > /proc/sys/net/ipv4/ip_forward

# Enable dynamic-address hacking
echo "1" > /proc/sys/net/ipv4/ip_dynaddr

# Clear any previous configuration
$IPTABLES -P INPUT ACCEPT
$IPTABLES -F INPUT
$IPTABLES -P OUTPUT ACCEPT
$IPTABLES -F OUTPUT
$IPTABLES -P FORWARD DROP
$IPTABLES -F FORWARD
$IPTABLES -t nat -F

# Redirect unregistered users to the info page
$IPTABLES -t nat -A PREROUTING -p tcp -s $FILTER_NET --dport 80 -j DNAT 
--to-destination 192.168.100.1:80

# Prevent hosts on 192.168.x.x subnet from reaching the Internet
$IPTABLES -t filter -A FORWARD --source $FILTER_NET -j DROP

# Block KaZaa because it is a bandwidth hog
iptables -A FORWARD --protocol tcp --dport 1214 -j REJECT

# Allow all connections OUT and only existing and related ones IN
$IPTABLES -A FORWARD -i $EXTIF -o $INTIF -m state --state 
ESTABLISHED,RELATED -j ACCEPT
$IPTABLES -A FORWARD -i $EXTIF -o $INTIF -j ACCEPT
$IPTABLES -A FORWARD -i $INTIF -o $EXTIF -j ACCEPT

$IPTABLES -A FORWARD -j LOG

# Enable simple NAT
$IPTABLES -t nat -A POSTROUTING -o $EXTIF -j MASQUERADE

echo -en "\n\nFirewall loaded. System secure\n"
transmogrifier:~#

