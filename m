Message-ID: <004d01c9a88e$c63711d0$1301a8c0@spappm.com>
From: "Praveen VS" <praveen@spacomp.com>
Date: Thu, 19 Mar 2009 18:02:26 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0048_01C9A8BC.DCDC8F90"
Subject: [Bridge] Is bridging possible if two devices connected peer to peer
	?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

This is a multi-part message in MIME format.

------=_NextPart_000_0048_01C9A8BC.DCDC8F90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,
In one of our project we need to connect one IMX 27 based baord which =
ahs a internal FEC controller & an MPC 8323RDb baord which has a Built =
in Network controller.
We need to connect the IMX27 based board to MPC board thro cross cable & =
MPC baord has wlan AP card .=20

Basically we want to communicate from IMX27 to wireless network. Hence =
we are planning to make follwoing arranage ment as given in the attached =
ppt &  we use bridge as per this site
http://www.linuxfoundation.org/en/Net:Bridge


If we use external network controller we can acheive teh communication =
as desired by bridging ra0 ( wlan ) & eth0 on MPC baord . BUt if we use =
IMX27 internal FEC controller we are unable to acheive the communication =
by bridging the eth0 & ra0 on MPC baord.=20

Anything setting to be done on the IMX 27 board? ( kernel configs, or =
specofoc protocol related configs?)=20

If we don't do teh bridging on the MPC side, we can communicate directly =
from IMX27 to MPC thor cross connection ( without bridging)

Can we get some inputs? has anybody tried similarly earlier ?

Regards
Praveen
------=_NextPart_000_0048_01C9A8BC.DCDC8F90
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.3492" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>In one of our project we need to =
connect one IMX 27=20
based baord which ahs a internal FEC controller &amp; an MPC 8323RDb =
baord which=20
has a Built in Network controller.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>We need to connect the IMX27 based =
board to MPC=20
board thro cross cable &amp; MPC baord has wlan AP card . </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Basically we want to communicate from =
IMX27 to=20
wireless network. Hence we are planning to make follwoing arranage ment =
as given=20
in the attached ppt &amp;&nbsp;<FONT face=3D"Times New Roman" size=3D3> =
we use=20
bridge as per this site<BR></FONT><A=20
href=3D"http://www.linuxfoundation.org/en/Net:Bridge"><FONT =
face=3D"Times New Roman"=20
size=3D3>http://www.linuxfoundation.org/en/Net:Bridge</FONT></A><BR></FON=
T></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If we use external network controller =
we can=20
acheive teh communication&nbsp;as desired&nbsp;by bridging ra0 ( wlan ) =
&amp;=20
eth0 on MPC baord . BUt if we use IMX27 internal FEC controller we are =
unable to=20
acheive the communication by bridging the eth0 &amp; ra0 on MPC baord.=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Anything setting to be done on the IMX =
27 board? (=20
kernel configs, or specofoc protocol related configs?) </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If we don't do teh bridging on the MPC =
side, we can=20
communicate directly from IMX27 to MPC thor cross connection ( without=20
bridging)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Can we get some inputs? has anybody =
tried similarly=20
earlier ?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Praveen</FONT></DIV></BODY></HTML>

------=_NextPart_000_0048_01C9A8BC.DCDC8F90--


