MIME-Version: 1.0
From: Radim Roska <radim.roska@gmail.com>
Date: Mon, 23 Nov 2009 23:12:27 +0100
Message-ID: <aa3710a80911231412p3e82dd05q7094c625efbb95f7@mail.gmail.com>
Content-Type: multipart/alternative; boundary=0015175cae181e90b9047911207a
Subject: [Bridge] weird question ? kvm virtual network and bunch of bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0015175cae181e90b9047911207a
Content-Type: text/plain; charset=UTF-8

Hello,

I have this very uncommon situation :). My diploma thesis will probably be
playing with linux kernel in various networks. Currently I have little free
time and limited computer resources -> only one laptop :). But I would like
to do some profiling of kernel particularly of bridging part. For that i
need network.

So i have 2 virtual machines VPC1 and VPC2 (running debian)

HOST - VPC1 - VPC2

VPC1 should act as bridge.
HOST: tap0 interface
VPC1:
eth0 ~ tap1 on host
eth1 ~ tap2 on host
VPC2:
eth0 ~ tap3 on host

how to connect it? :) Well tap0 - tap1 is in br0 on host and tap2 + tap3 is
on br1.

VPC1 than has eth0 and eth1 in bridge also :).

I know..it looks strange..but i thought its simplest :).

But:

1) although VPC2 is connected through br1 that has connection only with
tap2=eth1 on VPC1..I can ping anything even when VPC1 has all interfaces
down

2) i dont see any loop in my "network" but anyway once i turn on br0
without stp on VPC1, i got quite a serious perf problem - little storm i
guess:).
starting stp solves storm but disables eth0
[ 3839.200640] br0: starting userspace STP failed, starting kernel STP
[ 3839.201388] br0: topology change detected, sending tcn bpdu
[ 3839.202117] br0: port 2(eth0) entering blocking state

i does not matter if i have stp on HOST's br0/br1

If someone would have time to help me with that I'll be very happy :). Its
possible Im trying approach that is doomed to fail because i dont
know/understsand something.

Cheers,
Radim

--0015175cae181e90b9047911207a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,<br clear=3D"all"><br>I have this very uncommon situation :). My dipl=
oma thesis will probably be playing with linux kernel in various networks. =
Currently I have little free time and limited computer resources -&gt; only=
 one laptop :). But I would like to do some profiling of kernel particularl=
y of bridging part. For that i need network.<br>

<br>So i have 2 virtual machines VPC1 and VPC2 (running debian)<br><br>HOST=
 - VPC1 - VPC2<br><br>VPC1 should act as bridge.<br>HOST: tap0 interface<br=
>VPC1: <br>eth0 ~ tap1 on host<br>eth1 ~ tap2 on host<br>VPC2:<br>eth0 ~ ta=
p3 on host<br>

<br>how to connect it? :) Well tap0 - tap1 is in br0 on host and tap2 + tap=
3 is on br1.<br><br>VPC1 than has eth0 and eth1 in bridge also :). <br><br>=
I know..it looks strange..but i thought its simplest :).<br><br>But:<br>

<br>1) although VPC2 is connected through br1 that has connection only with=
 tap2=3Deth1 on VPC1..I can ping anything even when VPC1 has all interfaces=
 down<br><br>2) i dont see any loop in my &quot;network&quot; but anyway on=
ce i turn on br0=C2=A0 without stp on VPC1, i got quite a serious perf prob=
lem - little storm i guess:). <br>

starting stp solves storm but disables eth0<br>[ 3839.200640] br0: starting=
 userspace STP failed, starting kernel STP<br>[ 3839.201388] br0: topology =
change detected, sending tcn bpdu<br>[ 3839.202117] br0: port 2(eth0) enter=
ing blocking state<br>

<br>i does not matter if i have stp on HOST&#39;s br0/br1 <br><br>If someon=
e would have time to help me with that I&#39;ll be very happy :). Its possi=
ble Im trying approach that is doomed to fail because i dont know/understsa=
nd something.<br>

<br>Cheers,<br>Radim<br>

--0015175cae181e90b9047911207a--
