From: "thusitha" <thusitha@netplexer.com>
Date: Wed, 26 Mar 2008 21:09:47 +0530
Message-ID: <000001c88f57$a12d33c0$e3879b40$@com>
MIME-Version: 1.0
Content-Type: multipart/related;
	boundary="----=_NextPart_000_0001_01C88F85.BAE56FC0"
Content-Language: en-us
Subject: [Bridge] router interface errors
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

This is a multipart message in MIME format.

------=_NextPart_000_0001_01C88F85.BAE56FC0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0002_01C88F85.BAEB8A40"


------=_NextPart_001_0002_01C88F85.BAEB8A40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

 

I have created a simple bridge with 6 interfaces and connected it in between
a router and a switch. In the router fastEthernet interface I can see errors
with CRC. Also in the bridge interfaces like below.

 

eth5      Link encap:Ethernet  HWaddr 00:10:F3:11:43:AC  

          inet6 addr: fe80::210:f3ff:fe11:43ac/64 Scope:Link

          UP BROADCAST MULTICAST  MTU:1500  Metric:1

          RX packets:142300474 errors:0 dropped:0 overruns:0 frame:0

          TX packets:156954048 errors:1040733 dropped:0 overruns:0
carrier:1040733

          collisions:2070157 txqueuelen:100 

          RX bytes:2942761069 (2.7 GiB)  TX bytes:3367976736 (3.1 GiB)

          Base address:0xb000 Memory:df100000-df120000 

 

eth6      Link encap:Ethernet  HWaddr 00:10:F3:11:43:AD  

          inet6 addr: fe80::210:f3ff:fe11:43ad/64 Scope:Link

          UP BROADCAST MULTICAST  MTU:1500  Metric:1

          RX packets:157287078 errors:0 dropped:0 overruns:0 frame:0

          TX packets:142138508 errors:620885 dropped:0 overruns:0
carrier:620885

          collisions:3261727 txqueuelen:100 

          RX bytes:3390946046 (3.1 GiB)  TX bytes:2932101998 (2.7 GiB)

          Base address:0xb400 Memory:df140000-df160000 

 

In some environment the switch side is ok. But the router side is always
gives errors like above. There was ebtables enabled and I disabled it in
/proc/sys/net/bridge/bridge-nf* files by putting 0. Is this the problem or
are there anything else.
 
Thanks

 

 

signature

 


------=_NextPart_001_0002_01C88F85.BAEB8A40
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
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"2050" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hi<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I have created a simple bridge with 6 interfaces =
and
connected it in between a router and a switch. In the router =
fastEthernet
interface I can see errors with CRC. Also in the bridge interfaces like =
below.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>eth5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link
encap:Ethernet&nbsp; HWaddr 00:10:F3:11:43:AC&nbsp; =
<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
inet6 addr: fe80::210:f3ff:fe11:43ac/64 Scope:Link<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
UP BROADCAST MULTICAST&nbsp; MTU:1500&nbsp; =
Metric:1<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;RX
packets:142300474 errors:0 dropped:0 overruns:0 =
frame:0<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
TX packets:156954048 errors:1040733 dropped:0 overruns:0 =
carrier:1040733<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
collisions:2070157 txqueuelen:100 <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
RX bytes:2942761069 (2.7 GiB)&nbsp; TX bytes:3367976736 (3.1 =
GiB)<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Base address:0xb000 Memory:df100000-df120000 <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>eth6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link
encap:Ethernet&nbsp; HWaddr 00:10:F3:11:43:AD&nbsp; =
<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
inet6 addr: fe80::210:f3ff:fe11:43ad/64 Scope:Link<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
UP BROADCAST MULTICAST&nbsp; MTU:1500&nbsp; =
Metric:1<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
RX packets:157287078 errors:0 dropped:0 overruns:0 =
frame:0<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
TX packets:142138508 errors:620885 dropped:0 overruns:0 =
carrier:620885<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
collisions:3261727 txqueuelen:100 <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
RX bytes:3390946046 (3.1 GiB)&nbsp; TX bytes:2932101998 (2.7 =
GiB)<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Base address:0xb400 Memory:df140000-df160000 <o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<pre>In some environment the switch side is ok. But the router side is =
always gives errors like above. There was ebtables enabled and I =
disabled it in /proc/sys/net/bridge/bridge-nf* files by putting 0. Is =
this the problem or are there anything =
else.<o:p></o:p></pre><pre><o:p>&nbsp;</o:p></pre><pre>Thanks<o:p></o:p><=
/pre>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><img width=3D623 height=3D139 =
id=3D"Picture_x0020_1"
src=3D"cid:image002.jpg@01C88F81.DB039F60" =
alt=3Dsignature><o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_001_0002_01C88F85.BAEB8A40--

------=_NextPart_000_0001_01C88F85.BAE56FC0
Content-Type: image/jpeg;
	name="image002.jpg"
Content-Transfer-Encoding: base64
Content-ID: <image002.jpg@01C88F81.DB039F60>

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIf
IiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7
Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCACLAm8DASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD2aioL
m9trMKbiZY93Td3pi6nZPGJFuUKE4Bz3qXJLdiTTlyrctUVHDNFOm+Jw69MipKaaauimmtGFFVf7
SsvtZtftUfnj+DdzVqqaa3JTT2CikJwMmoIr61ngeeK4R4kJDODwMdaVuoXSLFFUP7b0z/n8jo/t
vTf+fyOlzLuT7SHdF+iqH9t6b/z+R1O19arafa2nQQf89M8UJp6IanF7MsUVnf8ACQaT/wA/8X50
f8JBpH/P/F+daezn2F7SHc0aKzv+Eg0n/n/h/OrFzqFnZxo9xcJGr/dJPWlyS7D5473LNFZv/CQ6
R/z/AMX50f8ACQ6R/wA/8X50/Zz7C9pDuaVFVLXU7G+crbXUcrDkhTzUou7c3RtRMnnhdxjzzip5
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
JUJGCQKNA1P/2Q==

------=_NextPart_000_0001_01C88F85.BAE56FC0--

