From: =?UTF-8?Q?Olek?= <ned_wed@o2.pl>
Mime-Version: 1.0
Message-ID: <b6f03e7.695e082a.4bb0590f.c840a@o2.pl>
Date: Mon, 29 Mar 2010 09:38:55 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] =?utf-8?q?Bridge_and_port_forwarding?=
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Stephen_Hemminger?= <shemminger@linux-foundation.org>
Cc: Bridge@lists.linux-foundation.org

I've=20assigned=20an=20ip=20address=20to=20my=20bridge,=20just=20forgot=20=
to=20add=20this=20line.

I've=20made=20some=20test=20and=20here=20are=20the=20tcpdump=20results:

Test=201=20-=20
=09Server=20WAN=20192.168.1.110
=20=20=20=20=20=20=20=20|
=20=20=20=20=20=20=20=20|
=20=20=20=20=20=20=20=20LAN=20192.168.1.99
=20=20=20=20=20=20=20=20router=20(port=20forwarding=20enabled)
=20=20=20=20=20=20=20=20WAN=20192.168.0.99
=20=20=20=20=20=20=20=20|
=20=20=20=20=20=20=20=20|
=20=20=20=20=20=20=20=20LAN=20192.168.0.150
=20=20=20=20=20=20=20=20router=20ISP1=20(port=20forwarding=20enabled)
=20=20=20=20=20=20=20=20(WAN=20$$.$$$.$$$.$$)

