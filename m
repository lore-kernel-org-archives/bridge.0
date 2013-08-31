Return-Path: <sujataverma3@yahoo.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1377921042; bh=ur80Nb3kj8T8c7GJPYFSzoDHXXAZdAP33njUtb3NNho=;
	h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type;
	b=SboHrZjrcKtM87Wg2JJQTdKVmupVSGlOJmu8tY6nNnEFOLsX72GRmHu35DFDLfbO5zte2k0Vp73M/mQmE1utajiq7Uzj+WQ1Z8x85vh/P4tMeLuOP+3VL3SwO2ZHHh/z/HKxLh8FjcLGJ/az4sQ3upk3o4ZR3joWGKL/60lEo+E=
References: <15785B7E063D464C86DD482FCAE4EBA5018D1AD3DA16@XCH11.scidom.de>
	<15785B7E063D464C86DD482FCAE4EBA5018D1B8B7C29@XCH11.scidom.de>
Message-ID: <1377921042.19249.YahooMailNeo@web160202.mail.bf1.yahoo.com>
Date: Fri, 30 Aug 2013 20:50:42 -0700 (PDT)
From: Sujata Verma <sujataverma3@yahoo.com>
In-Reply-To: <15785B7E063D464C86DD482FCAE4EBA5018D1B8B7C29@XCH11.scidom.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-125618876-1181367583-1377921042=:19249"
Subject: Re: [Bridge] br0: received packet on eth0 with own address as
	source	address
Reply-To: Sujata Verma <sujataverma3@yahoo.com>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>, "Bridge ML (bridge@lists.linux-foundation.org)" <bridge@lists.linux-foundation.org>

---125618876-1181367583-1377921042=:19249
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Bernd,=0A=0AWe see this messages ,when there is a loop in the network.=0A B=
asically, it means that the bridge is receiving same packets which it is se=
nding.=0A=0ARegards,=0ASujata=0A=0A=0A=0A________________________________=
=0A From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>=0ATo: "Bridg=
e ML (bridge@lists.linux-foundation.org)" <bridge@lists.linux-foundation.or=
g> =0ASent: Friday, August 30, 2013 10:49 PM=0ASubject: Re: [Bridge] br0: r=
eceived packet on eth0 with own address as source=09address=0A =0A=0A=0ABer=
nd wrote:=0A>=0A> Hi,=0A>=0A> i have a lot of the following messages in my =
/var/log/messages:=0A>=0A> Aug=A0 7 10:37:32 pc60181 kernel: [2043056.98258=
5] br0:=0A> received packet on eth0 with own address as source address=0A> =
[...]=0A>=0A> Messages appear for about 90 minutes and suddenly stopped.=0A=
>=0A> I have the following network configuration:=0A>=0A> pc60181:~ # ifcon=
fig=0A> br0=A0 =A0 =A0  Link encap:Ethernet=A0 HWaddr 54:04:A6:94:F4:93=0A>=
=A0 =A0 =A0 =A0 =A0  inet addr:10.35.23.36=A0 Bcast:10.35.23.0=A0 Mask:255.=
255.255.0=0A>=A0 =A0 =A0 =A0 =A0  inet6 addr: fe80::5604:a6ff:fe94:f493/64 =
Scope:Link=0A>=A0 =A0 =A0 =A0 =A0  UP BROADCAST RUNNING MULTICAST=A0 MTU:15=
00=A0 Metric:1=0A>=A0 =A0 =A0 =A0 =A0  RX packets:8087301 errors:0 dropped:=
196462=0A> overruns:0 frame:0=0A>=A0 =A0 =A0 =A0 =A0  TX packets:1329744 er=
rors:0 dropped:0 overruns:0 carrier:0=0A>=A0 =A0 =A0 =A0 =A0  collisions:0 =
txqueuelen:0=0A>=A0 =A0 =A0 =A0 =A0  RX bytes:480312835 (458.0 Mb)=A0 TX by=
tes:1250573611=0A> (1192.6 Mb)=0A>=0A> eth0=A0 =A0 =A0 Link encap:Ethernet=
=A0 HWaddr 54:04:A6:94:F4:93=0A>=A0 =A0 =A0 =A0 =A0  inet6 addr: fe80::5604=
:a6ff:fe94:f493/64 Scope:Link=0A>=A0 =A0 =A0 =A0 =A0  UP BROADCAST RUNNING =
PROMISC MULTICAST=A0 MTU:1500=A0 Metric:1=0A>=A0 =A0 =A0 =A0 =A0  RX packet=
s:424826060 errors:0 dropped:131484=0A> overruns:0 frame:0=0A>=A0 =A0 =A0 =
=A0 =A0  TX packets:14092606 errors:0 dropped:0 overruns:0 carrier:0=0A>=A0=
 =A0 =A0 =A0 =A0  collisions:0 txqueuelen:1000=0A>=A0 =A0 =A0 =A0 =A0  RX b=
