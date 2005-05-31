Message-ID: <34d8b2fe050531121736623672@mail.gmail.com>
Date: Tue, 31 May 2005 21:17:17 +0200
From: Louis Croisez <louis.croisez@gmail.com>
Subject: Re: [Bridge] Bridge not working on arm embedded platform
In-Reply-To: <20050531094024.75098a16@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4734_15295716.1117567037812"
References: <34d8b2fe05053002387a1942bf@mail.gmail.com>
	<20050531094024.75098a16@dxpl.pdx.osdl.net>
Reply-To: Louis Croisez <louis.croisez@gmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_4734_15295716.1117567037812
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Stephen,
first of all, thx for helping me :o)

2005/5/31, Stephen Hemminger <shemminger@osdl.org>:
>=20
> On Mon, 30 May 2005 11:38:59 +0200
> Louis Croisez <louis.croisez@gmail.com> wrote:
>=20
> > Hi,
> > i want to implement the bridging feature on an arm (cpu intel ixp425),
> > running busybox+linux kernel 2.6.11.
> > For this, I have recompiled the kernel to enable bridging and ebtables,=
=20
> and
> > I have compiled and installed brctl utility for arm.
> >
> > Here is my network setup:
> > [PC_A] eth0 10.0.0.10/24 <http://10.0.0.10/24> =3D=3D=3D=3D=3D=3D=3D=3D=
 eth0 --+-- eth1=20
> =3D=3D=3D=3D=3D=3D=3D=3D [PC_B] eth0 10.10.0.1/24 <http://10.10.0.1/24>
> > |
> > br0
> > [ARM]
>=20
> What is IP address of bridge? (br0) or do you not
> want the ARM box to be IP accessible?


It is not well sure that the bridge is to be accessible. But it is not=20
forbidden. In fact, a requirement is that the bridge worked with or without=
=20
IP address on br0 iface. On my linux bridge test box, whether to have or no=
t=20
an IP on br0 does not makes the difference.

>
> > Here is how I setup my bridge on the ARM:
> > brctl addbr br0
> > brctl addif br0 eth0
> > brctl addif br0 eth1
> > brctl setfd br0 1
> why set forwarding delay so low, please don't


Could please you explain me the consequence of setting this parameter too=
=20
low?=20

> ifconfig eth0 promisc
> Don't do this you don't need to, unless something is
> broken in driver.


I am currently debugging. To have idea of where is the network packet in th=
e=20
stack, I use the ebtables/iptables log feature, that show the traject of a=
=20
packet.
Here is the result of my last test.
Goal:
[PC_A] ping [PC_B] thru [ARM].
Result:
icmp request is even not sent, because first an arp request is broadcast on=
=20
the lan to resolve PC_B hw address. Problem is that this arp request never=
=20
reach PC_B. It is stopped inside ARM.
Here is the path followed by this packet:
ebt:BRoute:BRouting
ebt:Nat:PreRouting
ipt:Mangle:PreRouting
ipt:Nat:PreRouting
ebt:Filter:Input

I don't understand this behavior of the Bridgin Decision... The arp request=
=20
is a broadcast. It should not be kept only by br0.

To workaround this, I have set br0 to promisc mode.
The result of the test is the following:
ebt:BRoute:BRouting
ebt:Nat:PreRouting
ipt:Mangle:PreRouting
ipt:Nat:PreRouting
ebt:Filter:Input
ebt:Filter:Forward
ipt:Mangle:Forward
ipt:Filter:Forward
ebt:Nat:PostRouting

The packet is stopped here. I don't know why!!

I feel there is a config problem, because it cannot be a bridge source=20
problem, or a bug.
I thing about some /proc configuration related to arp. Do you have an idea?

Concerning ICMP packets, I have verified that the bridge is well working=20
with it, because if I set static ARP information inside PC_A and PC_B, the=
=20
bridge is working well, whether an IP is defined on br0 or not.

> ifconfig eth1 promisc
> > ifconfig eth0 0.0.0.0 <http://0.0.0.0>
> What is http:// stuff? some filter got it?
> expect:
> ifconfig eth0 0.0.0.0 <http://0.0.0.0>
> to bring up without IP address


