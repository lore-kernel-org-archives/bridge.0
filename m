Message-ID: <DBB171FED24842C6AB5F4ECCA91302D2@vpn.com>
Date: Wed, 18 Jun 2008 09:11:46 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_002F_01C8D123.552AADA0"
From: "c.j" <c.james.cj@gmail.com>
Subject: [Bridge] kernel doesn't support  bridge with a ppp interface ?
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

------=_NextPart_000_002F_01C8D123.552AADA0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi list,

From kernel code, I found it doesn't support bridge with a port that is =
a ppp interface:
# brctl addif br_name ppp0
# Invalid arg...

Is there a patch or way to do it if I want to make a kernel bridge with =
eth and ppp ports?

Reg&Tks

--
c.j
------=_NextPart_000_002F_01C8D123.552AADA0
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
<DIV><FONT face=3DArial size=3D2>Hi list,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>From kernel code, I found it doesn't =
support bridge=20
with a port that is a ppp interface:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2># brctl addif br_name ppp0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2># Invalid arg...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Is there a patch or way to do it if I =
want to make=20
a kernel bridge with eth and ppp ports?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Reg&amp;Tks</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>--</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>c.j</FONT></DIV></BODY></HTML>

------=_NextPart_000_002F_01C8D123.552AADA0--