ytes:79356560631 (75680.3 Mb)=A0 TX=0A> bytes:5338070565 (5090.7 Mb)=0A>=A0=
 =A0 =A0 =A0 =A0  Interrupt:58 Base address:0x6000=0A>=0A> lo=A0 =A0 =A0 =
=A0 Link encap:Local Loopback=0A>=A0 =A0 =A0 =A0 =A0  inet addr:127.0.0.1=
=A0 Mask:255.0.0.0=0A>=A0 =A0 =A0 =A0 =A0  inet6 addr: ::1/128 Scope:Host=
=0A>=A0 =A0 =A0 =A0 =A0  UP LOOPBACK RUNNING=A0 MTU:16436=A0 Metric:1=0A>=
=A0 =A0 =A0 =A0 =A0  RX packets:3773045 errors:0 dropped:0 overruns:0 frame=
:0=0A>=A0 =A0 =A0 =A0 =A0  TX packets:3773045 errors:0 dropped:0 overruns:0=
 carrier:0=0A>=A0 =A0 =A0 =A0 =A0  collisions:0 txqueuelen:0=0A>=A0 =A0 =A0=
 =A0 =A0  RX bytes:3030507414 (2890.1 Mb)=A0 TX=0A> bytes:3030507414 (2890.=
1 Mb)=0A>=0A> vnet0=A0 =A0  Link encap:Ethernet=A0 HWaddr FE:54:00:37:92:A0=
=0A>=A0 =A0 =A0 =A0 =A0  inet6 addr: fe80::fc54:ff:fe37:92a0/64 Scope:Link=
=0A>=A0 =A0 =A0 =A0 =A0  UP BROADCAST RUNNING MULTICAST=A0 MTU:1500=A0 Metr=
ic:1=0A>=A0 =A0 =A0 =A0 =A0  RX packets:81891 errors:0 dropped:0 overruns:0=
 frame:0=0A>=A0 =A0 =A0 =A0 =A0  TX packets:7394846 errors:0 dropped:0 over=
runs:6 carrier:0=0A>=A0 =A0 =A0 =A0 =A0  collisions:0 txqueuelen:500=0A>=A0=
 =A0 =A0 =A0 =A0  RX bytes:7477407 (7.1 Mb)=A0 TX bytes:536978695 (512.1 Mb=
)=0A>=0A> pc60181:~ # brctl show=0A> bridge name=A0 =A0  bridge id=A0 =A0 =
=A0 =A0 =A0 =A0 =A0  STP enabled=A0 =A0  interfaces=0A> br0=A0 =A0 =A0 =A0 =
=A0 =A0  8000.5404a694f493=A0 =A0 =A0  no=A0 =A0 =A0 =A0 =A0 =A0 =A0 eth0=
=0A>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  vnet0=0A>=0A> The bridge is used =
to connect a KVM VM network adapter to the=0A> one of the host.=0A> Host is=
 a SLES 11 SP2 64bit. Guest also.=0A>=0A> What is the reason for this messa=
ge ? I can't remember if i=0A> had a loss of connectivity for that host/vm,=
 because i=0A> realised the message some days after the error appeared.=0A=
=0AStop. I checked some emails and saw that the host was not accessible dur=
ing this time.=0A=0A>=0A> Any ideas ?=0A>=0A> I have now tcpdump running to=
 see the exact packets if the=0A> error reappears.=0A>=0A>=0A> Bernd=0A>=0A=
