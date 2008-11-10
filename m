Message-ID: <BLU149-W34C4000F51A9F3DBDA06EC8B1A0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_de42c297-967b-4396-a8de-fc19be9ef9f0_"
From: Fahim Akhter <akhter.fahim@hotmail.com>
Date: Mon, 10 Nov 2008 17:02:34 +0500
In-Reply-To: <fed120860811100228x3fbff600l4e672635d4c260e3@mail.gmail.com>
References: <BAY119-W404011B5F297F6E9D47DAA8B180@phx.gbl>
	<fed120860811081044k52dbd99fs174d10cd2df33d34@mail.gmail.com>
	<BLU149-W2552C09A3C56CF923B077E8B1A0@phx.gbl> 
	<fed120860811100228x3fbff600l4e672635d4c260e3@mail.gmail.com>
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

--_de42c297-967b-4396-a8de-fc19be9ef9f0_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Thanks a lot for the quick replies.=20
=20
I tried doing it with Bridging Hooks. Rather in the Bridge. I wrote a scrip=
t with was used to modify the packets if not already modified which was pla=
ced in /net/bridge/br_forward.c  br_forward() and the packets were listened=
 and encrypted in /net/bridge/br_forward.c should_deliver(). The enmcryptio=
n keys and status were travelling fine. But upon analyzing the packet. On t=
he receiving end using a Windows Based packet Analyzer. I got to know that =
only ARP broadcast packets were being modified.
=20
I found an old code which used kernel 2.4 used for encryption. The encrypti=
on was done in /net/bridge/br_input.c br_handle_frame().  I did all the usu=
al stuff there but still now effect its still only modifying the ARP packet=
s.
=20
The ethernets are running in promiscous mode=2C the settings are default an=
d the bridge works fine. Except for the fact it doesn't encrypt.=20
=20
It's taken me a while to get to this point. This being my first linux proje=
ct. Hope I get a solution which takes me forward from this instead of start=
ing from the start...> Date: Mon=2C 10 Nov 2008 15:58:05 +0530> From: srini=
vas.aji@gmail.com> To: akhter.fahim@hotmail.com> Subject: Re: [Bridge] Modi=
fying All Packets passing through the bridge!> CC: bridge@lists.linux-found=
ation.org> > On Mon=2C Nov 10=2C 2008 at 11:57 AM=2C Fahim Akhter <akhter.f=
ahim@hotmail.com> wrote:> > The Link> > https://lists.linux-foundation.org/=
pipermail/bridge/2008-October/006074.html> > =2C is about capturing packets=
 and sending to user space. Speed is important> > in my current scenario. I=
s there anyway I can do everything in kernel> > specially by hacking or twe=
aking the already kernel space. Instead of socket> > programming and captur=
ing packets at ethernet?> > That message also talks about the case where us=
erspace will not give> you enough performance. The thing to do then would b=
e to write a> network driver which sits on top of a real network device and=
> processes the packets before passing it on in either direction. Look> for=
 the vlan and bonding drivers for examples. Or maybe you could use> the net=
filter hooks in bridging=2C if your use of this encrypted link is> restrict=
ed to being between bridges.
_________________________________________________________________
Explore the seven wonders of the world
http://search.msn.com/results.aspx?q=3D7+wonders+world&mkt=3Den-US&form=3DQ=
BRE=

--_de42c297-967b-4396-a8de-fc19be9ef9f0_
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
Thanks a lot for the quick replies. <BR>
&nbsp=3B<BR>
I tried doing it with Bridging Hooks. Rather in the Bridge. I wrote a scrip=
t with was used to modify the packets if not already modified which was pla=
ced in /net/bridge/br_forward.c&nbsp=3B br_forward() and the packets were l=
istened and encrypted in /net/bridge/br_forward.c should_deliver(). The enm=
cryption keys and status were travelling fine. But upon analyzing the packe=
t. On the receiving end using a Windows Based packet Analyzer. I got to kno=
w that only ARP broadcast packets were being modified.<BR>
&nbsp=3B<BR>
I found an old code which used kernel 2.4 used for encryption. The encrypti=
on was done in /net/bridge/br_input.c br_handle_frame().&nbsp=3B I did all =
the usual stuff there but still now effect its still only modifying the ARP=
 packets.<BR>
&nbsp=3B<BR>
The ethernets are running in promiscous mode=2C the settings are default an=
d the bridge works fine. Except for the fact it doesn't encrypt. <BR>
&nbsp=3B<BR>
It's taken me a while to get&nbsp=3Bto this point. This being my first linu=
x project. Hope I get a solution which takes me forward from this instead o=
f starting from the start...<BR><BR>&gt=3B Date: Mon=2C 10 Nov 2008 15:58:0=
5 +0530<BR>&gt=3B From: srinivas.aji@gmail.com<BR>&gt=3B To: akhter.fahim@h=
otmail.com<BR>&gt=3B Subject: Re: [Bridge] Modifying All Packets passing th=
rough the bridge!<BR>&gt=3B CC: bridge@lists.linux-foundation.org<BR>&gt=3B=
 <BR>&gt=3B On Mon=2C Nov 10=2C 2008 at 11:57 AM=2C Fahim Akhter &lt=3Bakht=
er.fahim@hotmail.com&gt=3B wrote:<BR>&gt=3B &gt=3B The Link<BR>&gt=3B &gt=
=3B https://lists.linux-foundation.org/pipermail/bridge/2008-October/006074=
.html<BR>&gt=3B &gt=3B =2C is about capturing packets and sending to user s=
pace. Speed is important<BR>&gt=3B &gt=3B in my current scenario. Is there =
anyway I can do everything in kernel<BR>&gt=3B &gt=3B specially by hacking =
or tweaking the already kernel space. Instead of socket<BR>&gt=3B &gt=3B pr=
ogramming and capturing packets at ethernet?<BR>&gt=3B <BR>&gt=3B That mess=
age also talks about the case where userspace will not give<BR>&gt=3B you e=
nough performance. The thing to do then would be to write a<BR>&gt=3B netwo=
rk driver which sits on top of a real network device and<BR>&gt=3B processe=
s the packets before passing it on in either direction. Look<BR>&gt=3B for =
the vlan and bonding drivers for examples. Or maybe you could use<BR>&gt=3B=
 the netfilter hooks in bridging=2C if your use of this encrypted link is<B=
R>&gt=3B restricted to being between bridges.<BR><BR><br /><hr />Explore th=
e seven wonders of the world <a href=3D'http://search.msn.com/results.aspx?=
q=3D7+wonders+world&mkt=3Den-US&form=3DQBRE' target=3D'_new'>Learn more!</a=
></body>
</html>=

--_de42c297-967b-4396-a8de-fc19be9ef9f0_--
