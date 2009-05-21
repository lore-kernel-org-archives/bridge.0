From: Abhishek Mathur <abhishek_mathur@hcl.in>
Date: Thu, 21 May 2009 10:45:01 +0530
Message-ID: <E41234A68BEC6E48A9937E70B87564532F62DF6732@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary=_000_E41234A68BEC6E48A9937E70B87564532F62DF6732NDAHCLTEVS04H_
MIME-Version: 1.0
Subject: [Bridge] how to verify the blocking state in STP??
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

--_000_E41234A68BEC6E48A9937E70B87564532F62DF6732NDAHCLTEVS04H_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,

I configured a bridge br1 with eth0 and eth1 as its member ports ,=
 connected a hub to both the ports so that a loop is been created in the=
 bridge, also connected a host to another port of the hub=2E
When I ping the bridge br1 from the host with STP off then the ping request=
 and reply is generated on both the member ports eth0 and eth1 since hub=
 broadcasts the packets to both the ports ,
When STP is on eth0 is in forwarding state  while eth1 is in blocking=
 state, so ideally the ping request and reply should not be generated on=
 eth1 as per my understanding of blocking state since its should forward=
 only STP BPDUs and nothing else=2E=2E=2E=2Ebut its still generating the=
 ping request and reply=2E

Is there something wrong in the behaviour or is it correct=2E=2E=2EI m=
 confused with that=2E=2E=2E???????/

Is there any other way we can verify the blocking sate of STP??

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
--_000_E41234A68BEC6E48A9937E70B87564532F62DF6732NDAHCLTEVS04H_
Content-Type: text/html; charset="us-ascii"
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
font-family:Arial'>I configured a bridge br1 with eth0 and eth1 as its=
 member
ports , connected a hub to both the ports so that a loop is been created in=
 the
bridge, also connected a host to another port of the hub=
=2E<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>When I ping the bridge br1 from the host with STP off=
 then
the ping request and reply is generated on both the member ports eth0 and=
 eth1
since hub broadcasts the packets to both the ports=
 ,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>When STP is on eth0 is in forwarding state &nbsp;while=
 eth1 is in
blocking state, so ideally the ping request and reply should not be=
 generated
on eth1 as per my understanding of blocking state since its should forward=
 only
STP BPDUs and nothing else&#8230;=2Ebut its still generating the ping=
 request and
reply=2E<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Is there something wrong in the behaviour or is it=
 correct&#8230;I
m confused with that&#8230;???????/<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Is there any other way we can verify the blocking sate=
 of
STP??<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Abhishek=2E <o:p></o:p></span></font></p>

</div>

</body>

</html>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000>DISCLAIMER:<br>
---------------------------------------------------------------------------=
--------------------------------------------<br>
<br>
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
<br>
---------------------------------------------------------------------------=
--------------------------------------------<br>
</font></td></tr></table>
--_000_E41234A68BEC6E48A9937E70B87564532F62DF6732NDAHCLTEVS04H_--
