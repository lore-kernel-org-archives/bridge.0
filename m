From: "Kirti S. Bajwa" <kbajwa@tibonline.net>
Date: Wed, 28 Jun 2006 10:30:11 -0400
Message-ID: <00ae01c69abf$5f9ec6f0$20ed150c@SunShine>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00AF_01C69A9D.D88D26F0"
Subject: [Bridge] Error in Bridge Settings!!
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

------=_NextPart_000_00AF_01C69A9D.D88D26F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Bridge List:

=20

Please help a newbie!

=20

I have setup two freshly installed CentOS 4.3 servers and have setup
redundant BRIDGE. My plan is to have the 'redundant' BRIDGE working and then
I will add 'Shorewall' Firewall to these two servers. On both machines, I
have included the following lines in '/etc/rc.local' so that the BRIDGE will
be ACTIVE after BOOT:

=20

/etc/rc.local

=3D=3D=3D=3D=3D=3D=3D=3D=3D

 # Setup BRIDGE (First Bridge)

 brctl   addbr       tibbr1

 brctl   addif        tibbr1  eth0

 brctl   addif        tibbr1  eth1

 ifconfig   tibbr1  up

 ifconfig   tibbr1  12.21.237.2   netmask   255.255.255.0

 brctl   setageing   tibbr1  300

 brctl   stp   tibbr1    on

 brctl   setbridgeprio   tibbr1   100

 brctl   setpathcost  tibbr1  eth0  100

 brctl   setpathcost  tibbr1  eth1  100

 reboot=20

=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D

Similar lines are included in the second server except the bridge name is
'tibbr2', IP addr is 12.21.237.4 & bridge & path costs are 200.

MAC addresses on each server are as follows:

=20

Server 1:

eth0: 00:80:ad:16:f3:25

eth1: 00:30:1b:38:c6:41

=20

Server 2:

eth0: 00:80:ad:16:e6:43

eth1: 00:30:1b:38:c4:c9

=20

PROBLEM:

-------------

When I boot one of the servers, I get the following errors:

=20

eth1: received packet with own address as source address

eth0: received packet with own address as source address

=20

What are these errors & why they are appearing?=20

=20

