Message-ID: <062c01c4f441$fdfc79d0$3e0010ac@esonet18>
From: "mdpeters" <michael.peters@lazarusalliance.com>
Date: Thu, 6 Jan 2005 17:49:34 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0629_01C4F418.1518B630"
Subject: [Bridge] Transparent bridge trouble
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

------=_NextPart_000_0629_01C4F418.1518B630
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I can only "see" arp traffic through the bridge. I imagine that I am doing =
something wrong but I am at a loss.

Kernel linux-2.6.5-1.358, Fedora Core 2.

#/sbin/lsmod
Module                  Size  Used by
ipt_state               5504  2
ip_conntrack           30348  1 ipt_state
ipv6                  214624  16
iptable_filter          6016  1
ip_tables              18048  2 ipt_state,iptable_filter
bridge                 32024  0
ip_queue               11672  0
autofs4                15488  0
sunrpc                110280  1
e1000                  73356  0
e100                   30852  0
mii                     7552  1 e100
sg                     32288  0
microcode              10400  0
dm_mod                 37536  0
button                  8472  0
battery                10892  0
asus_acpi              12440  0
ac                      7308  0
ext3                  108136  2
jbd                    50328  1 ext3
ata_piix                9348  3
libata                 33536  1 ata_piix,[permanent]
sd_mod                 20352  4
scsi_mod               97224  3 sg,libata,sd_mod

++++++++++++++++++++++++++++++++++++++++

This is my bridge setup:

/sbin/modprobe ip_queue
/sbin/ifconfig eth1 0.0.0.0
/sbin/ifconfig eth2 0.0.0.0
/usr/local/sbin/brctl addbr br0
/usr/local/sbin/brctl addif br0 eth1
/usr/local/sbin/brctl addif br0 eth2
/sbin/ifconfig br0 up
/usr/local/sbin/brctl stp br0 off
/sbin/ifconfig br0 0.0.0.0 -arp

++++++++++++++++++++++++++++++++++++++++

This is what my iptables setup looks like.

/usr/local/sbin/iptables -P FORWARD DROP
/usr/local/sbin/iptables -A FORWARD -p tcp --syn -m state --state NEW -j QU=
EUE
/usr/local/sbin/iptables -A FORWARD -p tcp -m state --state RELATED,ESTABLI=
SHED -j QUEUE
/usr/local/sbin/iptables -A FORWARD -p udp -j QUEUE
/usr/local/sbin/iptables -A FORWARD -p icmp -j QUEUE

#/usr/local/sbin/iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination

Chain FORWARD (policy DROP)
target     prot opt source               destination
QUEUE      all  --  anywhere             anywhere
QUEUE      tcp  --  anywhere             anywhere            tcp
flags:SYN,RST,ACK/SYN state NEW
QUEUE      tcp  --  anywhere             anywhere            state
RELATED,ESTABLISHED
QUEUE      udp  --  anywhere             anywhere
QUEUE      icmp --  anywhere             anywhere

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

++++++++++++++++++++++++++++++++++++++++

# /sbin/ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:11:11:50:EE:D2
          inet addr:172.16.200.211  Bcast:172.16.255.255  Mask:255.255.0.0
          inet6 addr: fe80::211:11ff:fe50:eed2/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:77160 errors:5 dropped:0 overruns:0 frame:5
          TX packets:38287 errors:0 dropped:0 overruns:0 carrier:3
          collisions:2126 txqueuelen:1000
          RX bytes:7950909 (7.5 Mb)  TX bytes:14485654 (13.8 Mb)

eth1      Link encap:Ethernet  HWaddr 00:04:23:AD:ED:BA
          inet6 addr: fe80::204:23ff:fead:edba/64 Scope:Link
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:413 errors:0 dropped:0 overruns:0 frame:0
          TX packets:673 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:31654 (30.9 Kb)  TX bytes:71099 (69.4 Kb)
          Base address:0xc800 Memory:ff8c0000-ff8e0000

eth2      Link encap:Ethernet  HWaddr 00:04:23:AD:ED:BB
          inet6 addr: fe80::204:23ff:fead:edbb/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:10067 errors:0 dropped:0 overruns:0 frame:0
          TX packets:190 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:741428 (724.0 Kb)  TX bytes:16514 (16.1 Kb)
          Base address:0xcc00 Memory:ff8e0000-ff900000

