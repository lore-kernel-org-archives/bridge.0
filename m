Message-ID: <010701c42ba3$288f2570$41317d9e@keziah>
From: "Mark Sandford" <J.M.Sandford@lboro.ac.uk>
Date: Mon, 26 Apr 2004 16:28:43 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0104_01C42BAB.8A368F90"
Subject: [Bridge] ethernet bridge + iptables
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

This is a multi-part message in MIME format...

------=_NextPart_000_0104_01C42BAB.8A368F90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm trying to get iptables working with ethernet bridging.

I'm starting with a clean rh9 installation.=20=20

I've tried applying the ebtables-brnf-5_vs_2.4.24.diff patch.  This compile=
s ok but my machine completely hangs moments after I bring the bridge up.

http://article.gmane.org/gmane.linux.network.bridge.ebtables.devel/221  des=
cribes same problem (I emailed author who just suggested moving on to newer=
 kernel which is what I've tried)

I've since been using 2.4.25 kernel (and then 2.4.26).  Kernel compiles and=
 the system doesn't hang when the bridge comes up but I don't seem to be ab=
le to get it to actually do the bridging.  (Bridging does work with initial=
 rh9 install).  The ethernet cards work fine until I bring the bridge up.  =
After that I can't ping from the bridge or forward packets through the brid=
ge.

I'm wondering whether I've incorrectly set/missed some options while config=
uring the kernel but I don't know what to try.

Any clues / pointers hugely appreciated.

Mark.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Mark Sandford,
Research Associate,
Department of Electronic and Electrical Engineering,
Loughborough University,
Loughborough,
Leicestershire.
LE11 3TU

tel: (01509) 227079
e-mail: <j.m.sandford@lboro.ac.uk>
http://www.lboro.ac.uk/departments/el/
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
------=_NextPart_000_0104_01C42BAB.8A368F90
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<DEFANGED_style_0 </STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>I'm trying to get iptables working with et=
hernet=20
bridging.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm starting with a clean rh9 installation=
.&nbsp;=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I've tried applying the=20
ebtables-brnf-5_vs_2.4.24.diff patch.&nbsp; This compiles ok but my machine=
=20
completely hangs moments after I bring the bridge up.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://article.gmane.org/gmane.linux.network.bridge.ebtables.devel/=
221">http://article.gmane.org/gmane.linux.network.bridge.ebtables.devel/221=
</A>&nbsp;=20
describes same problem (I emailed author who just suggested moving on to ne=
wer=20
kernel which is what I've tried)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I've since been using 2.4.25 kernel (and t=
hen=20
2.4.26).&nbsp; Kernel compiles and the system doesn't hang when the bridge =
comes=20
up but I don't seem to be able to get it to actually do the bridging.&nbsp;=
=20
(Bridging does work with initial rh9 install).&nbsp; The ethernet cards wor=
k=20
fine until I bring the bridge up.&nbsp; After that I can't ping from the br=
idge=20
or forward packets through the bridge.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm wondering whether I've incorrectly set=
/missed=20
some options while configuring the kernel but I don't know what to=20
try.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Any clues / pointers hugely=20
appreciated.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Mark.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~<BR>Mark=20
Sandford,<BR>Research Associate,<BR>Department of Electronic and Electrical=
=20
Engineering,<BR>Loughborough=20
University,<BR>Loughborough,<BR>Leicestershire.<BR>LE11 3TU</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>tel: (01509) 227079<BR>e-mail: &lt;<A=20
href=3D"mailto:j.m.sandford@lboro.ac.uk">j.m.sandford@lboro.ac.uk</A>&gt;<B=
R><A=20
href=3D"http://www.lboro.ac.uk/departments/el/">http://www.lboro.ac.uk/depa=
rtments/el/</A><BR>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</FONT></DIV>=
</BODY></HTML>

------=_NextPart_000_0104_01C42BAB.8A368F90--
