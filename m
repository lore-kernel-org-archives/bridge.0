Message-ID: <4CCEB536.80008@mclink.it>
Date: Mon, 01 Nov 2010 13:40:22 +0100
From: Mauro Condarelli <mc5686@mclink.it>
MIME-Version: 1.0
References: <4CC69E41.6050205@mclink.it>	<AANLkTi=xHJyMbMqssrSaPabOp9mddGVv15SboU33h10G@mail.gmail.com>
	<4CCC45E9.7070801@mclink.it> <4CCC9940.8000700@free.fr>
In-Reply-To: <4CCC9940.8000700@free.fr>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Transparent wired/wirless bridge: is it possible?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: bridge@lists.linux-foundation.org

  Il 31/10/2010 00:16, Nicolas de Peslo=FCan ha scritto:
> Le 30/10/2010 18:20, Mauro Condarelli a =E9crit :
>>
>> I tried something like:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> auto lo
>> iface lo inet loopback
>>
>> auto wlan2
>> iface wlan2 inet manual
>> up /usr/sbin/service hostapd start
>> up /sbin/ifconfig wlan2 up
>> down /sbin/ifconfig wlan2 down
>> down /usr/sbin/service hostapd stop
>>
>> auto eth2
>> iface eth2 inet manual
>> up /sbin/ifconfig eth2 up
>> down /sbin/ifconfig eth2 down
>>
>> auto br0
>> iface br0 inet dhcp
>> bridge_ports eth2 wlan2
>> bridge_maxwait 0
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> ... but it does not seem to work as hoped.
>
> Consider reading=20
> http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge, =

> in particular the following sections :
>
> - 7.11 What can be bridged?
> - 7.16 It doesn't work with my Wireless card!
> - 7.17 I still don't understand!!
>
>     Nicolas.
Thanks for the pointer.
I assume the short answer (gleamed from the above link) is: "this can't=20
be done (easily)".

I have it working now without bridges using hostapd, dnsmasq and a=20
static route in the upstream router (ipfire).

This has the (small) drawback I have a second subnet and a largely=20
useless dnsmaq installed.

My setup is with a separate firewall (ipfire) connected to the Internet;=20
on the GREEN LAN I have another server with an "Atheros Communications=20
Inc. AR928X Wireless Network Adapter (PCI-Express) (rev 01)" managed via=20
ath9k and hostapd.
On "server" (ubuntu-workstation 10.10; I had some problems convincing=20
NetworkManager not to meddle with the interfaces) I have:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
auto wlan2
iface wlan2 inet static
     address 192.168.2.1
     netmask 255.255.255.0
     broadcast 192.168.2.255

auto eth2
iface eth2 inet dhcp # gets address from ipfire in the range=20
192.168.1.100-129
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
IPV4 routing is enabled.
hostapd and dnsmasq are set and configured.

On "ipfire" I have the additional static route
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
route add -net 192.168.2.0/24 gw server
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



Any comment?
Can I simplify?
Is this The Right Way to go?

Thanks
Mauro
