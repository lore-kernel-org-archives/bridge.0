From: =?us-ascii?Q?Raffaele_Carla?= <raffaele.carla@esteri.it>
Date: Wed, 30 Aug 2006 11:08:27 -0400
Message-ID: <00d301c6cc46$26b12b40$b4068b0a@ambit.itwash.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00D4_01C6CC24.9F9F8B40"
Subject: [Bridge] Trouble with ARP traffic
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_NextPart_000_00D4_01C6CC24.9F9F8B40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

 

I've setup a Linux (SUSE v. 2.6.16.13-4-smp) in bridging mode. The br0
interface has two physical: eth0 and eth1.

The eth0 interface is connected to our LAN, the eth1 is connected to a
SONICWALL firewall. STP is turned off, since it's the only bridge connecting
the two areas.

The bridge is also acting filtering some traffic via iptables.

 

All is working fine, but when I use tcpdump on the eth1 interface, I see all
the ARP requests of the LAN. In other words, the entirely ARP broadcasts
(that will be resolved internally) are passing the bridge and reaching the
firewall.

 

As a bridge, the Linux box should be aware where every machine is located
and separate logically the two segments, shouldn't it?

 

Also, the command "arp -a" shows only one address, wether the "brctl
showmacs br0"  shows all the addresses correctly. Is this a normal
behaviour?

 

Thank you for every advice,

Raffaele

 

 

Output of brctl showstp br0

---------------------------------------

 

br0

 bridge id              8000.001560a34be7

 designated root        8000.001560a34be7

 root port                 0                    path cost                  0

 max age                  20.00                 bridge max age
50.00

 hello time                2.00                 bridge hello time
5.00

 forward delay            37.50                 bridge forward delay
15.00

 ageing time             300.01

 hello timer               1.39                 tcn timer
0.00

 topology change timer     0.00                 gc timer
0.05

 flags

 

 

eth0 (1)

 port id                8001                    state
forwarding

 designated root        8000.001560a34be7       path cost                 19

 designated bridge      8000.001560a34be7       message age timer
0.00

 designated port        8001                    forward delay timer
0.00

 designated cost           0                    hold timer
0.39

 flags

 

eth1 (2)

 port id                8002                    state
forwarding

 designated root        8000.001560a34be7       path cost                100

 designated bridge      8000.001560a34be7       message age timer
0.00

 designated port        8002                    forward delay timer
0.00

 designated cost           0                    hold timer
0.39

 flags

 

Output of brctl showmacs br0

------------------------------------------

 

1     00:04:23:0a:a6:13       no                86.16

  1     00:04:75:4c:d7:03       no                 5.06

  1     00:04:75:87:bd:a9       no               138.51

  1     00:04:76:a3:c9:b8       no               100.12

  2     00:06:b1:11:8d:a4       no                 0.07

  1     00:0f:20:3b:8e:4e       no                41.11

  1     00:0f:20:3b:fe:57       no                60.78

  1     00:14:69:b4:49:84       no                 0.14

  1     00:15:60:a3:4b:e7       yes                0.00

  1     00:30:c1:5f:24:56       no                28.16

  1     00:30:c1:8c:e7:61       no                39.05

  2     00:c0:f0:56:51:c6       yes                0.00

 

 


------=_NextPart_000_00D4_01C6CC24.9F9F8B40
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html DEFANGED_xmlns:o=3D"urn:schemas-microsoft-com:office:office" DEFANGED=
_xmlns:w=3D"urn:schemas-microsoft-com:office:word" DEFANGED_xmlns=3D"http:/=
/www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<DEFANGED_style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</DEFANGED_style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">I&#8217;ve setup a Linux (SUSE v. 2.6.16.13-4-smp) in
bridging mode. The br0 interface has two physical: eth0 and eth1.<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">The eth0 interface is connected to our LAN, the eth1 is
connected to a SONICWALL firewall. STP is turned off, since it&#8217;s the =
only
bridge connecting the two areas.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">The bridge is also acting filtering some traffic via
iptables.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">All is working fine, but when I use tcpdump on the eth1
interface, I see all the ARP requests of the LAN. In other words, the entir=
ely ARP
broadcasts (that will be resolved internally) are passing the bridge and
reaching the firewall.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">As a bridge, the Linux box should be aware where every
machine is located and separate logically the two segments, shouldn&#8217;t=
 it?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Also, the command &#8220;arp &#8211;a&#8221; shows only =
one
address, wether the &#8220;brctl showmacs br0&#8221; &nbsp;shows all the
addresses correctly. Is this a normal behaviour?<o:p></o:p></span></font></=
p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Thank you for every advice,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Raffaele<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Output of brctl showstp br0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">---------------------------------------<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">br0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;bridge
id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
8000.001560a34be7<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;designated
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001560a34be7<o:p></o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;root
port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
path cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;max
age&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
20.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
bridge max
age&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 50.00=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;hello
time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
2.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
bridge hello time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.0=
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;forward
delay&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
37.50&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
bridge forward delay&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15.00<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;ageing
time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
300.01<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;hello
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
1.39&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;tcn
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0.00<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;topology change timer&nbsp;&nbsp;&nbsp;&nbsp;
0.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
gc
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0.05<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;flags<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">eth0 (1)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;port
id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
8001&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
forwarding<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;designated
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
8000.001560a34be7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path
cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
19<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;designated bridge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
8000.001560a34be7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message age
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<o:p></o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;designated
port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
8001&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
forward delay timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;designated cost&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
hold
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
0.39<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;flags<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">eth1 (2)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;port
id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
8002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
forwarding<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;designated
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
8000.001560a34be7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path
cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
100<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;designated bridge&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;80=
00.001560a34be7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
message age timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.0=
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;designated
port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
8002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
forward delay timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;designated
cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
hold timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0.39<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;flags<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Output of brctl showmacs br0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">------------------------------------------<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3D"IT" DEFANGED=
_style=3D"font-size:10.0pt;
font-family:Arial">1&nbsp;&nbsp;&nbsp;&nbsp;
00:04:23:0a:a6:13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
86.16<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3D"IT" DEFANGED=
_style=3D"font-size:10.0pt;
font-family:Arial">&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;
00:04:75:4c:d7:03&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
5.06<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3D"IT" DEFANGED=
_style=3D"font-size:10.0pt;
font-family:Arial">&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;
00:04:75:87:bd:a9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
138.51<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3D"IT" DEFANGED=
_style=3D"font-size:10.0pt;
font-family:Arial">&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;
00:04:76:a3:c9:b8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
100.12<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3D"IT" DEFANGED=
_style=3D"font-size:10.0pt;
font-family:Arial">&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;
00:06:b1:11:8d:a4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;
0.07<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3D"IT" DEFANGED=
_style=3D"font-size:10.0pt;
font-family:Arial">&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;
00:0f:20:3b:8e:4e&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
41.11<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3D"IT" DEFANGED=
_style=3D"font-size:10.0pt;
font-family:Arial">&nbsp; </span></font><font size=3D2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">1&nbsp;&nbsp;&nbsp;&n=
bsp;
00:0f:20:3b:fe:57&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
60.78<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;
00:14:69:b4:49:84&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
0.14<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;
00:15:60:a3:4b:e7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
0.00<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;
00:30:c1:5f:24:56&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
28.16<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;
00:30:c1:8c:e7:61&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
39.05<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;
00:c0:f0:56:51:c6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
0.00<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_00D4_01C6CC24.9F9F8B40--