Don't worry, it is some auto-formatting added by gmail smtp engine. I had=
=20
well encoded 0dot0dot0dot0.

> ifconfig eth1 0.0.0.0 <http://0.0.0.0>
> > ifconfig eth0 up
> unneeded device is already up.
> > ifconfig eth1 up
> > ifconfig br0 0.0.0.0 <http://0.0.0.0>
>=20
> You forgot to assign IP address to bridge, expect:
> ifconfig br0
>=20
> > ifconfig br0 up
> Likewise unneeded.
>=20
> > ip route add default dev br0
>=20
> In addition to configuration issues, I would also suspect the ARM ethernet
> driver. Possible issues:
> 1) Does each ethernet device have a valid unique ethernet address?=20
> (ifconfig -a)
> 2) Does promiscuous work correctly?
> Can you snoop the net correctly with tcpdump without the bridge and=20
> without forcing
> eth into promiscuous mode.


1) Yes, they have. It is not silly to ask this, because it is=20
software-modifiable.
2) I have verified with tcpdump that I can well snoop traffic that is not=
=20
target specifically to the ARM board, and that successivelly on eth0 and=20
eth1 of ARM board, and without forcing promisc mode on the ifaces. My first=
=20
conclusion is that this is not a lowlevel network driver problem.

To summarize, my problem is due to the behavior of the bridge concerning ar=
p=20
resolution.
I need a way to unlock this.

Best Regards,
/Louis Croisez.

------=_Part_4734_15295716.1117567037812
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Stephen,<br>
first of all, thx for helping me :o)<br>
<br><div><span class=3D"gmail_quote">2005/5/31, Stephen Hemminger &lt;<a hr=
ef=3D"mailto:shemminger@osdl.org">shemminger@osdl.org</a>&gt;:</span><block=
quote class=3D"gmail_quote" DEFANGED_style=3D"border-left: 1px solid rgb(20=
4, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Mon, 30 May 2005 11:38:59 +0200<br>Louis Croisez &lt;<a href=3D"mailto:l=
ouis.croisez@gmail.com">louis.croisez@gmail.com</a>&gt; wrote:<br><br>&gt; =
Hi,<br>&gt; i want to implement the bridging feature on an arm (cpu intel i=
xp425),
<br>&gt; running busybox+linux kernel 2.6.11.<br>&gt; For this, I have reco=
mpiled the kernel to enable bridging and ebtables, and<br>&gt; I have compi=
led and installed brctl utility for arm.<br>&gt;<br>&gt; Here is my network=
 setup:
<br>&gt; [PC_A] eth0 <a href=3D"http://10.0.0.10/24">10.0.0.10/24</a>&nbsp;=
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D eth0 --+-- eth1 =3D=3D=3D=3D=3D=3D=3D=3D [PC=
_B] eth0 <a href=3D"http://10.10.0.1/24">10.10.0.1/24</a><br>&gt;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
|<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
br0<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[ARM]<br><br>What is IP address of bridge? (br0) or do you not<br>want the =
ARM box to be IP accessible?</blockquote><div><br>
It is not well sure that the bridge is to be accessible. But it is not
forbidden. In fact, a requirement is that the bridge worked with or
without IP address on br0 iface. On my linux bridge test box, whether
to have or not an IP on br0 does not makes the difference.<br>
</div><br><blockquote class=3D"gmail_quote" DEFANGED_style=3D"border-left: =
1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;=
">&gt;<br>&gt; Here is how I setup my bridge on the ARM:<br>&gt; brctl addb=
r br0<br>
&gt; brctl addif br0 eth0<br>&gt; brctl addif br0 eth1<br>&gt; brctl setfd =
br0 1<br>why set forwarding delay so low, please don't</blockquote><div><br>
Could please you explain me the consequence of setting this parameter too l=
ow? <br>
</div><br><blockquote class=3D"gmail_quote" DEFANGED_style=3D"border-left: =
1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;=
">&gt; ifconfig eth0 promisc<br>Don't do this you don't need to, unless som=
ething is
<br>broken in driver.</blockquote><div><br>
I am currently debugging. To have idea of where is the network packet
in the stack, I use the ebtables/iptables log feature, that show the
traject of a packet.<br>
Here is the result of my last test.<br>
Goal:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [PC_A] p=
ing [PC_B] thru [ARM].<br>
Result:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; icmp
request is even not sent, because first an arp request is broadcast on
the lan to resolve PC_B hw address. Problem is that this arp request
never reach PC_B. It is stopped inside ARM.<br>
Here is the path followed by this packet:<br>
ebt:BRoute:BRouting<br>
ebt:Nat:PreRouting<br>
ipt:Mangle:PreRouting<br>
ipt:Nat:PreRouting<br>
ebt:Filter:Input<br>
<br>
I don't understand this behavior of the Bridgin Decision... The arp
request is a broadcast. It should&nbsp; not be kept only by br0.<br>
<br>
To workaround this, I have set br0 to promisc mode.<br>
The result of the test is the following:<br>
ebt:BRoute:BRouting<br>

