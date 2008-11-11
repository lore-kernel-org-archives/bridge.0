Message-ID: <BLU149-W6745579814EABDD0D0E228B150@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_ce0a7da0-be3b-4125-b5f5-b103123d4b1d_"
From: Fahim Akhter <akhter.fahim@hotmail.com>
Date: Tue, 11 Nov 2008 10:19:53 +0500
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

--_ce0a7da0-be3b-4125-b5f5-b103123d4b1d_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


But like any Ideas on why do I always see only ARP packets. Not all Packets=
 ? And do netfilters allow you to actually modify the incoming packet ? and=
 all packets ( not only ARP packets ) pass through netfilters?> Date: Mon=
=2C 10 Nov 2008 08:35:01 -0800> From: shemminger@vyatta.com> To: akhter.fah=
im@hotmail.com> CC: srinivas.aji@gmail.com=3B bridge@lists.linux-foundation=
.org> Subject: Re: [Bridge] Modifying All Packets passing through the bridg=
e!> > On Mon=2C 10 Nov 2008 17:02:34 +0500> Fahim Akhter <akhter.fahim@hotm=
ail.com> wrote:> > > > > Thanks a lot for the quick replies. > > > > I trie=
d doing it with Bridging Hooks. Rather in the Bridge. I wrote a script with=
 was used to modify the packets if not already modified which was placed in=
 /net/bridge/br_forward.c br_forward() and the packets were listened and en=
crypted in /net/bridge/br_forward.c should_deliver(). The enmcryption keys =
and status were travelling fine. But upon analyzing the packet. On the rece=
iving end using a Windows Based packet Analyzer. I got to know that only AR=
P broadcast packets were being modified.> > > > I found an old code which u=
sed kernel 2.4 used for encryption. The encryption was done in /net/bridge/=
br_input.c br_handle_frame(). I did all the usual stuff there but still now=
 effect its still only modifying the ARP packets.> > > > The ethernets are =
running in promiscous mode=2C the settings are default and the bridge works=
 fine. Except for the fact it doesn't encrypt. > > > > It's taken me a whil=
e to get to this point. This being my first linux project. Hope I get a sol=
ution which takes me forward from this instead of starting from the start..=
.> Date: Mon=2C 10 Nov 2008 15:58:05 +0530> From: srinivas.aji@gmail.com> T=
o: akhter.fahim@hotmail.com> Subject: Re: [Bridge] Modifying All Packets pa=
ssing through the bridge!> CC: bridge@lists.linux-foundation.org> > On Mon=
=2C Nov 10=2C 2008 at 11:57 AM=2C Fahim Akhter <akhter.fahim@hotmail.com> w=
rote:> > The Link> > https://lists.linux-foundation.org/pipermail/bridge/20=
08-October/006074.html> > =2C is about capturing packets and sending to use=
r space. Speed is important> > in my current scenario. Is there anyway I ca=
n do everything in kernel> > specially by hacking or tweaking the already k=
ernel space. Instead of socket> > programming and capturing packets at ethe=
rnet?> > That message also talks about the case where userspace will not gi=
ve> you enough performance. The thing to do then would be to write a> netwo=
rk d> river which sits on top of a real network device and> processes the p=
ackets before passing it on in either direction. Look> for the vlan and bon=
ding drivers for examples. Or maybe you could use> the netfilter hooks in b=
ridging=2C if your use of this encrypted link is> restricted to being betwe=
en bridges.> > ____________________________________________________________=
_____> > Explore the seven wonders of the world> > http://search.msn.com/re=
sults.aspx?q=3D7+wonders+world&mkt=3Den-US&form=3DQBRE> > > Use ebtables=2C=
 and write a netfilter module to do what you want.> There is no reason to m=
ess wit the bridging infrastructure to do this.> > Netfilter is the way to =
do all the kinds of analysis=2C filtering=2C and packet> mangling you might=
 want.
_________________________________________________________________
News=2C entertainment and everything you care about at Live.com. Get it now=
!
http://www.live.com/getstarted.aspx=

--_ce0a7da0-be3b-4125-b5f5-b103123d4b1d_
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
But like any Ideas on why do I always see only ARP packets. Not all Packets=
 ? And do netfilters allow you to actually modify the incoming packet ? and=
 all packets ( not only ARP packets ) pass through netfilters?<BR><BR>&gt=
