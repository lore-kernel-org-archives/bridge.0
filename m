From: "Kirti S. Bajwa" <kbajwa@tibonline.net>
Date: Tue, 27 Jun 2006 11:00:28 -0400
Message-ID: <00dd01c699fa$7462e5f0$20ed150c@SunShine>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00DE_01C699D8.ED5145F0"
In-Reply-To: <44A142D8.5010301@uku.co.uk>
Subject: Re: [Bridge] Bridge does not stay UP!!!
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

------=_NextPart_000_00DE_01C699D8.ED5145F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Robert:

 

This makes sense. I am pretty green when comes to LINUX. Does anybody has a
boot sequence script to share? Thank you in advance.

 

Kirt

 

-----Original Message-----
From: Robert Stannard [mailto:robert.stannard@uku.co.uk] 
Sent: Tuesday, June 27, 2006 10:38 AM
To: Kirti S. Bajwa
Cc: bridge@lists.osdl.org
Subject: Re: [Bridge] Bridge does not stay UP!!!

 

Dear Kirt,

The bridge needs to be setup each time you reboot the system. It is not
remembered or setup in the boot sequence as standard.
You need to include a small script in the bootup sequence to initialise the
bridge automatically.

I hope this helps a little?

Best Regards
Robert Stannard

PS
There are some previous posts about this.
See http://lists.osdl.org/mailman/htdig/bridge/2004-March/000215.html for
one example.

Kirti S. Bajwa wrote: 

Hello German:

 

Thank you for your response. I have read & re-read the documents you have
suggested. Why the Bridge would not stay ACTIVE is not discussed in any of
these documents.

 

Anybody else has a suggestion?

 

Kirt

 

 

-----Original Message-----
From: bridge-bounces@lists.osdl.org [mailto:bridge-bounces@lists.osdl.org]
On Behalf Of German Jimenez Leal
Sent: Monday, June 26, 2006 7:00 PM
To: bridge@lists.osdl.org
Subject: Re: [Bridge] Bridge does not stay UP!!!

 

Hello Kirti:

http://linux-net.osdl.org/index.php/Bridge

http://www.shorewall.net/   shorewall 3.x documentacion ----
7.-Bridging------  <http://www.shorewall.net/bridge.html> Bridge/Firewall
(control traffic through the bridge)

 

 

 

  _____  

De: bridge-bounces@lists.osdl.org [mailto:bridge-bounces@lists.osdl.org] En
nombre de Kirti S. Bajwa
Enviado el: Lunes, 26 de Junio de 2006 03:54 p.m.
Para: bridge@lists.osdl.org
Asunto: [Bridge] Bridge does not stay UP!!!

Hello List:

 

I am trying to setup a bridge & Shorewall on a CentOS 4.3 (fresh Install)
server. I successfully setup the bridge. However when I reboot the system,
the bridge does not remain ACTIVE. 

 

Am I missing a setting?

 

Thanks.

 

Kirti

 





  _____  



 
_______________________________________________
Bridge mailing list
Bridge@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/bridge
  

 


