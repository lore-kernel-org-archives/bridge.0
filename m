Message-ID: <8DA338857B4F404282EE2088005079EA7701EC@eammlex037-nb.lmc.ericsson.se>
From: "Andre Beliveau (QB/EMC)" <andre.beliveau@ericsson.com>
Date: Wed, 9 Nov 2005 09:35:54 -0600 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5E541.88CBE168"
Subject: [Bridge] Bridging EAPOL
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "'bridge@lists.osdl.org'" <bridge@lists.osdl.org>

This is a multi-part message in MIME format...

------_=_NextPart_001_01C5E541.88CBE168
Content-Type: text/plain
Content-Disposition: inline

Hi, 

I'm trying to bridge a WLAN interface to a Wired interface on a WRTG54GS.
I'm using openwrt package.

I want to let EAPol messages go through the bridge but it does not work.

EAPOL start message uses as destination mac 01:80:c2:00:00:03.  If I run
tcpdump on the
Wireless interface I can see the packet come in.  But it never gets out on
the network interface.

I wrote a program to listen in promisc. mode and send back the packet toward
the outgoing interface
(vlan0) and I can see the packet in tcpdump on vlan0 interface now.

The problem is that even if I see the packet in tcpdump on vlan0 (and I even
tried to send it to eth0 with
the same results) I don't see the packet transmitted on the wire.

I am running ethereal on a client pc connected to a lan port and nothing
shows up on ethereal.

If I change the destination address to another multicast address
(01:80:c3:00:00:03) instead, the 
Packet goes through and reaches my client PC and I can see the packet in
Ethereal.

Question:  What do I have to do to let packets with d-mac 01:80:c2:00:00:03
through the switch/bridge/firewall/

For you info.  EAP packets have ethertype=0x888e.

Regards, Andre Beliveau



------_=_NextPart_001_01C5E541.88CBE168
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 5.5.2658.2">
<TITLE>Bridging EAPOL</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi, </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I'm trying to bridge a WLAN interface to a=
 Wired interface on a WRTG54GS.&nbsp; I'm using openwrt package.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I want to let EAPol messages go through th=
e bridge but it does not work.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">EAPOL start message uses as destination ma=
c 01:80:c2:00:00:03.&nbsp; If I run tcpdump on the</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Wireless interface I can see the packet c=
ome in.&nbsp; But it never gets out on the network interface.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I wrote a program to listen in promisc. mo=
de and send back the packet toward the outgoing interface</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">(vlan0) and I can see the packet in tcpdu=
mp on vlan0 interface now.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The problem is that even if I see the pack=
et in tcpdump on vlan0 (and I even tried to send it to eth0 with</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">the same results) I don't see the packet =
transmitted on the wire.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am running ethereal on a client pc conne=
cted to a lan port and nothing shows up on ethereal.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">If I change the destination address to ano=
ther multicast address (01:80:c3:00:00:03) instead, the </FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Packet goes through and reaches my client=
 PC and I can see the packet in Ethereal.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Question:&nbsp; What do I have to do to le=
t packets with d-mac 01:80:c2:00:00:03 through the switch/bridge/firewall/<=
/FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">For you info.&nbsp; EAP packets have ether=
type=3D0x888e.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Regards, Andre Beliveau</FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C5E541.88CBE168--
