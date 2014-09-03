Return-Path: <rsen@vmware.com>
From: Rohan Sen <rsen@vmware.com>
Date: Wed, 3 Sep 2014 09:56:09 +0000
Message-ID: <c531a97fc4f445ea8ea9aa5c860ebcc5@EX13-MBX-010.vmware.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_c531a97fc4f445ea8ea9aa5c860ebcc5EX13MBX010vmwarecom_"
MIME-Version: 1.0
Subject: [Bridge] Parsing /etc/network/interfaces
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

--_000_c531a97fc4f445ea8ea9aa5c860ebcc5EX13MBX010vmwarecom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

When I configure a bunch of ports in access mode (with single native VLAN s=
ay 100) and associate them to a Bridge I don't see any way the system can f=
ind out what the VLAN ID is used by these ports after a restart.
For such configuration /etc/network/interfaces may have something like:

Auto swp1
Iface swp1 inet manual

Auto swp1
Iface swp2 inet manual

Auto bridge-primary
Iface bridge-primary inet manual
      Bridge_ports swp1 swp2

The command I used to associate VLAN 100 with swp1 and swp2 were

ip link add link swp1 type vlan id 100
ip link add link swp2 type vlan id 100

Are these commands at all required? If not it again raises the same questio=
n as just by reading contents of /etc/network/interfaces how does brctl kno=
w which port belongs to which native VLAN?

Nowhere did I mention which VLAN are tied to these ports. I did not keep th=
e bridge name also contain the VLAN ID (I could name it anything, right?).
I am confused because without the knowledge that native VLAN of swp1 and sw=
p2 is 100 how can we maintain such associations across reboots?

Thanks and regards,
Rohan Sen

--_000_c531a97fc4f445ea8ea9aa5c860ebcc5EX13MBX010vmwarecom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">When I configure a bunch of ports in access mode (wi=
th single native VLAN say 100) and associate them to a Bridge I don&#8217;t=
 see any way the system can find out what the VLAN ID is used by these port=
s after a restart.<o:p></o:p></p>
<p class=3D"MsoNormal">For such configuration /etc/network/interfaces may h=
ave something like:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Auto swp1<o:p></o:p></p>
<p class=3D"MsoNormal">Iface swp1 inet manual<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Auto swp1<o:p></o:p></p>
<p class=3D"MsoNormal">Iface swp2 inet manual<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Auto bridge-primary<o:p></o:p></p>
<p class=3D"MsoNormal">Iface bridge-primary inet manual<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bridge_ports swp1 swp=
2<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The command I used to associate VLAN 100 with swp1 a=
nd swp2 were<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">ip link add link swp1 type vlan id 100<o:p></o:p></p=
>
<p class=3D"MsoNormal">ip link add link swp2 type vlan id 100<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Are these commands at all required? If not it again =
raises the same question as just by reading contents of /etc/network/interf=
aces how does brctl know which port belongs to which native VLAN?<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Nowhere did I mention which VLAN are tied to these p=
orts. I did not keep the bridge name also contain the VLAN ID (I could name=
 it anything, right?).<o:p></o:p></p>
<p class=3D"MsoNormal">I am confused because without the knowledge that nat=
ive VLAN of swp1 and swp2 is 100 how can we maintain such associations acro=
ss reboots?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Rohan Sen<o:p></o:p></p>
</div>
</body>
</html>

--_000_c531a97fc4f445ea8ea9aa5c860ebcc5EX13MBX010vmwarecom_--
