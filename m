Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A8C2.5BAA3D60"
Date: Mon, 28 Apr 2008 09:56:49 +1000
Message-ID: <96CF49BD8B56384395D698BA99007FA32FA1E7@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Subject: [Bridge] Preventing packet reassembly
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

------_=_NextPart_001_01C8A8C2.5BAA3D60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,=20
I'm having some issues with my bridge reassembling fragmented packets,
with disastrous results.
I have a simple bridge set up:
=20
brctl addbr br0
brctl addif br0 eth0=20
brctl addif br0 eth1
=20
Simple enough. The MTU on each interface is 1500, and so is the MTU on
the bridge itself.=20
I have the bridge connected something like this:
=20
PC A----Switch A---eth0 (bridge) eth1---Switch B---PC B.
=20
The Switches are adding VLAN headers and the like, but this seems to be
irrelevant to the problem.
If i ping from PC A to PC B, all is OK. But, when I ping using a
1500-byte payload (or larger), the ping doesn't get through. Removing
the linux bridge and just going switch-switch works OK.
=20
Watching the ethernet ports on the bridge indicate that the ping is
entering the bridge on eth0, but not coming out of eth1. A packet
sniffer shows that the ping is being fragmented by PC A, and two packets
enter eth0. I then increased the MTU on eth0, eth1 and br0 to 1600, to
see if this was an MTU issue. I then see packets coming out of eth1, but
my switch is dropping them, because they are oversized.
Connecting eth1 straight to a packet sniffer shows that when two packets
enter eth0, the bridge is reassembling them into a single, larger
packet, which it then either drops because it is larget than the MTU of
eth1, or it passes a large packet (in this case, 1560 bytes or so).
Obviously, this packet is then dropped by other equipment in the
network, because it is too large for a proper ethernet packet.
=20
I am seeing this behaviour with any IP packets, not just ICMP. The
result is that anything which has a large-ish payload is being dropped
after it leaves the bridge.
=20
The question is, then: How do I stop the bridge from reassembling
fragmented packets?
=20
=20
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

------_=_NextPart_001_01C8A8C2.5BAA3D60
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1491" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial size=3D2>Hi =
All,=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial size=3D2>I'm =
having some=20
issues with my bridge reassembling fragmented packets, with disastrous=20
results.</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial size=3D2>I have =
a simple=20
bridge set up:</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial size=3D2>brctl =
addbr=20
br0</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial size=3D2>brctl =
addif br0 eth0=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial size=3D2>brctl =
addif br0=20
eth1</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial size=3D2>Simple =
enough. The=20
MTU on each interface is 1500, and so is the MTU on the bridge itself.=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial size=3D2>I have =
the bridge=20
connected something like this:</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial size=3D2>PC =
A----Switch=20
A---eth0 (bridge) eth1---Switch B---PC B.</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial size=3D2>The =
Switches are=20
adding VLAN headers and the like, but this seems to be irrelevant to the =

problem.</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial size=3D2>If i =
ping from PC A=20
to PC B, all is OK. But, when I ping using a 1500-byte payload (or =
larger), the=20
ping doesn't get through. Removing the linux bridge and just going =
switch-switch=20
works OK.</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial =
size=3D2>Watching the=20
ethernet ports on the bridge indicate that the ping is entering the =
bridge on=20
eth0, but not coming out of eth1. A packet sniffer shows that the ping =
is being=20
fragmented by PC A, and two packets enter eth0. I then increased the MTU =
on=20
eth0, eth1 and br0 to 1600, to see if this was an MTU issue. I then see =
packets=20
coming out of eth1, but my switch is dropping them, because they are=20
oversized.</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial =
size=3D2>Connecting eth1=20
straight to a packet sniffer shows that when two packets enter eth0, the =
bridge=20
is reassembling them into a single, larger packet, which it then either =
drops=20
because it is larget than the MTU of eth1, or it passes a large packet =
(in this=20
case, 1560 bytes or so). Obviously, this packet is then dropped by other =

equipment in the network, because it is too large for a proper ethernet=20
packet.</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial size=3D2>I am =
seeing this=20
behaviour with any IP packets, not just ICMP. The result is that =
anything which=20
has a large-ish payload is being dropped after it leaves the=20
bridge.</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial size=3D2>The =
question is,=20
then: How do I stop the bridge from reassembling fragmented=20
packets?</FONT></SPAN></DIV>
<DIV><SPAN class=3D033394423-27042008></SPAN><SPAN =
class=3D033394423-27042008><FONT=20
face=3DArial size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D033394423-27042008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
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

------_=_NextPart_001_01C8A8C2.5BAA3D60--
