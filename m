From: Ng Ming Ann <ming.ng@mimos.my>
Date: Wed, 30 Jun 2010 14:37:32 +0800
Message-ID: <0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5@EXCHANGE.mimos.local>
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_013_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_";
	type="multipart/alternative"
MIME-Version: 1.0
Subject: [Bridge] Enquiry on Linux bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

--_013_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_
Content-Type: multipart/alternative;
	boundary="_000_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_"

--_000_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear all,

I'm currently working on a Ethernet bridge for a system. I have a machine(n=
ot PC, but an embedded system) which has two Ethernet ports, I wanted to co=
nfigure it into a Ethernet bridge which connect other PC.

I have tested on configuring it into a bridge where the two PC able to ping=
 each other and send files. I'm wondering that whether I can involve the em=
bedded Linux system in the network, where the two PC able to detect the Lin=
ux OS( embedded system) and able to send files and communicate with it as t=
he figure below:

[cid:image006.png@01CB1861.C5C49440][cid:image007.png@01CB1861.C5C49440]   =
                                                                           =
                       [cid:image007.png@01CB1861.C5C49440]


PC1


PC2




PC1


PC2





I have try to add an IP to the bridge (virtual port) and the PCs are able t=
o Ping the bridge's IP.

Then I'd tried to configure the network to be like below:
[cid:image011.png@01CB1861.C5C49440][cid:image012.png@01CB1861.C5C49440][ci=
d:image007.png@01CB1861.C5C49440]                                          =
                                                                           =
                         [cid:image007.png@01CB1861.C5C49440]


PC1 and PC2 can ping each other can communicate well. I have added IP to bo=
th bridge, but the result is that, PC1 only able to ping bridge1's IP and n=
ot bridge2's IP. PC2 as well, is only able to ping bridge2's IP and not abl=
e to ping bridge1's IP.

Do you have any suggestion for me to configure the bridge so that both brid=
ge can be detected by each of the PC that connected to them?

Thank you very much in advance.

Regards,
Ming Ann

[cid:sigimage2213.jpg]


------------------------------------------------------------------
-
-
DISCLAIMER: 

This e-mail (including any attachments) is for the addressee(s) 
only and may contain confidential information. If you are not the 
intended recipient, please note that any dealing, review, 
distribution, printing, copying or use of this e-mail is strictly 
prohibited. If you have received this email in error, please notify 
the sender  immediately and delete the original message. 
MIMOS Berhad is a research and development institution under 
the purview of the Malaysian Ministry of Science, Technology and 
Innovation. Opinions, conclusions and other information in this e-
mail that do not relate to the official business of MIMOS Berhad 
and/or its subsidiaries shall be understood as neither given nor 
endorsed by MIMOS Berhad and/or its subsidiaries and neither 
MIMOS Berhad nor its subsidiaries accepts responsibility for the 
same. All liability arising from or in connection with computer 
viruses and/or corrupted e-mails is excluded to the fullest extent 
permitted by law.


--_000_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
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
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"2050" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
  <o:rules v:ext=3D"edit">
   <o:r id=3D"V:Rule2" type=3D"connector" idref=3D"#_x0000_s1028" />
   <o:r id=3D"V:Rule4" type=3D"connector" idref=3D"#_x0000_s1029" />
   <o:r id=3D"V:Rule6" type=3D"connector" idref=3D"#_x0000_s1032" />
   <o:r id=3D"V:Rule7" type=3D"connector" idref=3D"#_x0000_s1033" />
   <o:r id=3D"V:Rule10" type=3D"connector" idref=3D"#_x0000_s1035" />
  </o:rules>
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-MY link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Dear all,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;m currently working on a Ethernet bridge for a
system. I have a machine(not PC, but an embedded system) which has two Ethe=
rnet
ports, I wanted to configure it into a Ethernet bridge which connect other =
PC.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I have tested on configuring it into a bridge where th=
e two
PC able to ping each other and send files. I&#8217;m wondering that whether=
 I
can involve the embedded Linux system in the network, where the two PC able=
 to
