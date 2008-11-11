Message-ID: <BLU149-W3001C3DF281B41D8F506DB8B150@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_5f4e0a46-a434-4c6e-8171-68582048111f_"
From: Fahim Akhter <akhter.fahim@hotmail.com>
Date: Tue, 11 Nov 2008 12:16:34 +0500
In-Reply-To: <20081110083501.55aa10fd@extreme>
References: <BAY119-W404011B5F297F6E9D47DAA8B180@phx.gbl>
	<fed120860811081044k52dbd99fs174d10cd2df33d34@mail.gmail.com>
	<BLU149-W2552C09A3C56CF923B077E8B1A0@phx.gbl>
	<fed120860811100228x3fbff600l4e672635d4c260e3@mail.gmail.com>
	<BLU149-W34C4000F51A9F3DBDA06EC8B1A0@phx.gbl> 
	<20081110083501.55aa10fd@extreme>
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
To: shemminger@vyatta.com
Cc: bridge@lists.linux-foundation.org

--_5f4e0a46-a434-4c6e-8171-68582048111f_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


P.S according to the little knowledge I have netfilters decide the fate of =
the packet by looking at the header not the data=2C but I need the data to =
decide what to do with the packet.> Date: Mon=2C 10 Nov 2008 08:35:01 -0800=
> From: shemminger@vyatta.com> To: akhter.fahim@hotmail.com> CC: srinivas.a=
ji@gmail.com=3B bridge@lists.linux-foundation.org> Subject: Re: [Bridge] Mo=
difying All Packets passing through the bridge!> > On Mon=2C 10 Nov 2008 17=
:02:34 +0500> Fahim Akhter <akhter.fahim@hotmail.com> wrote:> > > > > Thank=
s a lot for the quick replies. > > > > I tried doing it with Bridging Hooks=
. Rather in the Bridge. I wrote a script with was used to modify the packet=
s if not already modified which was placed in /net/bridge/br_forward.c br_f=
orward() and the packets were listened and encrypted in /net/bridge/br_forw=
ard.c should_deliver(). The enmcryption keys and status were travelling fin=
e. But upon analyzing the packet. On the receiving end using a Windows Base=
d packet Analyzer. I got to know that only ARP broadcast packets were being=
 modified.> > > > I found an old code which used kernel 2.4 used for encryp=
tion. The encryption was done in /net/bridge/br_input.c br_handle_frame(). =
I did all the usual stuff there but still now effect its still only modifyi=
ng the ARP packets.> > > > The ethernets are running in promiscous mode=2C =
the settings are default and the bridge works fine. Except for the fact it =
doesn't encrypt. > > > > It's taken me a while to get to this point. This b=
eing my first linux project. Hope I get a solution which takes me forward f=
rom this instead of starting from the start...> Date: Mon=2C 10 Nov 2008 15=
:58:05 +0530> From: srinivas.aji@gmail.com> To: akhter.fahim@hotmail.com> S=
ubject: Re: [Bridge] Modifying All Packets passing through the bridge!> CC:=
 bridge@lists.linux-foundation.org> > On Mon=2C Nov 10=2C 2008 at 11:57 AM=
=2C Fahim Akhter <akhter.fahim@hotmail.com> wrote:> > The Link> > https://l=
ists.linux-foundation.org/pipermail/bridge/2008-October/006074.html> > =2C =
is about capturing packets and sending to user space. Speed is important> >=
 in my current scenario. Is there anyway I can do everything in kernel> > s=
pecially by hacking or tweaking the already kernel space. Instead of socket=
> > programming and capturing packets at ethernet?> > That message also tal=
ks about the case where userspace will not give> you enough performance. Th=
e thing to do then would be to write a> network d> river which sits on top =
of a real network device and> processes the packets before passing it on in=
 either direction. Look> for the vlan and bonding drivers for examples. Or =
maybe you could use> the netfilter hooks in bridging=2C if your use of this=
 encrypted link is> restricted to being between bridges.> > _______________=
__________________________________________________> > Explore the seven won=
ders of the world> > http://search.msn.com/results.aspx?q=3D7+wonders+world=
&mkt=3Den-US&form=3DQBRE> > > Use ebtables=2C and write a netfilter module =
to do what you want.> There is no reason to mess wit the bridging infrastru=
cture to do this.> > Netfilter is the way to do all the kinds of analysis=
=2C filtering=2C and packet> mangling you might want.
_________________________________________________________________
Explore the seven wonders of the world
http://search.msn.com/results.aspx?q=3D7+wonders+world&mkt=3Den-US&form=3DQ=
BRE=

