Date: Tue, 24 Jun 2008 09:31:33 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080624093133.6f2b896b@extreme>
In-Reply-To: <87skv27wiv.fsf@q-software-solutions.de>
References: <87skv27wiv.fsf@q-software-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Bridge troubles
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Friedrich Dominicus <frido@q-software-solutions.de>
Cc: bridge@lists.linux-foundation.org

On Tue, 24 Jun 2008 16:11:36 +0200
Friedrich Dominicus <frido@q-software-solutions.de> wrote:

> I'm sorry to bother you but I'm stuck
>=20
> I can not make a bridge work for me.=20
> My current configuration is:
> eth0      Link encap:Ethernet  Hardware Adresse 00:1d:7d:d1:06:bd =20
>           inet Adresse:192.168.1.1  Bcast:192.168.1.255  Maske:255.255.25=
5.0
>           inet6-Adresse: fe80::21d:7dff:fed1:6bd/64
> G=C3=BCltigkeitsbereich:V
>=20
> according to all what I could find in the net. The following should do
> to build a bridge=20
> ifconfig eth0 down
> # brctl addbr br0
> # addif br0 eth0
> # ifconfig eth0 0.0.0.0 up
> # ifconfig  br0 192.168.1.1 up
>=20
> Ok now let's see
>=20
>=20
>  brctl show
> bridge name	bridge id		STP enabled	interfaces
> br0		8000.001d7dd106bd	no		eth0
>=20
> looks fine to me
>=20
> then=20
>  ifconfig br0=20
> br0       Link encap:Ethernet  Hardware Adresse 00:1d:7d:d1:06:bd =20
>           inet Adresse:192.168.1.1  Bcast:192.168.1.255  Maske:255.255.25=
5.0
>           inet6-Adresse: fe80::21d:7dff:fed1:6bd/64 G=C3=BCltigkeitsberei=
ch:Verbindung
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metrik:1
>           RX packets:1 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:23 errors:0 dropped:0 overruns:0 carrier:0
>           Kollisionen:0 Sendewarteschlangenl=C3=A4nge:0=20
>           RX bytes:192 (192.0 B)  TX bytes:4420 (4.3 KiB)
> looks also fine to me
>=20
> but then:
>  ping 192.168.1.10
> PING 192.168.1.10 (192.168.1.10) 56(84) bytes of data.
> ping: sendmsg: Operation not permitted
> ping: sendmsg: Operation not permitted
> ping: sendmsg: Operation not permitted
>=20
> I can not make any sens why ping can fail.
> so either I misread all the docs or something is foul.
>=20
> Do you have any suggestions?


The system is still trying to connect over dead route to nameserver.
By default bridge waits 30 seconds in learning mode before going
to forwarding mode, you may want to do:

 # brctl setfd br0 0


What is output of:
 # ip ro

 # brctl showstp br0

 # cat /etc/resolv.conf

