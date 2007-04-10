Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C77B2A.204C30BE"
Date: Tue, 10 Apr 2007 14:38:46 +1000
Message-ID: <C953BD512FDBF641B6AC6D59B46B55F002484DBA@WSMSG2154V.srv.dir.telstra.com>
From: "Bainbridge, David D" <David.D.Bainbridge@team.telstra.com>
Subject: [Bridge] Bridge Problem: Ping works, nothing else does...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C77B2A.204C30BE
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I'm a newbie to linux to an extent but have a need to set up a linux
bridge to do some paclet loss testing using netem.  I have a PC with two
NIC cards and Fedora 6.  I have created the bridge using the following
commands

#brctl addbr mybridge
#brctl addif mybridge eth0
#brctl addif mybridge eth1
#brctl mybridge up

Physically I have two IP devices with static IP addresses connected to
the two NIC cards via cross over cables.  I have tested the NIC cards in
a non bridged mode and they work fine as normal NICs.  In bridged mode I
can ping the other IP device.  The IP devices are actually realtime
audio over IP codec devices and they stream using RTP on UDP port 5000.
If I connect the cross over cable directly between the two codec devices
the audio is transferred fine, if I put the linux bridge between them I
get nothing but I can still ping.....

A brctl showstp shows the eth0 and eth1 are in forwarding status but
nothing is happenig.  Can anyone help.  Both Eth1 and 0 are set to Ip
address of 0.0.0.0

Thanks


Regards
David Bainbridge


------_=_NextPart_001_01C77B2A.204C30BE
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7651.14">
<TITLE>Bridge Problem: Ping works, nothing else does...</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Tahoma">Hi,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Tahoma">I'm a newbie to linux to an extent but h=
ave a need to set up a linux bridge to do some paclet loss testing using ne=
tem.&nbsp; I have a PC with two NIC cards and Fedora 6.&nbsp; I have create=
d the bridge using the following commands</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Tahoma">#brctl addbr mybridge</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Tahoma">#brctl addif mybridge eth0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Tahoma">#brctl addif mybridge eth1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Tahoma">#brctl mybridge up</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Tahoma">Physically I have two IP devices with sta=
tic IP addresses connected to the two NIC cards via cross over cables.&nbsp=
; I have tested the NIC cards in a non bridged mode and they work fine as n=
ormal NICs.&nbsp; In bridged mode I can ping the other IP device.&nbsp; The=
 IP devices are actually realtime audio over IP codec devices and they stre=
am using RTP on UDP port 5000.&nbsp; If I connect the cross over cable dire=
ctly between the two codec devices the audio is transferred fine, if I put =
the linux bridge between them I get nothing but I can still ping&#8230;..</=
FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Tahoma">A brctl showstp shows the eth0 and eth1 a=
re in forwarding status but nothing is happenig.&nbsp; Can anyone help.&nbs=
p; Both Eth1 and 0 are set to Ip address of 0.0.0.0</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Tahoma">Thanks</FONT>
</P>
<BR>

<P><FONT COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Tahoma">Regards</FONT>

<BR><B><FONT COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Tahoma">David Bainbridge</F=
ONT></B>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C77B2A.204C30BE--