------=_NextPart_000_00DE_01C699D8.ED5145F0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<DEFANGED_style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";
	color:black;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.EmailStyle18
	{font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</DEFANGED_style>

</head>

<body bgcolor=3Dwhite lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial;color:navy">Robert:</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial;color:navy">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial;color:navy">This makes sense. I am pretty green wh=
en
comes to LINUX. Does anybody has a boot sequence script to share? Thank you=
 in
advance.</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial;color:navy">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial;color:navy">Kirt</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial;color:navy">&nbsp;</span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dblack
face=3DTahoma><span DEFANGED_style=3D"font-size:10.0pt;font-family:Tahoma;c=
olor:windowtext">-----Original
Message-----<br>
<b><span DEFANGED_style=3D"font-weight:bold">From:</span></b> Robert Stanna=
rd
[mailto:robert.stannard@uku.co.uk] <br>
<b><span DEFANGED_style=3D"font-weight:bold">Sent:</span></b> </span></font=
><font size=3D2 color=3Dblack face=3DTahoma><span DEFANGED_style=3D"font-si=
ze:10.0pt;font-family:Tahoma;
 color:windowtext">Tuesday, June 27, 2006</span></font><font size=3D2
color=3Dblack face=3DTahoma><span DEFANGED_style=3D"font-size:10.0pt;font-f=
amily:Tahoma;
color:windowtext"> </span></font><font size=3D2 color=3Dblack face=3DTahoma=
><span
 DEFANGED_style=3D"font-size:10.0pt;font-family:Tahoma;color:windowtext">10=
:38 AM</span></font><font
size=3D2 color=3Dblack face=3DTahoma><span DEFANGED_style=3D"font-size:10.0=
pt;font-family:Tahoma;
color:windowtext"><br>
<b><span DEFANGED_style=3D"font-weight:bold">To:</span></b> Kirti S. Bajwa<=
br>
<b><span DEFANGED_style=3D"font-weight:bold">Cc:</span></b> bridge@lists.os=
dl.org<br>
<b><span DEFANGED_style=3D"font-weight:bold">Subject:</span></b> Re: [Bridg=
e] Bridge does
not stay UP!!!</span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">&nbsp;</=
span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">Dear Kir=
t,<br>
<br>
The bridge needs to be setup each time you reboot the system. It is not
remembered or setup in the boot sequence as standard.<br>
You need to include a small script in the bootup sequence to initialise the
bridge automatically.<br>
<br>
I hope this helps a little?<br>
<br>
Best Regards<br>
Robert Stannard<br>
<br>
PS<br>
There are some previous posts about this.<br>
See <a href=3D"http://lists.osdl.org/mailman/htdig/bridge/2004-March/000215=
.html">http://lists.osdl.org/mailman/htdig/bridge/2004-March/000215.html</a>
for one example.<br>
<br>
Kirti S. Bajwa wrote: </span></font></p>

<div>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dnavy face=3DArial><span
DEFANGED_defanged_style=3D"font-size:&#13;&#10;10.0pt;font-family:Arial;col=
or:navy"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial;color:navy"><DEFANGED_=
style><!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
	{font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
--></DEFANGED_style><DEFANGED_STYLE><!--
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
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
--></DEFANGED_STYLE>Hello German:</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dnavy face=3DArial><span
DEFANGED_defanged_style=3D"font-size:&#13;&#10;10.0pt;font-family:Arial;col=
or:navy"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial;color:navy">&nbsp;</sp=
an></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dnavy face=3DArial><span
DEFANGED_defanged_style=3D"font-size:&#13;&#10;10.0pt;font-family:Arial;col=
or:navy"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial;color:navy">Thank you =
for your
response. I have read &amp; re-read the documents you have suggested. Why t=
he
Bridge would not stay ACTIVE is not discussed in any of these documents.</s=
pan></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dnavy face=3DArial><span
DEFANGED_defanged_style=3D"font-size:&#13;&#10;10.0pt;font-family:Arial;col=
or:navy"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial;color:navy">&nbsp;</sp=
an></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dnavy face=3DArial><span
DEFANGED_defanged_style=3D"font-size:&#13;&#10;10.0pt;font-family:Arial;col=
or:navy"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial;color:navy">Anybody el=
se has a
suggestion?</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dnavy face=3DArial><span
DEFANGED_defanged_style=3D"font-size:&#13;&#10;10.0pt;font-family:Arial;col=
or:navy"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial;color:navy">&nbsp;</sp=
an></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dnavy face=3DArial><span
DEFANGED_defanged_style=3D"font-size:&#13;&#10; 10.0pt;font-family:Arial;co=
lor:navy"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial;color:navy">Kirt</span=
></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dnavy face=3DArial><span
DEFANGED_defanged_style=3D"font-size:&#13;&#10;10.0pt;font-family:Arial;col=
or:navy"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial;color:navy">&nbsp;</sp=
an></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dnavy face=3DArial><span
DEFANGED_defanged_style=3D"font-size:&#13;&#10;10.0pt;font-family:Arial;col=
or:navy"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial;color:navy">&nbsp;</sp=
an></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D2 color=3Dblack face=3DTahoma><span DEFANGED_defanged_style=3D"font-=
size:10.0pt;font-family:Tahoma"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Tahoma">-----Original Messag=
e-----<br>
<b><span DEFANGED_defanged_style=3D"font-weight:bold"><span DEFANGED_style=
=3D"font-weight:bold">From:</span></span></b>
<a href=3D"mailto:bridge-bounces@lists.osdl.org">bridge-bounces@lists.osdl.=
org</a>
[<a href=3D"mailto:bridge-bounces@lists.osdl.org">mailto:bridge-bounces@lis=
ts.osdl.org</a>]
<b><span DEFANGED_defanged_style=3D"font-weight:bold"><span DEFANGED_style=
=3D"font-weight:bold">On
Behalf Of </span></span></b>German Jimenez Leal<br>
<b><span DEFANGED_defanged_style=3D"font-weight:bold"><span DEFANGED_style=
=3D"font-weight:bold">Sent:</span></span></b>
</span></span></font><font size=3D2 face=3DTahoma><span DEFANGED_defanged_s=
tyle=3D"font-size:10.0pt;font-family:Tahoma"><span
 DEFANGED_style=3D"font-size:10.0pt;font-family:Tahoma">Monday, June 26, 20=
06</span></span></font><font
size=3D2 face=3DTahoma><span DEFANGED_defanged_style=3D"font-size:10.0pt;&#=
13;&#10;font-family:Tahoma"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Tahoma"> </span></font><font
 size=3D2 face=3DTahoma><span DEFANGED_style=3D"font-size:10.0pt;font-famil=
y:Tahoma">7:00 PM</span></span></font><font
size=3D2 face=3DTahoma><span DEFANGED_defanged_style=3D"font-size:10.0pt;fo=
nt-family:Tahoma"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Tahoma"><br>
<b><span DEFANGED_defanged_style=3D"font-weight:bold"><span DEFANGED_style=
=3D"font-weight:bold">To:</span></span></b>
<a href=3D"mailto:bridge@lists.osdl.org">bridge@lists.osdl.org</a><br>
<b><span DEFANGED_defanged_style=3D"font-weight:bold"><span DEFANGED_style=
=3D"font-weight:bold">Subject:</span></span></b>
Re: [Bridge] Bridge does not stay UP!!!</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D2 color=3Dblue face=3DArial><span DEFANGED_defanged_style=3D"font-si=
ze:10.0pt;font-family:Arial;color:blue"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial;color:blue">Hello Kirt=
i:</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D2 color=3Dblue face=3DArial><span DEFANGED_defanged_style=3D"font-si=
ze:10.0pt;font-family:Arial;color:blue"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial;color:blue"><a
href=3D"http://linux-net.osdl.org/index.php/Bridge">http://linux-net.osdl.o=
rg/index.php/Bridge</a></span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D2 color=3Dblue face=3DArial><span DEFANGED_defanged_style=3D"font-si=
ze:10.0pt;font-family:Arial;color:blue"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial;color:blue"><a
href=3D"http://www.shorewall.net/">http://www.shorewall.net/</a>&nbsp;&nbsp;
shorewall 3.x documentacion ----&nbsp;7.-Bridging------ <a
href=3D"http://www.shorewall.net/bridge.html" target=3D"_self"><font size=
=3D3
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:12.0pt;=
font-family:&quot;Times New Roman&quot;"><span
DEFANGED_style=3D'font-size:12.0pt;font-family:"Times New Roman"'>Bridge/Fi=
rewall (control
traffic through the bridge)</span></span></font></a></span></span></font></=
p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<font size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defang=
ed_style=3D"font-size:12.0pt"></font>

<div class=3D"MsoNormal" align=3D"center" DEFANGED_style=3D"margin-left:.5i=
n;text-align:center"><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span lang=3D"ES" DEFANGED_=
style=3D"font-size:12.0pt">

<hr size=3D2 width=3D"100%" align=3Dcenter>

</span></font></div>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"
DEFANGED_defanged_style=3D"margin-right:0in;margin-bottom:12.0pt;margin-lef=
t:&#13;&#10;.5in"><b><font
size=3D2 color=3Dblack face=3DTahoma><span lang=3D"ES" DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Tahoma;font-weight:bold">De:</span></span></font></b><font size=
=3D2
face=3DTahoma><span DEFANGED_defanged_style=3D"font-size:10.0pt;font-family=
:Tahoma"><span
lang=3D"ES" DEFANGED_style=3D"font-size:10.0pt;font-family:Tahoma"> <a
href=3D"mailto:bridge-bounces@lists.osdl.org">bridge-bounces@lists.osdl.org=
</a> [<a
href=3D"mailto:bridge-bounces@lists.osdl.org">mailto:bridge-bounces@lists.o=
sdl.org</a>]
<b><span DEFANGED_defanged_style=3D"font-weight:bold"><span DEFANGED_style=
=3D"font-weight:bold">En
nombre de </span></span></b>Kirti S. Bajwa<br>
<b><span DEFANGED_defanged_style=3D"font-weight:bold"><span DEFANGED_style=
=3D"font-weight:bold">Enviado
el:</span></span></b> Lunes, 26 de Junio de 2006 03:54 p.m.<br>
<b><span DEFANGED_defanged_style=3D"font-weight:bold"><span DEFANGED_style=
=3D"font-weight:bold">Para:</span></span></b>
<a href=3D"mailto:bridge@lists.osdl.org">bridge@lists.osdl.org</a><br>
<b><span DEFANGED_defanged_style=3D"font-weight:bold"><span DEFANGED_style=
=3D"font-weight:bold">Asunto:</span></span></b>
[Bridge] Bridge does not stay UP!!!</span></span></font></p>

<div>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D2 color=3Dblack face=3D"Courier New"><span DEFANGED_defanged_style=
=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;"><span
DEFANGED_defanged_style=3D"font-size:10.0pt;font-family:&quot;Courier New&q=
uot;"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Hello List:</=
span></span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D2 color=3Dblack face=3D"Courier New"><span DEFANGED_defanged_style=
=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;"><span
DEFANGED_defanged_style=3D"font-size:10.0pt;font-family:&quot;Courier New&q=
uot;"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>I am trying t=
o setup a
bridge &amp; Shorewall on a CentOS 4.3 (fresh Install) server. I successful=
ly
setup the bridge. However when I reboot the system, the bridge does not rem=
ain
ACTIVE. </span></span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D2 color=3Dblack face=3D"Courier New"><span DEFANGED_defanged_style=
=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;"><span
DEFANGED_defanged_style=3D"font-size:10.0pt;font-family:&quot;Courier New&q=
uot;"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Am I missing =
a setting?</span></span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D2 color=3Dblack face=3D"Courier New"><span DEFANGED_defanged_style=
=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;"><span
DEFANGED_defanged_style=3D"font-size:10.0pt;font-family:&quot;Courier New&q=
uot;"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Thanks.</span=
></span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D2 color=3Dblack face=3D"Courier New"><span DEFANGED_defanged_style=
=3D"font-size:10.0pt;&#13;&#10; font-family:&quot;Courier New&quot;"><span
DEFANGED_defanged_style=3D"font-size:10.0pt;font-family:&quot;Courier New&q=
uot;"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Kirt</span><s=
pan
DEFANGED_defanged_style=3D"font-size:10.0pt;font-family:&quot;Courier New&q=
uot;">i</span></span></span></font></p>

</div>

</div>

<pre DEFANGED_style=3D"margin-left:.5in" wrap=3D""><font size=3D2 color=3Db=
lack
face=3D"Courier New"><span DEFANGED_style=3D"font-size:10.0pt">&nbsp;</span=
></font></pre><pre
DEFANGED_style=3D"margin-left:.5in;text-align:center"><font size=3D2 color=
=3Dblack
face=3D"Courier New"><span DEFANGED_style=3D"font-size:10.0pt">

<hr size=3D4 width=3D"90%" align=3Dcenter>

</span></font></pre><pre DEFANGED_style=3D"margin-left:.5in"><font size=3D2=
 color=3Dblack
face=3D"Courier New"><span DEFANGED_style=3D"font-size:10.0pt">&nbsp;</span=
></font></pre><pre
DEFANGED_style=3D"margin-left:.5in"><font size=3D2 color=3Dblack face=3D"Co=
urier New"><span
DEFANGED_style=3D"font-size:10.0pt">_______________________________________=
________</span></font></pre><pre
DEFANGED_style=3D"margin-left:.5in"><font size=3D2 color=3Dblack face=3D"Co=
urier New"><span
DEFANGED_style=3D"font-size:10.0pt">Bridge mailing list</span></font></pre>=
<pre
DEFANGED_style=3D"margin-left:.5in"><font size=3D2 color=3Dblack face=3D"Co=
urier New"><span
DEFANGED_style=3D"font-size:10.0pt"><a href=3D"mailto:Bridge@lists.osdl.org=
">Bridge@lists.osdl.org</a></span></font></pre><pre
DEFANGED_style=3D"margin-left:.5in"><font size=3D2 color=3Dblack face=3D"Co=
urier New"><span
DEFANGED_style=3D"font-size:10.0pt"><a
href=3D"https://lists.osdl.org/mailman/listinfo/bridge">https://lists.osdl.=
org/mailman/listinfo/bridge</a></span></font></pre><pre
DEFANGED_style=3D"margin-left:.5in"><font size=3D2 color=3Dblack face=3D"Co=
urier New"><span
DEFANGED_style=3D"font-size:10.0pt">&nbsp; </span></font></pre>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">&nbsp;</=
span></font></p>

</div>

</body>

</html>

------=_NextPart_000_00DE_01C699D8.ED5145F0--
