Message-ID: <BAY143-W21B8CF58FB3E148BB39208A6710@phx.gbl>
From: "SYED JAHANZAiB ~!~ AA Internet Cable.Network Services"
	<aacable@hotmail.com>
Date: Mon, 11 Aug 2008 06:39:43 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] VPN on Bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


Hi=2C
I want to discuss a linux problem with you in which I am stuck from many da=
ys.=20
=20
The scenario is
=20
USERS =3D=3D> eth0 ---- LINUX BRIDGE with MAC/IP Binding ----- eth1 =3D=3D=
=3D> ISA PROXY SERVE

Users =3D 10.0.0.x
Linux Bridge =3D 10.0.8.1 (br0)
ISA =3D 10.0.0.1
=20
This linux Bridge Acts a firewall & DHCP for my users. Valid users get 10.0=
.x.x fox ip (set in a text file with ip mac) and can access ISA through thi=
s bridge=2C and unknwon users gets 192.168.x.x fake series and blocked from=
 passing through. Smart users are copying working users mac address and thu=
s getting valid ip and passed through the bride to access my ISA Server. No=
w I want to implement VPN Server user id authentication along with mac/ip b=
inding on my bridge.
=20
I have setup the POPTOP VPN on this bridge. Users can successfully login to=
 this Bridge=2C but how can I restrict that only VPN logged in users can pa=
ss throught this server to my ISA proxy server. I have tried
=20
iptables -A FORWARD -i ppp+ -s 0/0 -d 0/0 -j ACCEPT
but no use=2C users cannot ping/connect the ISA SERVER. however if I clear =
iptables rules=2C everything works fine.
=20
In POPTOP VPN Server config=2C How to set default gateway pointed to my ISA=
 SERVER? bcoz without gateway=2C internet will not work.
=20
How Can I bind user id with specific IP or MAC address. so that specific Id=
 would connect from specific IP/MAC only. to prevent user id sharing cheati=
ng.
=20
My MAC/IP Binding Script is as follows ...
=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
#!/bin/sh
echo "Starting Secure Firewall . . ."
#set -x
IPT=3D"/sbin/iptables"
DHCP_SERVER=3D"10.0.8.1"
FILE=3D`cat path | awk '/FINAL_FILE/' | cut -d"=3D" -f2`
LOOPBACK=3D"lo"
 $IPT -F
$IPT -X
$IPT -t nat -F
$IPT -t nat -X
$IPT -t mangle -F
$IPT -t mangle -X
 $IPT -P INPUT ACCEPT
$IPT -P FORWARD ACCEPT
$IPT -P OUTPUT ACCEPT
 # ALLOW LOOPBACK
$IPT -A INPUT -i $LOOPBACK -j ACCEPT
$IPT -A OUTPUT -o $LOOPBACK -j ACCEPT
 # ALLOW PPTPD
$IPT -I INPUT -p tcp --dport 1723 -j ACCEPT
$IPT -I OUTPUT -p tcp --dport 1723 -j ACCEPT
$IPT -I INPUT -p 47 -j ACCEPT
$IPT -I OUTPUT -p 47 -j ACCEPT
$IPT -A FORWARD -i ppp+ -d 0/0 -j ACCEPT
 # ALLOW DHCP
$IPT -A INPUT -p udp -s $DHCP_SERVER --sport 67 -d 255.255.255.255=20
--dport 68 -j ACCEPT
$IPT -A OUTPUT -p udp -s 255.255.255.255 --sport 68 -d $DHCP_SERVER=20
--dport 67 -j ACCEPT
 cat $FILE | while read MACS
do
IP=3D`echo $MACS | awk '{print $2}'`
MAC=3D`echo $MACS | awk '{print $1}'`
$IPT -t mangle -A PREROUTING -s $IP -m mac --mac-source $MAC -j MARK=20
--set-mark 1
done
 # Allow Marked Packets to be allowed
 $IPT -A INPUT -m mark --mark 1 -j ACCEPT
$IPT -A FORWARD -m mark --mark 1 -j ACCEPT
 $IPT -A INPUT -m mark ! --mark 1 -j DROP
$IPT -A FORWARD -m mark ! --mark 1 -j DROP
$IPT -P INPUT DROP
$IPT -P FORWARD DROP
echo "Secure Firewall & DHCP Process Complete."
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

How can I enable support to connect different subnet address to connect to =
my vpn server? like 192.168.x.x can connect to my 10.0.8.1 server. How can =
I enable it? Currently only 10.0.x.x users can connect to my vpn server. i =
have tried enabling ipforward but with no luck
=20
=20
=20
Regards=2C
SYED JAHANZAIB
_________________________________________________________________
Invite your mail contacts to join your friends list with Windows Live Space=
s. It's easy!
http://spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/friends.=
aspx&mkt=3Den-us=
