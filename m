Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5287D.19D6A7C0"
Date: Mon, 14 Mar 2005 11:03:40 +0100
Message-ID: <2AF8FF7D89242541B12E7A47F6ECB4BE01B9D7BD@ftrdmel3.rd.francetelecom.fr>
From: "CHOU Sovatha RD-CORE-ISS" <sovatha.chou@francetelecom.com>
Subject: [Bridge] Need help: bridge does not flood ethernet frame with mtu >
	1500
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C5287D.19D6A7C0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello all,

On my previous post I maked a mistake on my analyze. The bridge forward
well any kind of frames it received. The problem was I used frame with
VLAN. On Is-Is hello frame, the frame has an MTU greater than 1500
because of the 4 bytes VLAN enclosed. So all Is-Is hello packets were
dropped.

The architecture used is:

	eth1 (real physical interface) ---- BRIDGE ---- uml0 (tuntap
interface to UML)

I solve the this problem with the real interface by changing the mtu to
1520. But the issue remains on the virtual side. I can not modify the
tuntap's MTU to something greater then 1500.=20

Does someone know how I can do to change the mtu of the tuptap device ?=20

In advance thanks.

Sovatha

PS: The MTU must not be lower than 1500 because the simulated Is-Is has
to form topology with a real router where the interface MTU can not set
to a value lower than 1500.

------_=_NextPart_001_01C5287D.19D6A7C0
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7226.0">
<TITLE>Need help: bridge does not flood ethernet frame with mtu &gt; 1500</=
TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">Hello all,</FONT></SPAN>
</P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">On my previous post I ma=
ked a mistake on my analyze. The bridge forward well any kind of frames it =
received. The problem was I used frame with VLAN. On Is-Is hello frame, the=
 frame has an MTU greater than 1500 because of the 4 bytes VLAN enclosed. S=
o all Is-Is hello packets were dropped.</FONT></SPAN></P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">The architecture used is=
:</FONT></SPAN>
</P>

<P><SPAN LANG=3D"fr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=
=3D2 FACE=3D"Arial">eth1 (real physical interface) ---- BRIDGE ---- uml0 (t=
untap interface to UML)</FONT></SPAN>
</P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">I solve the this problem=
 with the real interface by changing the mtu to 1520. But the issue remains=
 on the virtual side. I can not modify the tuntap's MTU to something greate=
r then 1500. </FONT></SPAN></P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">Does someone know how I =
can do to change the mtu of the tuptap device ? </FONT></SPAN>
</P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">In advance thanks.</FONT=
></SPAN>
</P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">Sovatha</FONT></SPAN>
</P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">PS: The MTU must not be =
lower than 1500 because the simulated Is-Is has to form topology with a rea=
l router where the interface MTU can not set to a value lower than 1500.</F=
ONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C5287D.19D6A7C0--
