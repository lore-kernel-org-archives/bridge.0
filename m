Message-ID: <34d8b2fe05053002387a1942bf@mail.gmail.com>
Date: Mon, 30 May 2005 11:38:59 +0200
From: Louis Croisez <louis.croisez@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2466_25441109.1117445939662"
Subject: [Bridge] Bridge not working on arm embedded platform
Reply-To: Louis Croisez <louis.croisez@gmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_2466_25441109.1117445939662
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
i want to implement the bridging feature on an arm (cpu intel ixp425),=20
running busybox+linux kernel 2.6.11.
For this, I have recompiled the kernel to enable bridging and ebtables, and=
=20
I have compiled and installed brctl utility for arm.

Here is my network setup:
[PC_A] eth0 10.0.0.10/24 <http://10.0.0.10/24> =3D=3D=3D=3D=3D=3D=3D=3D eth=
0 ----+----eth1=20
=3D=3D=3D=3D=3D=3D=3D=3D [PC_B] eth0 10.10.0.1/24 <http://10.10.0.1/24>
|=20
br0=20
[ARM]=20

Here is how I setup my bridge on the ARM:
brctl addbr br0
brctl addif br0 eth0
brctl addif br0 eth1
brctl setfd br0 1
ifconfig eth0 promisc
ifconfig eth1 promisc
ifconfig eth0 0.0.0.0 <http://0.0.0.0>
ifconfig eth1 0.0.0.0 <http://0.0.0.0>
ifconfig eth0 up
ifconfig eth1 up
ifconfig br0 0.0.0.0 <http://0.0.0.0>
ifconfig br0 up
ip route add 0.0.0.0/0 <http://0.0.0.0/0> dev br0


On PC_A, I ping PC_B. It does not work
[pc_a]# ping 10.0.0.10 <http://10.0.0.10>

Then, I verified with tcpdump on the arm platform where the problem could=
=20
be:
[arm]# tcpdump -i br0
listening on br0, link-type EN10MB (Ethernet), capture size 68 bytes
arp who-has 10.10.0.1 <http://10.10.0.1> tell 10.0.0.10 <http://10.0.0.10>=
=20
3 packets captured=20
3 packets received by filter=20
0 packets dropped by kernel=20

[arm]# tcpdump -i eth0
listening on eth0, link-type EN10MB (Ethernet), capture size 68 bytes
arp who-has 10.10.0.1 <http://10.10.0.1> tell 10.0.0.10 <http://10.0.0.10>=
=20
3 packets captured=20
3 packets received by filter=20
0 packets dropped by kernel=20


[arm]# tcpdump -i eth1=20
listening on eth1, link-type EN10MB (Ethernet), capture size 68 bytes
0 packets captured=20
0 packets received by filter=20
0 packets dropped by kernel=20

The ICMP packet is not sent because the arp resolution is not completed.
Finally, the problem is: why does the bridge not forward the arp request=20
from PC_A (10.0.0.10 <http://10.0.0.10>) to PC_B (10.10.0.1<http://10.10.0.=
1>
)
This is a broadcast packet, and it should be forwarded on the other=20
interface of the bridge.

What I have done to find the problem:

   - I have verified that both eth0 and eth1 on the bridge are well=20
   working in promiscuous mode.=20
   - I have statically defined an arp entry for PC_A inside PC_B, and an=20
   arp entry for PC_B inside PC_A; the result is that the ICMP packet (ping=
) is=20
   well bridged through the two interfaces of the ARM platform. Thus the=20
   problem is related to the arp resolution.
=20=20=20=20

If someone could help me, it would be great because I am completely locked.=
=20
Replacing the ARM by a standard PC make the things working.

--L.Croisez.

------=_Part_2466_25441109.1117445939662
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
i want to implement the bridging feature on an arm (cpu intel ixp425), runn=
ing busybox+linux kernel 2.6.11.<br>
For this, I have recompiled the kernel to enable bridging and ebtables, and=
 I have compiled and installed brctl utility for arm.<br>