=3B Date: Mon=2C 10 Nov 2008 08:35:01 -0800<BR>&gt=3B From: shemminger@vyat=
ta.com<BR>&gt=3B To: akhter.fahim@hotmail.com<BR>&gt=3B CC: srinivas.aji@gm=
ail.com=3B bridge@lists.linux-foundation.org<BR>&gt=3B Subject: Re: [Bridge=
] Modifying All Packets passing through the bridge!<BR>&gt=3B <BR>&gt=3B On=
 Mon=2C 10 Nov 2008 17:02:34 +0500<BR>&gt=3B Fahim Akhter &lt=3Bakhter.fahi=
m@hotmail.com&gt=3B wrote:<BR>&gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B Th=
anks a lot for the quick replies. <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B I tri=
ed doing it with Bridging Hooks. Rather in the Bridge. I wrote a script wit=
h was used to modify the packets if not already modified which was placed i=
n /net/bridge/br_forward.c br_forward() and the packets were listened and e=
ncrypted in /net/bridge/br_forward.c should_deliver(). The enmcryption keys=
 and status were travelling fine. But upon analyzing the packet. On the rec=
eiving end using a Windows Based packet Analyzer. I got to know that only A=
RP broadcast packets were being modified.<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=
=3B I found an old code which used kernel 2.4 used for encryption. The encr=
yption was done in /net/bridge/br_input.c br_handle_frame(). I did all the =
usual stuff there but still now effect its still only modifying the ARP pac=
kets.<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B The ethernets are running in promi=
scous mode=2C the settings are default and the bridge works fine. Except fo=
r the fact it doesn't encrypt. <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B It's tak=
en me a while to get to this point. This being my first linux project. Hope=
 I get a solution which takes me forward from this instead of starting from=
 the start...&gt=3B Date: Mon=2C 10 Nov 2008 15:58:05 +0530&gt=3B From: sri=
nivas.aji@gmail.com&gt=3B To: akhter.fahim@hotmail.com&gt=3B Subject: Re: [=
Bridge] Modifying All Packets passing through the bridge!&gt=3B CC: bridge@=
lists.linux-foundation.org&gt=3B &gt=3B On Mon=2C Nov 10=2C 2008 at 11:57 A=
M=2C Fahim Akhter &lt=3Bakhter.fahim@hotmail.com&gt=3B wrote:&gt=3B &gt=3B =
The Link&gt=3B &gt=3B https://lists.linux-foundation.org/pipermail/bridge/2=
008-October/006074.html&gt=3B &gt=3B =2C is about capturing packets and sen=
ding to user space. Speed is important&gt=3B &gt=3B in my current scenario.=
 Is there anyway I can do everything in kernel&gt=3B &gt=3B specially by ha=
cking or tweaking the already kernel space. Instead of socket&gt=3B &gt=3B =
programming and capturing packets at ethernet?&gt=3B &gt=3B That message al=
so talks about the case where userspace will not give&gt=3B you enough perf=
ormance. The thing to do then would be to write a&gt=3B network d<BR>&gt=3B=
 river which sits on top of a real network device and&gt=3B processes the p=
ackets before passing it on in either direction. Look&gt=3B for the vlan an=
d bonding drivers for examples. Or maybe you could use&gt=3B the netfilter =
hooks in bridging=2C if your use of this encrypted link is&gt=3B restricted=
 to being between bridges.<BR>&gt=3B &gt=3B _______________________________=
__________________________________<BR>&gt=3B &gt=3B Explore the seven wonde=
rs of the world<BR>&gt=3B &gt=3B http://search.msn.com/results.aspx?q=3D7+w=
onders+world&amp=3Bmkt=3Den-US&amp=3Bform=3DQBRE<BR>&gt=3B <BR>&gt=3B <BR>&=
gt=3B Use ebtables=2C and write a netfilter module to do what you want.<BR>=
&gt=3B There is no reason to mess wit the bridging infrastructure to do thi=
s.<BR>&gt=3B <BR>&gt=3B Netfilter is the way to do all the kinds of analysi=
s=2C filtering=2C and packet<BR>&gt=3B mangling you might want.<BR><br /><h=
r />Get news=2C entertainment and everything you care about at Live.com. <a=
 href=3D'http://www.live.com/getstarted.aspx ' target=3D'_new'>Check it out=
!</a></body>
</html>=

--_ce0a7da0-be3b-4125-b5f5-b103123d4b1d_--