detect the Linux OS( embedded system) and able to send files and communicat=
e
with it as the figure below:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><!--[if gte vml 1]><v:shapetype id=3D"_x0000_t32" coor=
dsize=3D"21600,21600"=20
 o:spt=3D"32" o:oned=3D"t" path=3D"m,l21600,21600e" filled=3D"f">
 <v:path arrowok=3D"t" fillok=3D"f" o:connecttype=3D"none" />
 <o:lock v:ext=3D"edit" shapetype=3D"t" />
</v:shapetype><v:shape id=3D"_x0000_s1029" type=3D"#_x0000_t32" style=3D'po=
sition:absolute;
 margin-left:260.25pt;margin-top:34.5pt;width:54.75pt;height:3.75pt;z-index=
:3'=20
 o:connectortype=3D"straight" /><![endif]--><![if !vml]><span style=3D'mso-=
ignore:
vglayout;position:absolute;z-index:3;margin-left:346px;margin-top:45px;
width:75px;height:7px'><img width=3D75 height=3D7
src=3D"cid:image001.png@01CB1860.B0C971B0" v:shapes=3D"_x0000_s1029"></span=
><![endif]><!--[if gte vml 1]><v:shape=20
 id=3D"_x0000_s1028" type=3D"#_x0000_t32" style=3D'position:absolute;margin=
-left:1in;
 margin-top:34.5pt;width:79.5pt;height:3.75pt;flip:x;z-index:2'=20
 o:connectortype=3D"straight" /><![endif]--><![if !vml]><span style=3D'mso-=
ignore:
vglayout;position:absolute;z-index:2;margin-left:95px;margin-top:45px;
width:108px;height:7px'><img width=3D108 height=3D7
src=3D"cid:image002.png@01CB1860.B0C971B0" v:shapes=3D"_x0000_s1028"></span=
><![endif]><!--[if gte vml 1]><v:roundrect=20
 id=3D"_x0000_s1027" style=3D'position:absolute;margin-left:151.5pt;margin-=
top:11.25pt;
 width:108.75pt;height:42.75pt;z-index:1' arcsize=3D"10923f">
 <v:textbox>
  <![if !mso]>
  <table cellpadding=3D0 cellspacing=3D0 width=3D"100%">
   <tr>
    <td><![endif]>
    <div>
    <p class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><span l=
ang=3DEN-US>Embedded=20
    System<o:p></o:p></span></p>
    <p class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><span l=
ang=3DEN-US>(=20
    Bridge)<o:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  <![endif]></v:textbox>
</v:roundrect><![endif]--><![if !vml]><span style=3D'mso-ignore:vglayout;
position:absolute;z-index:1;margin-left:201px;margin-top:14px;width:151px;
height:63px'><img width=3D151 height=3D63 src=3D"cid:image006.png@01CB1861.=
C5C49440"
alt=3D"Rounded Rectangle: Embedded System&#13;&#10;( Bridge)&#13;&#10;" v:s=
hapes=3D"_x0000_s1027"></span><![endif]><img
width=3D116 height=3D88 id=3D"_x0000_i1028" src=3D"cid:image007.png@01CB186=
1.C5C49440">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;<img width=3D116 height=3D88 id=3D"_x0000_i1027"
src=3D"cid:image007.png@01CB1861.C5C49440"><o:p></o:p></p>

<p class=3DMsoNormal><!--[if gte vml 1]><v:shapetype id=3D"_x0000_t202"=20
 coordsize=3D"21600,21600" o:spt=3D"202" path=3D"m,l,21600r21600,l21600,xe"=
>
 <v:stroke joinstyle=3D"miter" />
 <v:path gradientshapeok=3D"t" o:connecttype=3D"rect" />
</v:shapetype><v:shape id=3D"_x0000_s1037" type=3D"#_x0000_t202" style=3D'p=
osition:absolute;
 margin-left:18.75pt;margin-top:.95pt;width:36.75pt;height:18.7pt;z-index:9=
' /><v:shape=20
 id=3D"_x0000_s1039" type=3D"#_x0000_t202" style=3D'position:absolute;margi=
n-left:25.5pt;
 margin-top:136.55pt;width:36.75pt;height:18.7pt;z-index:11' /><v:shape id=
=3D"_x0000_s1040"=20
 type=3D"#_x0000_t202" style=3D'position:absolute;margin-left:435.75pt;
 margin-top:136.55pt;width:36.75pt;height:18.7pt;z-index:12' /><v:shape id=
