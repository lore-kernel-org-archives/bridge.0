Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9BC15.FF50A88A"
Date: Mon, 13 Apr 2009 16:58:20 +0800
Message-ID: <E9E3926FA9CDBF489EA1684042C8A026012DBAA9@zmy16exm72.ds.mot.com>
From: "Tekale Sharad-FHJN78" <FHJN78@motorola.com>
Subject: [Bridge]  Out of memory problem
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

------_=_NextPart_001_01C9BC15.FF50A88A
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C9BC15.FF50A88A"


------_=_NextPart_002_01C9BC15.FF50A88A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, I'm using linux 2.6.21.5 and our kernel is freeze.
=20
The problem is, if I create a Software bridge using $brctl command. and
add two interfaces say, eth0.0 and eth0.1 using

$brctl addbr br-lan
$brctl addif br-lan eth0.0
$brctl addif br-lan eth0.1
=20
and when i send traffic from a host connected to one port to host
connected at other end, soon all the memory is dried up and and kernel
crashes,=20
then oom-killer gets invoked which kills all the processes finally
system reboots.
=20
Can any one help me to refer to some patch  or point some location in
code from where memory is failed to deallocate.
=20
Thanks,
Sharad.

------_=_NextPart_002_01C9BC15.FF50A88A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3492" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3D"Trebuchet MS" color=3D#000080 =
size=3D2><SPAN=20
class=3D240183609-09042009>Hi, I'm using linux 2.6.21.5 and our kernel =
is=20
freeze.</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009>The problem is, if I create a =
Software&nbsp;bridge=20
using <STRONG>$brctl</STRONG> command. and add two interfaces say, =
eth0.0 and=20
eth0.1 using</SPAN></FONT></DIV>
<DIV><FONT size=3D2><SPAN class=3D240183609-09042009><SPAN=20
class=3D240183609-09042009><BR><FONT face=3D"Trebuchet MS" =
color=3D#000080>$brctl=20
addbr br-lan</FONT></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009>$brctl addif br-lan =
eth0.0</SPAN></FONT></DIV>
<DIV><SPAN class=3D240183609-09042009>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009>$brctl addif br-lan =
eth0.1</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009>and when i send&nbsp;traffic from a host =
connected to=20
one port to host connected&nbsp;at other end, soon all =
the&nbsp;<STRONG>memory=20
is dried up and and kernel crashes</STRONG>, </SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009>then oom-killer gets invoked which kills all =
the=20
processes finally system&nbsp;reboots.</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009>Can any one help me to refer to some =
patch&nbsp;<SPAN=20
class=3D711315608-13042009>&nbsp;or</SPAN> point some location in code =
from where=20
memory is failed to deallocate.</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009>Thanks,</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009>Sharad.</SPAN></FONT></DIV></SPAN></DIV></BODY=
></HTML>

------_=_NextPart_002_01C9BC15.FF50A88A--

------_=_NextPart_001_01C9BC15.FF50A88A
Content-Type: text/plain;
	name="ATT5660628.txt"
Content-Transfer-Encoding: base64
Content-Description: ATT5660628.txt
Content-Disposition: inline;
	filename="ATT5660628.txt"

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkJyaWRnZSBt
YWlsaW5nIGxpc3QNCkJyaWRnZUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0KaHR0cHM6Ly9s
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JyaWRnZQ==

------_=_NextPart_001_01C9BC15.FF50A88A--
