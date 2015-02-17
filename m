Return-Path: <theq@rogers.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048;
	t=1424144213; bh=YEwAO3Xak2Qehamebpbwz1AEVojda6JI+UlERmVgiJw=;
	h=From:To:Subject:Date:From:Subject;
	b=bR382LswlV4QQaY+n4WxZ4cXW8f0bNQ7ErvouwG+Oaovdra1VPRNH/osjn++1KdGrwP81fSgSW00sPU/Kpe9LsTfkFokLXgj39pHyzUCIY3o2uBLDdB/YiYyzfR7fZtL3TE3vFqQPgQRbuji2QSAnM0rUmwJqAwJOMGs8quDiulE+zY+Tkx7JbmeYQOU5SoZ+0+mEx2GEKlKmgRizWCVS3vI9cyUf/T9o51fz4N6l/PO+dJ/HkLUCjLfEfvKMV3zWf4jX2Mja2aE/s+0cuLOn7WxJGY6WonYhdfMdjNsioEYKA4HHz5elMbYQTdO/TOj9VAErPJowC5TEocLGb+40g==
From: "Q" <theq@rogers.com>
Date: Mon, 16 Feb 2015 22:36:45 -0500
Message-ID: <033601d04a62$f67c3510$e3749f30$@rogers.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0337_01D04A39.0DB9B510"
Content-Language: en-ca
Subject: [Bridge] Is there anyway to force an ethernet inteface to stay up
	(ignore carrier detection) in order to keep the bridge up?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a multipart message in MIME format.

------=_NextPart_000_0337_01D04A39.0DB9B510
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi guys

 

I am trying to keep a linux bridge up even when there is no interface
connected to it. Is this possible?

 

 

br0 has eth13 and eth0 ensalved to it

eth0 is up

eht13 is down

 

 

 

 

    /opt# ip link show br0

    25: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state
UP mode DEFAULT group default 

        link/ether 00:0f:20:67:dc:b4 brd ff:ff:ff:ff:ff:ff

    /opt# 

    /opt# 

    /opt/iou/bin# ip link show eth13

    15: eth13: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast
master br0 state DOWN mode DEFAULT group default qlen 1000

        link/ether 00:e0:4c:80:1a:50 brd ff:ff:ff:ff:ff:ff

    /opt# 

    /opt# 

    /opt# ip link show eth0

    3: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
master br0 state UP mode DEFAULT group default qlen 1000

        link/ether 00:0f:20:67:dc:b4 brd ff:ff:ff:ff:ff:ff

    /opt# 

    /opt# ip link show eth13

    15: eth13: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast
master br0 state DOWN mode DEFAULT group default qlen 1000

        link/ether 00:e0:4c:80:1a:50 brd ff:ff:ff:ff:ff:ff

    

    /opt# brctl delif br0 eth0   

    /opt# ip link show br0        

    25: br0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
state DOWN mode DEFAULT group default 

        link/ether 00:e0:4c:80:1a:50 brd ff:ff:ff:ff:ff:ff

 

thanks

Q


------=_NextPart_000_0337_01D04A39.0DB9B510
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
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
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-CA link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hi =
guys<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>I am trying to keep a linux bridge up even when there =
is no interface connected to it. Is this possible?<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>br0 has =
eth13 and eth0 ensalved to it<o:p></o:p></p><p class=3DMsoNormal>eth0 is =
up<o:p></o:p></p><p class=3DMsoNormal>eht13 is down<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; /opt# ip link show =
br0<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; 25: br0: =
&lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc noqueue state UP =
mode DEFAULT group default <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;link/et=
her 00:0f:20:67:dc:b4 brd ff:ff:ff:ff:ff:ff<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; /opt# <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;/opt# <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;/opt/iou/bin# ip link show =
eth13<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; 15: eth13: =
&lt;NO-CARRIER,BROADCAST,MULTICAST,UP&gt; mtu 1500 qdisc pfifo_fast =
master br0 state DOWN mode DEFAULT group default qlen =
1000<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link/ether =
00:e0:4c:80:1a:50 brd ff:ff:ff:ff:ff:ff<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; /opt# <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;/opt# <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;/opt# ip link show =
eth0<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; 3: eth0: =
&lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc pfifo_fast master =
br0 state UP mode DEFAULT group default qlen 1000<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link/ether =
00:0f:20:67:dc:b4 brd ff:ff:ff:ff:ff:ff<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; /opt# <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;/opt# ip link show =
eth13<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; 15: eth13: =
&lt;NO-CARRIER,BROADCAST,MULTICAST,UP&gt; mtu 1500 qdisc pfifo_fast =
master br0 state DOWN mode DEFAULT group default qlen =
1000<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link/ether =
00:e0:4c:80:1a:50 brd ff:ff:ff:ff:ff:ff<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;/opt# brctl delif br0 =
eth0&nbsp;&nbsp; <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;/opt# ip link show =
br0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;25: br0: =
&lt;NO-CARRIER,BROADCAST,MULTICAST,UP&gt; mtu 1500 qdisc noqueue state =
DOWN mode DEFAULT group default <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;link/et=
her 00:e0:4c:80:1a:50 brd ff:ff:ff:ff:ff:ff<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>thanks<o:p></o:p></p><p =
class=3DMsoNormal>Q<o:p></o:p></p></div></body></html>
------=_NextPart_000_0337_01D04A39.0DB9B510--

