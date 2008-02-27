Message-ID: <BAY111-W5E4FBCA18E6CB1F20E641AC1A0@phx.gbl>
From: George - <giorger@hotmail.com>
Date: Wed, 27 Feb 2008 19:07:37 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] Bridging troubles
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


Hallo.
I am trying to establish a bridge on my debian linux box between an etherne=
t and a wireless interface, in order to be able to connect to the bridge vi=
a my laptop's wireless. My laptop has WinXP.

Well, i have a bridge which i created by

brctl addbr br0
brctl addif eth1 (Ethernet controller: Intel Corporation 82562ET/EZ/GT/GZ -=
 PRO/100 VE (LOM) Ethernet Controller (rev 03))
brctl addif eth4 (Network controller: RaLink RT2500 802.11g Cardbus/mini-PC=
I (rev 01))

I am connected through eth1 to a router and I want to bridge this two conne=
ctions in order to connect remotely from my laptop's wireless card which is=
 an Intel(R) Wireless WiFi Link 4965 AGN.
My last steps are to=20

dhclient br0=20
echo "0"> /proc/sys/net/ipv4/ip_forward
iptables -P FORWARD ACCEPT

I was able to connect from my laptop, and router's dhcp worked fine. But he=
re my problems start. I tried to ping my linux box and i was successful. I =
captured arp, dhcp packets. But when I am trying to ping my router (from my=
 laptop), I fail. I try to catch packets with tcpdump -i br0 -vvvv|grep lap=
top_ip but it seems as if packets never get to my linux box. I found out ab=
out some kind of shapping so i also tried the following

for f in `ls /proc/sys/net/bridge/`; do echo "0"> /proc/sys/net/bridge/$f ;=
cat /proc/sys/net/bridge/$f;done

but no good. My linux box can access Internet with no problem. My cards are=
 ok, since the same configuration with a WinXP box (instead of debian) work=
s.
Are there any ideas?

Giwrgos
_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/=