--_5f4e0a46-a434-4c6e-8171-68582048111f_
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
P.S according to the little knowledge I have netfilters decide the fate of =
the packet by looking at the header not the data=2C but I need the data to =
decide what to do with the packet.<BR><BR>&gt=3B Date: Mon=2C 10 Nov 2008 0=
8:35:01 -0800<BR>&gt=3B From: shemminger@vyatta.com<BR>&gt=3B To: akhter.fa=
him@hotmail.com<BR>&gt=3B CC: srinivas.aji@gmail.com=3B bridge@lists.linux-=
foundation.org<BR>&gt=3B Subject: Re: [Bridge] Modifying All Packets passin=
g through the bridge!<BR>&gt=3B <BR>&gt=3B On Mon=2C 10 Nov 2008 17:02:34 +=
0500<BR>&gt=3B Fahim Akhter &lt=3Bakhter.fahim@hotmail.com&gt=3B wrote:<BR>=
&gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B Thanks a lot for the quick repli=
es. <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B I tried doing it with Bridging Hook=
s. Rather in the Bridge. I wrote a script with was used to modify the packe=
ts if not already modified which was placed in /net/bridge/br_forward.c br_=
forward() and the packets were listened and encrypted in /net/bridge/br_for=
ward.c should_deliver(). The enmcryption keys and status were travelling fi=
ne. But upon analyzing the packet. On the receiving end using a Windows Bas=
ed packet Analyzer. I got to know that only ARP broadcast packets were bein=
g modified.<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B I found an old code which us=
ed kernel 2.4 used for encryption. The encryption was done in /net/bridge/b=
r_input.c br_handle_frame(). I did all the usual stuff there but still now =
effect its still only modifying the ARP packets.<BR>&gt=3B &gt=3B <BR>&gt=
=3B &gt=3B The ethernets are running in promiscous mode=2C the settings are=
 default and the bridge works fine. Except for the fact it doesn't encrypt.=
 <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B It's taken me a while to get to this p=
oint. This being my first linux project. Hope I get a solution which takes =
me forward from this instead of starting from the start...&gt=3B Date: Mon=
=2C 10 Nov 2008 15:58:05 +0530&gt=3B From: srinivas.aji@gmail.com&gt=3B To:=
 akhter.fahim@hotmail.com&gt=3B Subject: Re: [Bridge] Modifying All Packets=
 passing through the bridge!&gt=3B CC: bridge@lists.linux-foundation.org&gt=
=3B &gt=3B On Mon=2C Nov 10=2C 2008 at 11:57 AM=2C Fahim Akhter &lt=3Bakhte=
r.fahim@hotmail.com&gt=3B wrote:&gt=3B &gt=3B The Link&gt=3B &gt=3B https:/=
/lists.linux-foundation.org/pipermail/bridge/2008-October/006074.html&gt=3B=
 &gt=3B =2C is about capturing packets and sending to user space. Speed is =
important&gt=3B &gt=3B in my current scenario. Is there anyway I can do eve=
rything in kernel&gt=3B &gt=3B specially by hacking or tweaking the already=
 kernel space. Instead of socket&gt=3B &gt=3B programming and capturing pac=
kets at ethernet?&gt=3B &gt=3B That message also talks about the case where=
 userspace will not give&gt=3B you enough performance. The thing to do then=
 would be to write a&gt=3B network d<BR>&gt=3B river which sits on top of a=
 real network device and&gt=3B processes the packets before passing it on i=
n either direction. Look&gt=3B for the vlan and bonding drivers for example=
s. Or maybe you could use&gt=3B the netfilter hooks in bridging=2C if your =
use of this encrypted link is&gt=3B restricted to being between bridges.<BR=
>&gt=3B &gt=3B ____________________________________________________________=
_____<BR>&gt=3B &gt=3B Explore the seven wonders of the world<BR>&gt=3B &gt=
=3B http://search.msn.com/results.aspx?q=3D7+wonders+world&amp=3Bmkt=3Den-U=
S&amp=3Bform=3DQBRE<BR>&gt=3B <BR>&gt=3B <BR>&gt=3B Use ebtables=2C and wri=
te a netfilter module to do what you want.<BR>&gt=3B There is no reason to =
mess wit the bridging infrastructure to do this.<BR>&gt=3B <BR>&gt=3B Netfi=
lter is the way to do all the kinds of analysis=2C filtering=2C and packet<=
BR>&gt=3B mangling you might want.<BR><br /><hr />Explore the seven wonders=
 of the world <a href=3D'http://search.msn.com/results.aspx?q=3D7+wonders+w=
orld&mkt=3Den-US&form=3DQBRE' target=3D'_new'>Learn more!</a></body>
</html>=

--_5f4e0a46-a434-4c6e-8171-68582048111f_--
