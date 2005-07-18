Message-ID: <006101c58b6d$76cf7250$2f00a8c0@coco>
From: =?iso-8859-1?Q?Ir=E9n=E9e_BROCHIER?= <irenee.brochier@etictelecom.com>
Date: Mon, 18 Jul 2005 09:51:10 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_005E_01C58B7E.3A132300"
Subject: [Bridge] brctl masking interrupts ?
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

------=_NextPart_000_005E_01C58B7E.3A132300
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I recently discovered that when I am using brctl in my product, I got some =
troubles with a driver which need to quickly handle interrupts. Brct seems =
to "mask interrupts" for long time - more than 6 ms  - when there is ethern=
et traffic in it.

I also noticed that there is a lot of messages on the console when there is=
 trafic in the bridge.Here a sample of messages :

...
PROTO=3D17 192.168.0.43:137 192.168.0.255:137 L=3D78 S=3D0x00 I=3D387 F=3D0=
x0000 T=3D128
nf_hook: hook 1 already set.
skb: pf=3D2 (unowned) dev=3Dbr0 len=3D78
PROTO=3D17 192.168.0.43:137 192.168.0.255:137 L=3D78 S=3D0x00 I=3D387 F=3D0=
x0000 T=3D128
...

Maybe these two things are linked ?

These messages are quite boring but this is not my real problem. My problem=
 is the enormous interrupt latency that brctl bring in my product.

My product runs with a linux 2.4.27 for arm.=20

Is what happens in my product normal ?
Is there any magical patch for my problem ?

Thanks all,

bye.

Ir=E9n=E9e B.
------=_NextPart_000_005E_01C58B7E.3A132300
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1505" name=3DGENERATOR>
<DEFANGED_style_0 </STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi all,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I recently discovered that when I am using=
 brctl in=20
my product, I got some troubles with a driver which need to quickly handle=
=20
interrupts.&nbsp;Brct seems to "mask interrupts" for long time&nbsp;- more =
than=20
6 ms&nbsp; -&nbsp;when there is ethernet traffic in it.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I also noticed that there is a lot of mess=
ages on=20
the console when there is trafic in the bridge.Here a sample of messages=20
:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><EM>PROTO=3D17 192.168.0.43:137 192.168.0.=
255:137=20
L=3D78 S=3D0x00 I=3D387 F=3D0x0000 T=3D128<BR>nf_hook: hook 1 already set.<=
BR>skb: pf=3D2=20
(unowned) dev=3Dbr0 len=3D78<BR>PROTO=3D17 192.168.0.43:137 192.168.0.255:1=
37 L=3D78=20
S=3D0x00 I=3D387 F=3D0x0000 T=3D128</EM></FONT></DIV>
<DIV><EM><FONT face=3DArial size=3D2>...</FONT></EM></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Maybe these two things are linked ?</FONT>=
</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>These messages are quite boring but this i=
s not my=20
real problem. My problem is the enormous interrupt latency that brctl bring=
 in=20
my product.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>My product runs with a linux 2.4.27 for=20
arm.&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Is what happens in my product normal ?</FO=
NT></DIV>
<DIV><FONT face=3DArial size=3D2>Is there any magical patch for my problem=
=20
?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks all,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>bye.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Ir=E9n=E9e B.</FONT></DIV></BODY></HTML>

------=_NextPart_000_005E_01C58B7E.3A132300--
