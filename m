Message-ID: <BLU149-W2552C09A3C56CF923B077E8B1A0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_7daa7573-978c-4a39-a3ce-91b0874230bc_"
From: Fahim Akhter <akhter.fahim@hotmail.com>
Date: Mon, 10 Nov 2008 11:27:49 +0500
In-Reply-To: <fed120860811081044k52dbd99fs174d10cd2df33d34@mail.gmail.com>
References: <BAY119-W404011B5F297F6E9D47DAA8B180@phx.gbl>
	<fed120860811081044k52dbd99fs174d10cd2df33d34@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Modifying All Packets passing through the bridge!
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: srinivas.aji@gmail.com
Cc: bridge@lists.linux-foundation.org

--_7daa7573-978c-4a39-a3ce-91b0874230bc_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


The Link https://lists.linux-foundation.org/pipermail/bridge/2008-October/0=
06074.html =2C is about capturing packets and sending to user space. Speed =
is important in my current scenario. Is there anyway I can do everything in=
 kernel specially by hacking or tweaking the already kernel space. Instead =
of socket programming and capturing packets at ethernet?> Date: Sun=2C 9 No=
v 2008 00:14:21 +0530> From: srinivas.aji@gmail.com> To: akhter.fahim@hotma=
il.com> Subject: Re: [Bridge] Modifying All Packets passing through the bri=
dge!> CC: bridge@lists.linux-foundation.org> > You could probably use the s=
olution that was given to an earlier> question on this list (Bridge with a =
tweak...). The message is> archived at https://lists.linux-foundation.org/p=
ipermail/bridge/2008-October/006074.html> .> > On Sat=2C Nov 8=2C 2008 at 4=
:50 PM=2C Fahim Akhter <akhter.fahim@hotmail.com> wrote:> > Hi Everyone=2C>=
 >> > I am currently working on a Ethernet Link Encryptor (so its called). =
The> > concept is to have two Subnetworks connected together using two brid=
ges and> > the middle lays the internet connection or another network. The =
bridge is> > meant for encryption. The ecryption module and ready and worki=
ng (> > independantly ) =2C if one bridge is set to crypto the other is sup=
posed to> > turn on automatically.> >> > In crypto mode you only accept pac=
ket modified by the other bridge the rest> > of the packets ( rest of the L=
ANS/INTERNET) are supposed to be dropped. In> > order to acheive that =2C I=
 have to modify all the packets passing through the> > bridge so the other =
bridge is able to recognise it.> >> > I was modifying the packets in net/br=
idge/br_forward.c should_deliver() but> > on the other end I only received =
ARP packets as modified. Than I switched> > over to net/bridge/br_input.c b=
r_handle_frame() but encountring the same> > problem. And in the kernel log=
 only a few packets appear. ( dmesg =2C I'm> > printing a message )> >> > I=
 need to Modify all packets passing through the bridge ( in kernel ) . Any>=
 > Ideas ?> >> > Thanks=2C> > Fahim Akhter> >> > __________________________=
______> > Discover the new Windows Vista Learn more!> > ___________________=
____________________________> > Bridge mailing list> > Bridge@lists.linux-f=
oundation.org> > https://lists.linux-foundation.org/mailman/listinfo/bridge=
> >
_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline=

--_7daa7573-978c-4a39-a3ce-91b0874230bc_
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
The Link <A href=3D"https://lists.linux-foundation.org/pipermail/bridge/200=
8-October/006074.html">https://lists.linux-foundation.org/pipermail/bridge/=
2008-October/006074.html</A> =2C is about capturing packets and sending to =
user space. Speed is important in my current scenario. Is there anyway I ca=
n do everything in kernel specially by hacking or tweaking the already kern=
el space. Instead of socket programming and capturing packets at ethernet?<=
BR><BR>&gt=3B Date: Sun=2C 9 Nov 2008 00:14:21 +0530<BR>&gt=3B From: sriniv=
as.aji@gmail.com<BR>&gt=3B To: akhter.fahim@hotmail.com<BR>&gt=3B Subject: =
Re: [Bridge] Modifying All Packets passing through the bridge!<BR>&gt=3B CC=
: bridge@lists.linux-foundation.org<BR>&gt=3B <BR>&gt=3B You could probably=
 use the solution that was given to an earlier<BR>&gt=3B question on this l=
ist (Bridge with a tweak...). The message is<BR>&gt=3B archived at https://=
lists.linux-foundation.org/pipermail/bridge/2008-October/006074.html<BR>&gt=
=3B .<BR>&gt=3B <BR>&gt=3B On Sat=2C Nov 8=2C 2008 at 4:50 PM=2C Fahim Akht=
er &lt=3Bakhter.fahim@hotmail.com&gt=3B wrote:<BR>&gt=3B &gt=3B Hi Everyone=
=2C<BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B I am currently working on a Ethernet =
Link Encryptor (so its called). The<BR>&gt=3B &gt=3B concept is to have two=
 Subnetworks connected together using two bridges and<BR>&gt=3B &gt=3B the =
middle lays the internet connection or another network. The bridge is<BR>&g=
t=3B &gt=3B meant for encryption. The ecryption module and ready and workin=
g (<BR>&gt=3B &gt=3B independantly ) =2C if one bridge is set to crypto the=
 other is supposed to<BR>&gt=3B &gt=3B turn on automatically.<BR>&gt=3B &gt=
=3B<BR>&gt=3B &gt=3B In crypto mode you only accept packet modified by the =
other bridge the rest<BR>&gt=3B &gt=3B of the packets ( rest of the LANS/IN=
TERNET) are supposed to be dropped. In<BR>&gt=3B &gt=3B order to acheive th=
at =2C I have to modify all the packets passing through the<BR>&gt=3B &gt=
=3B bridge so the other bridge is able to recognise it.<BR>&gt=3B &gt=3B<BR=
>&gt=3B &gt=3B I was modifying the packets in net/bridge/br_forward.c shoul=
d_deliver() but<BR>&gt=3B &gt=3B on the other end I only received ARP packe=
ts as modified. Than I switched<BR>&gt=3B &gt=3B over to net/bridge/br_inpu=
t.c br_handle_frame() but encountring the same<BR>&gt=3B &gt=3B problem. An=
d in the kernel log only a few packets appear. ( dmesg =2C I'm<BR>&gt=3B &g=
t=3B printing a message )<BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B I need to Modif=
y all packets passing through the bridge ( in kernel ) . Any<BR>&gt=3B &gt=
=3B Ideas ?<BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B Thanks=2C<BR>&gt=3B &gt=3B Fa=
him Akhter<BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B ______________________________=
__<BR>&gt=3B &gt=3B Discover the new Windows Vista Learn more!<BR>&gt=3B &g=
t=3B _______________________________________________<BR>&gt=3B &gt=3B Bridg=
e mailing list<BR>&gt=3B &gt=3B Bridge@lists.linux-foundation.org<BR>&gt=3B=
 &gt=3B https://lists.linux-foundation.org/mailman/listinfo/bridge<BR>&gt=
=3B &gt=3B<BR><br /><hr />Connect to the next generation of MSN Messenger=
=A0  <a href=3D'http://imagine-msn.com/messenger/launch80/default.aspx?loca=
le=3Den-us&source=3Dwlmailtagline' target=3D'_new'>Get it now! </a></body>
</html>=

--_7daa7573-978c-4a39-a3ce-91b0874230bc_--