>=0A>=0A>=0A>=0A=0AI'm googleing for three days and found tons of these mes=
sages, but no clear reason/explaination. Any help would be really appreciat=
ed.=0A=0A=0ABeernd=0A=0AHelmholtz Zentrum M=FCnchen=0ADeutsches Forschungsz=
entrum f=FCr Gesundheit und Umwelt (GmbH)=0AIngolst=E4dter Landstr. 1=0A857=
64 Neuherberg=0Awww.helmholtz-muenchen.de=0AAufsichtsratsvorsitzende: MinDi=
r=B4in B=E4rbel Brumme-Bothe=0AGesch=E4ftsf=FChrer: Prof. Dr. G=FCnther Wes=
s Dr. Nikolaus Blum Dr. Alfons Enhsen=0ARegistergericht: Amtsgericht M=FCnc=
hen HRB 6466=0AUSt-IdNr: DE 129521671
---125618876-1181367583-1377921042=:19249
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:Co=
urier New, courier, monaco, monospace, sans-serif;font-size:12pt">Bernd,<br=
><br>We see this messages ,when there is a loop in the network.=0A Basicall=
y, it means that the bridge is receiving same packets which it is sending.<=
br><br>Regards,<br>Sujata<br><div><span><br></span></div>  <div style=3D"fo=
nt-family: Courier New, courier, monaco, monospace, sans-serif; font-size: =
12pt;"> <div style=3D"font-family: times new roman, new york, times, serif;=
 font-size: 12pt;"> <div dir=3D"ltr"> <hr size=3D"1">  <font face=3D"Arial"=
 size=3D"2"> <b><span style=3D"font-weight:bold;">From:</span></b> "Lentes,=
 Bernd" &lt;bernd.lentes@helmholtz-muenchen.de&gt;<br> <b><span style=3D"fo=
nt-weight: bold;">To:</span></b> "Bridge ML (bridge@lists.linux-foundation.=
org)" &lt;bridge@lists.linux-foundation.org&gt; <br> <b><span style=3D"font=
-weight: bold;">Sent:</span></b> Friday, August 30, 2013 10:49 PM<br> <b><s=
pan style=3D"font-weight: bold;">Subject:</span></b> Re: [Bridge] br0: rece=
ived packet on eth0 with own address as source=09address<br> </font> </div>=
 <div class=3D"y_msg_container"><br><br>Bernd wrote:<br>&gt;<br>&gt;
 Hi,<br>&gt;<br>&gt; i have a lot of the following messages in my /var/log/=
messages:<br>&gt;<br>&gt; Aug&nbsp; 7 10:37:32 pc60181 kernel: [2043056.982=
585] br0:<br>&gt; received packet on eth0 with own address as source addres=
s<br>&gt; [...]<br>&gt;<br>&gt; Messages appear for about 90 minutes and su=
ddenly stopped.<br>&gt;<br>&gt; I have the following network configuration:=
<br>&gt;<br>&gt; pc60181:~ # ifconfig<br>&gt; br0&nbsp; &nbsp; &nbsp;  Link=
 encap:Ethernet&nbsp; HWaddr 54:04:A6:94:F4:93<br>&gt;&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;  inet addr:10.35.23.36&nbsp; Bcast:10.35.23.0&nbsp; Mask:255.=
255.255.0<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  inet6 addr: fe80::5604=
:a6ff:fe94:f493/64 Scope:Link<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  UP=
 BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp; Metric:1<br>&gt;&nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;  RX packets:8087301 errors:0 dropped:196462<br>&g=
t; overruns:0 frame:0<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  TX
 packets:1329744 errors:0 dropped:0 overruns:0 carrier:0<br>&gt;&nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;  collisions:0 txqueuelen:0<br>&gt;&nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp;  RX bytes:480312835 (458.0 Mb)&nbsp; TX bytes:1250573611<=
