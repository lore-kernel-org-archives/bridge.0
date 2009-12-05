MIME-Version: 1.0
From: Radim Roska <radim.roska@gmail.com>
Date: Sat, 5 Dec 2009 13:11:14 +0100
Message-ID: <aa3710a80912050411k43417309r9989f7df0eed1010@mail.gmail.com>
Content-Type: multipart/alternative; boundary=00151747ba9c2048f60479fa20df
Subject: [Bridge] how bridge interacts with tap ifaces?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--00151747ba9c2048f60479fa20df
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

few weeks ago I asked question that was probably not interesting for you.

Now ill put it differently.

2 computers - VPC and HOST
VPC has 2 eth0 and eth1 interfaces (on host tap1 and tap2)
HOST has 1 tap (tap0)

HOST has br0 where tap0 and tap1 are bound
VPC has br0 where eth0 and eth1 are bound

tap1 has ip
br0 on VPC has ip

ping from VPC -> tap1:

__ratelimit: 32575 callbacks suppressed
eth0: received packed with own address as source address
eth0: received packed with own address as source address
eth0: received packed with own address as source address
...

infinity loop stopped by command to turn on stp on VPC. This blocks eth0 ->
port connected to bridge on HOST.

No more problem with loop and VPC can actually ping HOST. Probably using
eth1 which is not connected anywhere.

So I assume that once packet is somewhere on a tap interface in the HOST.
Thus its not possible to do little complicated network because all taps
create a loop no matter how user connects them in bridges...is that right?

I've lost big amount of time trying to make this working...so please make
sure i dont lost even more :))

Thanks
Radim



On Mon, Nov 23, 2009 at 11:12 PM, Radim Roska <radim.roska@gmail.com> wrote=
:

> Hello,
>
> I have this very uncommon situation :). My diploma thesis will probably b=
e
> playing with linux kernel in various networks. Currently I have little fr=
ee
> time and limited computer resources -> only one laptop :). But I would li=
ke
> to do some profiling of kernel particularly of bridging part. For that i
> need network.
>
> So i have 2 virtual machines VPC1 and VPC2 (running debian)
>
> HOST - VPC1 - VPC2
>
> VPC1 should act as bridge.
> HOST: tap0 interface
> VPC1:
> eth0 ~ tap1 on host
> eth1 ~ tap2 on host
> VPC2:
> eth0 ~ tap3 on host
>
> how to connect it? :) Well tap0 - tap1 is in br0 on host and tap2 + tap3 =
is
> on br1.
>
> VPC1 than has eth0 and eth1 in bridge also :).
>
> I know..it looks strange..but i thought its simplest :).
>
> But:
>
> 1) although VPC2 is connected through br1 that has connection only with
> tap2=3Deth1 on VPC1..I can ping anything even when VPC1 has all interface=
s
> down
>
> 2) i dont see any loop in my "network" but anyway once i turn on br0
> without stp on VPC1, i got quite a serious perf problem - little storm i
> guess:).
> starting stp solves storm but disables eth0
> [ 3839.200640] br0: starting userspace STP failed, starting kernel STP
> [ 3839.201388] br0: topology change detected, sending tcn bpdu
> [ 3839.202117] br0: port 2(eth0) entering blocking state
>
> i does not matter if i have stp on HOST's br0/br1
>
> If someone would have time to help me with that I'll be very happy :). It=
s
> possible Im trying approach that is doomed to fail because i dont
> know/understsand something.
>
> Cheers,
> Radim
>



--=20
Radim Ro=C5=A1ka

--00151747ba9c2048f60479fa20df
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>few weeks ago I asked question that was probably not interesting=
 for you.<br><br>Now ill put it differently.<br><br>2 computers - VPC and H=
OST<br>VPC has 2 eth0 and eth1 interfaces (on host tap1 and tap2)<br>
HOST has 1 tap (tap0)<br><br>HOST has br0 where tap0 and tap1 are bound<br>=
VPC has br0 where eth0 and eth1 are bound<br><br>tap1 has ip<br>br0 on VPC =
has ip<br><br>ping from VPC -&gt; tap1:<br><br>__ratelimit: 32575 callbacks=
 suppressed<br>


eth0: received packed with own address as source address<br>
eth0: received packed with own address as source address<br>
eth0: received packed with own address as source address<br>...<br><br>infi=
nity loop stopped by command to turn on stp on VPC. This blocks eth0 -&gt; =
port connected to bridge on HOST. <br><br>No more problem with loop and VPC=
 can actually ping HOST. Probably using eth1 which is not connected anywher=
e.<br>

<br>So I assume that once packet is somewhere on a tap interface in the HOS=
T. Thus its not possible to do little complicated network because all taps =
create a loop no matter how user connects them in bridges...is that right?<=
br>

<br>I&#39;ve lost big amount of time trying to make this working...so pleas=
e make sure i dont lost even more :))<br><br>Thanks<br>Radim<br><br><br><br=
><div class=3D"gmail_quote">On Mon, Nov 23, 2009 at 11:12 PM, Radim Roska <=
span dir=3D"ltr">&lt;<a href=3D"mailto:radim.roska@gmail.com" target=3D"_bl=
ank">radim.roska@gmail.com</a>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hello,<br clear=
=3D"all"><br>I have this very uncommon situation :). My diploma thesis will=
 probably be playing with linux kernel in various networks. Currently I hav=
e little free time and limited computer resources -&gt; only one laptop :).=
 But I would like to do some profiling of kernel particularly of bridging p=
art. For that i need network.<br>



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



<br>Cheers,<br><font color=3D"#888888">Radim<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Radim Ro=C5=A1ka=
<br>

--00151747ba9c2048f60479fa20df--
