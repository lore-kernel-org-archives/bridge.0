Message-ID: <4CCC9940.8000700@free.fr>
Date: Sun, 31 Oct 2010 00:16:32 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <4CC69E41.6050205@mclink.it>	<AANLkTi=xHJyMbMqssrSaPabOp9mddGVv15SboU33h10G@mail.gmail.com>
	<4CCC45E9.7070801@mclink.it>
In-Reply-To: <4CCC45E9.7070801@mclink.it>
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
To: Mauro Condarelli <mc5686@mclink.it>
Cc: bridge@lists.linux-foundation.org

Le 30/10/2010 18:20, Mauro Condarelli a =E9crit :
>
> I tried something like:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> auto lo
> iface lo inet loopback
>
> auto wlan2
> iface wlan2 inet manual
> up /usr/sbin/service hostapd start
> up /sbin/ifconfig wlan2 up
> down /sbin/ifconfig wlan2 down
> down /usr/sbin/service hostapd stop
>
> auto eth2
> iface eth2 inet manual
> up /sbin/ifconfig eth2 up
> down /sbin/ifconfig eth2 down
>
> auto br0
> iface br0 inet dhcp
> bridge_ports eth2 wlan2
> bridge_maxwait 0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ... but it does not seem to work as hoped.

Consider reading http://www.linuxfoundation.org/collaborate/workgroups/netw=
orking/bridge, in=20
particular the following sections :

- 7.11 What can be bridged?
- 7.16 It doesn't work with my Wireless card!
- 7.17 I still don't understand!!

	Nicolas.


