Message-ID: <COL102-DS8EEFACEAA0D1A8E3D5CA2CF0A0@phx.gbl>
From: "Song Ping \(pubic emailbox\)" <itestitest@hotmail.com>
Date: Thu, 6 Aug 2009 13:10:21 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_002F_01CA1697.40FF8200"
Subject: [Bridge] bridge on colinux: need to configure bridging in kernel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

------=_NextPart_000_002F_01CA1697.40FF8200
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi:

I'm trying to setup dynamips to simulate some cisco routers in ubuntu and I
need to bridge the router interface out of the linux NIC (so two virtual
routers hold by 2 linux can talk), and it looks I need this fancy bridge
tool, but.

When I install the bridge-utils and start to configure a bridge, it reports
the following error:

# brctl addbr br0

add bridge failed: Package not installed

 

read through the document and realize I probably need to "configure Ethernet
bridging into my kernel", here is my kernel version:

root@ubuntu-1:/home/ping1# uname -r

2.6.22.18-co-0.7.4

 

So , yes I'm using colinux (running on top of winxp), but I don't think that
should be the root cause, problem is now how do I "configure Ethernet
bridging into my kernel"? 

Sorry this may sound a stupid question for experts but I'm not an export of
linux so that sound real hard and dangrious for me , any step-by-step
suggestion on that?

 

Thanks!

 

Regards/ping

 

 


------=_NextPart_000_002F_01CA1697.40FF8200
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chsdate"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:&#23435;&#20307;;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@&#23435;&#20307;";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
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
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:15.6pt;}
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

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Hi:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>I&#8217;m trying to setup dynamips to simulate =
some cisco
routers in ubuntu and I need to bridge the router interface out of the =
linux
NIC (so two virtual routers hold by 2 linux can talk), and it looks I =
need this
fancy bridge tool, but&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>When I install the bridge-utils and start to =
configure
a bridge, it reports the following error:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'># brctl addbr br0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>add bridge failed: Package not =
installed<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>read through the document and realize I =
probably need
to &#8220;configure Ethernet bridging into my kernel&#8221;, here is my =
kernel version:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DPT-BR =
style=3D'font-size:
9.0pt;font-family:Arial'>root@ubuntu-1:/home/ping1# uname =
-r<o:p></o:p></span></font></p>

<p class=3DMsoNormal><st1:chsdate IsROCDate=3D"False" =
IsLunarDate=3D"False" Day=3D"30"
Month=3D"12" Year=3D"1899" w:st=3D"on"><font size=3D1 face=3DArial><span =
lang=3DEN-US
 =
style=3D'font-size:9.0pt;font-family:Arial'>2.6.22</span></font></st1:chs=
date><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>.18-co-0.7.4<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>So , yes I&#8217;m using colinux (running on =
top of winxp),
but I don&#8217;t think that should be the root cause, problem is now =
how do I &#8220;configure
Ethernet bridging into my kernel&#8221;? <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Sorry this may sound a stupid question for =
experts but
I&#8217;m not an export of linux so that sound real hard and dangrious =
for me , any
step-by-step suggestion on that?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Thanks!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Regards/ping<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_002F_01CA1697.40FF8200--
