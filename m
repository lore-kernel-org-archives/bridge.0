MIME-Version: 1.0
In-Reply-To: <OF4B3FF703.CC38E26C-ONC12575D4.0058F1ED-C12575D4.005AB7C4@transmode.se>
References: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<m3ab4dovgi.fsf@ursa.amorsen.dk>
	<OFCE5E72FE.D082AB78-ONC12575D4.005256D7-C12575D4.0052B193@transmode.se>
	<2e59e6970906130857t2441d0bap34e15fd2af12fe72@mail.gmail.com>
	<OF4B3FF703.CC38E26C-ONC12575D4.0058F1ED-C12575D4.005AB7C4@transmode.se>
Date: Sat, 13 Jun 2009 21:36:41 -0500
Message-ID: <2e59e6970906131936x6ca31f2fte0c34d9deab0f709@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: multipart/alternative; boundary=001485f8955ecbee58046c45cf8a
Subject: Re: [Bridge] [PATCH] [bridge] Add split horizon
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org, Benny Amorsen <benny+usenet@amorsen.dk>

--001485f8955ecbee58046c45cf8a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Sat, Jun 13, 2009 at 11:30 AM, Joakim Tjernlund <
joakim.tjernlund@transmode.se> wrote:

> "richardvoigt@gmail.com" <richardvoigt@gmail.com> wrote on 13/06/2009
> 17:57:55:
> >
> > On Sat, Jun 13, 2009 at 10:03 AM, Joakim
> > Tjernlund<joakim.tjernlund@transmode.se> wrote:
> > > Benny Amorsen <benny+usenet@amorsen.dk <benny%2Busenet@amorsen.dk>>
> wrote on 13/06/2009 01:58:53:
> > >>
> > >> Joakim Tjernlund <Joakim.Tjernlund@transmode.se> writes:
> > >>
> > >> > Currently the bridge does not impl. split horizon which will easily
> > >> > cause loops when 2 or more VLANs are added from the same physical
> interface.
> > >>
> > >> Why would they cause loops? If your topology isn't loop free, run
> > >> spanning tree in the VLAN's. Yet another thing most hardware switches
> > >> can't do, incidentally.
> > >
> > > ehh, connect two Linux bridges that have 2 VLANs in common on the
> interswitch connection.
> >
> > For example, here is a configuration that meets your problem
> > description and has no loops:
> >
> > host A eth0 connected to hostB eth0
> >
> > host A:
> > brctl add br0
> > brctl addif br0 eth0.1
> > brctl addif br0 eth1
> > brctl add br1
> > brctl addif br1 eth0.2
> > brctl addif br1 eth2
>
> Yes, but eth1 and eth2 don't talk.


You've been asking how to do private ports on bridges.  By definition they
wouldn't talk.  Below, you ask about mimicking VLAN-capable switch hardware.
 This does, it represents the case where eth1 and eth2 are untagged ports in
VLAN1 and VLAN2, respectively, and eth0 is a trunking port.


>
>
> >
> > host B:
> > brctl add br0
> > brctl addif br0 eth0.1
> > brctl addif br0 wlan0.1
> > brctl add br1
> > brctl addif br1 eth0.2
> > brctl addif br1 wlan0.2
> >
> > Let's compare this to your complaint:
> > Two Linux hosts.... check
> > Two VLANs in common.... check
> > Both VLANs on the inter-switch connection.... check
> >
> > Nope, there are no loops.
>
> Of course not. You can always fix what you want somehow but that
> doesn't mean that there may be better ways of doing things.


You're just confusing the issue with very vague wording of your problem
scenario, then claiming it has troublesome loops.  Express your scenario as
a set of brctl commands or we'll never be discussing the same thing, because
we're thinking of the command set that achieves what you want, while you're
thinking of the command set that doesn't do what you want without a patch.


>
> >
> > You need to stop calling "a machine running bridging" a "Linux
> > bridge".  A "bridge", in Linux, is a virtual interface inside a
> > machine with the bridging module loaded.  There can be more than zero,
> > one, or multiple bridges in a single Linux machine.  I think that when
> > you understand that, all your problems will go away with a simpler
> > configuration and no changes to the Linux kernel.
>
> Aha, I had/have the impression that one bridge instance should mimic
> a real bridge, if not you are making some sense.


No, a bridge instance is better compared to a VLAN inside a VLAN-capable
switch.  The switch moves traffic between all ports which are members of the
same VLAN, without crossing VLANs.  That's what a Linux bridge instance
does.

