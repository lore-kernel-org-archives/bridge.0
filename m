Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C52629.F2D799B3"
Date: Fri, 11 Mar 2005 12:03:22 +0100
Message-ID: <2AF8FF7D89242541B12E7A47F6ECB4BE01B9D21D@ftrdmel3.rd.francetelecom.fr>
From: "CHOU Sovatha RD-CORE-ISS" <sovatha.chou@francetelecom.com>
Subject: [Bridge] Need help: brctl and isis packets
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

------_=_NextPart_001_01C52629.F2D799B3
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello all,

First thanks to all for helping me. I have an issue to bring up bridging
isis packets using BRCTL.
As i am quite a newbie, maybe this is not possible or maybe I forget to
load modules so that the bridging I am trying to put in place work
properly.

Here is the configuration I used:

	I1 ------ eth1 (physical interface of my linux machine)
----------- BRIDGE ----------- n1-eth0 (tuntap interface) ---- I2

Where I1 and I2 are two ISIS processes.

On both eth1 and n1-eth0, there are ISIS packets send by I1 and I2
processes.
With an analyzer (ethereal), I can see ISIS packets sent by ISIS process
(I1) on eth1 but no ISIS packet from I2 (and vice versa).

However, if I make a capture on the BRIDGE, I have ISIS packets from
both ISIS processes (I1 and I2).=20

Bridge configuration:
	-bridge-utils-1.0.4
	-linux kernel: 2.6

Anyone can help me ?

Thank you
Sovatha

------_=_NextPart_001_01C52629.F2D799B3
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7226.0">
<TITLE>Need help: brctl and isis packets</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">Hello all,</FONT></SPAN>
</P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">First thanks to all for =
helping me. I have an issue to bring up bridging isis packets using BRCTL.<=
/FONT></SPAN>

<BR><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">As i am quite a newbie,=
 maybe this is not possible or maybe I forget to load modules so that the b=
ridging I am trying to put in place work properly.</FONT></SPAN></P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">Here is the configuratio=
n I used:</FONT></SPAN>
</P>

<P><SPAN LANG=3D"fr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=
=3D2 FACE=3D"Arial">I1 ------ eth1 (physical interface of my linux machine)=
 ----------- BRIDGE ----------- n1-eth0 (tuntap interface) ---- I2</FONT></=
SPAN></P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">Where I1 and I2 are two =
ISIS processes.</FONT></SPAN>
</P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">On both eth1 and n1-eth0=
, there are ISIS packets send by I1 and I2 processes.</FONT></SPAN>

<BR><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">With an analyzer (ether=
eal), I can see ISIS packets sent by ISIS process (I1) on eth1 but no ISIS =
packet from I2 (and vice versa).</FONT></SPAN></P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">However, if I make a cap=
ture on the BRIDGE, I have ISIS packets from both ISIS processes (I1 and I2=
). </FONT></SPAN>
</P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">Bridge configuration:</F=
ONT></SPAN>

<BR><SPAN LANG=3D"fr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=
=3D2 FACE=3D"Arial">-bridge-utils-1.0.4</FONT></SPAN>

<BR><SPAN LANG=3D"fr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=
=3D2 FACE=3D"Arial">-linux kernel: 2.6</FONT></SPAN>
</P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">Anyone can help me ?</FO=
NT></SPAN>
</P>

<P><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">Thank you</FONT></SPAN>

<BR><SPAN LANG=3D"fr"><FONT SIZE=3D2 FACE=3D"Arial">Sovatha</FONT></SPAN><S=
PAN LANG=3D"en-us"></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C52629.F2D799B3--