If I no-op (#) the following lines, the error disappear:

=20

# ifconfig   tibbr1  up

# ifconfig   tibbr1  12.21.237.2   netmask   255.255.255.0

=20

=20

FYI, my current hardware setup is as follows:

=20

                              T1 Line

                                     |

                      Cisco 26XX Router

                                     |

                                 HUB -------> HUB (Current Network)

                                     |

               ----------------------------

               |                  eth0                |=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20

             fw1                                   fw2=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20

               |                  eth1                |

              -----------------------------

                                     |

                                 HUB

                                     |

             (Future: additional Servers)

=20

Please HELP! How can I fix the settings so the above listed PROBLEM is
resolved!!

=20

Kirti


------=_NextPart_000_00AF_01C69A9D.D88D26F0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<DEFANGED_style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
p.MsoAutoSig, li.MsoAutoSig, div.MsoAutoSig
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.emailstyle17
	{font-family:Arial;
	color:windowtext;}
span.EmailStyle20
	{font-family:Arial;}
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
  font-family:Arial">Hello</span></font><font size=3D2 face=3DArial><span
 DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"> </span></font><font=
 size=3D2
  face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">=
Bridge</span></font><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"> List:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Please help a newbie!</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">I have setup two freshly installed CentOS 4.3 servers and have setup
redundant BRIDGE. My plan is to have the &#8216;redundant&#8217; BRIDGE wor=
king
and then I will add &#8216;Shorewall&#8217; Firewall to these two servers. =
On
both machines, I have included the following lines in
&#8216;/etc/rc.local&#8217; so that the BRIDGE will be ACTIVE after BOOT:</=
span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">/etc/rc.local</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">=3D=3D=3D=3D=3D=3D=3D=3D=3D</span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><strong><b><font=
 size=3D3
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">&nbsp;<f=
ont color=3Dblue><span
DEFANGED_style=3D"color:blue"># </span></font></span></font></b></strong><s=
trong><b><font
  color=3Dblue face=3D"Times New Roman"><span DEFANGED_style=3D"color:blue"=
>Setup</span></font></b></strong><strong><b><font
 color=3Dblue face=3D"Times New Roman"><span DEFANGED_style=3D"color:blue">=
 </span></font></b></strong><strong><b><font
  color=3Dblue face=3D"Times New Roman"><span DEFANGED_style=3D"color:blue"=
>BRIDGE</span></font></b></strong><strong><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_style=3D"color:blue"> =
(</span></font></b></strong><font
  color=3Dred><span DEFANGED_style=3D"color:red"><strong><b><font face=3D"T=
imes New Roman">First</font></b></strong></span></font><strong><b><font
 color=3Dred face=3D"Times New Roman"><span DEFANGED_style=3D"color:red"> <=
/span></font></b></strong><strong><b><font
  color=3Dred face=3D"Times New Roman"><span DEFANGED_style=3D"color:red">B=
ridge</span></font></b></strong><strong><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_style=3D"color:blue">)=
</span></font></b></strong></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><strong><b><font=
 size=3D3
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">&nbsp;<f=
ont color=3Dblue><span
DEFANGED_style=3D"color:blue">brctl &nbsp;&nbsp;addbr&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tibbr1</span></font></span></font></b></stron=
g></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><strong><b><font=
 size=3D3
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">&nbsp;<f=
ont color=3Dblue><span
DEFANGED_style=3D"color:blue">brctl&nbsp;&nbsp; addif&nbsp;&nbsp;&nbsp;&nbs=
p;
&nbsp;&nbsp;&nbsp;tibbr1 &nbsp;eth0</span></font></span></font></b></strong=
></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><strong><b><font=
 size=3D3
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">&nbsp;<f=
ont color=3Dblue><span
DEFANGED_style=3D"color:blue">brctl&nbsp;&nbsp; addif&nbsp;&nbsp;&nbsp;&nbs=
p;
&nbsp;&nbsp;&nbsp;tibbr1 &nbsp;eth1</span></font></span></font></b></strong=
></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><strong><b><font=
 size=3D3
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">&nbsp;<f=
ont color=3Dblue><span
DEFANGED_style=3D"color:blue">ifconfig&nbsp;&nbsp; tibbr1&nbsp; up</span></=
font></span></font></b></strong></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><strong><b><font=
 size=3D3
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">&nbsp;<f=
ont color=3Dblue><span
DEFANGED_style=3D"color:blue">ifconfig&nbsp;&nbsp; tibbr1&nbsp; 12.21.237.2=
&nbsp;&nbsp;
netmask&nbsp;&nbsp; 255.255.255.0</span></font></span></font></b></strong><=
/p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><strong><b><font=
 size=3D3
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">&nbsp;<f=
ont color=3Dblue><span
DEFANGED_style=3D"color:blue">brctl&nbsp;&nbsp; setageing&nbsp;&nbsp; tibbr=
1&nbsp; 300</span></font></span></font></b></strong></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><strong><b><font=
 size=3D3
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">&nbsp;<f=
ont color=3Dblue><span
DEFANGED_style=3D"color:blue">brctl&nbsp;&nbsp; stp&nbsp;&nbsp; tibbr1&nbsp=
;&nbsp;&nbsp;
on</span></font></span></font></b></strong></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><strong><b><font=
 size=3D3
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">&nbsp;<f=
ont color=3Dblue><span
DEFANGED_style=3D"color:blue">brctl&nbsp;&nbsp; setbridgeprio&nbsp;&nbsp;
tibbr1&nbsp;&nbsp; 100</span></font></span></font></b></strong></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><strong><b><font=
 size=3D3
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">&nbsp;<f=
ont color=3Dblue><span
DEFANGED_style=3D"color:blue">brctl&nbsp;&nbsp; setpathcost&nbsp; tibbr1&nb=
sp; eth0&nbsp;
100</span></font></span></font></b></strong></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><strong><b><font=
 size=3D3
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">&nbsp;<f=
ont color=3Dblue><span
DEFANGED_style=3D"color:blue">brctl&nbsp;&nbsp; setpathcost&nbsp; tibbr1&nb=
sp; eth1&nbsp;
100</span></font></span></font></b></strong></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 f=
ace=3D"Times New Roman"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;<b><font color=3Dblue><span DEFAN=
GED_style=3D"color:blue;
font-weight:bold">reboot</span></font><font color=3Dred><span DEFANGED_styl=
e=3D"color:red"> </span></font></b></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">=3D=3D=3D=3D=3D=3D=3D=3D=3D</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">Similar lines are included in the second server except the bridge n=
ame
is &#8216;tibbr2&#8217;, IP addr is 12.21.237.4 &amp; bridge &amp; path cos=
ts are
200.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">MAC addresses on each server are as follows:</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">Server 1:</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">eth0: 00:80:ad:16:f3:25</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">eth1: </span></font>00:30:1b:38:c6:41</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">Server 2:</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">eth0: 00:80:ad:16:e6:43</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">eth1: </span></font>00:30:1b:38:c4:c9</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">PROBLEM:</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">-------------</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">When I boot one of the servers, I get the following errors:</span><=
/font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">eth1: received packet with own address as source address</span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">eth0: received packet with own address as source address</span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">What are these errors &amp; why they are appearing? </span></font><=
/p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">If I no-op (#) the following lines, the error disappear:</span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><strong><b><font=
 size=3D3
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt"># <font =
color=3Dblue><span
DEFANGED_style=3D"color:blue">ifconfig&nbsp;&nbsp; tibbr1&nbsp; up</span></=
font></span></font></b></strong></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><strong><b><font=
 size=3D3
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt"># <font =
color=3Dblue><span
DEFANGED_style=3D"color:blue">ifconfig&nbsp;&nbsp; tibbr1&nbsp; 12.21.237.2=
&nbsp;&nbsp;
netmask&nbsp;&nbsp; 255.255.255.0</span></font></span></font></b></strong><=
/p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">FYI, my current hardware setup is as follows:</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
T1 Line</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Cisco 26XX Router</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;|</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;HUB
-----</span></font><font face=3DWingdings><span DEFANGED_style=3D"font-fami=
ly:Wingdings">&agrave;</span></font>
HUB (Current Network)</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
----------------------------</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
eth0&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fw1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fw2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
eth1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;|</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
-----------------------------</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
HUB</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
(Future: additional Servers)</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">Please HELP! How can I fix the settings so the above listed PROBLEM=
 is
resolved!!</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
 12.0pt">Kirt</span></font>i</p>

</div>

</body>

</html>

------=_NextPart_000_00AF_01C69A9D.D88D26F0--