Incidentally the Linux way allows you to remap VLAN IDs in the process.  For
example, you could merge two VLAN trunks (eth1 and eth2), both using VLAN
IDs 1-9, such that on the combined trunk (eth0) the eth1 VLANs become 11-19
and the eth2 VLANs become 21-29.

On VLAN-capable switches, the VLAN is completely determined by its ID.  On
Linux, the VLAN interface is determined by a combination of parent interface
and VLAN ID, there is not automatically any association between eth0.1 and
eth1.1


> But now I start asking myself what are the semantics for a Linux
> bridge instance?
>
> I would really like to know in what situation you would use
> the current behavior to forward back VLAN pkgs over the same interface
> it was received on?
>
> Also, I am trying to find where it states that a VLAN is considered its own
> physical port. Any pointers?
>

It is its own "logical interface". Physical interfaces are only different
because they are implemented by NIC drivers talking to real hardware, vs
virtual interface drivers which are pure software.  The rest of the
networking stack just looks at logical interfaces.  VLANs are virtual
interfaces.  So are bridge, bonding, tun/tap, and veth virtual machine
connections.  I'm pretty sure you can have VLANs on a tun/tap interface, in
which case there is no physical interface at all. I know you can have VLANs
on bonded interfaces, in which case there's more than one underlying
physical interface.  You talk a lot about "physical port" or "physical
interface" but the patch you offered doesn't do what you claim because
the vlan_dev_real_dev
function doesn't have any guarantee that the return value is a "physical"
interface like you think it does.

--001485f8955ecbee58046c45cf8a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sat, Jun 13, 2009 at 11:30 AM, Joakim=
 Tjernlund <span dir=3D"ltr">&lt;<a href=3D"mailto:joakim.tjernlund@transmo=
de.se">joakim.tjernlund@transmode.se</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex;">
&quot;<a href=3D"mailto:richardvoigt@gmail.com">richardvoigt@gmail.com</a>&=
quot; &lt;<a href=3D"mailto:richardvoigt@gmail.com">richardvoigt@gmail.com<=
/a>&gt; wrote on 13/06/2009 17:57:55:<br>
<div class=3D"im">&gt;<br>
&gt; On Sat, Jun 13, 2009 at 10:03 AM, Joakim<br>
&gt; Tjernlund&lt;<a href=3D"mailto:joakim.tjernlund@transmode.se">joakim.t=
jernlund@transmode.se</a>&gt; wrote:<br>
&gt; &gt; Benny Amorsen &lt;<a href=3D"mailto:benny%2Busenet@amorsen.dk">be=
nny+usenet@amorsen.dk</a>&gt; wrote on 13/06/2009 01:58:53:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Joakim Tjernlund &lt;<a href=3D"mailto:Joakim.Tjernlund@trans=
mode.se">Joakim.Tjernlund@transmode.se</a>&gt; writes:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; Currently the bridge does not impl. split horizon which =
will easily<br>
&gt; &gt;&gt; &gt; cause loops when 2 or more VLANs are added from the same=
 physical interface.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Why would they cause loops? If your topology isn&#39;t loop f=
ree, run<br>
&gt; &gt;&gt; spanning tree in the VLAN&#39;s. Yet another thing most hardw=
are switches<br>
&gt; &gt;&gt; can&#39;t do, incidentally.<br>
&gt; &gt;<br>
&gt; &gt; ehh, connect two Linux bridges that have 2 VLANs in common on the=
 interswitch connection.<br>