eth3      Link encap:Ethernet  HWaddr 00:04:23:AD:ED:D6
          inet6 addr: fe80::204:23ff:fead:edd6/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:398 (398.0 b)
          Base address:0xc000 Memory:ff780000-ff7a0000

eth4      Link encap:Ethernet  HWaddr 00:04:23:AD:ED:D7
          inet6 addr: fe80::204:23ff:fead:edd7/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1429283 errors:1835 dropped:0 overruns:0 frame:1835
          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:307722248 (293.4 Mb)  TX bytes:398 (398.0 b)
          Base address:0xc400 Memory:ff7a0000-ff7c0000

eth5      Link encap:Ethernet  HWaddr 00:04:23:AD:ED:A8
          inet6 addr: fe80::204:23ff:fead:eda8/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:164 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:11008 (10.7 Kb)  TX bytes:398 (398.0 b)
          Base address:0xb800 Memory:ff640000-ff660000

eth6      Link encap:Ethernet  HWaddr 00:04:23:AD:ED:A9
          inet6 addr: fe80::204:23ff:fead:eda9/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:9078 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:898198 (877.1 Kb)  TX bytes:398 (398.0 b)
          Base address:0xbc00 Memory:ff660000-ff680000

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:107 errors:0 dropped:0 overruns:0 frame:0
          TX packets:107 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:14503 (14.1 Kb)  TX bytes:14503 (14.1 Kb)

br0      Link encap:Ethernet  HWaddr 00:04:23:AD:ED:BA
          inet6 addr: fe80::204:23ff:fead:edba/64 Scope:Link
          UP BROADCAST RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:9861 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:506916 (495.0 Kb)  TX bytes:210 (210.0 b)

sit0      Link encap:IPv6-in-IPv4
          NOARP  MTU:1480  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

++++++++++++++++++++++++++++++++++++++++

Am I missing something? I appreciate tremendously your help.

Best regards,

Michael D. Peters
Director of Security Services
CISSP
Lazarus Alliance Inc.
M: 502-767-3448
O: 502-231-8017 x8
H: 502-231-6923
F: 502-231-5347

michael.peters@lazarusalliance.com
www.lazarusalliance.com