ebt:Nat:PreRouting<br>

ipt:Mangle:PreRouting<br>

ipt:Nat:PreRouting<br>

ebt:Filter:Input<br>
ebt:Filter:Forward<br>
ipt:Mangle:Forward<br>
ipt:Filter:Forward<br>
ebt:Nat:PostRouting<br>
<br>
The packet is stopped here. I don't know why!!<br>
<br>
I feel there is a config problem, because it cannot be a bridge source prob=
lem, or a bug.<br>
I thing about some /proc configuration related to arp. Do you have an idea?=
<br>
<br>
Concerning ICMP packets, I have verified that the bridge is well
working with it, because if I set static ARP information inside PC_A
and PC_B, the bridge is working well, whether an IP is defined on br0
or not.<br>
</div><br><blockquote class=3D"gmail_quote" DEFANGED_style=3D"border-left: =
1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;=
">&gt; ifconfig eth1 promisc<br>&gt; ifconfig eth0 <a href=3D"http://0.0.0.=
0">0.0.0.0
</a><br>What is http:// stuff? some filter got it?<br>expect:<br>&nbsp;&nbs=
p; ifconfig eth0 <a href=3D"http://0.0.0.0">0.0.0.0</a><br>to bring up with=
out IP address</blockquote><div><br>
Don't worry, it is some auto-formatting added by gmail smtp engine. I had w=
ell encoded 0dot0dot0dot0.<br>
</div><br><blockquote class=3D"gmail_quote" DEFANGED_style=3D"border-left: =
1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;=
">&gt; ifconfig eth1 <a href=3D"http://0.0.0.0">0.0.0.0</a><br>&gt; ifconfi=
g eth0 up<br>
unneeded device is already up.<br>&gt; ifconfig eth1 up<br>&gt; ifconfig br=
0 <a href=3D"http://0.0.0.0">0.0.0.0</a><br><br>You forgot to assign IP add=
ress to bridge, expect:<br>&nbsp;&nbsp; ifconfig br0<br><br>&gt; ifconfig b=
r0 up<br>
Likewise unneeded.<br><br>&gt; ip route add default dev br0<br><br>In addit=
ion to configuration issues, I would also suspect the ARM ethernet<br>drive=
r.&nbsp;&nbsp;Possible issues:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;1) Does each ethernet device have a valid unique ethernet address? (=
ifconfig -a)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2) Does promiscuous wor=
k correctly?<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Can you snoop the net correctly with tcpdump without the bridge and
without forcing<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; eth into promiscuous mode.</blockquote><div><br>
1) Yes, they have. It is not silly to ask this, because it is software-modi=
fiable.<br>
2) I have verified with tcpdump that I can well snoop traffic that is
not target specifically to the ARM board, and that successivelly on
eth0 and eth1 of ARM board, and without forcing promisc mode on the
ifaces. My first conclusion is that this is not a lowlevel network
driver problem.<br>
<br>
To summarize, my problem is due to the behavior of the bridge concerning ar=
p resolution.<br>
I need a way to unlock this.<br>
<br>
Best Regards,<br>
/Louis Croisez.<br>
</div></div>

------=_Part_4734_15295716.1117567037812--
