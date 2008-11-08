Message-ID: <BAY119-W404011B5F297F6E9D47DAA8B180@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_abb7a3fe-ae41-4b0d-b6cf-bcaad5e9812d_"
From: Fahim Akhter <akhter.fahim@hotmail.com>
Date: Sat, 8 Nov 2008 16:20:23 +0500
MIME-Version: 1.0
Subject: [Bridge] Modifying All Packets passing through the bridge!
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--_abb7a3fe-ae41-4b0d-b6cf-bcaad5e9812d_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Everyone=2C
=20
I am currently working on a Ethernet Link Encryptor (so its called). The co=
ncept is to have two Subnetworks connected together using two bridges and t=
he middle lays the internet connection or another network. The bridge is me=
ant for encryption. The ecryption module and ready and working ( independan=
tly ) =2C if one bridge is set to crypto the other is supposed to turn on a=
utomatically.=20
=20
In crypto mode you only accept packet modified by the other bridge the rest=
 of the packets ( rest of the LANS/INTERNET) are supposed to be dropped. In=
 order to acheive that =2C I have to modify all the packets passing through=
 the bridge so the other bridge is able to recognise it.=20
=20
I was modifying the packets in net/bridge/br_forward.c should_deliver() but=
 on the other end I only received ARP packets as modified. Than I switched =
over to net/bridge/br_input.c br_handle_frame() but encountring the same pr=
oblem. And in the kernel log only a few packets appear. ( dmesg =2C I'm pri=
nting a message )
=20
I need to Modify all packets passing through the bridge ( in kernel ) . Any=
 Ideas ?=20
=20
Thanks=2C
Fahim Akhter
_________________________________________________________________
Discover the new Windows Vista
http://search.msn.com/results.aspx?q=3Dwindows+vista&mkt=3Den-US&form=3DQBR=
E=

--_abb7a3fe-ae41-4b0d-b6cf-bcaad5e9812d_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
Hi Everyone=2C<BR>
&nbsp=3B<BR>
I am currently working on&nbsp=3Ba Ethernet Link Encryptor (so its called).=
 The concept is to have two Subnetworks connected together using two bridge=
s and the middle lays the internet connection or another network. The bridg=
e is meant for encryption. The ecryption module and ready and working ( ind=
ependantly ) =2C if one bridge is set to crypto the other is supposed to tu=
rn on automatically. <BR>
&nbsp=3B<BR>
In crypto mode you only accept packet modified by the other bridge the rest=
 of the packets ( rest of the LANS/INTERNET) are supposed to be dropped. In=
 order to acheive that =2C I have to modify all the packets passing through=
 the bridge so the other bridge is able to recognise it. <BR>
&nbsp=3B<BR>
I was modifying the packets in net/bridge/br_forward.c should_deliver() but=
 on the other end I only received ARP packets as modified. Than I switched =
over to net/bridge/br_input.c br_handle_frame() but encountring the same pr=
oblem. And in the kernel log only a few packets appear. ( dmesg =2C I'm pri=
nting a message )<BR>
&nbsp=3B<BR>
I need to Modify all packets passing through the bridge ( in kernel ) . Any=
 Ideas ? <BR>
&nbsp=3B<BR>
Thanks=2C<BR>
Fahim Akhter<RTE_TEXT></RTE_TEXT><BR><br /><hr />Discover the new Windows V=
ista <a href=3D'http://search.msn.com/results.aspx?q=3Dwindows+vista&mkt=3D=
en-US&form=3DQBRE' target=3D'_new'>Learn more!</a></body>
</html>=

--_abb7a3fe-ae41-4b0d-b6cf-bcaad5e9812d_--
