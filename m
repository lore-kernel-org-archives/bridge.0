Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C749BB.771D5639"
Date: Tue, 6 Feb 2007 12:23:10 +0530
Message-ID: <CE677D1BAD605E40B22AE0704FE6DCAE03CCC0E7@blamsg001.corp.satyam.ad>
From: "Suraj_Budha" <Suraj_Buddha@satyam.com>
Subject: [Bridge] Bridge not working for 2.4.21 kernel
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C749BB.771D5639
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello All,

Hope someone will address my problem.
I configured my Linux box (2.4.21 kernel) with the
ebtables-brnf-10_vs_2.4.21 patch.
I had installed the bridge-utils package also.
As soon as the I type the following commands, it hangs
#ifconfig eth0 0.0.0.0
#ifconfig eth1 0.0.0.0
#brctl addbr br0
#brctl addif br0 eth0
#brctl addif br0 eth1
#ifconfig br0 up

The following scenario explains my setup:


Thank in advance.
Any help will be highly appreciated.


Regards,
Suraj


DISCLAIMER:
This email (including any attachments) is intended for the sole use of the =
intended recipient/s and may contain material that is CONFIDENTIAL AND PRIV=
ATE COMPANY INFORMATION. Any review or reliance by others or copying or dis=
tribution or forwarding of any or all of the contents in this message is ST=
RICTLY PROHIBITED. If you are not the intended recipient, please contact th=
e sender by email and delete all copies; your cooperation in this regard is=
 appreciated.

------_=_NextPart_001_01C749BB.771D5639
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7638.1">
<TITLE>Bridge not working for 2.4.21 kernel</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D=
2 FACE=3D"Arial">Hello All,</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Hope someon=
e will address my problem.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">I configure=
d my Linux box (2.4.21 kernel) with the ebtables-brnf-10_vs_2.4.21 patch.</=
FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">I had insta=
lled the bridge-utils package also.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">As soon as =
the I type the following commands, it hangs</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#ifconfig e=
th0 0.0.0.0</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#ifconfig e=
th1 0.0.0.0</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#brctl addb=
r br0</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#brctl addi=
f br0 eth0</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#brctl addi=
f br0 eth1</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#ifconfig b=
r0 up</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">The followi=
ng scenario explains my setup:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Thank in ad=
vance.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Any help wi=
ll be highly appreciated.</FONT></SPAN></P>
<BR>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Regards,</F=
ONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Suraj</FONT=
></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<p></p><p>DISCLAIMER:<br>This email (including any attachments) is intended=
 for the sole use of the intended recipient/s and may contain material that=
 is CONFIDENTIAL AND PRIVATE COMPANY INFORMATION. Any review or reliance by=
 others or copying or distribution or forwarding of any or all of the conte=
nts in this message is STRICTLY PROHIBITED. If you are not the intended rec=
ipient, please contact the sender by email and delete all copies; your coop=
eration in this regard is appreciated..</BODY>
</HTML>
------_=_NextPart_001_01C749BB.771D5639--