=3D"_x0000_s1038"=20
 type=3D"#_x0000_t202" style=3D'position:absolute;margin-left:346.5pt;margi=
n-top:.95pt;
 width:36.75pt;height:18.7pt;z-index:10' /><![endif]--><![if !vml]><span
style=3D'mso-ignore:vglayout'>

<table cellpadding=3D0 cellspacing=3D0 align=3Dleft>
 <tr>
  <td width=3D24 height=3D0></td>
  <td width=3D9></td>
  <td width=3D46></td>
  <td width=3D9></td>
  <td width=3D373></td>
  <td width=3D55></td>
  <td width=3D64></td>
  <td width=3D55></td>
 </tr>
 <tr>
  <td height=3D31></td>
  <td colspan=3D2 width=3D55 height=3D31 bgcolor=3Dwhite style=3D'border:.7=
5pt solid black;
  vertical-align:top;background:white'><![endif]><![if !mso]><span
  style=3D'position:absolute;mso-ignore:vglayout;z-index:9'>
  <table cellpadding=3D0 cellspacing=3D0 width=3D"100%">
   <tr>
    <td><![endif]>
    <div v:shape=3D"_x0000_s1037" style=3D'padding:4.35pt 7.95pt 4.35pt 7.9=
5pt'
    class=3Dshape>
    <p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:8.0pt'>PC1<o=
:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  </span><![endif]><![if !mso & !vml]>&nbsp;<![endif]><![if !vml]></td>
  <td colspan=3D2></td>
  <td width=3D55 height=3D31 bgcolor=3Dwhite style=3D'border:.75pt solid bl=
ack;
  vertical-align:top;background:white'><![endif]><![if !mso]><span
  style=3D'position:absolute;mso-ignore:vglayout;z-index:10'>
  <table cellpadding=3D0 cellspacing=3D0 width=3D"100%">
   <tr>
    <td><![endif]>
    <div v:shape=3D"_x0000_s1038" style=3D'padding:4.35pt 7.95pt 4.35pt 7.9=
5pt'
    class=3Dshape>
    <p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:8.0pt'>PC2<o=
:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  </span><![endif]><![if !mso & !vml]>&nbsp;<![endif]><![if !vml]></td>
 </tr>
 <tr>
  <td height=3D150></td>
 </tr>
 <tr>
  <td height=3D31></td>
  <td></td>
  <td colspan=3D2 width=3D55 height=3D31 bgcolor=3Dwhite style=3D'border:.7=
5pt solid black;
  vertical-align:top;background:white'><![endif]><![if !mso]><span
  style=3D'position:absolute;mso-ignore:vglayout;z-index:11'>
  <table cellpadding=3D0 cellspacing=3D0 width=3D"100%">
   <tr>
    <td><![endif]>
    <div v:shape=3D"_x0000_s1039" style=3D'padding:4.35pt 7.95pt 4.35pt 7.9=
5pt'
    class=3Dshape>
    <p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:8.0pt'>PC1<o=
:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  </span><![endif]><![if !mso & !vml]>&nbsp;<![endif]><![if !vml]></td>
  <td colspan=3D3></td>
  <td width=3D55 height=3D31 bgcolor=3Dwhite style=3D'border:.75pt solid bl=
ack;
  vertical-align:top;background:white'><![endif]><![if !mso]><span
  style=3D'position:absolute;mso-ignore:vglayout;z-index:12'>
  <table cellpadding=3D0 cellspacing=3D0 width=3D"100%">
   <tr>
    <td><![endif]>
    <div v:shape=3D"_x0000_s1040" style=3D'padding:4.35pt 7.95pt 4.35pt 7.9=
5pt'
    class=3Dshape>
    <p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:8.0pt'>PC2<o=
:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  </span><![endif]><![if !mso & !vml]>&nbsp;<![endif]><![if !vml]></td>
 </tr>
</table>

</span><![endif]><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<br style=3D'mso-ignore:vglayout' clear=3DALL>

<p class=3DMsoNormal>I have try to add an IP to the bridge (virtual port) a=
nd the
PCs are able to Ping the bridge&#8217;s IP. <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Then I&#8217;d tried to configure the network to be li=
ke
below:<o:p></o:p></p>

