Message-ID: <001701c5de02$7f634440$6502a8c0@tim>
From: "Tim Keupen" <timbub@uni-koblenz.de>
Date: Mon, 31 Oct 2005 11:04:32 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0014_01C5DE0A.DF570AF0"
Subject: [Bridge] device eth0 is already a member of a bridge;
	can't enslave it to bridge Net6
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_NextPart_000_0014_01C5DE0A.DF570AF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,
I am working on Network-Simulation (VNUML). Our simulator uses linux bridgi=
ng to connect the UMLs.
So there is one problem:
The example is the following: There are two hosts simulating one big net.
The two hosts have connection over the external nets Net3 and Net6 (see htt=
p://www.uni-koblenz.de/~timbub/verteilteSim3.GIF), but in fact there is onl=
y one physical connection between the host: connected through a switch an e=
ach host has one interface card eth0. (so normaly you should bind the ip ad=
resses related Net3 and to Net6 to the eth0 and it already is part of the t=
wo nets - even if there is one phsical connection)

So my virtual nets are implemented by linux bridges. But if I now connect t=
he physical interface eth0 to the bridge Net3 and then to Net6 the followin=
g error occurs: "device eth0 is already a member of a bridge; can't enslave=
 it to bridge Net6"=20
Is this a bug or a feature? Why is it not allowed to bind an Interface to t=
wo different bridges?=20
Is there a workaround for this issue?


Problem:=20
UML1 ---- bridge1  \
                             eth0=20=20
UML2 ---- bridge2  /


Workaround?:
UML1 ---- bridge1  \
                             bridge3 ---- eth0
UML2 ---- bridge2  /


UML1   \
             bridge1 ---- eth0
UML2   /



Thanks for your help
Tim Keupen
------=_NextPart_000_0014_01C5DE0A.DF570AF0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR>
<DEFANGED_style_0 </STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I am working on Network-Simulation (VNUML)=
. Our=20
simulator uses linux bridging to connect the UMLs.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>So there is one problem:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>The example is the following: There are tw=
o hosts=20
simulating one big net.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>The two hosts have connection over the ext=
ernal=20
nets Net3 and Net6 (see <A=20
href=3D"http://www.uni-koblenz.de/~timbub/verteilteSim3.GIF">http://www.uni=
-koblenz.de/~timbub/verteilteSim3.GIF</A>),=20
but in fact there is only one physical connection between the host: connect=
ed=20
through a switch an each host has one interface card eth0. (so normaly you=
=20
should bind the ip adresses related Net3 and to Net6 to the eth0 and it alr=
eady=20
is part of the two nets - even if there is one phsical connection)</FONT></=
DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>So my virtual nets are implemented by linu=
x=20
bridges. But if I now connect the physical interface eth0 to the bridge Net=
3 and=20
then to Net6 the following error occurs:<FONT face=3D"Times New Roman" size=
=3D3>=20
</FONT><FONT face=3D"Times New Roman" size=3D3>"device eth0 is already a me=
mber of a=20
bridge; can't enslave it to bridge Net6" </FONT></FONT></DIV>
<DIV>Is this a bug or a feature? Why is it not allowed to bind an Interface=
 to=20
two different bridges? </DIV>
<DIV><FONT face=3DArial size=3D2>Is there a workaround for this issue?</FON=
T></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Problem: </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>UML1 ---- bridge1&nbsp; \</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
&nbsp;eth0&nbsp; </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>UML2 ---- bridge2&nbsp; /</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Workaround?:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>UML1 ---- bridge1&nbsp; \</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
&nbsp;bridge3 ---- eth0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>UML2 ---- bridge2&nbsp; /</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>UML1&nbsp;&nbsp; \</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;bridge1=20
---- eth0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>UML2&nbsp; &nbsp;/</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks for your help</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Tim Keupen</FONT></DIV></BODY></HTML>

------=_NextPart_000_0014_01C5DE0A.DF570AF0--