<br>
Here is my network setup:<br>
<font DEFANGED_style=3D"background-color: rgb(255, 255, 102); color: rgb(51=
, 0, 51);" size=3D"1"><span DEFANGED_style=3D"font-family: courier new,mono=
space; font-weight: bold;"><span DEFANGED_style=3D"text-decoration: underli=
ne;"><span DEFANGED_style=3D"text-decoration: underline;">
<span DEFANGED_style=3D"font-weight: bold;">[</span></span>PC_A]</span> eth=
0 <a href=3D"http://10.0.0.10/24">10.0.0.10/24</a> =3D=3D=3D=3D=3D=3D=3D=3D=
 eth0 ----+----eth1&nbsp; =3D=3D=3D=3D=3D=3D=3D=3D&nbsp; <span DEFANGED_sty=
le=3D"text-decoration: underline;"><span DEFANGED_style=3D"text-decoration:=
 underline;">
<span DEFANGED_style=3D"font-weight: bold;">[</span></span>PC_B]</span> eth=
0 <a href=3D"http://10.10.0.1/24">10.10.0.1/24</a><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp; &nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
&nbsp;&nbsp;
br0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
<span DEFANGED_style=3D"text-decoration: underline;"><span DEFANGED_style=
=3D"text-decoration: underline;"><span DEFANGED_style=3D"font-weight: bold;=
">[</span></span>ARM]</span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
</span><br DEFANGED_style=3D"font-family: courier new,monospace; font-weigh=
t: bold;">
<span DEFANGED_style=3D"font-family: courier new,monospace;"></span><span D=
EFANGED_style=3D"font-family: courier new,monospace; font-weight: bold;"></=
span></font><span DEFANGED_style=3D"font-family: courier new,monospace;"><b=
r>
</span>Here is how I setup my bridge on the ARM:<span DEFANGED_style=3D"fon=
t-family: courier new,monospace;"><br>
<font DEFANGED_style=3D"background-color: rgb(255, 255, 102);" size=3D"1">b=
rctl addbr br0<br>
brctl addif br0 eth0<br>
brctl addif br0 eth1<br>
brctl setfd br0 1<br>
ifconfig eth0 promisc<br>
ifconfig eth1 promisc<br>
ifconfig eth0 <a href=3D"http://0.0.0.0">0.0.0.0</a><br>
ifconfig eth1 <a href=3D"http://0.0.0.0">0.0.0.0</a><br>
ifconfig eth0 up<br>
ifconfig eth1 up<br>
ifconfig br0 <a href=3D"http://0.0.0.0">0.0.0.0</a><br>
ifconfig br0 up<br>
ip route add <a href=3D"http://0.0.0.0/0">0.0.0.0/0</a> dev br0<br>
</font><br>
</span><br>
<font size=3D"2">On PC_A, I ping PC_B. It does not work</font><span DEFANGE=
D_style=3D"font-family: courier new,monospace;"><br>
<font DEFANGED_style=3D"font-family: courier new,monospace; background-colo=
r: rgb(204, 255, 255);" size=3D"1">[pc_a]# ping <a href=3D"http://10.0.0.10=
">10.0.0.10</a></font><br>
<font size=3D"1"><br>
Then, I verified with tcpdump on the arm platform where the problem could b=
e:<br DEFANGED_style=3D"font-family: courier new,monospace;">
</font></span><font DEFANGED_style=3D"font-family: courier new,monospace; b=
ackground-color: rgb(204, 255, 255);" size=3D"1">[arm]# tcpdump -i br0<br>
listening on br0, link-type EN10MB (Ethernet), capture size 68 bytes<br>
arp who-has <a href=3D"http://10.10.0.1">10.10.0.1</a> tell
<a href=3D"http://10.0.0.10">10.0.0.10</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
</font><font DEFANGED_style=3D"background-color: rgb(204, 255, 255);" size=
=3D"1"><br DEFANGED_style=3D"font-family: courier new,monospace;">
<span DEFANGED_style=3D"font-family: courier new,monospace;">3 packets
captured&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;
</span><br DEFANGED_style=3D"font-family: courier new,monospace;">
<span DEFANGED_style=3D"font-family: courier new,monospace;">3 packets rece=
ived by
filter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
</span><br DEFANGED_style=3D"font-family: courier new,monospace;">
<span DEFANGED_style=3D"font-family: courier new,monospace;">0 packets drop=
ped by
kernel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></font><br DEFANGED_style=3D"background-color: rgb(204, 255, 255);">
<br DEFANGED_style=3D"background-color: rgb(204, 255, 255);">
<font DEFANGED_style=3D"font-family: courier new,monospace; background-colo=
r: rgb(204, 255, 255);" size=3D"1"><span DEFANGED_style=3D"font-family: cou=
rier new,monospace;">[arm]# tcpdump -i eth0</span><br DEFANGED_style=3D"fon=
t-family: courier new,monospace;">