<p class=3DMsoNormal><!--[if gte vml 1]><v:shape id=3D"_x0000_s1035" type=
=3D"#_x0000_t32"=20
 style=3D'position:absolute;margin-left:369pt;margin-top:29.25pt;width:39pt=
;
 height:1.6pt;flip:y;z-index:8' o:connectortype=3D"straight" /><![endif]-->=
<![if !vml]><span
style=3D'mso-ignore:vglayout;position:absolute;z-index:8;margin-left:491px;
margin-top:38px;width:54px;height:4px'><img width=3D54 height=3D4
src=3D"cid:image008.png@01CB1861.C5C49440" v:shapes=3D"_x0000_s1035"></span=
><![endif]><!--[if gte vml 1]><v:shape=20
 id=3D"_x0000_s1033" type=3D"#_x0000_t32" style=3D'position:absolute;margin=
-left:223.5pt;
 margin-top:30.1pt;width:36.75pt;height:.75pt;flip:y;z-index:7'=20
 o:connectortype=3D"straight" /><![endif]--><![if !vml]><span style=3D'mso-=
ignore:
vglayout;position:absolute;z-index:7;margin-left:297px;margin-top:39px;
width:51px;height:3px'><img width=3D51 height=3D3
src=3D"cid:image009.png@01CB1861.C5C49440" v:shapes=3D"_x0000_s1033"></span=
><![endif]><!--[if gte vml 1]><v:shape=20
 id=3D"_x0000_s1032" type=3D"#_x0000_t32" style=3D'position:absolute;margin=
-left:1in;
 margin-top:28.5pt;width:42.75pt;height:.75pt;z-index:6' o:connectortype=3D=
"straight" /><![endif]--><![if !vml]><span
style=3D'mso-ignore:vglayout;position:absolute;z-index:6;margin-left:95px;
margin-top:37px;width:59px;height:3px'><img width=3D59 height=3D3
src=3D"cid:image010.png@01CB1861.C5C49440" v:shapes=3D"_x0000_s1032"></span=
><![endif]><!--[if gte vml 1]><v:roundrect=20
 id=3D"_x0000_s1031" style=3D'position:absolute;margin-left:260.25pt;margin=
-top:9.8pt;
 width:108.75pt;height:42.75pt;z-index:5' arcsize=3D"10923f">
 <v:textbox>
  <![if !mso]>
  <table cellpadding=3D0 cellspacing=3D0 width=3D"100%">
   <tr>
    <td><![endif]>
    <div>
    <p class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><span l=
ang=3DEN-US>Embedded=20
    System<o:p></o:p></span></p>
    <p class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><span l=
ang=3DEN-US>(=20
    Bridge2)<o:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  <![endif]></v:textbox>
</v:roundrect><![endif]--><![if !vml]><span style=3D'mso-ignore:vglayout;
position:absolute;z-index:5;margin-left:346px;margin-top:12px;width:151px;
height:63px'><img width=3D151 height=3D63 src=3D"cid:image011.png@01CB1861.=
C5C49440"
alt=3D"Rounded Rectangle: Embedded System&#13;&#10;( Bridge2)&#13;&#10;" v:=
shapes=3D"_x0000_s1031"></span><![endif]><!--[if gte vml 1]><v:roundrect=20
 id=3D"_x0000_s1030" style=3D'position:absolute;margin-left:114.75pt;margin=
-top:9.8pt;
 width:108.75pt;height:42.75pt;z-index:4' arcsize=3D"10923f">
 <v:textbox>
  <![if !mso]>
  <table cellpadding=3D0 cellspacing=3D0 width=3D"100%">
   <tr>
    <td><![endif]>
    <div>
    <p class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><span l=
ang=3DEN-US>Embedded=20
    System<o:p></o:p></span></p>
    <p class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><span l=
ang=3DEN-US>(=20
    Bridge1)<o:p></o:p></span></p>
    </div>
    <![if !mso]></td>
   </tr>
  </table>
  <![endif]></v:textbox>
