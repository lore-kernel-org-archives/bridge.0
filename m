Message-ID: <F55E8F29D088429A91CEA39FC41CBE7D@vpn.com>
Date: Wed, 13 Aug 2008 06:32:48 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00CC_01C8FD0E.67877840"
From: "c.j" <c.james.cj@gmail.com>
Subject: [Bridge] question about bridge's work
Reply-To: "c.j" <C.James.CJ@gmail.com>
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

------=_NextPart_000_00CC_01C8FD0E.67877840
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi bridge list,

We got a concept that as follow description:

A linux BOX with several real NICs(suppose that number is three)=20
and a new virtual interface which is a ppp interface(may use several =
channel) normally.

Now we intend to let machine(PC) behind this BOX  talk with ones out of =
BOX.=20
Now ppp's peer is ISP, so PC want to talk to ISP.

In this case we may find it's so similar with bridge's scene:=20
all packets from PC we just forward to PPP interface and then xmit to =
ISP by pppd code.=20
As I know, bridge cannot work for ppp interface(this why it puzzle me =
.).
Also ip_forward can do that things if there are routes in kernel.

My question is:
How can we restrict the machines behind BOX. We only want one can go=20
through now.=20
For extending we cannot just drop the packets from the restricted PC =
like iptable's drop rule.

Please point out my fault in my mind.
Thanks in advance.

Regards~

--
c.j



------=_NextPart_000_00CC_01C8FD0E.67877840
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
<META content=3D"MSHTML 6.00.2900.5583" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3D"Courier New" size=3D2>Hi bridge list,</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>We got a concept that as follow =

description:</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>A linux&nbsp;BOX with several =
real=20
NICs(suppose that&nbsp;number is three) </FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>and a new virtual interface =
which is a ppp=20
interface(may use several channel) normally.</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>Now&nbsp;we intend to let =
machine(PC)=20
behind this BOX&nbsp; talk with&nbsp;ones out of BOX.&nbsp;</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>Now ppp's peer is ISP, =
so&nbsp;PC want to=20
talk to ISP.</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>In this case we may find it's =
so similar=20
with bridge's scene: </FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>all packets from PC we just =
forward to PPP=20
interface and then xmit to ISP by pppd code. </FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>As I know, bridge cannot work =
for ppp=20
interface(this why it puzzle me .).</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>Also ip_forward can do that =
things if=20
</FONT><FONT face=3D"Courier New" size=3D2>there are routes in =
kernel.</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>My question is:</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>How can we restrict the =
machines behind=20
BOX. We only want one can go </FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>through now. </FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>For extending we cannot just =
drop the=20
packets from the restricted PC like iptable's drop rule.</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>Please point out my fault in my =

mind.</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>Thanks in advance.</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>Regards~</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>--</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>c.j</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_00CC_01C8FD0E.67877840--

