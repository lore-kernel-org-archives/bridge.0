Message-ID: <01f701c63728$6203bef0$4a27b3d5@tungemaskin>
From: =?iso-8859-1?Q?J=F8rgen_Hovland?= <jorgen@hovland.cx>
Date: Tue, 21 Feb 2006 21:50:00 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_01F4_01C63730.C3B78520"
Subject: [Bridge] physical interface on a bridge
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

------=_NextPart_000_01F4_01C63730.C3B78520
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

Is there a way to either:
Find the real ifindex/ifname a mac-address is bound to
or
Find the real ifindex/ifname of an incoming packet
?

I am writing a dhcp server and need to know what real interface the dhcp re=
quest packet came from. An acceptable solution would be to get the interfac=
e by the mac-address, but that can be faked so I would rather get the inter=
face by knowing where the data actually came from. Data is IP, UDP broadcas=
t.
I _could_ use raw sockets. The problem is when I do that, the program is us=
ing ~8% cpu on a 3.2ghz xeon64 just reading packets without doing anything =
due to the amount of traffic passing through the box (~200mbit and increasi=
ng) so that doesn't look like a good idea.

brctl showmacs returns a list of port numbers, but they dont make much sens=
e to me. They do not seem to be in the same order I added the interfaces? I=
s there a mapping here?

Example,
jorgen@ams41:/$ /tmp/brctl showmacs test0
port no mac addr                is local?       ageing timer
  2     00:04:e2:a8:3b:d7       no                 0.24
  1     00:08:a1:85:39:fd       no                17.31
133     00:0d:88:a3:61:4a       no                 9.90
  1     00:14:22:b0:cd:e0       yes                0.00
133     00:16:c7:f5:8f:e2       no                 0.48

Port 133 is the 901'th interface (0x385) I added to bridge test0. What does=
 133 point to?  The ifindex of this physical interface is 912 (0x390) (retr=
ieved with SIOCGIFINDEX).

Secondly,
I seem to be unable to add more than around 1024 interfaces to a single bri=
dge. Is there a way to increase this limit?

I am using linux kernel 2.6


Thanks a million,
Joergen
------=_NextPart_000_01F4_01C63730.C3B78520
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.3790.2577" name=3DGENERATOR>
<DEFANGED_style_0 </STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Is there a way to either:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Find the real ifindex/ifname a mac-address=
 is bound=20
to</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>or</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Find the real ifindex/ifname of an incomin=
g=20
packet</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am writing a dhcp server and need to kno=
w what=20
real interface the dhcp request packet came from. An acceptable solution wo=
uld=20
be to get the interface by the mac-address, but that can be faked so I woul=
d=20
rather get the interface by knowing where the data actually came from. Data=
 is=20
IP, UDP broadcast.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I _could_ use raw sockets. The problem is =
when I do=20
that, the&nbsp;program is using ~8% cpu on a 3.2ghz xeon64 just reading pac=
kets=20
without doing anything due to the amount of traffic passing through the box=
=20
(~200mbit and increasing)&nbsp;so that doesn't look like a good=20
idea.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>brctl showmacs returns a list of port numb=
ers, but=20
they dont make much sense to me. They do not seem to be in the same order I=
=20
added the interfaces? Is there a mapping here?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Example,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"mailto:jorgen@ams41:/$">jorgen@ams41:/$</A> /tmp/brctl showmacs=20
test0<BR>port no mac=20
addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;=20
is local?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ageing timer<BR>&nbsp;=20
2&nbsp;&nbsp;&nbsp;&nbsp; 00:04:e2:a8:3b:d7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
0.24<BR>&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;=20
00:08:a1:85:39:fd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;=20
17.31<BR>133&nbsp;&nbsp;&nbsp;&nbsp;=20
00:0d:88:a3:61:4a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
9.90<BR>&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;=20
00:14:22:b0:cd:e0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
0.00<BR>133&nbsp;&nbsp;&nbsp;&nbsp;=20
00:16:c7:f5:8f:e2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
0.48<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Port 133 is the 901'th interface (0x385)&n=
bsp;I=20
added to bridge test0. What&nbsp;does 133 point to?&nbsp; </FONT><FONT=20
face=3DArial size=3D2>The ifindex of this physical interface is 912 (0x390)=
=20
(retrieved with <FONT size=3D2>SIOCGIFINDEX).</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Secondly,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I seem to be unable to add more than aroun=
d 1024=20
interfaces to a single bridge. Is there a way to increase this=20
limit?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>I am using linux kernel 2.6</FONT></DIV>
<DIV>&nbsp;</DIV></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks a million,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Joergen</FONT></DIV></BODY></HTML>

------=_NextPart_000_01F4_01C63730.C3B78520--
