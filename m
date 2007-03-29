Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C771FA.435E37AB"
Date: Thu, 29 Mar 2007 17:33:28 +0530
Message-ID: <AFB2687AB4F98E419EDFA205E376D4132C7CFB@BLR-HCLT-EVS01.HCLT.CORP.HCL.IN>
From: "Majjari Vikram(TLS-ESG), Bangalore" <Majjari.Vikram@hcl.in>
Subject: [Bridge] Static filtering entries in bridging -- linux 2.4.20 kernel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C771FA.435E37AB
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Hi all

            Iam working on bridging in linux 2.4.20 kernel. can any one
help me on these questions.

=20

1.	how to make static filtering entries and
2.	how to make group MAC addresses (multicast addresses) in
bridging.

=20

Eagerly waiting for reply.

=20

Vikram.

=20



DISCLAIMER:
---------------------------------------------------------------------------=
--------------------------------------------

The contents of this e-mail and any attachment(s) are confidential and inte=
nded for the named recipient(s) only.
It shall not attach any liability on the originator or HCL or its affiliate=
s. Any views or opinions presented in=20
this email are solely those of the author and may not necessarily reflect t=
he opinions of HCL or its affiliates.
Any form of reproduction, dissemination, copying, disclosure, modification,=
 distribution and / or publication of=20
this message without the prior written consent of the author of this e-mail=
 is strictly prohibited. If you have=20
received this email in error please delete it and notify the sender immedia=
tely. Before opening any mail and=20
attachments please check them for viruses and defect.

---------------------------------------------------------------------------=
--------------------------------------------
------_=_NextPart_001_01C771FA.435E37AB
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html DEFANGED_xmlns:o=3D"urn:schemas-microsoft-com:office:office" DEFANGED=
_xmlns:w=3D"urn:schemas-microsoft-com:office:word" DEFANGED_xmlns=3D"http:/=
/www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
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
 /* List Definitions */
 @list l0
	{mso-list-id:878396418;
	mso-list-type:hybrid;
	mso-list-template-ids:807443732 67698703 67698713 67698715 67698703 676987=
13 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</DEFANGED_style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Hi all<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; Iam working on bridging in linux 2.4.20 kernel. can
any one help me on these questions.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<ol DEFANGED_style=3D"margin-top:0in" start=3D"1" type=3D"1">
 <li class=3D"MsoNormal" DEFANGED_style=3D"mso-list:l0 level1 lfo1"><font s=
ize=3D2 face=3DArial><span
     DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">how to make stat=
ic filtering
     entries and<o:p></o:p></span></font></li>
 <li class=3D"MsoNormal" DEFANGED_style=3D"mso-list:l0 level1 lfo1"><font s=
ize=3D2 face=3DArial><span
     DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">how to make grou=
p MAC addresses
     (multicast addresses) in bridging.<o:p></o:p></span></font></li>
</ol>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Eagerly waiting for reply.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Vikram.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000>DISCLAIMER:<br>
---------------------------------------------------------------------------=
--------------------------------------------<br>
<br>
The contents of this e-mail and any attachment(s) are confidential and inte=
nded for the named recipient(s) only.<br>
It shall not attach any liability on the originator or HCL or its affiliate=
s. Any views or opinions presented in <br>
this email are solely those of the author and may not necessarily reflect t=
he opinions of HCL or its affiliates.<br>
Any form of reproduction, dissemination, copying, disclosure, modification,=
 distribution and / or publication of <br>
this message without the prior written consent of the author of this e-mail=
 is strictly prohibited. If you have <br>
received this email in error please delete it and notify the sender immedia=
tely. Before opening any mail and <br>
attachments please check them for viruses and defect.<br>
<br>
---------------------------------------------------------------------------=
--------------------------------------------<br>
</font></td></tr></table>
------_=_NextPart_001_01C771FA.435E37AB--
