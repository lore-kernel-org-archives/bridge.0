Message-ID: <DEE020BE3841D7118C6B0008C791AE50010EBAFA@szexchange.schmid-telecom.ch>
From: "Ritter, Moritz" <moritz.ritter@schmid-telecom.ch>
Date: Wed, 21 Apr 2004 09:07:11 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4276F.44A4A330"
Subject: [Bridge] IEEE 802.1Q (VLAN-) Bridge incl. GARP, GMRP, GVRP,
	MSTP and LMMS
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "'bridge@osdl.org'" <bridge@osdl.org>

This is a multi-part message in MIME format...

------_=_NextPart_001_01C4276F.44A4A330
Content-Type: text/plain
Content-Disposition: inline

I'm trying to build a fully IEEE 802.1Q-2003-standard compliant bridge. I
was delighted about your bridge implementation in the Linux kernel which
takes most of the low-layer work from me. (Thanks!) For the higher layer
stuff I found (google, your docs) only your STP implementation, so what's
missing is GARP(Generic Attribute Registration Protocol, acc. 802.1D/Q),
GMRP(GARP Multicast Registration Protocol, acc. 802.1D), GVRP(GARP Vlan
Registration Protocol, acc. 802.1Q), MSTP(Multiple Spanning Tree Protocol,
i.e. one STP instance per forwarding-database (which is a set of vlans),
acc. 802.1Q) and the LMMS (LAN/MAN Management Services, used for
remote-management (incl. configuration) of bridges acc. to 802.1b and some
ISO standard). Is any of those things going on in your project or are you
aware of other projects taking care of those matters? (Any helpful link is
greatly appreciated.) Thanks.

Moritz


------_=_NextPart_001_01C4276F.44A4A330
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 5.5.2652.35">
<TITLE>IEEE 802.1Q (VLAN-) Bridge incl. GARP, GMRP, GVRP, MSTP and LMMS</TI=
TLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2 FACE=3D"Arial">I'm trying to build a fully IEEE 802.1Q-20=
03-standard compliant bridge. I was delighted about your bridge implementat=
ion in the Linux kernel which takes most of the low-layer work from me. (Th=
anks!) For the higher layer stuff I found (google, your docs) only your STP=
 implementation, so what's missing is GARP(Generic Attribute Registration P=
rotocol, acc. 802.1D/Q), GMRP(GARP Multicast Registration Protocol, acc. 80=
2.1D), GVRP(GARP Vlan Registration Protocol, acc. 802.1Q), MSTP(Multiple Sp=
anning Tree Protocol, i.e. one STP instance per forwarding-database (which =
is a set of vlans), acc. 802.1Q) and the LMMS (LAN/MAN Management Services,=
 used for remote-management (incl. configuration) of bridges acc. to 802.1b=
 and some ISO standard). Is any of those things going on in your project or=
 are you aware of other projects taking care of those matters? (Any helpful=
 link is greatly appreciated.) Thanks.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Moritz</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C4276F.44A4A330--
