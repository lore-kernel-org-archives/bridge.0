From: "Vaidas M" <admin@vdx.lt>
Date: Sat, 20 Oct 2007 13:56:56 +0300
Message-ID: <001301c81307$ee5cb110$cb161330$@lt>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0014_01C81321.13A9E910"
Content-Language: lt
Subject: [Bridge] vlan, bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a multipart message in MIME format.

------=_NextPart_000_0014_01C81321.13A9E910
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello to everyone,

 

Here is the situation:

 

[LAN1] ---- [eth3] /----------\

                   | LinuxBR  | [eth2] ---- [LAN0] ----- [linuxgateway] ---
[internet]

[LAN2] ---- [eth4] \----------/

 

Whole LAN is in subnet 10.0.0.0/24.

 

So I need LAN0, LAN1, LAN2 could not see each other.

LAN0, LAN1, LAN2 is in same subnet (10.0.0.0/24).

All LANs have to get only internet.

 

How can I configure LinuxBR to do so?

 

Do I have to do only bridge? Or only vlan? Or both?

 

Thanks.

 

_      _     _    _   _  _ _ __ ___ ____ _____

Vaidas M. [Noxius]

 


------=_NextPart_000_0014_01C81321.13A9E910
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Tahoma","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:3.0cm 1.0cm 2.0cm 3.0cm;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>Hello to =
everyone,<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>Here is =
the
situation:<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[LAN1] =
---- [eth3] /----------\<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| LinuxBR &nbsp;| [eth2] ---- =
[LAN0] -----
[linuxgateway] --- [internet]<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[LAN2] =
---- [eth4] \----------/<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>Whole LAN =
is in
subnet 10.0.0.0/24.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>So I need =
LAN0,
LAN1, LAN2 could not see each other.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>LAN0, =
LAN1, LAN2 is
in same subnet (10.0.0.0/24).<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>All LANs =
have to get
only internet.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>How can I =
configure
LinuxBR to do so?<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>Do I have =
to do only
bridge? Or only vlan? Or both?<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier =
New"'>Thanks.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal align=3Dright style=3D'text-align:right'><span =
style=3D'font-size:
10.0pt;font-family:"Courier New"'>_&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
_&nbsp;&nbsp;&nbsp;&nbsp; _&nbsp;&nbsp;&nbsp; _&nbsp;&nbsp; _&nbsp; _ _ =
__ ___
____ _____<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dright style=3D'text-align:right'><b><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Vaidas =
M</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>. =
<b>[</b>Noxius<b>]</b><o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

</div>

</body>

</html>

------=_NextPart_000_0014_01C81321.13A9E910--

