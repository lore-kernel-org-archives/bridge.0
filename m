Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C494B4.B5F1ABB2"
Date: Tue, 7 Sep 2004 10:28:52 +0200
Message-ID: <3418F3471F1CA4409901547349FFAE2E0226D24B@ftrdmel2.rd.francetelecom.fr>
From: "zze-gandhi PERESSE M ext RD-RESA-REN"
	<mperesse.ext@rd.francetelecom.com>
Subject: [Bridge] Wired iface + Wireless iface configuration in managed mode
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C494B4.B5F1ABB2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,


I have to set up a bridge in the following configuration:

1 Wired Interface
1 Wireless Interface in Managed Mode (ie connected to an access point)


The architecture is as follows:


Private Internet ------- Wireless Router/AP ----     air     ----- Linux
Bridge ----wire----- Host A

So let's say I have a host (Host A) connected to the wired interface of
that bridge, I would like to be able to communicate with hosts that are
behind the wireless router (ie the private Internet)

The problem is that when the Linux bridge forwards Host A's Ethernet
frames to the AP, the AP doesn't allow these frames to pass through,
because Host A isn't a regular wireless client who has been
authenticated/associated (802.11).

One solution is to implement an authentication/association proxy in the
Linux Bridge  (I think D-LINK does that in their APs):
- The bridge would do the association/authentication process on behalf
of the wired hosts..

Another solution would be to spoof the mac address of the Wireless
Interface of the Linux Bridge but there is no way to multiplex frames
for multiple wired hosts (is there any ?).

Are there plans for solving_this_"issue" / adding_this_feature ?


Thanks a lot.

Mathieu.

PS: I NEED to do this for an experiment only, I can't use another
architecure.






------_=_NextPart_001_01C494B4.B5F1ABB2
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.6980.72">
<TITLE>Wired iface + Wireless iface configuration in managed mode</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi all,</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have to set up a bridge in the following=
 configuration:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">1 Wired Interface</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">1 Wireless Interface in Managed Mode (ie =
connected to an access point)</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">The architecture is as follows:</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Private Internet ------- Wireless Router/A=
P ----&nbsp;&nbsp;&nbsp;&nbsp; air&nbsp;&nbsp;&nbsp;&nbsp; ----- Linux Brid=
ge ----wire----- Host A</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">So let's say I have a host (Host A) connec=
ted to the wired interface of that bridge, I would like to be able to commu=
nicate with hosts that are behind the wireless router (ie the private Inter=
net)</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The problem is that when the Linux bridge =
forwards Host A's Ethernet frames to the AP, the AP doesn't allow these fra=
mes to pass through, because Host A isn't a regular wireless client who has=
 been authenticated/associated (802.11).</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">One solution is to implement an authentica=
tion/association proxy in the Linux Bridge&nbsp; (I think D-LINK does that =
in their APs):</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">- The bridge would do the association/auth=
entication process on behalf of the wired hosts..</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Another solution would be to spoof the mac=
 address of the Wireless Interface of the Linux Bridge but there is no way =
to multiplex frames for multiple wired hosts (is there any ?).</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Are there plans for solving_this_&quot;iss=
ue&quot; / adding_this_feature ?</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks a lot.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Mathieu.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">PS: I NEED to do this for an experiment on=
ly, I can't use another architecure.</FONT>
</P>
<BR>
<BR>
<BR>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C494B4.B5F1ABB2--
