Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C819E5.77923670"
Date: Mon, 29 Oct 2007 15:37:52 +1100
Message-ID: <96CF49BD8B56384395D698BA99007FA32D05@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Subject: [Bridge] Small packets
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

------_=_NextPart_001_01C819E5.77923670
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi All,
 I have a bridge set up thusly:
=20
=20
brctl addbr br0                                 # Create the bridge.

brctl addif br0 eth2                            # Add eth2
brctl addif br0 eth3                            # And eth3

brctl setfd br0 0                               # Forward immediately.

brctl stp br0 off                               # Turn off Spanning
Tree.

ifconfig eth2 up                                # bring up eth2
ifconfig eth3 up                                # Bring up eth3
ifconfig br0 up                                 # Bring up the bridge.

Which seems to bridge OK. However, I have noticed that the bridge
appears to be truncating some packets. In particular, I am worried about
packets such as IP ACK's, which are entering the bridge as 64-byte
packets, but coming out the other side as 60-byte packets.
As I recall, the smallest valid ehternet packet is 64 bytes. The bridge
seems to be removing any padding in the packet and sending it on it's
way as a packet smaller than the minimum ethernet packet size.=20
Looking at the packet distribution on other devices connected to the
bridge, it seems to be doing the same to lots of other packets, too.=20
Anybody got any idea why the bridge might be truncating packets?
Any idea why it's sending 60-byte packets, when the minimu should be 64?
Or where to tell it to pad all packets out to 64 bytes?
=20
=20
Leigh.
=20
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

------_=_NextPart_001_01C819E5.77923670
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1491" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial size=3D2>Hi=20
All,</FONT></SPAN></DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial =
size=3D2>&nbsp;I have a=20
bridge set up thusly:</FONT></SPAN></DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial size=3D2>brctl =
addbr=20
br0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
# Create the bridge.<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial size=3D2>brctl =
addif br0=20
eth2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;=20
# Add eth2<BR>brctl addif br0=20
eth3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;=20
# And eth3<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial size=3D2>brctl =
setfd br0=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
# Forward immediately.<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial size=3D2>brctl =
stp br0=20
off&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
# Turn off Spanning Tree.<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial =
size=3D2>ifconfig eth2=20
up&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
# bring up eth2<BR>ifconfig eth3=20
up&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
# Bring up eth3<BR>ifconfig br0=20
up&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
# Bring up the bridge.<BR></DIV></FONT></SPAN>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial size=3D2>Which =
seems to=20
bridge OK. However, I have noticed that the bridge appears to be =
truncating some=20
packets. In particular, I am worried about packets such as IP ACK's, =
which are=20
entering the bridge as 64-byte packets, but coming out the other side as =
60-byte=20
packets.</FONT></SPAN></DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial size=3D2>As I =
recall, the=20
smallest valid ehternet packet is 64 bytes. The bridge seems to be =
removing any=20
padding in the packet and sending it on it's way as a packet smaller =
than the=20
minimum ethernet packet size. </FONT></SPAN></DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial =
size=3D2>Looking at the=20
packet distribution on other devices connected to the bridge, it seems =
to be=20
doing the same to lots of other packets, too. </FONT></SPAN></DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial =
size=3D2>Anybody got any idea=20
why the bridge might be truncating packets?</FONT></SPAN></DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial size=3D2>Any =
idea why it's=20
sending 60-byte packets, when the minimu should be 64? Or where to tell =
it to=20
pad all packets out to 64 bytes?</FONT></SPAN></DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial=20
size=3D2>Leigh.</FONT></SPAN></DIV>
<DIV><SPAN class=3D194353104-29102007></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D194353104-29102007><FONT face=3DArial=20
size=3D2>&nbsp;</DIV></FONT></SPAN>
<DIV>&nbsp;</DIV>
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

------_=_NextPart_001_01C819E5.77923670--
