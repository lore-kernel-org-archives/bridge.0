Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C820BF.3757B9E0"
Subject: RE: [Bridge] Lowering CPU utilisation
Date: Wed, 7 Nov 2007 08:51:41 +1100
Message-ID: <96CF49BD8B56384395D698BA99007FA32D23@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vaidas M <admin@vdx.lt>
Cc: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C820BF.3757B9E0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

I'm using e1000 cards.
According to oprofile, around 50% of the time is spent in the e1000
driver.=20
Given that my load average is still under 0.5, I suspect I've got plenty
of room for the driver to handle more traffic before I need to worry too
much.
=20

________________________________

From: Vaidas M [mailto:admin@vdx.lt]=20
Sent: Tuesday, 6 November 2007 9:32 PM
To: Leigh Sharpe
Subject: RE: [Bridge] Lowering CPU utilisation



What kind of NIC you are using?

I suggest you to use cards with NAPI featured in driver.

=20

_      _     _    _   _  _ _ __ ___ ____ _____

Vaidas M.=20

=20

From: bridge-bounces@lists.linux-foundation.org
[mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of Leigh
Sharpe
Sent: Thursday, November 01, 2007 12:00 AM
To: bridge@lists.linux-foundation.org
Subject: [Bridge] Lowering CPU utilisation

=20

Hi All,=20

 I have a box with 12 bridges on it, each of which has 2 ports.

When the traffic level on the box reaches around 15-20Mbps on each
bridge, my CPU utilisation gets to about 90-95%.

I would like to avoid working the CPU that hard. Is there anything which
can be done to get the CPU utlilisation down a bit? I have plans for an
even bigger bridge, but these results indicate that it may not scale
quite that well.

=20

Regards,
             Leigh

=20

=20


------_=_NextPart_001_01C820BF.3757B9E0
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:v =3D=20
"urn:schemas-microsoft-com:vml" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word" xmlns:m =3D=20
"http://schemas.microsoft.com/office/2004/12/omml"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1491" name=3DGENERATOR>
<STYLE>@font-face {
	font-family: Cambria Math;
}
@font-face {
	font-family: Calibri;
}
@font-face {
	font-family: Tahoma;
}
@page Section1 {size: 612.0pt 792.0pt; margin: 3.0cm 1.0cm 2.0cm 3.0cm; =
}
P.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New =
Roman","serif"
}
LI.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New =
Roman","serif"
}
DIV.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New =
Roman","serif"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.EmailStyle17 {
	COLOR: #1f497d; FONT-FAMILY: "Tahoma","sans-serif"; mso-style-type: =
personal-reply
}
.MsoChpDefault {
	FONT-SIZE: 10pt; mso-style-type: export-only
}
DIV.Section1 {
	page: Section1
}
</STYLE>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]--></HEAD>
<BODY lang=3DEN-US vLink=3Dpurple link=3Dblue>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D330104921-06112007><FONT =
face=3DArial=20
size=3D2>I'm using e1000 cards.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D330104921-06112007><FONT =
face=3DArial=20
size=3D2>According to oprofile, around 50% of the time is spent in the =
e1000=20
driver. </FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D330104921-06112007><FONT =
face=3DArial=20
size=3D2>Given that my load average is still under 0.5, I suspect I've =
got plenty=20
of room for the driver to handle more traffic before I need to worry too =

much.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN =
class=3D330104921-06112007></SPAN>&nbsp;</DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> Vaidas M [mailto:admin@vdx.lt] =

<BR><B>Sent:</B> Tuesday, 6 November 2007 9:32 PM<BR><B>To:</B> Leigh=20
Sharpe<BR><B>Subject:</B> RE: [Bridge] Lowering CPU=20
utilisation<BR></FONT><BR></DIV>
<DIV></DIV>
<DIV class=3DSection1>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Tahoma','sans-serif'">What=20
kind of NIC you are using?<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Tahoma','sans-serif'">I=20
suggest you to use cards with NAPI featured in =
driver.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Tahoma','sans-serif'"><o:p>&nbsp;</o:p></SPAN></P>
<DIV>
<P class=3DMsoNormal style=3D"TEXT-ALIGN: right" align=3Dright><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: #1f497d; FONT-FAMILY: =
'Tahoma','sans-serif'">_&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
_&nbsp; &nbsp;&nbsp;&nbsp;_&nbsp;&nbsp;&nbsp; _&nbsp;&nbsp; _&nbsp; _ _ =
__ ___=20
____ _____<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"TEXT-ALIGN: right" align=3Dright><B><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: #1f497d; FONT-FAMILY: =
'Tahoma','sans-serif'">Vaidas=20
M</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: #1f497d; FONT-FAMILY: =
'Tahoma','sans-serif'">.=20
<o:p></o:p></SPAN></P></DIV>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Tahoma','sans-serif'"><o:p>&nbsp;</o:p></SPAN></P>
<DIV>
<DIV=20
style=3D"BORDER-RIGHT: medium none; PADDING-RIGHT: 0cm; BORDER-TOP: =
#b5c4df 1pt solid; PADDING-LEFT: 0cm; PADDING-BOTTOM: 0cm; BORDER-LEFT: =
medium none; PADDING-TOP: 3pt; BORDER-BOTTOM: medium none">
<P class=3DMsoNormal><B><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
'Tahoma','sans-serif'">From:</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: 'Tahoma','sans-serif'">=20
bridge-bounces@lists.linux-foundation.org=20
[mailto:bridge-bounces@lists.linux-foundation.org] <B>On Behalf Of =
</B>Leigh=20
Sharpe<BR><B>Sent:</B> Thursday, November 01, 2007 12:00 =
AM<BR><B>To:</B>=20
bridge@lists.linux-foundation.org<BR><B>Subject:</B> [Bridge] Lowering =
CPU=20
utilisation<o:p></o:p></SPAN></P></DIV></DIV>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<DIV>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: 'Arial','sans-serif'">Hi All,=20
</SPAN><o:p></o:p></P></DIV>
<DIV>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: 'Arial','sans-serif'">&nbsp;I =
have a box=20
with 12 bridges on it, each of which has 2 =
ports.</SPAN><o:p></o:p></P></DIV>
<DIV>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: 'Arial','sans-serif'">When the =
traffic=20
level on the box reaches around 15-20Mbps on each bridge, my CPU =
utilisation=20
gets to about 90-95%.</SPAN><o:p></o:p></P></DIV>
<DIV>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: 'Arial','sans-serif'">I would =
like to avoid=20
working the CPU that hard. Is there anything which can be done to get =
the CPU=20
utlilisation down a bit? I have plans for an even bigger bridge, but =
these=20
results indicate that it may not scale quite that=20
well.</SPAN><o:p></o:p></P></DIV>
<DIV>
<P class=3DMsoNormal>&nbsp;<o:p></o:p></P></DIV>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
'Arial','sans-serif'">Regards,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Leigh</SPAN><o:p></o:p></P>
<P class=3DMsoNormal>&nbsp;<o:p></o:p></P>
<DIV>
<P class=3DMsoNormal>&nbsp;<o:p></o:p></P></DIV></DIV></BODY></HTML>

------_=_NextPart_001_01C820BF.3757B9E0--