</v:roundrect><![endif]--><![if !vml]><span style=3D'mso-ignore:vglayout;
position:absolute;z-index:4;margin-left:152px;margin-top:12px;width:151px;
height:63px'><img width=3D151 height=3D63 src=3D"cid:image012.png@01CB1861.=
C5C49440"
alt=3D"Rounded Rectangle: Embedded System&#13;&#10;( Bridge1)&#13;&#10;" v:=
shapes=3D"_x0000_s1030"></span><![endif]><img
width=3D116 height=3D88 id=3D"_x0000_i1026" src=3D"cid:image007.png@01CB186=
1.C5C49440">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img
width=3D116 height=3D88 id=3D"Picture_x0020_1"
src=3D"cid:image007.png@01CB1861.C5C49440"><o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>PC1 and PC2 can ping each other can communicate well. =
I have
added IP to both bridge, but the result is that, PC1 only able to ping brid=
ge1&#8217;s
IP and not bridge2&#8217;s IP. PC2 as well, is only able to ping bridge2&#8=
217;s
IP and not able to ping bridge1&#8217;s IP.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Do you have any suggestion for me to configure the bri=
dge so
that both bridge can be detected by each of the PC that connected to them?<=
o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thank you very much in advance.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt;font-fami=
ly:"Times New Roman","serif"'>Regards,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt;font-fami=
ly:"Times New Roman","serif"'>Ming
Ann<o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

<IMG alt=3D"" src=3D"cid:sigimage2213.jpg" width=3D426=20
height=3D90><br></body>

</html>

<p>

------------------------------------------------------------------<br>
-<br>
-<br>
DISCLAIMER: <br>
<br>
This e-mail (including any attachments) is for the addressee(s) <br>
only and may contain confidential information. If you are not the <br>
intended recipient, please note that any dealing, review, <br>
distribution, printing, copying or use of this e-mail is strictly <br>
prohibited. If you have received this email in error, please notify <br>
the sender  immediately and delete the original message. <br>
MIMOS Berhad is a research and development institution under <br>
the purview of the Malaysian Ministry of Science, Technology and <br>
Innovation. Opinions, conclusions and other information in this e-<br>
mail that do not relate to the official business of MIMOS Berhad <br>
and/or its subsidiaries shall be understood as neither given nor <br>
endorsed by MIMOS Berhad and/or its subsidiaries and neither <br>
MIMOS Berhad nor its subsidiaries accepts responsibility for the <br>
same. All liability arising from or in connection with computer <br>
viruses and/or corrupted e-mails is excluded to the fullest extent <br>
permitted by law.<br>
<br>
<br>
</p>
--_000_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_--

--_013_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_
Content-Type: image/png; name="image001.png"
Content-Description: image001.png
Content-Disposition: inline; filename="image001.png"; size=305;
	creation-date="Wed, 30 Jun 2010 14:36:43 GMT";
	modification-date="Wed, 30 Jun 2010 14:36:43 GMT"
Content-ID: <image001.png@01CB1860.B0C971B0>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAEsAAAAHCAYAAABA1LD9AAAAAXNSR0ICQMB9xQAAAAlwSFlzAAAO
xAAADsQBlSsOGwAAABl0RVh0U29mdHdhcmUATWljcm9zb2Z0IE9mZmljZX/tNXEAAACxSURBVEjH
Y2BgYBAAYgckbNDY2MgwijExCBgA8X4kfB6I/yPh62jyDUg4Ay2gBYZ1YBERmhpoAYIcWNPRAvI9
WkAjyy1H0xuAZKbFsAgsCpMtciBHoAXWeqSAPI4WyPfRArofSV8FmrkKwyKwKAhkBbQAKUAKrHa0
gLyPFtDHkeTWo0VQApq5HEM+sCgMaAukwAhAC6z5aAH9HSmQ36PJTUfTKzBayyECGb1VkIEWWAYA
WKWVc8t1iGsAAAAASUVORK5CYII=

--_013_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_
Content-Type: image/png; name="image002.png"
Content-Description: image002.png
Content-Disposition: inline; filename="image002.png"; size=311;
	creation-date="Wed, 30 Jun 2010 14:36:43 GMT";
	modification-date="Wed, 30 Jun 2010 14:36:43 GMT"
