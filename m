From: "Sam Stephenson" <sam.stephenson@ezadcorp.com>
Date: Thu, 8 Jul 2004 11:29:28 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0020_01C464DE.D51DBDF0"
Message-Id: <20040708162733.86A92600FE@cmlapp13.siteprotect.com>
Subject: [Bridge] Request Help: Error when compiling with Bridging enabled 
Reply-To: sam.stephenson@ezadcorp.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org
Cc: sam.stephenson@ezadcorp.com

This is a multi-part message in MIME format...

------=_NextPart_000_0020_01C464DE.D51DBDF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am attempting to use the bridging-utilities (i.e., bridge-utils-0.9.5.1)
in an

Linux-arm environment (linux-arm 2.4.19).

 

But, when executed command listed below, further investigation indicated we
are required to

rebuild kernel to enable the bridging code.

 

# brctl addbr br0

br_add_bridge: Package not installed

 

Therefore our initial attempt to rebuild kernel failed as indicated below
(with

"CONFIG_BRIDGE=y" ) in .config file. 

 

net/network.o: In function `__br_clear_frame_hook':

net/network.o(.text+0x461dc): undefined reference to `br_handle_frame_hook'

net/network.o: In function `__br_clear_ioctl_hook':

net/network.o(.text+0x461fc): undefined reference to `br_ioctl_hook'

net/network.o: In function `br_init':

net/network.o(.text.init+0x2c50): undefined reference to
`br_handle_frame_hook'

net/network.o(.text.init+0x2c5c): undefined reference to `br_ioctl_hook'

make: *** [vmlinux] Error 1

 

Has anyone seen this particular problem? And if so, what was (or is) the
resolution?

 

Looking forward to your response. If this is routed inappropriately, please
provide

a list of recipients.

 

Sam Stephenson


------=_NextPart_000_0020_01C464DE.D51DBDF0
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

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">I am attempting to us=
e the
bridging-utilities (i.e., bridge-utils-0.9.5.1) in an<o:p></o:p></span></fo=
nt></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">Linux-arm environment=
 (linux-arm
2.4.19).<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"><o:p>&nbsp;</o:p></sp=
an></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">But, when executed co=
mmand listed below,
further investigation indicated we are required to<o:p></o:p></span></font>=
</p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">rebuild kernel to ena=
ble the
bridging code.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"><o:p>&nbsp;</o:p></sp=
an></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in;text-autospace:no=
ne"><font size=3D2
face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"># =
brctl addbr br0<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in;text-autospace:no=
ne"><font size=3D2
face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">br=
_add_bridge:
Package not installed<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"><o:p>&nbsp;</o:p></sp=
an></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">Therefore our initial=
 attempt to
rebuild kernel failed as indicated below (with<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">&#8220;CONFIG_BRIDGE=
=3Dy&#8221; ) in .config
file. <o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"><o:p>&nbsp;</o:p></sp=
an></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in;text-autospace:no=
ne"><font size=3D2
face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">ne=
t/network.o: In
function `__br_clear_frame_hook':<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in;text-autospace:no=
ne"><font size=3D2
face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">ne=
t/network.o(.text+0x461dc):
undefined reference to `br_handle_frame_hook'<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in;text-autospace:no=
ne"><font size=3D2
face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">ne=
t/network.o: In
function `__br_clear_ioctl_hook':<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in;text-autospace:no=
ne"><font size=3D2
face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">ne=
t/network.o(.text+0x461fc):
undefined reference to `br_ioctl_hook'<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in;text-autospace:no=
ne"><font size=3D2
face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">ne=
t/network.o: In
function `br_init':<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in;text-autospace:no=
ne"><font size=3D2
face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">ne=
t/network.o(.text.init+0x2c50):
undefined reference to `br_handle_frame_hook'<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in;text-autospace:no=
ne"><font size=3D2
face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">ne=
t/network.o(.text.init+0x2c5c):
undefined reference to `br_ioctl_hook'<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in;text-autospace:no=
ne"><font size=3D2
face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">ma=
ke: *** [vmlinux]
Error 1<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"><o:p>&nbsp;</o:p></sp=
an></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">Has anyone seen this =
particular
problem? And if so, what was (or is) the resolution?<o:p></o:p></span></fon=
t></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"><o:p>&nbsp;</o:p></sp=
an></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">Looking forward to yo=
ur response. If
this is routed inappropriately, please provide<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">a list of recipients.=
<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"><o:p>&nbsp;</o:p></sp=
an></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">Sam Stephenson<o:p></=
o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0020_01C464DE.D51DBDF0--
