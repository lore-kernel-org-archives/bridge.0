Message-ID: <3B521E4B016EB148BC2942380918690508680A@hw-mail02.hannover.huwag.net>
From: "SDI. - Dikhoff, Sascha" <SDI@Hoeft-Wessel.de>
Subject: RE: [Bridge] 2.6.11/10 (and probably others), usbnet + bridge => 
	massive memory corruption
Date: Mon, 2 May 2005 08:46:30 +0200 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C54EE2.ABC981D4"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Adam M' <gnuman1@gmail.com>, "'bridge@lists.osdl.org'" <bridge@lists.osdl.org>

This is a multi-part message in MIME format...

------_=_NextPart_001_01C54EE2.ABC981D4
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Disposition: inline

Hi Adam, 

like you can see in the bridge Mailing list, I had the same problem.
But then I added some networking features in my kernel Konfiguration
(xconfig) and everything works fine.
Here are my changes:

Networking support->Networking options->	Packet socket =Y
							TCP/IP networking= Y
								IP
multicasting= Y
								IP advanced
router= Y
And I suppose the most importang change was:

Networking support->Networking packet filtering->	Network packet
filtering replaces ipchains =Y
	
Bridged IP/ARP packets filtering=Y	
									

Regards
Sascha



------_=_NextPart_001_01C54EE2.ABC981D4
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 5.5.2657.73">
<TITLE>RE: [Bridge] 2.6.11/10 (and probably others), usbnet + bridge =3D&gt=
; massive memory corruption</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Hi Adam, </FONT>
</P>

<P><FONT SIZE=3D2>like you can see in the bridge Mailing list, I had the sa=
me problem.</FONT>
<BR><FONT SIZE=3D2>But then I added some networking features in my kernel K=
onfiguration (xconfig) and everything works fine.</FONT>
<BR><FONT SIZE=3D2>Here are my changes:</FONT>
</P>

<P><FONT SIZE=3D2>Networking support-&gt;Networking options-&gt;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet socket =3DY</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <FONT SIZE=3D2>TCP/IP networking=3D Y</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>IP multicast=
ing=3D Y</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>IP advanced =
router=3D Y</FONT>
<BR><FONT SIZE=3D2>And I suppose the most importang change was:</FONT>
</P>

<P><FONT SIZE=3D2>Networking support-&gt;Networking packet filtering-&gt;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Network packet filtering replaces ipchai=
ns =3DY</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; <FONT SIZE=3D2>&nbsp; Bridged IP/ARP packets filtering=3DY&=
nbsp;&nbsp;&nbsp; </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;=20
</P>

<P><FONT SIZE=3D2>Regards</FONT>
<BR><FONT SIZE=3D2>Sascha</FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C54EE2.ABC981D4--