=09
=20=20=20=20=20=20=20=20Desktop=20--->=20switch=20--->=20router=20ISP2=20=
(WAN=20host-##-###-###-##.com.pl)

07:22:56.390026=20IP=20host-##-###-###-##.com.pl.48812=20>=20my-server.ss=
h:=20F=201000:1000(0)=20ack=201696=20win=20165=20<nop,nop,timestamp=20254=
208=2014408377>
07:22:56.390919=20IP=20my-server.ssh=20>=20host-##-###-###-##.com.pl.4881=
2:=20F=201696:1696(0)=20ack=201001=20win=20140=20<nop,nop,timestamp=20144=
11426=20254208>
07:22:56.411155=20IP=20host-##-###-###-##.com.pl.48812=20>=20my-server.ss=
h:=20.=20ack=201697=20win=20165=20<nop,nop,timestamp=20254213=2014411426>=

07:23:00.463201=20IP=20host-##-###-###-##.com.pl.48813=20>=20my-server.ss=
h:=20S=20903136994:903136994(0)=20win=205840=20<mss=201460,sackOK,timesta=
mp=20255226=200,nop,wscale=206>
07:23:00.463246=20IP=20my-server.ssh=20>=20host-##-###-###-##.com.pl.4881=
3:=20S=20148776143:148776143(0)=20ack=20903136995=20win=205792=20<mss=201=
460,sackOK,timestamp=2014411833=20255226,nop,wscale=206>
07:23:00.478059=20IP=20host-##-###-###-##.com.pl.48813=20>=20my-server.ss=
h:=20.=20ack=201=20win=2092=20<nop,nop,timestamp=20255230=2014411833>
07:23:00.483759=20IP=20my-server.ssh=20>=20host-##-###-###-##.com.pl.4881=
3:=20P=201:40(39)=20ack=201=20win=2091=20<nop,nop,timestamp=2014411835=20=
255230>
07:23:00.501445=20IP=20host-##-###-###-##.com.pl.48813=20>=20my-server.ss=
h:=20.=20ack=2040=20win=2092=20<nop,nop,timestamp=20255236=2014411835>
07:23:00.502330=20IP=20host-##-###-###-##.com.pl.48813=20>=20my-server.ss=
h:=20P=201:40(39)=20ack=2040=20win=2092=20<nop,nop,timestamp=20255236=201=
4411835>
07:23:00.502514=20IP=20my-server.ssh=20>=20host-##-###-###-##.com.pl.4881=
3:=20.=20ack=2040=20win=2091=20<nop,nop,timestamp=2014411837=20255236>
07:23:00.503337=20IP=20my-server.ssh=20>=20host-##-###-###-##.com.pl.4881=
3:=20P=2040:824(784)=20ack=2040=20win=2091=20<nop,nop,timestamp=201441183=
7=20255236>
07:23:00.525540=20IP=20host-##-###-###-##.com.pl.48813=20>=20my-server.ss=
h:=20P=2040:832(792)=20ack=2040=20win=2092=20<nop,nop,timestamp=20255240=20=
14411837>
07:23:00.566232=20IP=20my-server.ssh=20>=20host-##-###-###-##.com.pl.4881=
3:=20.=20ack=20832=20win=20116=20<nop,nop,timestamp=2014411843=20255240>
07:23:00.587910=20IP=20host-##-###-###-##.com.pl.48813=20>=20my-server.ss=
h:=20.=20ack=20824=20win=20116=20<nop,nop,timestamp=20255256=2014411837>
07:23:00.591374=20IP=20host-##-###-###-##.com.pl.48813=20>=20my-server.ss=
h:=20P=20832:856(24)=20ack=20824=20win=20116=20<nop,nop,timestamp=2025525=
8=2014411843>
07:23:00.591392=20IP=20my-server.ssh=20>=20host-##-###-###-##.com.pl.4881=
3:=20.=20ack=20856=20win=20116=20<nop,nop,timestamp=2014411846=20255258>
07:23:00.593477=20IP=20my-server.ssh=20>=20host-##-###-###-##.com.pl.4881=
3:=20P=20824:976(152)=20ack=20856=20win=20116=20<nop,nop,timestamp=201441=
1846=20255258>
07:23:00.614536=20IP=20host-##-###-###-##.com.pl.48813=20>=20my-server.ss=
h:=20.=20ack=20976=20win=20141=20<nop,nop,timestamp=20255264=2014411846>
07:23:00.622464=20IP=20host-##-###-###-##.com.pl.48813=20>=20my-server.ss=
h:=20P=20856:1000(144)=20ack=20976=20win=20141=20<nop,nop,timestamp=20255=
265=2014411846>
07:23:00.630837=20IP=20my-server.ssh=20>=20host-##-###-###-##.com.pl.4881=
3:=20P=20976:1696(720)=20ack=201000=20win=20140=20<nop,nop,timestamp=2014=
411850=20255265>
07:23:00.705941=20IP=20host-##-###-###-##.com.pl.48813=20>=20my-server.ss=
h:=20.=20ack=201696=20win=20165=20<nop,nop,timestamp=20255287=2014411850>=

07:23:42.595330=20IP=20host-##-###-###-##.com.pl.48813=20>=20my-server.ss=
h:=20F=201000:1000(0)=20ack=201696=20win=20165=20<nop,nop,timestamp=20265=
757=2014411850>
07:23:42.596233=20IP=20my-server.ssh=20>=20host-##-###-###-##.com.pl.4881=
3:=20F=201696:1696(0)=20ack=201001=20win=20140=20<nop,nop,timestamp=20144=
16046=20265757>
07:23:42.614668=20IP=20host-##-###-###-##.com.pl.48813=20>=20my-server.ss=
h:=20.=20ack=201697=20win=20165=20<nop,nop,timestamp=20265765=2014416046>=

07:23:47.594202=20arp=20who-has=20my-server=20tell=20192.168.1.99
07:23:47.594214=20arp=20reply=20my-server=20is-at=2000:1a:4b:51:fa:17=20(=
oui=20Unknown)
07:25:45.592713=20IP=20my-server.45565=20>=20192.168.1.99.domain:=2029543=
+=20PTR?=2031.0.168.192.in-addr.arpa.=20(43)
07:25:45.605938=20IP=20192.168.1.99.domain=20>=20my-server.45565:=2029543=
=20NXDomain=200/0/0=20(43)
07:25:45.706550=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=2031.0.168.192.in-addr.arpa.=20(43)
07:25:46.707834=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=2031.0.168.192.in-addr.arpa.=20(43)
07:25:48.710117=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=2031.0.168.192.in-addr.arpa.=20(43)
07:25:50.587801=20arp=20who-has=20192.168.1.99=20tell=20my-server
07:25:50.587970=20arp=20reply=20192.168.1.99=20is-at=2000:1d:0f:f1:88:6c=20=
(oui=20Unknown)


Test=202=20-=20
=09Server=20WAN=20192.168.1.110
=20=20=20=20=20=20=20=20|
=20=20=20=20=20=20=20=20|
=20=20=20=20=20=20=20=20LAN=20192.168.1.99
=20=20=20=20=20=20=20=20router=20(port=20forwarding=20enabled)
=20=20=20=20=20=20=20=20WAN=20192.168.0.99
=20=20=20=20=20=20=20=20|
=20=20=20=20=20=20=20=20|
=20=20=20=20=20=20=20=20LAN=20192.168.0.150
=20=20=20=20=20=20=20=20router=20ISP2=20(port=20forwarding=20enabled)
=20=20=20=20=20=20=20=20(WAN=20host-##-###-###-##.com.pl)

=09
=20=20=20=20=20=20=20=20Desktop=20--->=20switch=20--->=20router=20ISP2=20=
(WAN=20$$.$$$.$$$.$$)


07:34:46.453033=20IP=20192.168.0.150.28215=20>=20my-server.ssh:=20S=20337=
4008677:3374008677(0)=20win=205840=20<mss=201460,sackOK,timestamp=2043173=
2=200,nop,wscale=206>
07:34:46.453650=20IP=20my-server.52286=20>=20192.168.1.99.domain:=209316+=
=20PTR?=20150.0.168.192.in-addr.arpa.=20(44)
07:34:46.458183=20IP=20192.168.1.99.domain=20>=20my-server.52286:=209316=20=
NXDomain*=200/1/0=20(96)
07:34:46.558818=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=20150.0.168.192.in-addr.arpa.=20(44)
07:34:47.560216=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=20150.0.168.192.in-addr.arpa.=20(44)
07:34:49.449615=20IP=20192.168.0.150.28215=20>=20my-server.ssh:=20S=20337=
4008677:3374008677(0)=20win=205840=20<mss=201460,sackOK,timestamp=2043248=
2=200,nop,wscale=206>
07:34:49.562576=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=20150.0.168.192.in-addr.arpa.=20(44)
07:34:51.447806=20arp=20who-has=20192.168.1.99=20tell=20my-server
07:34:51.447928=20arp=20reply=20192.168.1.99=20is-at=2000:1d:0f:f1:88:6c=20=
(oui=20Unknown)
07:34:51.460918=20IP=20my-server.39609=20>=20192.168.1.99.domain:=206688+=
=20PTR?=2099.1.168.192.in-addr.arpa.=20(43)
07:34:51.485944=20IP=20192.168.1.99.domain=20>=20my-server.39609:=206688=20=
NXDomain*=200/1/0=20(95)
07:34:51.596437=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=2099.1.168.192.in-addr.arpa.=20(43)
07:34:52.597752=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=2099.1.168.192.in-addr.arpa.=20(43)
07:34:53.094496=20arp=20who-has=20192.168.1.120=20tell=20192.168.1.99
07:34:54.094421=20arp=20who-has=20192.168.1.120=20tell=20192.168.1.99
07:34:54.599136=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=2099.1.168.192.in-addr.arpa.=20(43)
07:34:55.094349=20arp=20who-has=20192.168.1.120=20tell=20192.168.1.99
07:34:55.451650=20IP=20192.168.0.150.28215=20>=20my-server.ssh:=20S=20337=
4008677:3374008677(0)=20win=205840=20<mss=201460,sackOK,timestamp=2043398=
2=200,nop,wscale=206>
07:34:56.498449=20IP=20my-server.45687=20>=20192.168.1.99.domain:=2029498=
+=20PTR?=20251.0.0.224.in-addr.arpa.=20(42)
07:34:56.724035=20IP=20192.168.1.99.domain=20>=20my-server.45687:=2029498=
=20NXDomain=200/1/0=20(100)
07:34:56.824541=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=20251.0.0.224.in-addr.arpa.=20(42)
07:34:57.825866=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=20251.0.0.224.in-addr.arpa.=20(42)
07:34:59.827240=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=20251.0.0.224.in-addr.arpa.=20(42)
07:35:01.726629=20IP=20my-server.57079=20>=20192.168.1.99.domain:=201230+=
=20PTR?=20120.1.168.192.in-addr.arpa.=20(44)
07:35:01.751267=20IP=20192.168.1.99.domain=20>=20my-server.57079:=201230=20=
NXDomain*=200/1/0=20(96)
07:35:01.851999=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=20120.1.168.192.in-addr.arpa.=20(44)
07:35:02.853355=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=20120.1.168.192.in-addr.arpa.=20(44)
07:35:04.853879=20IP=20my-server.mdns=20>=20224.0.0.251.mdns:=200=20PTR=20=
(QM)?=20120.1.168.192.in-addr.arpa.=20(44)
07:35:07.447310=20IP=20192.168.0.150.28215=20>=20my-server.ssh:=20S=20337=
4008677:3374008677(0)=20win=205840=20<mss=201460,sackOK,timestamp=2043698=
2=200,nop,wscale=206>



my-server.ssh=20=3D=20192.168.1.110.22


In=20Test=202=20the=20SSH=20connection=20request=20is=20forwarded=20throu=
gh=20the=20ISP2=20router=20(LAN=20192.168.0.150),=20which=20is=20configur=
ed=20by=20my=20internet=20provider.
The=20server=20isn't=20answering=20on=20the=20ssh=20request,=20when=20the=
=20LAN=20bridge=20is=20enabled.
I'm=20not=20an=20advanced=20linux=20specialist,=20but=20I=20think=20the=20=
reason=20for=20this=20problem=20is=20caused=20by=20the=20ISP2=20router.=20=
Before=20I=20start=20arguing=20with=20my=20internet=20provider=20I=20want=
=20to=20check=20if=20this=20isn't=20caused=20by=20the=20bridge.
On=20my=20old=20internet=20connection=20ISP1=20the=20ssh=20request=20is=20=
also=20forwarded,=20but=20the=20package=20source=20address=20has=20an=20o=
utside=20IP=20address=20not=20a=20local=20one=20like=20in=20the=20second=20=
test.=20In=20Test=201=20server=20answers=20on=20the=20ssh=20request=20and=
=20everything=20works=20(LAN=20bridge=20enabled).


Dnia=2028=20marca=202010=205:00=20Stephen=20Hemminger=20<shemminger@linux=
-foundation.org>=20napisa=C5=82(a):

>=20On=20Mon,=2022=20Mar=202010=2013:41:19=20+0100
>=20Olek=20<ned=5Fwed@o2.pl>=20wrote:
>=20
>=20>=20Hi,
>=20>=20I'm=20stuck=20with=20the=20configuration=20of=20my=20server.
>=20>=20Currently=20my=20network=20is=20set=20up=20like=20this:
>=20>=20
>=20>=20
>=20>=20Internet=20
>=20>=20=20=20|
>=20>=20=20=20|
>=20>=20Router
>=20>=20(WAN=20192.168.0.99,=20LAN=20192.168.1.99,=20
>=20>=20port=20forwarding=201-65535)
>=20>=20=20=20|
>=20>=20=20=20|
>=20>=20Ubuntu=20Server=2064-bit
>=20>=20(WAN(eth0)=20192.168.1.110,=20LAN-bridge(eth1,eth2)=20192.168.0.1=
10)
>=20>=20
>=20>=20
>=20>=20Description=20of=20the=20problem:
>=20>=20When=20I=20connect=20my=20desktop=20to=20the=20router=20LAN=20and=
=20try=20to=20access=20FTP,=20SSH=20or=20others=20the=20server=20answers=20=
correct=20(brigde=20enabled).
>=20>=20When=20I=20try=20to=20access=20the=20server=20from=20the=20Intern=
et,=20i=20get=20no=20answer.
>=20>=20When=20the=20bridge=20is=20disabled=20I=20can=20easily=20access=20=
SSH=20or=20FTP=20from=20the=20Internet.
>=20>=20
>=20>=20My=20bridge=20config:
>=20>=20ifconfig=20eth1=20promisc=20up
>=20>=20ifconfig=20eth2=20promisc=20up
>=20
>=20Unnecessary=20step.=20Bridge=20has=20done=20this=20automatically=20fo=
r=20at=20least
>=205=20years,=20probably=20more.=20But=20old=20instructions=20never=20di=
e.
>=20
>=20>=20brctl=20addbr=20mybridge
>=20>=20brctl=20addif=20mybridge=20eth1
>=20>=20brctl=20addif=20mybridge=20eth2
>=20>=20
>=20>=20The=20firewall=20is=20disabled,=20to=20get=20sure=20it's=20not=20=
blocking=20network=20traffic.
>=20>=20Maybe=20someone=20knows=20what's=20causing=20this=20problem?
>=20
>=20You=20need=20to=20assign=20IP=20address=20to=20br0,=20not=20the=20eth=
ernets=20in=20the=20bridge?
>=20