br>&gt; (1192.6 Mb)<br>&gt;<br>&gt; eth0&nbsp; &nbsp; &nbsp; Link encap:Eth=
ernet&nbsp; HWaddr 54:04:A6:94:F4:93<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;  inet6 addr: fe80::5604:a6ff:fe94:f493/64 Scope:Link<br>&gt;&nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;  UP BROADCAST RUNNING PROMISC MULTICAST&nbsp; MTU:1=
500&nbsp; Metric:1<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  RX packets:42=
4826060 errors:0 dropped:131484<br>&gt; overruns:0 frame:0<br>&gt;&nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;  TX packets:14092606 errors:0 dropped:0 overruns:=
0 carrier:0<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  collisions:0 txqueue=
len:1000<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  RX bytes:79356560631 (7=
5680.3 Mb)&nbsp; TX<br>&gt; bytes:5338070565 (5090.7
 Mb)<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  Interrupt:58 Base address:0=
x6000<br>&gt;<br>&gt; lo&nbsp; &nbsp; &nbsp; &nbsp; Link encap:Local Loopba=
ck<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  inet addr:127.0.0.1&nbsp; Mas=
k:255.0.0.0<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  inet6 addr: ::1/128 =
Scope:Host<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  UP LOOPBACK RUNNING&n=
bsp; MTU:16436&nbsp; Metric:1<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  RX=
 packets:3773045 errors:0 dropped:0 overruns:0 frame:0<br>&gt;&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp;  TX packets:3773045 errors:0 dropped:0 overruns:0 car=
rier:0<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  collisions:0 txqueuelen:0=
<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  RX bytes:3030507414 (2890.1 Mb)=
&nbsp; TX<br>&gt; bytes:3030507414 (2890.1 Mb)<br>&gt;<br>&gt; vnet0&nbsp; =
&nbsp;  Link encap:Ethernet&nbsp; HWaddr FE:54:00:37:92:A0<br>&gt;&nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;  inet6 addr: fe80::fc54:ff:fe37:92a0/64
 Scope:Link<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  UP BROADCAST RUNNING=
 MULTICAST&nbsp; MTU:1500&nbsp; Metric:1<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp;  RX packets:81891 errors:0 dropped:0 overruns:0 frame:0<br>&gt;&nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;  TX packets:7394846 errors:0 dropped:0 overr=
uns:6 carrier:0<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  collisions:0 txq=
ueuelen:500<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  RX bytes:7477407 (7.=
1 Mb)&nbsp; TX bytes:536978695 (512.1 Mb)<br>&gt;<br>&gt; pc60181:~ # brctl=
 show<br>&gt; bridge name&nbsp; &nbsp;  bridge id&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;  STP enabled&nbsp; &nbsp;  interfaces<br>&gt; br0&nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  8000.5404a694f493&nbsp; &nbsp; &nbs=
p;  no&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; eth0<br>&gt;&nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  vnet0<br>&gt;<br>&gt; Th=
e bridge is used to connect a KVM VM network adapter to the<br>&gt; one of =
the host.<br>&gt; Host is a SLES 11 SP2 64bit. Guest also.<br>&gt;<br>&gt; =
What is the reason for this message ? I can't remember if i<br>&gt; had a l=
oss of connectivity for that host/vm, because i<br>&gt; realised the messag=
e some days after the error appeared.<br><br>Stop. I checked some emails an=
d saw that the host was not accessible during this time.<br><br>&gt;<br>&gt=
; Any ideas ?<br>&gt;<br>&gt; I have now tcpdump running to see the exact p=
ackets if the<br>&gt; error reappears.<br>&gt;<br>&gt;<br>&gt; Bernd<br>&gt=
;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br><br>I'm googleing for three days and f=
ound tons of these messages, but no clear reason/explaination. Any help wou=
ld be really appreciated.<br><br><br>Beernd<br><br>Helmholtz Zentrum M=FCnc=
hen<br>Deutsches Forschungszentrum f=FCr Gesundheit und Umwelt
 (GmbH)<br>Ingolst=E4dter Landstr. 1<br>85764 Neuherberg<br>www.helmholtz-m=
uenchen.de<br>Aufsichtsratsvorsitzende: MinDir=B4in B=E4rbel Brumme-Bothe<b=
r>Gesch=E4ftsf=FChrer: Prof. Dr. G=FCnther Wess Dr. Nikolaus Blum Dr. Alfon=
s Enhsen<br>Registergericht: Amtsgericht M=FCnchen HRB 6466<br>USt-IdNr: DE=
 129521671<br><br><br></div> </div> </div>  </div></body></html>
---125618876-1181367583-1377921042=:19249--
