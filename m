Message-Id: <200706211851.l5LIpEP8018352@smtp2.linux-foundation.org>
From: "Hasan Rashid" <hasan@digitalpath.net>
Date: Thu, 21 Jun 2007 11:51:31 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C7B3FA.828D4240"
Subject: [Bridge] Customize bridge code to set transmit interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C7B3FA.828D4240
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I am trying to modify the bridge code so I can define what interfaces to
transmit data through. I added a function in brctl CLI to accept the
interface name as an argument.

 

For example:

 

brctl settransmit br0 ath0

 

Basically this is for an embedded device where I have two radios on the
device. I want to send all the outgoing traffic through ath0 (radio 1) and
use the other radio for receving ath1 (radio 2).

 

I am trying to load the net_bridge_port from the ifindex and set that as the
port for the *skb->dev->br_port in br_device.c in function br_dev_xmit. No
real success so far.

 

Any ideas on how this could be accomplished? 

 

Thank you!

 

Regards,

Hasan Rashid

Software Developer

 

Digital Path, Inc

275 Airpark Blvd suite 500

Chico, CA 95973

 


------=_NextPart_000_0000_01C7B3FA.828D4240
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40"
xmlns:ns0=3D"urn:schemas-microsoft-com:office:smarttags">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PostalCode"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"State"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"Street"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"address"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
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
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am trying to modify the bridge code so I can define =
what
interfaces to transmit data through. I added a function in brctl CLI to =
accept
the interface name as an argument.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>For example:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>brctl settransmit br0 =
ath0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Basically this is for an embedded device where I have =
two
radios on the device. I want to send all the outgoing traffic through =
ath0
(radio 1) and use the other radio for receving ath1 (radio =
2).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am trying to load the net_bridge_port from the =
ifindex and
set that as the port for the *skb-&gt;dev-&gt;br_port in br_device.c in
function br_dev_xmit. No real success so =
far.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any ideas on how this could be accomplished? =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thank you!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Regards,</span></font><o:p></o:p></p=
>

<p class=3DMsoNormal><b><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy;font-weight:bold'>=
Hasan
Rashid<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Software =
Developer</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><em><i><font size=3D3 color=3Dnavy face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt;color:navy'>Digital Path, =
Inc</span></font></i></em><em><i><font
size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:navy'><o:p></o:p></span></font></i></em></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><ns0:Street w:insAuthor=3D"Administrator"
 w:insDate=3D"2007-06-21T11:42:00Z" w:endInsAuthor=3D"Administrator"
 w:endInsDate=3D"2007-06-21T11:42:00Z"><ns0:address =
w:insAuthor=3D"Administrator"
  w:insDate=3D"2007-06-21T11:42:00Z" w:endInsAuthor=3D"Administrator"
  w:endInsDate=3D"2007-06-21T11:42:00Z"><st1:Street =
w:st=3D"on"><st1:address w:st=3D"on"><font
    color=3Dnavy><span style=3D'color:navy'>275 Airpark Blvd suite =
500</span></font></st1:address></st1:Street></ns0:address></ns0:Street></=
span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><ns0:place w:insAuthor=3D"Administrator"
 w:insDate=3D"2007-06-21T11:42:00Z" w:endInsAuthor=3D"Administrator"
 w:endInsDate=3D"2007-06-21T11:42:00Z"><ns0:City =
w:insAuthor=3D"Administrator"
  w:insDate=3D"2007-06-21T11:42:00Z" w:endInsAuthor=3D"Administrator"
  w:endInsDate=3D"2007-06-21T11:42:00Z"><st1:place w:st=3D"on"><st1:City =
w:st=3D"on"><font
    color=3Dnavy><span =
style=3D'color:navy'>Chico</span></font></st1:City></ns0:City></st1:place=
><font
 color=3Dnavy><span style=3D'color:navy'>, </span></font><ns0:State
  w:insAuthor=3D"Administrator" w:insDate=3D"2007-06-21T11:42:00Z"
  w:endInsAuthor=3D"Administrator" =
w:endInsDate=3D"2007-06-21T11:42:00Z"><st1:State
  w:st=3D"on"><font color=3Dnavy><span =
style=3D'color:navy'>CA</span></font></st1:State></ns0:State><font
 color=3Dnavy><span style=3D'color:navy'> </span></font><ns0:PostalCode
  w:insAuthor=3D"Administrator" w:insDate=3D"2007-06-21T11:42:00Z"
  w:endInsAuthor=3D"Administrator" =
w:endInsDate=3D"2007-06-21T11:42:00Z"><st1:PostalCode
  w:st=3D"on"><font color=3Dnavy><span =
style=3D'color:navy'>95973</span></font></st1:PostalCode></ns0:PostalCode=
></ns0:place></span></font><font
size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0000_01C7B3FA.828D4240--

