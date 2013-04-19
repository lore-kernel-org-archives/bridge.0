Return-Path: <Pieter.DeBaets@ugent.be>
MIME-Version: 1.0
From: Pieter De Baets <Pieter.DeBaets@UGent.be>
Date: Fri, 19 Apr 2013 19:55:32 +0200
Message-ID: <CAEj-7xc24rTO-vHw7xFtkmDwZJkScpBMt1J+V+y7hcuqQi-AsA@mail.gmail.com>
Content-Type: multipart/alternative; boundary=047d7b450a22232e8204daba6e1c
Subject: [Bridge] Configuration-messages from root switch hello-timer not
	forwarded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--047d7b450a22232e8204daba6e1c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I'm trying to set up a simple ring-netwerk using a managed switch as root
(an HP ProCurve 2512) and some mini-ITX boards with 2 network-interfaces.

Initial setup is working fine but when I add a node B to a deeper level (so
[switch] =E2=86=92 [node A] =E2=86=92 *[node B]* =E2=86=92 [node C] =E2=86=
=92 [switch]) I get the following
error-messages on node about 20 seconds after initialization complets (when
the message age timer expires)

br0: port 1(eth0) neighbor 8000.00:0d:b9:1c:66:20 lost
> br0: topology change detected, propagating


which causes a reconfiguration of the network, and if there's any loops
causes blocking and relearning of the tree, with lots of traffic being
generated.

net_ratelimit: 35664 callbacks suppressed
> br0: received packet on eth1 with own address as source address


When I look at one of the upstream-nodes (A or C) they do receive hello
messages within the message window (on their designated port) but do not
seem to forward them to their other interfaces.

The bridges are created with the following commands:

brctl addbr br0

brctl stp on

brctl addif br0 eth0

brctl addif br0 eth1

ifconfig br0 up


eth0 and eth1 have no further configuration and are declared manual
interfaces in /etc/network/interfaces. I'm running Voyage Linux
(kernel-version is 2.6.35).

Your help is very much appreciated, as I would like to use this setup as a
redundancy tool for an event next tuesday.

Thanks,
Pieter De Baets

--047d7b450a22232e8204daba6e1c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi everyone,<div><br></div><div>I&#39;m trying to set up a=
 simple ring-netwerk using a managed switch as root (an HP ProCurve=C2=A025=
12) and some mini-ITX boards with 2 network-interfaces.</div><div><br></div=
><div style>

Initial setup is working fine but when I add a node B to a deeper level (so=
 [switch] =E2=86=92 [node A] =E2=86=92 <b>[node B]</b> =E2=86=92 [node C] =
=E2=86=92 [switch]) I get the following error-messages on node about 20 sec=
onds after initialization complets (when the message age timer expires)</di=
v>

<div style><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bord=
er-left-style:solid;padding-left:1ex">br0: port 1(eth0) neighbor 8000.00:0d=
:b9:1c:66:20 lost<br>

br0: topology change detected, propagating=C2=A0</blockquote><div><br></div=
><div style>which causes a reconfiguration of the network, and if there&#39=
;s any loops causes blocking and relearning of the tree, with lots of traff=
ic being generated.</div>

<div style><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bord=
er-left-style:solid;padding-left:1ex">net_ratelimit: 35664 callbacks suppre=
ssed<br>

br0: received packet on eth1 with own address as source address</blockquote=
><div><br></div><div style>When I look at one of the upstream-nodes (A or C=
) they do receive hello messages within the message window (on their design=
ated port) but do not seem to forward them to their other interfaces.</div>

<div><br></div><div style>The bridges are created with the following comman=
ds:</div><div style><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,=
204);border-left-style:solid;padding-left:1ex">

brctl addbr br0</blockquote><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,20=
4);border-left-style:solid;padding-left:1ex">brctl stp on=C2=A0</blockquote=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;=
padding-left:1ex">

brctl addif br0 eth0=C2=A0</blockquote><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb=
(204,204,204);border-left-style:solid;padding-left:1ex">brctl addif br0 eth=
1=C2=A0</blockquote>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">ifconfig br0 up</blockquote><div><br></div><div style>eth0=
 and eth1 have no further configuration and are declared manual interfaces =
in /etc/network/interfaces. I&#39;m running Voyage Linux (kernel-version is=
 2.6.35).</div>

<div><br clear=3D"all"><div>Your help is very much appreciated, as I would =
like to use this setup as a redundancy tool for an event next tuesday.</div=
><div><br></div><div style>Thanks,</div>
<div>Pieter De Baets</div>
</div></div>

--047d7b450a22232e8204daba6e1c--
