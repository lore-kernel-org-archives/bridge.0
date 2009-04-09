Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9B8F8.1C0EC32A"
Date: Thu, 9 Apr 2009 17:46:50 +0800
Message-ID: <E9E3926FA9CDBF489EA1684042C8A026012DB6AA@zmy16exm72.ds.mot.com>
From: "Tekale Sharad-FHJN78" <FHJN78@motorola.com>
Subject: [Bridge] Out of memory problem
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

------_=_NextPart_001_01C9B8F8.1C0EC32A
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
I googled for solution or patch, I saw the same defect was reported by
some people, but in between only the threaded ended, with no exact
solution. Don't know Y???
=20
Can any one help me to refer to some patch to point some location in
code from where memory is failed to deallocate.
=20
Thanks,
Sharad.

------_=_NextPart_001_01C9B8F8.1C0EC32A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3492" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
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
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009><SPAN class=3D240183609-09042009><BR>$brctl =
addbr=20
br-lan</SPAN></SPAN></FONT></DIV>
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
one port to host connected&nbsp;at other end, soon all the&nbsp;memory =
is dried=20
up and and kernel crashes, </SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009>then oom-killer gets invoked which kills all =
the=20
processes finally system&nbsp;reboots.</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009>I googled for solution or patch, I saw the =
same defect=20
was reported by some people, but in between only the threaded ended, =
with no=20
exact solution. Don't know Y???</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009>Can any one help me to refer to some patch to =
point=20
some location in code from where memory is failed to=20
deallocate.</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009>Thanks,</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#000080 size=3D2><SPAN=20
class=3D240183609-09042009>Sharad.</SPAN></FONT></DIV></SPAN></DIV></BODY=
></HTML>

------_=_NextPart_001_01C9B8F8.1C0EC32A--
