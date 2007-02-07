Date: Wed, 7 Feb 2007 13:34:39 +1100
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Message-ID: <H00000690012fc95.1170815678.mail.pacificwireless.net.au@MHS>
In-Reply-To: <CE677D1BAD605E40B22AE0704FE6DCAE03CCC0E5@blamsg001.corp.satyam.ad>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="2_0_1fb_633f4fMHTML_=_01"
Subject: Re: [Bridge] Bridge not working for 2.4.21 kernel
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge <bridge@osdl.org>

This is a multi-part message in MIME format...

--2_0_1fb_633f4fMHTML_=_01
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Your switch will forward traffic from N/W1 to N/W 2 without going
through your linux bridge. You should use two seperate switches and
bridge them with your linux box, or segment the switch with VLANs and
forward between them with your linux box.
=20
Regards,
             Leigh
=20
Leigh Sharpe
Network Systems Engineer
Pacific Wireless
Ph +61 3 9584 8966
Mob 0408 009 502
Helpdesk 1300 300 616
email lsharpe@pacificwireless.com.au
web www.pacificwireless.com.au
=20

  _____=20=20

From: Suraj_Budha [mailto:Suraj_Buddha@satyam.com]=20
Sent: Tuesday, February 06, 2007 5:29 PM
To: bridge@osdl.org
Subject: [Bridge] Bridge not working for 2.4.21 kernel



Hello All,

Hope someone will address my problem.

I configured my Linux box (2.4.21 kernel) with the
ebtables-brnf-10_vs_2.4.21 patch.

I had installed the bridge-utils package also.

As soon as the I type the following commands, it hangs

#ifconfig eth0 0.0.0.0

#ifconfig eth1 0.0.0.0

#brctl addbr br0

#brctl addif br0 eth0

#brctl addif br0 eth1

#ifconfig br0 up

The following scenario explains my setup:



Thank in advance.

Any help will be highly appreciated.

Regards,

Suraj

DISCLAIMER:
This email (including any attachments) is intended for the sole use of
the intended recipient/s and may contain material that is CONFIDENTIAL
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or
copying or distribution or forwarding of any or all of the contents in
this message is STRICTLY PROHIBITED. If you are not the intended
recipient, please contact the sender by email and delete all copies;
your cooperation in this regard is appreciated..=20



--2_0_1fb_633f4fMHTML_=_01
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML DEFANGED_xmlns=3D"http://www.w3.org/TR/REC-html40"=20
DEFANGED_xmlns:w=3D"urn:schemas-microsoft-com:office:word"=20
DEFANGED_xmlns:o=3D"urn:schemas-microsoft-com:office:office"=20
DEFANGED_xmlns:v=3D"urn:schemas-microsoft-com:vml"><HEAD>

<META content=3D"MSHTML 6.00.2800.1491"=20
name=3DGENERATOR><!--[if !mso]><DEFANGED_STYLE {behavior:url(#default#VML);=
}=20
.shape w\:* o\:* v\:*></DEFANGED_STYLE><![endif]--><DEFANGED_STYLE><!--
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
--></DEFANGED_STYLE></HEAD>
<BODY lang=3DEN-US vLink=3Dpurple link=3Dblue>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D108043302-07022007><FONT face=3DA=
rial=20
size=3D2>Your switch will forward traffic from N/W1 to N/W 2 without going =
through=20
your linux bridge. You should use two seperate switches and bridge them wit=
h=20
your linux box, or segment the switch with VLANs and forward between them w=
ith=20
your linux box.</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft>
<DIV align=3Dleft><FONT face=3DArial=20
size=3D2>Regards,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
Leigh</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Leigh Sharpe<BR>Network Systems Engineer<B=
R>Pacific=20
Wireless<BR>Ph +61 3 9584 8966<BR>Mob 0408 009 502</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Helpdesk 1300 300 616<BR>email <A=20
title=3Dmailto:lsharpe@pacificwireless.com.au=20
href=3D"blocked::mailto:lsharpe@pacificwireless.com.au">lsharpe@pacificwire=
less.com.au</A><BR>web=20
<A title=3Dhttp://www.pacificwireless.com.au/=20
href=3D"blocked::http://www.pacificwireless.com.au/">www.pacificwireless.co=
m.au</A></FONT></DIV></DIV>
<DIV>&nbsp;</DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> Suraj_Budha=20
[mailto:Suraj_Buddha@satyam.com] <BR><B>Sent:</B> Tuesday, February 06, 200=
7=20
5:29 PM<BR><B>To:</B> bridge@osdl.org<BR><B>Subject:</B> [Bridge] Bridge no=
t=20
working for 2.4.21 kernel<BR></FONT><BR></DIV>
<DIV></DIV>
<P>
<DIV class=3DSection1>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">Hello=20
All,<O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial"><O:P></O:P></SPA=
N></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">Hope someone wil=
l=20
address my problem.<O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">I configured my =
Linux=20
box (2.4.21 kernel) with the ebtables-brnf-10_vs_2.4.21=20
patch.<O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">I had installed =
the=20
bridge-utils package also.<O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">As soon as the I=
 type=20
the following commands, it hangs<O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">#ifconfig eth0=
=20
0.0.0.0<O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">#ifconfig eth1=
=20
0.0.0.0<O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">#brctl addbr=20
br0<O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">#brctl addif br0=
=20
eth0<O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">#brctl addif br0=
=20
eth1<O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">#ifconfig br0=20
up<O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial"><O:P></O:P></SPA=
N></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">The following sc=
enario=20
explains my setup:<O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial"><O:P></O:P></SPA=
N></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial"><IMG id=3D"_x000=
0_i1029"=20
height=3D"336" width=3D"576" DEFANGED_src=3D"cid:image002.gif@01C749E6.1F0B=
52D0"=20
NOSEND=3D"1"><O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">Thank in=20
advance.<O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">Any help will be=
 highly=20
appreciated.<O:P></O:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial"><O:P></O:P></SPA=
N></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial"><O:P></O:P></SPA=
N></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">Regards,<O:P></O=
:P></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
DEFANGED_style=3D"font-size:10.0pt;&#10;font-family:Arial">Suraj<O:P></O:P>=
</SPAN></FONT></P></DIV>
<P></P>
<P>DISCLAIMER:<BR>This email (including any attachments) is intended for th=
e=20
sole use of the intended recipient/s and may contain material that is=20
CONFIDENTIAL AND PRIVATE COMPANY INFORMATION. Any review or reliance by oth=
ers=20
or copying or distribution or forwarding of any or all of the contents in t=
his=20
message is STRICTLY PROHIBITED. If you are not the intended recipient, plea=
se=20
contact the sender by email and delete all copies; your cooperation in this=
=20
regard is appreciated.. </P></BODY></HTML>
--2_0_1fb_633f4fMHTML_=_01--
