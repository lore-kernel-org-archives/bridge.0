Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C73FE1.74B620A7"
Date: Wed, 24 Jan 2007 09:59:56 -0800
Message-ID: <8764B2C538F2C44B845C4B608D4515D31A48C2@EXVBE012-5.exch012.intermedia.net>
From: "Jake Farrell" <jake@amperion.com>
Subject: [Bridge] STP Loop not blocking
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C73FE1.74B620A7
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Recently ran into a problem with the 2.6.18 kernel on Xscale arch when a br=
idge, with multiple interfaces on it, is configured with a redundant loop. =
All interfaces are left on forwarding and nexer switch to block when the lo=
op is introduced. This was tested against a 2.6.16 kernel and the problem d=
id not occur, interfaces forwared and blocked correctly. Any help would be =
appreciated.

------_=_NextPart_001_01C73FE1.74B620A7
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7650.28">
<TITLE>STP Loop not blocking</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Recently ran into a problem with the 2.6.18 kernel on Xsc=
ale arch when a bridge, with multiple interfaces on it, is configured with =
a redundant loop. All interfaces are left on forwarding and nexer switch to=
 block when the loop is introduced. This was tested against a 2.6.16 kernel=
 and the problem did not occur, interfaces forwared and blocked correctly. =
Any help would be appreciated.</FONT></P>

</BODY>
</HTML>
------_=_NextPart_001_01C73FE1.74B620A7--