Content-ID: <image002.png@01CB1860.B0C971B0>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAGwAAAAHCAYAAADtVahUAAAAAXNSR0ICQMB9xQAAAAlwSFlzAAAO
xAAADsQBlSsOGwAAABl0RVh0U29mdHdhcmUATWljcm9zb2Z0IE9mZmljZX/tNXEAAAC3SURBVEjH
7dWhDYAwEIVhRugISCQSiWQEJCMwAp2AEZAdAYnsCEhGYAQ4kOQ/QSCBQJs8d7nmvjZtZK2NQt4V
WUaSQ0wAuo4bA2whaSC9ZDhkkiyHzFC3Jf0bbgK4pYJLYDPgTlDXKz0L2D8+NcOLcTMYrgKEVsFd
ICPUOQUXn6THXW7CpeFqQOgAzCu4Hmo76FnT/h9+JfYPjm6YA7BRwaUb3kLPCnCz8BeeO7BUObAS
cJOA9mxWwzm9dBeMnOcAAAAASUVORK5CYII=

--_013_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_
Content-Type: image/png; name="image006.png"
Content-Description: image006.png
Content-Disposition: inline; filename="image006.png"; size=1521;
	creation-date="Wed, 30 Jun 2010 14:36:43 GMT";
	modification-date="Wed, 30 Jun 2010 14:36:43 GMT"
Content-ID: <image006.png@01CB1861.C5C49440>
Content-Transfer-Encoding: base64

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

--_013_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_
Content-Type: image/png; name="image007.png"
Content-Description: image007.png
Content-Disposition: inline; filename="image007.png"; size=393;
	creation-date="Wed, 30 Jun 2010 14:36:43 GMT";
	modification-date="Wed, 30 Jun 2010 14:36:43 GMT"
Content-ID: <image007.png@01CB1861.C5C49440>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAHQAAABYAgMAAABZmjv5AAAAAXNSR0ICQMB9xQAAAAlQTFRFAAAA
AAAA///MPA2uxAAAAAF0Uk5TAEDm2GYAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAZdEVYdFNvZnR3
YXJlAE1pY3Jvc29mdCBPZmZpY2V/7TVxAAAA50lEQVRIx+3WQQ6CMBAF0LLAI7jgNB7BBeOiN5DT
uEAX3ZlQkukplUJpO51qYiQxyN/Jc6Z1JAUhvhAgOUTamDjr12swi1SVL0Snpf1undGd/dgtoXar
WR0u4oe1y+15003/ULlTxSt3Iq1X+SeOUyGqYJLu5P1pLckPqiOtyDDukdJRRbPSFM0l0F6TdWWo
UpLSvvOKZ9oY0WvSGKA5zKpMmtYpNpAGnfaaqbWtB1VcZ9VOyjWGE47K9Z2G+dRbRlv77G40ZFuL
wki2FMddI/CRx/l/4ELuJ0b3L7XM6rBuAbm8eRV8AErqdpfJfPmpAAAAAElFTkSuQmCC

--_013_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_
Content-Type: image/png; name="image008.png"
Content-Description: image008.png
Content-Disposition: inline; filename="image008.png"; size=222;
	creation-date="Wed, 30 Jun 2010 14:36:43 GMT";
	modification-date="Wed, 30 Jun 2010 14:36:43 GMT"
Content-ID: <image008.png@01CB1861.C5C49440>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAADYAAAAECAYAAADF98x7AAAAAXNSR0ICQMB9xQAAAAlwSFlzAAAO
xAAADsQBlSsOGwAAABl0RVh0U29mdHdhcmUATWljcm9zb2Z0IE9mZmljZX/tNXEAAABeSURBVDjL
Y2hsbGQYqhgILIDYAQsWoLXFGjgsLgDiBix4PRDvx4K/A/F/LPg4DvUGMAegW5yAw+L5OAx6jsPi
6zjU9+MwPwBHQHCQEahA32FaPB+HxQk4LJYYbMkUALKk6Czx3A1lAAAAAElFTkSuQmCC

--_013_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_
Content-Type: image/png; name="image009.png"
Content-Description: image009.png
Content-Disposition: inline; filename="image009.png"; size=190;
	creation-date="Wed, 30 Jun 2010 14:36:43 GMT";
	modification-date="Wed, 30 Jun 2010 14:36:43 GMT"
Content-ID: <image009.png@01CB1861.C5C49440>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAADMAAAADCAYAAAA+2zeHAAAAAXNSR0ICQMB9xQAAAAlwSFlzAAAO
xAAADsQBlSsOGwAAABl0RVh0U29mdHdhcmUATWljcm9zb2Z0IE9mZmljZX/tNXEAAAA+SURBVCjP
Y2hsbGQYqhgIHJAwBzZBXLgAiBtIwPOBeD8J+DwQ/ycRI+v3AHnEgEjL+kn0TAKRgQTDBpTGFAC5
CpIb87G+UQAAAABJRU5ErkJggg==

