Date: Thu, 6 Jan 2005 13:32:29 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050106133229.39dc4ce5@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart_Thu__6_Jan_2005_13_32_29_-0800_pwelz6P74RMEAnz+"
Subject: [Bridge] Fw: Bridge setup problems
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

This is a multi-part message in MIME format...

--Multipart_Thu__6_Jan_2005_13_32_29_-0800_pwelz6P74RMEAnz+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



Begin forwarded message:

Date: Thu, 6 Jan 2005 15:40:03 -0500
From: "mdpeters" <michael.peters@lazarusalliance.com>
To: <shemminger@osdl.org>
Subject: Mailing list?


Hello Stephen,

I tried to subscribe but the mailman process reject it as an expired request.

I'm having trouble getting a transparent bridge set up and I am seeking assistance. Can you help?

This is what I know for sure:

Kernel linux-2.6.5-1.358, Fedora Core 2.

I can only "see" arp traffic through the bridge. 

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
/usr/local/sbin/iptables -A FORWARD -p tcp --syn -m state --state NEW -j QUEUE
/usr/local/sbin/iptables -A FORWARD -p tcp -m state --state RELATED,ESTABLISHED -j QUEUE
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

--Multipart_Thu__6_Jan_2005_13_32_29_-0800_pwelz6P74RMEAnz+
Content-Type: text/html; name=
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<META content="MSHTML 6.00.2900.2523" name=GENERATOR>
<DEFANGED_style_0 </STYLE>
</HEAD>
<BODY bgColor=#ffffff>
<DIV><FONT face=Arial size=2>Hello Stephen,</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>I tried to subscribe but the mailman process reject 
it as an expired request. I'm&nbsp;having trouble getting a transparent bridge 
set up and I am seeking assistance. Can you help?</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>This is what I know for sure:</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV>Kernel linux-2.6.5-1.358, Fedora Core 2.</DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>I can only "see" arp traffic through the 
bridge.&nbsp;</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV>#/sbin/lsmod<BR>Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
Size&nbsp; Used 
by<BR>ipt_state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
5504&nbsp; 
2<BR>ip_conntrack&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
30348&nbsp; 1 
ipt_state<BR>ipv6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
214624&nbsp; 
16<BR>iptable_filter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
6016&nbsp; 
1<BR>ip_tables&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
18048&nbsp; 2 
ipt_state,iptable_filter<BR>bridge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
32024&nbsp; 
0<BR>ip_queue&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
11672&nbsp; 
0<BR>autofs4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
15488&nbsp; 
0<BR>sunrpc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
110280&nbsp; 
1<BR>e1000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
73356&nbsp; 
0<BR>e100&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
30852&nbsp; 
0<BR>mii&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
7552&nbsp; 1 
e100<BR>sg&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
32288&nbsp; 
0<BR>microcode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
10400&nbsp; 
0<BR>dm_mod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
37536&nbsp; 
0<BR>button&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
8472&nbsp; 
0<BR>battery&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
10892&nbsp; 
0<BR>asus_acpi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
12440&nbsp; 
0<BR>ac&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
7308&nbsp; 
0<BR>ext3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
108136&nbsp; 
2<BR>jbd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
50328&nbsp; 1 
ext3<BR>ata_piix&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
9348&nbsp; 
3<BR>libata&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
33536&nbsp; 1 
ata_piix,[permanent]<BR>sd_mod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
20352&nbsp; 
4<BR>scsi_mod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
97224&nbsp; 3 
sg,libata,sd_mod<BR><BR>++++++++++++++++++++++++++++++++++++++++<BR><BR>This is 
my bridge setup:<BR><BR>/sbin/modprobe ip_queue<BR>/sbin/ifconfig eth1 
0.0.0.0<BR>/sbin/ifconfig eth2 0.0.0.0<BR>/usr/local/sbin/brctl addbr 
br0<BR>/usr/local/sbin/brctl addif br0 eth1<BR>/usr/local/sbin/brctl addif br0 
eth2<BR>/sbin/ifconfig br0 up<BR>/usr/local/sbin/brctl stp br0 
off<BR>/sbin/ifconfig br0 0.0.0.0 
-arp<BR><BR>++++++++++++++++++++++++++++++++++++++++<BR><BR>This is what my 
iptables setup looks like.<BR><BR>/usr/local/sbin/iptables -P FORWARD 
DROP<BR>/usr/local/sbin/iptables -A FORWARD -p tcp --syn -m state --state NEW -j 
QUEUE<BR>/usr/local/sbin/iptables -A FORWARD -p tcp -m state --state 
RELATED,ESTABLISHED -j QUEUE<BR>/usr/local/sbin/iptables -A FORWARD -p udp -j 
QUEUE<BR>/usr/local/sbin/iptables -A FORWARD -p icmp -j 
QUEUE<BR><BR>#/usr/local/sbin/iptables -L<BR>Chain INPUT (policy 
ACCEPT)<BR>target&nbsp;&nbsp;&nbsp;&nbsp; prot opt 
source&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
destination<BR><BR>Chain FORWARD (policy DROP)<BR>target&nbsp;&nbsp;&nbsp;&nbsp; 
prot opt 
source&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
destination<BR>QUEUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; all&nbsp; --&nbsp; 
anywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
anywhere<BR>QUEUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcp&nbsp; --&nbsp; 
anywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
anywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
tcp<BR>flags:SYN,RST,ACK/SYN state NEW<BR>QUEUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
tcp&nbsp; --&nbsp; 
anywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
anywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
state<BR>RELATED,ESTABLISHED<BR>QUEUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udp&nbsp; 
--&nbsp; 
anywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
anywhere<BR>QUEUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; icmp --&nbsp; 
anywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
anywhere<BR><BR>Chain OUTPUT (policy ACCEPT)<BR>target&nbsp;&nbsp;&nbsp;&nbsp; 
prot opt 
source&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
destination<BR><BR>++++++++++++++++++++++++++++++++++++++++<BR><BR># 
/sbin/ifconfig -a<BR>eth0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link 
encap:Ethernet&nbsp; HWaddr 
00:11:11:50:EE:D2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inet 
addr:172.16.200.211&nbsp; Bcast:172.16.255.255&nbsp; 
Mask:255.255.0.0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inet6 
addr: fe80::211:11ff:fe50:eed2/64 
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP 
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp; 
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
packets:77160 errors:5 dropped:0 overruns:0 
frame:5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX 
packets:38287 errors:0 dropped:0 overruns:0 
carrier:3<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
collisions:2126 
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
bytes:7950909 (7.5 Mb)&nbsp; TX bytes:14485654 (13.8 
Mb)<BR><BR>eth1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; HWaddr 
00:04:23:AD:ED:BA<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
inet6 addr: fe80::204:23ff:fead:edba/64 
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP 
BROADCAST MULTICAST&nbsp; MTU:1500&nbsp; 
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
packets:413 errors:0 dropped:0 overruns:0 
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:673 
errors:0 dropped:0 overruns:0 
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
bytes:31654 (30.9 Kb)&nbsp; TX bytes:71099 (69.4 
Kb)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base 
address:0xc800 
Memory:ff8c0000-ff8e0000<BR><BR>eth2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link 
encap:Ethernet&nbsp; HWaddr 
00:04:23:AD:ED:BB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
inet6 addr: fe80::204:23ff:fead:edbb/64 
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP 
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp; 
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
packets:10067 errors:0 dropped:0 overruns:0 
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:190 
errors:0 dropped:0 overruns:0 
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
bytes:741428 (724.0 Kb)&nbsp; TX bytes:16514 (16.1 
Kb)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base 
address:0xcc00 
Memory:ff8e0000-ff900000<BR><BR>eth3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link 
encap:Ethernet&nbsp; HWaddr 
00:04:23:AD:ED:D6<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
inet6 addr: fe80::204:23ff:fead:edd6/64 
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP 
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp; 
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packets:0 
errors:0 dropped:0 overruns:0 
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:5 
errors:0 dropped:0 overruns:0 
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
bytes:0 (0.0 b)&nbsp; TX bytes:398 (398.0 
b)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base address:0xc000 
Memory:ff780000-ff7a0000<BR><BR>eth4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link 
encap:Ethernet&nbsp; HWaddr 
00:04:23:AD:ED:D7<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
inet6 addr: fe80::204:23ff:fead:edd7/64 
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP 
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp; 
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
packets:1429283 errors:1835 dropped:0 overruns:0 
frame:1835<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX 
packets:5 errors:0 dropped:0 overruns:0 
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
bytes:307722248 (293.4 Mb)&nbsp; TX bytes:398 (398.0 
b)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base address:0xc400 
Memory:ff7a0000-ff7c0000<BR><BR>eth5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link 
encap:Ethernet&nbsp; HWaddr 
00:04:23:AD:ED:A8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
inet6 addr: fe80::204:23ff:fead:eda8/64 
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP 
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp; 
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
packets:164 errors:0 dropped:0 overruns:0 
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:5 
errors:0 dropped:0 overruns:0 
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
bytes:11008 (10.7 Kb)&nbsp; TX bytes:398 (398.0 
b)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base address:0xb800 
Memory:ff640000-ff660000<BR><BR>eth6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link 
encap:Ethernet&nbsp; HWaddr 
00:04:23:AD:ED:A9<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
inet6 addr: fe80::204:23ff:fead:eda9/64 
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP 
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp; 
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
packets:9078 errors:0 dropped:0 overruns:0 
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:5 
errors:0 dropped:0 overruns:0 
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
bytes:898198 (877.1 Kb)&nbsp; TX bytes:398 (398.0 
b)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base address:0xbc00 
Memory:ff660000-ff680000<BR><BR>lo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
Link encap:Local 
Loopback<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inet 
addr:127.0.0.1&nbsp; 
Mask:255.0.0.0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inet6 
addr: ::1/128 
Scope:Host<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP LOOPBACK 
RUNNING&nbsp; MTU:16436&nbsp; 
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
packets:107 errors:0 dropped:0 overruns:0 
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:107 
errors:0 dropped:0 overruns:0 
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 
txqueuelen:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
bytes:14503 (14.1 Kb)&nbsp; TX bytes:14503 (14.1 
Kb)<BR><BR>br0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; HWaddr 
00:04:23:AD:ED:BA<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
inet6 addr: fe80::204:23ff:fead:edba/64 
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP 
BROADCAST RUNNING NOARP MULTICAST&nbsp; MTU:1500&nbsp; 
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
packets:9861 errors:0 dropped:0 overruns:0 
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:3 
errors:0 dropped:0 overruns:0 
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 
txqueuelen:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
bytes:506916 (495.0 Kb)&nbsp; TX bytes:210 (210.0 
b)<BR><BR>sit0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link 
encap:IPv6-in-IPv4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
NOARP&nbsp; MTU:1480&nbsp; 
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packets:0 
errors:0 dropped:0 overruns:0 
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:0 
errors:0 dropped:0 overruns:0 
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 
txqueuelen:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX 
bytes:0 (0.0 b)&nbsp; TX bytes:0 (0.0 
b)<BR><BR>++++++++++++++++++++++++++++++++++++++++<BR><BR>Am I missing 
something? I appreciate tremendously your help.</DIV>
<DIV><FONT face=Arial size=2><BR>Best regards,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Michael D. Peters<BR>Director of Security Services<BR>CISSP<BR>Lazarus 
Alliance Inc.<BR>M: 502-767-3448<BR>O: 502-231-8017 x8<BR>H: 502-231-6923<BR>F: 
502-231-5347</DIV>
<DIV>&nbsp;</DIV>
<DIV><A 
href="mailto:michael.peters@lazarusalliance.com">michael.peters@lazarusalliance.com</A><BR><A 
href="http://www.lazarusalliance.com">www.lazarusalliance.com</A><BR></FONT></DIV></BODY></HTML>

--Multipart_Thu__6_Jan_2005_13_32_29_-0800_pwelz6P74RMEAnz+--
