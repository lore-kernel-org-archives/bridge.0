Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C97D21.983D4EB6"
Date: Fri, 23 Jan 2009 11:42:39 +0530
Message-ID: <339FB3905798284FA015E7DC8A13E4A601E212D2@nda-hclt-egw02.HCLT.CORP.HCL.IN>
From: "Abhishek Mathur" <abhishek_mathur@hcl.in>
Subject: [Bridge]  RSTP user mode implementation
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

------_=_NextPart_001_01C97D21.983D4EB6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,

=20

=20

I am working on implementations of RSTP and MSTP=2E

=20

It would be of great help of me if you could provide me with a robust
open source implementation of RSTP and MSTP which I can have a look upon
and some guidelines on how to implement/configure on Linux=2E

=20

=20

Looking for a positive response soon=2E

=20

Regards,

Abhishek=2E



DISCLAIMER:
---------------------------------------------------------------------------=
--------------------------------------------
The contents of this e-mail and any attachment(s) are confidential and=
 intended for the named recipient(s) only=2E=20
It shall not attach any liability on the originator or HCL or its=
 affiliates=2E Any views or opinions presented in=20
this email are solely those of the author and may not necessarily reflect=
 the opinions of HCL or its affiliates=2E=20
Any form of reproduction, dissemination, copying, disclosure, modification,=
 distribution and / or publication of=20
this message without the prior written consent of the author of this e-mail=
 is strictly prohibited=2E If you have=20
received this email in error please delete it and notify the sender=
 immediately=2E Before opening any mail and=20
attachments please check them for viruses and defect=2E
---------------------------------------------------------------------------=
--------------------------------------------
------_=_NextPart_001_01C97D21.983D4EB6
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=
=3D"urn:schemas-microsoft-com:office:word" xmlns=3D"http://www=2Ew3=
=2Eorg/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p=2EMsoNormal, li=2EMsoNormal, div=2EMsoNormal
	{margin:0in;
	margin-bottom:=2E0001pt;
	font-size:12=2E0pt;
	font-family:"Times New Roman";}
a:link, span=2EMsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span=2EMsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span=2EEmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8=2E5in 11=2E0in;
	margin:1=2E0in 1=2E25in 1=2E0in 1=2E25in;}
div=2ESection1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>I am working on implementations of RSTP and MSTP=
=2E<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>It would be of great help of me if you could provide me=
 with
a robust open source implementation of RSTP and MSTP which I can have a=
 look
upon and some guidelines on how to implement/configure on Linux=
=2E<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Looking for a positive response soon=
=2E<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Abhishek=2E<o:p></o:p></span></font></p>

</div>

</body>

</html>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000>DISCLAIMER:<br>
---------------------------------------------------------------------------=
--------------------------------------------<br>
The contents of this e-mail and any attachment(s) are confidential and=
 intended for the named recipient(s) only=2E <br>
It shall not attach any liability on the originator or HCL or its=
 affiliates=2E Any views or opinions presented in <br>
this email are solely those of the author and may not necessarily reflect=
 the opinions of HCL or its affiliates=2E <br>
Any form of reproduction, dissemination, copying, disclosure, modification,=
 distribution and / or publication of <br>
this message without the prior written consent of the author of this e-mail=
 is strictly prohibited=2E If you have <br>
received this email in error please delete it and notify the sender=
 immediately=2E Before opening any mail and <br>
attachments please check them for viruses and defect=2E<br>
---------------------------------------------------------------------------=
--------------------------------------------<br>
</font></td></tr></table>
------_=_NextPart_001_01C97D21.983D4EB6--