--_013_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_
Content-Type: image/png; name="image010.png"
Content-Description: image010.png
Content-Disposition: inline; filename="image010.png"; size=187;
	creation-date="Wed, 30 Jun 2010 14:36:43 GMT";
	modification-date="Wed, 30 Jun 2010 14:36:43 GMT"
Content-ID: <image010.png@01CB1861.C5C49440>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAADsAAAADCAYAAAAtDHdzAAAAAXNSR0ICQMB9xQAAAAlwSFlzAAAO
xAAADsQBlSsOGwAAABl0RVh0U29mdHdhcmUATWljcm9zb2Z0IE9mZmljZX/tNXEAAAA7SURBVCjP
Y2BgYBAAYgcysUBjYyPDUMEgYADE+8nE74H4Pxn4Ppn2rQfiBjKxwECFsAKZKSmAAs8aAAC4PqYu
QBv+gQAAAABJRU5ErkJggg==

--_013_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_
Content-Type: image/png; name="image011.png"
Content-Description: image011.png
Content-Disposition: inline; filename="image011.png"; size=1554;
	creation-date="Wed, 30 Jun 2010 14:36:43 GMT";
	modification-date="Wed, 30 Jun 2010 14:36:43 GMT"
Content-ID: <image011.png@01CB1861.C5C49440>
Content-Transfer-Encoding: base64

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
p+8bAAAAAElFTkSuQmCC

--_013_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_
Content-Type: image/png; name="image012.png"
Content-Description: image012.png
Content-Disposition: inline; filename="image012.png"; size=1544;
	creation-date="Wed, 30 Jun 2010 14:36:43 GMT";
	modification-date="Wed, 30 Jun 2010 14:36:43 GMT"
Content-ID: <image012.png@01CB1861.C5C49440>
Content-Transfer-Encoding: base64

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
RK5CYII=

--_013_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_
Content-Type: image/jpeg; name="sigimage2213.jpg"
Content-Description: sigimage2213.jpg
Content-Disposition: inline; filename="sigimage2213.jpg"; size=8143;
	creation-date="Wed, 30 Jun 2010 14:36:45 GMT";
	modification-date="Wed, 30 Jun 2010 14:36:45 GMT"
Content-ID: <sigimage2213.jpg>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEASABIAAD//gAMQXBwbGVNYXJrCv/bAIQABwUFBgUFBwYGBggHBwgKEQsK
CQkKFA8PDBEYFRkZFxUXFxodJSAaHCMcFxchLCEjJygqKioZHy4xLSkxJSkqKAEHCAgKCQoTCwsT
KBsXGygoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgo/8QB
ogAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoLAQADAQEBAQEBAQEBAAAAAAAAAQIDBAUGBwgJ
CgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJ
ChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeI
iYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq
8fLz9PX29/j5+hEAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMz
UvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3
eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna
4uPk5ebn6Onq8vP09fb3+Pn6/8AAEQgAWgGqAwEiAAIRAQMRAf/aAAwDAQACEQMRAD8A+faKKK6C
QooooAKKKKACiiikWgooooAKKKKACiiigApaSimMWlpKWgApaTNGaBi0opuacKAHClpBS0ygpKWk
oYCgZOBUnle9Nj+9UwppFJBDF8x57VMYiBkHNLBDKTxG5B77TVxLKZ+wX/eNUkXdIoClFXV00/xT
oPpzUyadbj705b2GBTsHMjOpa1VgsV6IG+rGnfaLWP7iR59QBTHzIxZIZJGBSNm47DNKthct/wAs
8fUgVoT3rO4weOnFQGZj3qHuQ3qRDTn/AI5UUe3JpfsMQ6zk/Rf/AK9KZCT1pN9ILifZI+0jH8KQ
2ydnP40u7ijknA5NAxhtx2b9Kb5J7MKn2P8A3Gx9P8/59KTy3/uN9MU7FWZXMbjtSYI6girOx+u0
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

--_013_0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5EXCHANGEmim_--
