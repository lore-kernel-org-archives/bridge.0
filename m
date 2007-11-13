Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C825B6.4ADAADB0"
Date: Tue, 13 Nov 2007 16:30:25 +1100
Message-ID: <96CF49BD8B56384395D698BA99007FA32D4A@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Subject: [Bridge] Rx Buffer sizes on e1000
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

------_=_NextPart_001_01C825B6.4ADAADB0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi All,
 I have a box with 24 e1000 cards in it. They are configured as 12
bridges, each with 2 ports.
I have found that when the total traffic on the box gets to around
100Mbps or so, it starts dropping packets.
As far as I can tell, it's related to the amount of traffic per card,
rather than the total throughput on the box. (I'm using 6 x 4-port
ethernet cards.).
=20
My best guess at this point is that the receive buffers are either too
small, or not being emptied quickly enough. (NAPI is enabled.).
Can anybody give me any ideas on where to look for issues?
And how can I change the size of the receive buffers? Is it just a
kernel paramater, or do I need to re-compile?
CPU utilisation is hovering around 50%, and load average is consistently
under 0.1, so I don't beleive I'm looking at a CPU bottleneck.
=20
Any other ideas?
=20
Regards,
             Leigh
=20
Leigh Sharpe
Network Systems Engineer
Pacific Wireless
Ph +61 3 9584 8966
Mob 0408 009 502
Helpdesk 1300 300 616
email lsharpe@pacificwireless.com.au
<blocked::mailto:lsharpe@pacificwireless.com.au>=20
web www.pacificwireless.com.au
<blocked::http://www.pacificwireless.com.au/>=20
=20

------_=_NextPart_001_01C825B6.4ADAADB0
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1491" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D580280404-13112007><FONT face=3DArial size=3D2>Hi=20
All,</FONT></SPAN></DIV>
<DIV><SPAN class=3D580280404-13112007><FONT face=3DArial =
size=3D2>&nbsp;I have a box=20
with 24 e1000 cards in it. They are configured as 12 bridges, each with =
2=20
ports.</FONT></SPAN></DIV>
<DIV><SPAN class=3D580280404-13112007><FONT face=3DArial size=3D2>I have =
found that=20
when the total traffic on the box gets to around 100Mbps or so, it =
starts=20
dropping packets.</FONT></SPAN></DIV>
<DIV><SPAN class=3D580280404-13112007><FONT face=3DArial size=3D2>As far =
as I can=20
tell, it's related to the amount of traffic per card, rather than the =
total=20
throughput on the box. (I'm using 6 x 4-port ethernet=20
cards.).</FONT></SPAN></DIV>
<DIV><SPAN class=3D580280404-13112007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D580280404-13112007><FONT face=3DArial size=3D2>My =
best guess at=20
this point is that the receive buffers are either too small, or not =
being=20
emptied quickly enough. (NAPI is enabled.).</FONT></SPAN></DIV>
<DIV><SPAN class=3D580280404-13112007><FONT face=3DArial size=3D2>Can =
anybody give me=20
any ideas on where to look for issues?</FONT></SPAN></DIV>
<DIV><SPAN class=3D580280404-13112007><FONT face=3DArial size=3D2>And =
how can I change=20
the size of the receive buffers? Is it just a kernel paramater, or do I =
need to=20
re-compile?</FONT></SPAN></DIV>
<DIV><SPAN class=3D580280404-13112007><FONT face=3DArial size=3D2>CPU =
utilisation is=20
hovering around 50%, and load average is consistently under 0.1, so I =
don't=20
beleive I'm looking at a CPU bottleneck.</FONT></SPAN></DIV>
<DIV><SPAN class=3D580280404-13112007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D580280404-13112007><FONT face=3DArial size=3D2>Any =
other=20
ideas?</FONT></SPAN></DIV>
<DIV><SPAN class=3D580280404-13112007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV align=3Dleft>
<DIV align=3Dleft><FONT face=3DArial=20
size=3D2>Regards,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;=20
Leigh</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Leigh Sharpe<BR>Network Systems =
Engineer<BR>Pacific=20
Wireless<BR>Ph +61 3 9584 8966<BR>Mob 0408 009 502</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Helpdesk 1300 300 616<BR>email <A=20
title=3Dmailto:lsharpe@pacificwireless.com.au=20
href=3D"blocked::mailto:lsharpe@pacificwireless.com.au">lsharpe@pacificwi=
reless.com.au</A><BR>web=20
<A title=3Dhttp://www.pacificwireless.com.au/=20
href=3D"blocked::http://www.pacificwireless.com.au/">www.pacificwireless.=
com.au</A></FONT></DIV></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C825B6.4ADAADB0--
