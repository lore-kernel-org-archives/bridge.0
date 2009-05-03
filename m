Message-ID: <49FDD890.1090302@free.fr>
Date: Sun, 03 May 2009 19:46:56 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>
	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>
	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>
In-Reply-To: <49FC4764.3030707@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
 connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Cc: bridge@lists.linux-foundation.org

Jochen Hebbrecht wrote:
> Nicolas de Peslo=FCan schreef:
>>
>> Can you also explain why you are trying to use bridge ?

> Nicolas,
>=20
> I'm not sure that bonding is the thing I need. I'll explain what I want=20
> to do.
>=20
> Please check this image: http://www.jochus.be/brol/networking.png
> * Purple lines: wired (UTP)
> * Blue (dashed) lines: wireless
>=20
> So in this building, there are 2 locations. Location A and B. There's no =

> possibility to link them using a wired cable, and I don't like the net=20
> adapters who transmits packets using the 50Hz channel.
>=20
> In location A, there's a desktop and a notebook a. In location B,=20
> there's a notebook, a server which maintains e-mails, backup,=20
> Subversion, Archiva, ... and there's also printer (a network printer).

Ok, now we understand what you are trying to do. In particular, I assume=20
the DHCP server is on the subnet of location B (or behind a router=20
connected on this subnet), so the expected DHCP offer will come from the=20
wire interface (eth0) and definitely not from the wireless interface=20
(eth1).

> So, notebook B needs to print to the network printer, which is very easy =

> by using the switch that's on location B. So that works. But now I want=20
> to print from location A on the desktop and notebook A. So I needed to=20
> connect them in the same subnet of the networkprinter.

Let's try a step-by-step bridge configuration :

1/ Try to setup a non-bridge configuration and ensure you successfully=20
get a DHCP answer using eth0.

auto eth0
iface eth0 inet dhcp

#auto eth1
#iface eth1 inet dhcp
#wpa-driver wext
#wpa-ssid ##SSID##
#wpa-ap-scan 1
#wpa-proto RSN
#wpa-pairwise CCMP
#wpa-group CCMP
#wpa-key-mgmt WPA-PSK
#wpa-psk ##PSK KEY##

#auto br0
#iface br0 inet dhcp
#bridge_ports eth0 eth1

2/ Try to setup a bridge with only eth0 (wire interface) and ensure this=20
work well, using a static IP address.

#auto eth0
iface eth0 inet manual

#auto eth1
iface eth1 inet manual

auto br0
iface br0 inet static
bridge_ports eth0
address 192.168.1.111
netmask 255.255.255.0

3/ Try to setup a bridge with only eth0 (wire interface) and ensure this=20
work well, using DHCP.

#auto eth0
iface eth0 inet manual

#auto eth1
iface eth1 inet manual

auto br0
iface br0 inet dhcp
bridge_ports eth0

4/ Then add the eth1 (wireless interface).

#auto eth0
iface eth0 inet manual

auto eth1
iface eth1 inet manual
wpa-driver wext
wpa-ssid ##SSID##
wpa-ap-scan 1
wpa-proto RSN
wpa-pairwise CCMP
wpa-group CCMP
wpa-key-mgmt WPA-PSK
wpa-psk ##PSK KEY##
# The wpa-bridge option is expected to instruct wpa_supplicant
# to listen on br0 instead of eth1. This is a workaround which
# should net be necessary after kernel 2.6.28 or 2.6.29, for
# as far as I remember.
wpa-bridge br0

auto br0
iface br0 inet dhcp
bridge_ports eth0 eth1

5/ If the previous fail, can you please test the following configuration:

#auto eth0
iface eth0 inet manual

#auto eth1
iface eth1 inet manual

auto br0
iface br0 inet dhcp
bridge_ports eth0 eth1
# the wpa-iface option is expected to instruct wpa_supplicant
# to setup the wifi link using eth1 instead of br0.
wpa-iface eth1
wpa-driver wext
wpa-ssid ##SSID##
wpa-ap-scan 1
wpa-proto RSN
wpa-pairwise CCMP
wpa-group CCMP
wpa-key-mgmt WPA-PSK
wpa-psk ##PSK KEY##
# The wpa-bridge option is expected to instruct wpa_supplicant
# to listen on br0 instead of eth1. This is a workaround which
# should net be necessary after kernel 2.6.28 or 2.6.29, for
# as far as I remember.
wpa-bridge br0

6/ If all this fail, please try the above (#5), without the wpa-bridge=20
option.

7/ If all this fail... let's try something really different (and totally=20
out of topic for the bridge list, sorry guys) :

Why do you need location A to be in the same subnet as the printer in=20
location B ? The Ubuntu server in location B might be setup as a normal=20
router (with two different IP in two different subnets). Then, the=20
default route on the printer should be set to the LAN IP address of the=20
ubuntu server.

If you cannot change de default route for the printer, then add a route=20
on the router of this subnet. This new route should ask the router to=20
forward packet for the subnet of  location A through the Ubuntu server.

If you cannot change de routing table in this router, then I suggest you=20
try some sort of NAT configuration to arrange for all host in location A=20
to be NATted to an IP address of location B subnet (using proxy ARP).

	Nicolas.

> So, I wanted to created a bridge on the Ubuntu server (who has a=20
> wireless WMP54G network card), and on eth0 an ethernet controller. So by =

> connecting eth0 to the switch, all notebooks and desktop would be able=20
> to print to the networkprinter
>=20
> This situation works fine if the server is running Windows, but not=20
> Ubuntu as the bridge isn't working there :-(