------=_NextPart_000_0629_01C4F418.1518B630
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2523" name=3DGENERATOR>
<DEFANGED_style_0 </STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV>I can only "see" arp traffic through the bridge. I imagine that I am d=
oing=20
something wrong but I am at a loss.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Kernel linux-2.6.5-1.358, Fedora Core 2.</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>#/sbin/lsmod<BR>Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Size&nbsp; Used=20
by<BR>ipt_state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;=20
5504&nbsp;=20
2<BR>ip_conntrack&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
30348&nbsp; 1=20
ipt_state<BR>ipv6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
214624&nbsp;=20
16<BR>iptable_filter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
6016&nbsp;=20
1<BR>ip_tables&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;=20
18048&nbsp; 2=20
ipt_state,iptable_filter<BR>bridge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
32024&nbsp;=20
0<BR>ip_queue&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
11672&nbsp;=20
0<BR>autofs4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;=20
15488&nbsp;=20
0<BR>sunrpc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;=20
110280&nbsp;=20
1<BR>e1000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
73356&nbsp;=20
0<BR>e100&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
30852&nbsp;=20
0<BR>mii&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
7552&nbsp; 1=20
e100<BR>sg&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
32288&nbsp;=20
0<BR>microcode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;=20
10400&nbsp;=20
0<BR>dm_mod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
37536&nbsp;=20
0<BR>button&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
8472&nbsp;=20
0<BR>battery&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;=20
10892&nbsp;=20
0<BR>asus_acpi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;=20
12440&nbsp;=20
0<BR>ac&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
7308&nbsp;=20
0<BR>ext3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
108136&nbsp;=20
2<BR>jbd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
50328&nbsp; 1=20
ext3<BR>ata_piix&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
9348&nbsp;=20
3<BR>libata&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
33536&nbsp; 1=20
ata_piix,[permanent]<BR>sd_mod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
20352&nbsp;=20
4<BR>scsi_mod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
97224&nbsp; 3=20
sg,libata,sd_mod<BR><BR>++++++++++++++++++++++++++++++++++++++++<BR><BR>Thi=
s is=20
my bridge setup:<BR><BR>/sbin/modprobe ip_queue<BR>/sbin/ifconfig eth1=20
0.0.0.0<BR>/sbin/ifconfig eth2 0.0.0.0<BR>/usr/local/sbin/brctl addbr=20
br0<BR>/usr/local/sbin/brctl addif br0 eth1<BR>/usr/local/sbin/brctl addif =
br0=20
eth2<BR>/sbin/ifconfig br0 up<BR>/usr/local/sbin/brctl stp br0=20
off<BR>/sbin/ifconfig br0 0.0.0.0=20
-arp<BR><BR>++++++++++++++++++++++++++++++++++++++++<BR><BR>This is what my=
=20
iptables setup looks like.<BR><BR>/usr/local/sbin/iptables -P FORWARD=20
DROP<BR>/usr/local/sbin/iptables -A FORWARD -p tcp --syn -m state --state N=
EW -j=20
QUEUE<BR>/usr/local/sbin/iptables -A FORWARD -p tcp -m state --state=20
RELATED,ESTABLISHED -j QUEUE<BR>/usr/local/sbin/iptables -A FORWARD -p udp =
-j=20
QUEUE<BR>/usr/local/sbin/iptables -A FORWARD -p icmp -j=20
QUEUE<BR><BR>#/usr/local/sbin/iptables -L<BR>Chain INPUT (policy=20
ACCEPT)<BR>target&nbsp;&nbsp;&nbsp;&nbsp; prot opt=20
source&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;=20
destination<BR><BR>Chain FORWARD (policy DROP)<BR>target&nbsp;&nbsp;&nbsp;&=
nbsp;=20
prot opt=20
source&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;=20
destination<BR>QUEUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; all&nbsp; --&nbsp;=20
anywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
anywhere<BR>QUEUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcp&nbsp; --&nbsp;=20
anywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
anywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
tcp<BR>flags:SYN,RST,ACK/SYN state NEW<BR>QUEUE&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
tcp&nbsp; --&nbsp;=20
anywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
anywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
state<BR>RELATED,ESTABLISHED<BR>QUEUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udp&nbs=
p;=20
--&nbsp;=20
anywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
anywhere<BR>QUEUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; icmp --&nbsp;=20
anywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
anywhere<BR><BR>Chain OUTPUT (policy ACCEPT)<BR>target&nbsp;&nbsp;&nbsp;&nb=
sp;=20
prot opt=20
source&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;=20
destination<BR><BR>++++++++++++++++++++++++++++++++++++++++<BR><BR>#=20
/sbin/ifconfig -a<BR>eth0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link=20
encap:Ethernet&nbsp; HWaddr=20
00:11:11:50:EE:D2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 inet=20
addr:172.16.200.211&nbsp; Bcast:172.16.255.255&nbsp;=20
Mask:255.255.0.0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
inet6=20
addr: fe80::211:11ff:fe50:eed2/64=20
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP=20
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=20
packets:77160 errors:5 dropped:0 overruns:0=20
frame:5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX=20
packets:38287 errors:0 dropped:0 overruns:0=20
carrier:3<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
collisions:2126=20
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=
X=20
bytes:7950909 (7.5 Mb)&nbsp; TX bytes:14485654 (13.8=20
Mb)<BR><BR>eth1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; HWa=
ddr=20
00:04:23:AD:ED:BA<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
inet6 addr: fe80::204:23ff:fead:edba/64=20
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP=20
BROADCAST MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=20
packets:413 errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packet=
s:673=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisi=
ons:0=20
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=
X=20
bytes:31654 (30.9 Kb)&nbsp; TX bytes:71099 (69.4=20
Kb)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base=20
address:0xc800=20
Memory:ff8c0000-ff8e0000<BR><BR>eth2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link=20
encap:Ethernet&nbsp; HWaddr=20
00:04:23:AD:ED:BB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
inet6 addr: fe80::204:23ff:fead:edbb/64=20
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP=20
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=20
packets:10067 errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packet=
s:190=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisi=
ons:0=20
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=
X=20
bytes:741428 (724.0 Kb)&nbsp; TX bytes:16514 (16.1=20
Kb)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base=20
address:0xcc00=20
Memory:ff8e0000-ff900000<BR><BR>eth3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link=20
encap:Ethernet&nbsp; HWaddr=20
00:04:23:AD:ED:D6<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
inet6 addr: fe80::204:23ff:fead:edd6/64=20
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP=20
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packe=
ts:0=20
errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packet=
s:5=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisi=
ons:0=20
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=
X=20
bytes:0 (0.0 b)&nbsp; TX bytes:398 (398.0=20
b)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base address:0=
xc000=20
Memory:ff780000-ff7a0000<BR><BR>eth4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link=20
encap:Ethernet&nbsp; HWaddr=20
00:04:23:AD:ED:D7<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
inet6 addr: fe80::204:23ff:fead:edd7/64=20
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP=20
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=20
packets:1429283 errors:1835 dropped:0 overruns:0=20
frame:1835<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX=20
packets:5 errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisi=
ons:0=20
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=
X=20
bytes:307722248 (293.4 Mb)&nbsp; TX bytes:398 (398.0=20
b)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base address:0=
xc400=20
Memory:ff7a0000-ff7c0000<BR><BR>eth5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link=20
encap:Ethernet&nbsp; HWaddr=20
00:04:23:AD:ED:A8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
inet6 addr: fe80::204:23ff:fead:eda8/64=20
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP=20
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=20
packets:164 errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packet=
s:5=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisi=
ons:0=20
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=
X=20
bytes:11008 (10.7 Kb)&nbsp; TX bytes:398 (398.0=20
b)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base address:0=
xb800=20
Memory:ff640000-ff660000<BR><BR>eth6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link=20
encap:Ethernet&nbsp; HWaddr=20
00:04:23:AD:ED:A9<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
inet6 addr: fe80::204:23ff:fead:eda9/64=20
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP=20
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=20
packets:9078 errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packet=
s:5=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisi=
ons:0=20
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=
X=20
bytes:898198 (877.1 Kb)&nbsp; TX bytes:398 (398.0=20
b)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base address:0=
xbc00=20
Memory:ff660000-ff680000<BR><BR>lo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
Link encap:Local=20
Loopback<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inet=20
addr:127.0.0.1&nbsp;=20
Mask:255.0.0.0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in=
et6=20
addr: ::1/128=20
Scope:Host<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP LOO=
PBACK=20
RUNNING&nbsp; MTU:16436&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=20
packets:107 errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packet=
s:107=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisi=
ons:0=20
txqueuelen:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=
=20
bytes:14503 (14.1 Kb)&nbsp; TX bytes:14503 (14.1=20
Kb)<BR><BR>br0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; HWad=
dr=20
00:04:23:AD:ED:BA<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
inet6 addr: fe80::204:23ff:fead:edba/64=20
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP=20
BROADCAST RUNNING NOARP MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=20
packets:9861 errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packet=
s:3=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisi=
ons:0=20
txqueuelen:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=
=20
bytes:506916 (495.0 Kb)&nbsp; TX bytes:210 (210.0=20
b)<BR><BR>sit0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link=20
encap:IPv6-in-IPv4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
NOARP&nbsp; MTU:1480&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packe=
ts:0=20
errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packet=
s:0=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisi=
ons:0=20
txqueuelen:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=
=20
bytes:0 (0.0 b)&nbsp; TX bytes:0 (0.0=20
b)<BR><BR>++++++++++++++++++++++++++++++++++++++++<BR><BR>Am I missing=20
something? I appreciate tremendously your help.</DIV>
<DIV><FONT face=3DArial size=3D2><BR>Best regards,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Michael D. Peters<BR>Director of Security Services<BR>CISSP<BR>Lazarus=
=20
Alliance Inc.<BR>M: 502-767-3448<BR>O: 502-231-8017 x8<BR>H: 502-231-6923<B=
R>F:=20
502-231-5347</DIV>
<DIV>&nbsp;</DIV>
<DIV><A=20
href=3D"mailto:michael.peters@lazarusalliance.com">michael.peters@lazarusal=
liance.com</A><BR><A=20
href=3D"http://www.lazarusalliance.com">www.lazarusalliance.com</A><BR></FO=
NT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_0629_01C4F418.1518B630--