<span DEFANGED_style=3D"font-family: courier new,monospace;">listening on e=
th0, link-type EN10MB (Ethernet), capture size 68 bytes</span><br DEFANGED_=
style=3D"font-family: courier new,monospace;">
<span DEFANGED_style=3D"font-family: courier new,monospace;">arp who-has <a=
 href=3D"http://10.10.0.1">10.10.0.1</a>
tell
<a href=3D"http://10.0.0.10">10.0.0.10</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
</span><br DEFANGED_style=3D"font-family: courier new,monospace;">
<span DEFANGED_style=3D"font-family: courier new,monospace;">3 packets
captured&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
</span><br DEFANGED_style=3D"font-family: courier new,monospace;">
<span DEFANGED_style=3D"font-family: courier new,monospace;">3 packets rece=
ived by
filter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span><br DEFANGED_style=3D"font-family: courier new,monospace;">
<span DEFANGED_style=3D"font-family: courier new,monospace;">0 packets drop=
ped by
kernel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><br DEFANGED_style=3D"font-family: courier new,monospace;">
<br>
</font><br DEFANGED_style=3D"background-color: rgb(204, 255, 255);">
<font DEFANGED_style=3D"font-family: courier new,monospace; background-colo=
r: rgb(204, 255, 255);" size=3D"1">[arm]#
tcpdump -i
eth1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
listening on eth1, link-type EN10MB (Ethernet), capture size 68 bytes</font=
><font DEFANGED_style=3D"background-color: rgb(204, 255, 255);" size=3D"1">=
<br DEFANGED_style=3D"font-family: courier new,monospace;">
</font><font size=3D"1"><span DEFANGED_style=3D"font-family: courier new,mo=
nospace; background-color: rgb(204, 255, 255);">0
packets
captured&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
</span><br DEFANGED_style=3D"font-family: courier new,monospace; background=
-color: rgb(204, 255, 255);">
<span DEFANGED_style=3D"font-family: courier new,monospace; background-colo=
r: rgb(204, 255, 255);">0
packets received by
filter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span><br DEFANGED_style=3D"font-family: courier new,monospace; background=
-color: rgb(204, 255, 255);">
<span DEFANGED_style=3D"font-family: courier new,monospace; background-colo=
r: rgb(204, 255, 255);">0
packets dropped by
kernel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><br DEFANGED_style=3D"background-color: rgb(255, 153, 0); font-famil=
y: courier new,monospace;">
</font><br>
The ICMP packet is not sent because the arp resolution is not completed.<br>
Finally, the problem is: why does the bridge not forward the arp request fr=
om PC_A (<a href=3D"http://10.0.0.10">10.0.0.10</a>) to PC_B (<a href=3D"ht=
tp://10.10.0.1">10.10.0.1</a>)<br>
This is a broadcast packet, and it should be forwarded on the other interfa=
ce of the bridge.<br>
<br>
What I have done to find the problem:<br>
<ul>
  <li>I have verified that both eth0 and eth1 on the bridge are well workin=
g in promiscuous mode.</li>
  <li>I have statically defined an arp entry for PC_A inside PC_B, and
an arp entry for PC_B inside PC_A; the result is that the ICMP packet
(ping) is well bridged through the two interfaces of the ARM platform.
Thus the problem is related to the arp resolution.<br>
  </li>
</ul>
<br>
If someone could help me, it would be great because I am completely
locked. Replacing the ARM by a standard PC make the things working.<br>
<br>
--L.Croisez.<br>

------=_Part_2466_25441109.1117445939662--