&gt;<br>
&gt; For example, here is a configuration that meets your problem<br>
&gt; description and has no loops:<br>
&gt;<br>
&gt; host A eth0 connected to hostB eth0<br>
&gt;<br>
&gt; host A:<br>
&gt; brctl add br0<br>
&gt; brctl addif br0 eth0.1<br>
&gt; brctl addif br0 eth1<br>
&gt; brctl add br1<br>
&gt; brctl addif br1 eth0.2<br>
&gt; brctl addif br1 eth2<br>
<br>
</div>Yes, but eth1 and eth2 don&#39;t talk.</blockquote><div><br></div><di=
v>You&#39;ve been asking how to do private ports on bridges. =A0By definiti=
on they wouldn&#39;t talk. =A0Below, you ask about=A0mimicking=A0VLAN-capab=
le switch hardware. =A0This does, it represents the case where eth1 and eth=
2 are untagged ports in VLAN1 and VLAN2, respectively, and eth0 is a trunki=
ng port.</div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex;"><br>
<div class=3D"im"><br>
&gt;<br>
&gt; host B:<br>
&gt; brctl add br0<br>
&gt; brctl addif br0 eth0.1<br>
&gt; brctl addif br0 wlan0.1<br>
&gt; brctl add br1<br>
&gt; brctl addif br1 eth0.2<br>
&gt; brctl addif br1 wlan0.2<br>
&gt;<br>
&gt; Let&#39;s compare this to your complaint:<br>
&gt; Two Linux hosts.... check<br>
&gt; Two VLANs in common.... check<br>
&gt; Both VLANs on the inter-switch connection.... check<br>
&gt;<br>
&gt; Nope, there are no loops.<br>
<br>
</div>Of course not. You can always fix what you want somehow but that<br>
doesn&#39;t mean that there may be better ways of doing things.</blockquote=
><div><br></div><div>You&#39;re just confusing the issue with very vague wo=
rding of your problem scenario, then claiming it has troublesome loops. =A0=
Express your scenario as a set of brctl commands or we&#39;ll never be disc=
ussing the same thing, because we&#39;re thinking of the command set that a=
chieves what you want, while you&#39;re thinking of the command set that do=
esn&#39;t do what you want without a patch.</div>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex;"><br>
<div class=3D"im"><br>
&gt;<br>
&gt; You need to stop calling &quot;a machine running bridging&quot; a &quo=
t;Linux<br>
&gt; bridge&quot;. =A0A &quot;bridge&quot;, in Linux, is a virtual interfac=
e inside a<br>
&gt; machine with the bridging module loaded. =A0There can be more than zer=
o,<br>
&gt; one, or multiple bridges in a single Linux machine. =A0I think that wh=
en<br>
&gt; you understand that, all your problems will go away with a simpler<br>
&gt; configuration and no changes to the Linux kernel.<br>
<br>
</div>Aha, I had/have the impression that one bridge instance should mimic<=
br>
a real bridge, if not you are making some sense.</blockquote><div><br></div=
><div>No, a bridge instance is better compared to a VLAN inside a VLAN-capa=
ble switch. =A0The switch moves traffic between all ports which are members=
 of the same VLAN, without crossing VLANs. =A0That&#39;s what a Linux bridg=
e instance does.</div>
<div><br></div><div>Incidentally the Linux way allows you to remap VLAN IDs=
 in the process. =A0For example, you could merge two VLAN trunks (eth1 and =
eth2), both using VLAN IDs 1-9, such that on the combined trunk (eth0) the =
eth1 VLANs become 11-19 and the eth2 VLANs become 21-29.</div>
<div><br></div><div>On VLAN-capable switches, the VLAN is completely determ=
ined by its ID. =A0On Linux, the VLAN interface is determined by a combinat=
ion of parent interface and VLAN ID, there is not automatically any associa=
tion between eth0.1 and eth1.1</div>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex;"><br>
But now I start asking myself what are the semantics for a Linux<br>
bridge instance?<br>
<br>
I would really like to know in what situation you would use<br>
the current behavior to forward back VLAN pkgs over the same interface<br>
it was received on?<br>
<br>
Also, I am trying to find where it states that a VLAN is considered its own=
<br>
<div><div></div><div class=3D"h5">physical port. Any pointers?</div></div><=
/blockquote><div><br></div><div>It is its own &quot;logical interface&quot;=
. Physical interfaces are only different because they are implemented by NI=
C drivers talking to real hardware, vs virtual interface drivers which are =
pure software. =A0The rest of the networking stack just looks at logical in=
terfaces. =A0VLANs are virtual interfaces. =A0So are bridge, bonding, tun/t=
ap, and veth virtual machine connections. =A0I&#39;m pretty sure you can ha=
ve VLANs on a tun/tap interface, in which case there is no physical interfa=
ce at all. I know you can have VLANs on bonded interfaces, in which case th=
ere&#39;s more than one underlying physical interface. =A0You talk a lot ab=
out &quot;physical port&quot; or &quot;physical interface&quot; but the pat=
ch you offered doesn&#39;t do what you claim because the=A0<span class=3D"A=
pple-style-span" style=3D"border-collapse: collapse; ">vlan_dev_real_dev fu=
nction doesn&#39;t have any guarantee that the return value is a &quot;phys=
ical&quot; interface like you think it does.</span></div>
<div><br></div></div>

--001485f8955ecbee58046c45cf8a--
