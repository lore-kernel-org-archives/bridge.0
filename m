Message-ID: <959514.14125.qm@web8705.mail.in.yahoo.com>
Date: Fri, 20 Nov 2009 09:08:38 +0530 (IST)
From: sunil saraff <sunil_007_xxx@yahoo.co.in>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1555616281-1258688318=:14125"
Subject: [Bridge] Regarding default vlan
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0-1555616281-1258688318=:14125
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hello,
=C2=A0
I have two vlan=E2=80=99s configured on my switch port i.e 246 & 247. 247 i=
s a tagged vlan and 246 is the untagged vlan(native vlan).When I create a v=
irtual vlan interface with tagged vlan 247 using vconfig(eth0.247) it works=
 fine. If I create a virtual vlan interface with untagged vlan 246 using vc=
onfig(eth0.246) I see a different behaviour.
=C2=A0
My configuration
=C2=A0
Ifconfig eth0 0.0.0.0 up
Vconfig add eth0 246
Ifconfig eth0.246 192.168.246.3 netmask 255.255.255.0 up
Route add default gw 192.168.246.1
=C2=A0
=C2=A0
The packet that goes out from the linux box is tagged with 246 vlan but the=
 replies are untagged(as it is the native vlan). So these untagged packets =
are not accepted by linux box. So, can you suggest me a way in which I can =
configure my linux box so that the untagged packets for default vlan are ac=
cepted?Can bridging be done on eth0(untagged interface) and eth0.246(tagged=
 interface)?
=C2=A0
Thanks,
Sunil =0A=0A=0A      The INTERNET now has a personality. YOURS! See your Ya=
hoo! Homepage. http://in.yahoo.com/
--0-1555616281-1258688318=:14125
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><DIV class=3DSection1>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana">Hello,<?xml:namespace prefix =3D o ns =3D "ur=
n:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN></FONT></DIV>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana"><o:p>&nbsp;</o:p></SPAN></FONT></DIV>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana">I have two vlan=E2=80=99s configured on my sw=
itch port i.e 246 &amp; 247. 247 is a tagged vlan and 246 is the untagged v=
lan(native vlan).When I create a virtual vlan interface with tagged vlan 24=
7 using vconfig(eth0.247) it works fine. If I create a virtual vlan interfa=
ce with untagged vlan 246 using vconfig(eth0.246) I see a different behavio=
ur.<o:p></o:p></SPAN></FONT></DIV>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana"><o:p>&nbsp;</o:p></SPAN></FONT></DIV>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana">My configuration<o:p></o:p></SPAN></FONT></DI=
V>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana"><o:p>&nbsp;</o:p></SPAN></FONT></DIV>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana">Ifconfig eth0 0.0.0.0 up<o:p></o:p></SPAN></F=
ONT></DIV>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana">Vconfig add eth0 246<o:p></o:p></SPAN></FONT>=
</DIV>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana">Ifconfig eth0.246 192.168.246.3 netmask 255.2=
55.255.0 up<o:p></o:p></SPAN></FONT></DIV>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana">Route add default gw 192.168.246.1<o:p></o:p>=
</SPAN></FONT></DIV>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana"><o:p>&nbsp;</o:p></SPAN></FONT></DIV>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana"><o:p>&nbsp;</o:p></SPAN></FONT></DIV>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana">The packet that goes out from the linux box i=
s tagged with 246 vlan but the replies are untagged(as it is the native vla=
n). So these untagged packets are not accepted by linux box. So, can you su=
ggest me a way in which I can configure my linux box so that the untagged p=
ackets for default vlan are accepted?Can bridging be done on eth0(untagged =
interface) and eth0.246(tagged interface)?</SPAN></FONT></DIV>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana"><o:p>&nbsp;</o:p></SPAN></FONT></DIV>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana">Thanks,<o:p></o:p></SPAN></FONT></DIV>
<P class=3DMsoNormal><FONT face=3DVerdana size=3D2><SPAN style=3D"FONT-SIZE=
: 10pt; FONT-FAMILY: Verdana">Sunil <o:p></o:p></SPAN></FONT></DIV></DIV></=
td></tr></table><br>=0A=0A=0A=0A      <!--1--><hr size=3D1></hr> =0AThe INT=
ERNET now has a personality. YOURS! <a href=3D"http://in.rd.yahoo.com/tagli=
ne_yyi_1/*http://in.yahoo.com/" target=3D"_blank">See your Yahoo! Homepage<=
/a>.
--0-1555616281-1258688318=:14125--
