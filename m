Return-Path: <estantep@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to;
	bh=vorBxSHyuwltZ29kq04c8NJiDYoqGmTdGHo8DV4QJfw=;
	b=IVHur+WrT5/qODcElb6TKnxVPLYKRoeOyQm+arlvpEDnLR8QLGQwrsvPvdPEhp0QXi
	R8jeg9j/N8R6VKEjVY3Scr7L4ECn3UP3zN/Uoa+LL7srlZjJmhwqruMYob8vKdkj4vZM
	1mWWF8TQF8lK1ZJcq82cn9vf9GljQF93U2FJQ6MkeAZ84oGah3iwG2Pu+NmWKMxTOfnm
	/y3YJ2MEvsUGrJdS/+qfM4+B5sn4nnU9Rojl2PRjCW+YTU4dryxNXze3AFsvq8y2hs6o
	3KvXe7HnLx7pr+aKEGtz2YrRHbHxYPUhXOVGTV6FirEXs1Aq8TVMW5TJSIaMgGVhkD80
	tVQw==
MIME-Version: 1.0
From: Paulo Estante <estantep@gmail.com>
Date: Sun, 20 Nov 2016 10:24:29 -0500
Message-ID: <CAPn5SsThX_d_0Y3m14vgU8bsy1+9uQ93ceLEJiaKXMQLOJyVMw@mail.gmail.com>
Content-Type: multipart/alternative; boundary=001a113ec9bca751bd0541bd220c
Subject: [Bridge] VLAN tag being incorreclty removed from ethernet frame
 when sent on the wire
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--001a113ec9bca751bd0541bd220c
Content-Type: text/plain; charset=UTF-8

Hello

I have the following setup:

+------------------------------------+
|  KVM CENTOS7 3.10.0-327.el7.x86_64 |
| +------+                           |  +--------+
| | VM1  |         +--------+        |  | SWITCH |
| | vio0-+--vnet0--+mytrunk0+--enp1s0+--+ TRUNK  |
| +------+         +--------+        |  |  PORT  |
+------------------------------------+  +--------+

The enp1s0 physical interface dump from ethtool is pasted at the end of
this email as well as brctl output and interfaces config (please scroll
down).

I am trying to achieve transparent VLAN bridging without defining any
subinterfaces on the KVM box. The goal is for the KVM box just forward
frames from physical port to VM and vice-versa. Any VM connected to
mytrunk0 should be able to use any VLAN ID without the hypervisor having to
be configured on it as well. The VMs (to be) connected to mytrunk0 will be
a part of several dozen VLANs therefore having to manually define one
bridge for each one of those just won't scale from a management perspective.

What I am seeing is:

0 - After KVM host boot i add enp1s0 to the bridge using the command "brctl
addif mytrunk0 enp1s0"

1 - VM1 (OpenBSD 6.0) is properly tagging packets out on vnet0 (tcpdump
output below):

# tcpdump -n -e -i vnet0
<...>
09:52:42.786031 52:54:00:40:24:a5 > Broadcast, ethertype 802.1Q (0x8100),
length 46: vlan 1000, p 3, ethertype ARP, Request who-has 10.0.0.19 tell
10.0.0.222, length 28

2 - enp2s0 tells me (INCORRECTLY) it is forwarding this packet out enp1s0
*WITH* the tag:
# tcpdump -n -e -i enp1s0
<...>
09:54:47.107468 52:54:00:40:24:a5 > Broadcast, ethertype 802.1Q (0x8100),
length 46: vlan 1000, p 3, ethertype ARP, Request who-has 10.0.0.19 tell
10.0.0.222, length 28

3 - Switch trunk port learns no MAC address on vlan 1000. As soon as I
configure the switch as ACCESS port I learn the VM MAC address. This tells
me the VLAN tag is being removed from the ethernet frame before sending it
to the switch. VM1 learns NO mac address from anywhere with switch being
configured either as trunk or access (makes no difference).

4 - I tried disabling all possible NIC offloads with ethtool with no luck.
It seems the NIC is somehow stripping the VLAN tag out of the packet before
putting on the wire.

# ethtool -K enp1s0 gro off gso off rxvlan off txvlan off rx off tx off sg
off rxhash off

5 - I also tried Ubuntu 16.04 and 16.10, and also tried replacing e1000e
NIC with a realtek one, getting the exact same results.

Any help figuring this out is greatly appreciated. Not sure I am
missing/skipping a step or if this is a bug.

Thank you

Paulo

# ethtool -i enp1s0
driver: e1000e
version: 3.2.5-k
firmware-version: 1.8-0
bus-info: 0000:01:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no

# ethtool -d enp1s0
MAC Registers
-------------
0x00000: CTRL (Device control register)  0x18100248
      Endian mode (buffers):             little
      Link reset:                        reset
      Set link up:                       1
      Invert Loss-Of-Signal:             no
      Receive flow control:              enabled
      Transmit flow control:             enabled
      VLAN mode:                         disabled
      Auto speed detect:                 disabled
      Speed select:                      1000Mb/s
      Force speed:                       no
      Force duplex:                      no
0x00008: STATUS (Device status register) 0x00080783
      Duplex:                            full
      Link up:                           link config
      TBI mode:                          disabled
      Link speed:                        1000Mb/s
      Bus type:                          PCI
      Bus speed:                         33MHz
      Bus width:                         32-bit
0x00100: RCTL (Receive control register) 0x0400801A
      Receiver:                          enabled
      Store bad packets:                 disabled
      Unicast promiscuous:               enabled
      Multicast promiscuous:             enabled
      Long packet:                       disabled
      Descriptor minimum threshold size: 1/2
      Broadcast accept mode:             accept
      VLAN filter:                       disabled
      Canonical form indicator:          disabled
      Discard pause frames:              filtered
      Pass MAC control frames:           don't pass
      Receive buffer size:               2048
0x02808: RDLEN (Receive desc length)     0x00001000
0x02810: RDH   (Receive desc head)       0x00000003
0x02818: RDT   (Receive desc tail)       0x00000000
0x02820: RDTR  (Receive delay timer)     0x00000020
0x00400: TCTL (Transmit ctrl register)   0x3103F0FA
      Transmitter:                       enabled
      Pad short packets:                 enabled
      Software XOFF Transmission:        disabled
      Re-transmit on late collision:     enabled
0x03808: TDLEN (Transmit desc length)    0x00001000
0x03810: TDH   (Transmit desc head)      0x00000003
0x03818: TDT   (Transmit desc tail)      0x00000003
0x03820: TIDV  (Transmit delay timer)    0x00000008
PHY type:                                unknown

# brctl show
bridge name bridge id STP enabled interfaces
mytrunk0 8000.6805ca4124ff no enp1s0
vnet0
# cat /etc/sysconfig/network-scripts/ifcfg-mytrunk0
DEVICE=mytrunk0
STP=no
TYPE=Bridge
BOOTPROTO=none
IPV4_FAILURE_FATAL=no
IPV6INIT=no
NAME=mytrunk0
ONBOOT=yes
NM_CONTROLLED=no

# cat /etc/sysconfig/network-scripts/ifcfg-enp1s0
TYPE=Ethernet
BOOTPROTO=none
DEFROUTE=yes
PEERDNS=yes
PEERROUTES=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=no
IPV6_AUTOCONF=no
IPV6_DEFROUTE=no
IPV6_PEERDNS=no
IPV6_PEERROUTES=no
IPV6_FAILURE_FATAL=no
NAME=enp1s0
DEVICE=enp1s0
ONBOOT=yes
BRIDGE=mytrunk0

# virsh dumpxml VM1
<...>
    <interface type='bridge'>
      <mac address='52:54:00:40:24:a5'/>
      <source bridge='mytrunk0'/>
      <target dev='vnet0'/>
      <model type='virtio'/>
      <alias name='net0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03'
function='0x0'/>
    </interface>

--001a113ec9bca751bd0541bd220c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello<br><br>I have the following setup:<br><font face=3D"=
monospace, monospace"><br>+------------------------------------+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>| =C2=A0KVM CENTOS7 3.10.0-327.el7.x86_64 |<br>=
| +------+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0+--------+<br>| | VM1 =C2=A0| =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 +--------+ =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0| SWITCH=
 |<br>| | vio0-+--vnet0--+mytrunk0+--enp1s0+--+ TRUNK =C2=A0|<br>| +------+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +--------+ =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0=
| =C2=A0PORT =C2=A0|<br>+------------------------------------+ =C2=A0+-----=
---+</font><br><br>The enp1s0 physical interface dump from ethtool is paste=
d at the end of this email as well as brctl output and interfaces config (p=
lease scroll down).<br><br>I am trying to achieve transparent VLAN bridging=
 without defining any subinterfaces on the KVM box. The goal is for the KVM=
 box just forward frames from physical port to VM and vice-versa. Any VM co=
nnected to mytrunk0 should be able to use any VLAN ID without the hyperviso=
r having to be configured on it as well. The VMs (to be) connected to mytru=
nk0 will be a part of several dozen VLANs therefore having to manually defi=
ne one bridge for each one of those just won&#39;t scale from a management =
perspective.<br><br>What I am seeing is:<br><br>0 - After KVM host boot i a=
dd enp1s0 to the bridge using the command &quot;brctl addif mytrunk0 enp1s0=
&quot;<br><br>1 - VM1 (OpenBSD 6.0) is properly tagging packets out on vnet=
0 (tcpdump output below):<br><br># tcpdump -n -e -i vnet0<br>&lt;...&gt;<br=
>09:52:42.786031 52:54:00:40:24:a5 &gt; Broadcast, ethertype 802.1Q (0x8100=
), length 46: vlan 1000, p 3, ethertype ARP, Request who-has 10.0.0.19 tell=
 10.0.0.222, length 28<br><br>2 - enp2s0 tells me (INCORRECTLY) it is forwa=
rding this packet out enp1s0 *WITH* the tag:<br># tcpdump -n -e -i enp1s0<b=
r>&lt;...&gt;<br>09:54:47.107468 52:54:00:40:24:a5 &gt; Broadcast, ethertyp=
e 802.1Q (0x8100), length 46: vlan 1000, p 3, ethertype ARP, Request who-ha=
s 10.0.0.19 tell 10.0.0.222, length 28<br><br>3 - Switch trunk port learns =
no MAC address on vlan 1000. As soon as I configure the switch as ACCESS po=
rt I learn the VM MAC address. This tells me the VLAN tag is being removed =
from the ethernet frame before sending it to the switch. VM1 learns NO mac =
address from anywhere with switch being configured either as trunk or acces=
s (makes no difference).<br><br>4 - I tried disabling all possible NIC offl=
oads with ethtool with no luck. It seems the NIC is somehow stripping the V=
LAN tag out of the packet before putting on the wire.<br><br># ethtool -K e=
np1s0 gro off gso off rxvlan off txvlan off rx off tx off sg off rxhash off=
<br><br>5 - I also tried Ubuntu 16.04 and 16.10, and also tried replacing e=
1000e NIC with a realtek one, getting the exact same results.<br><br>Any he=
lp figuring this out is greatly appreciated. Not sure I am missing/skipping=
 a step or if this is a bug.<br><br>Thank you<br><br>Paulo<br><br># ethtool=
 -i enp1s0<br>driver: e1000e<br>version: 3.2.5-k<br>firmware-version: 1.8-0=
<br>bus-info: 0000:01:00.0<br>supports-statistics: yes<br>supports-test: ye=
s<br>supports-eeprom-access: yes<br>supports-register-dump: yes<br>supports=
-priv-flags: no<br><br># ethtool -d enp1s0<br>MAC Registers<br>------------=
-<br>0x00000: CTRL (Device control register) =C2=A00x18100248<br>=C2=A0 =C2=
=A0 =C2=A0 Endian mode (buffers): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 little<br>=C2=A0 =C2=A0 =C2=A0 Link reset: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reset<br>=C2=A0 =C2=A0 =
=C2=A0 Set link up: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 1<br>=C2=A0 =C2=A0 =C2=A0 Invert Loss-Of-Signal: =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no<br>=C2=A0 =C2=A0 =C2=A0 Receive f=
low control: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enabled<br>=C2=
=A0 =C2=A0 =C2=A0 Transmit flow control: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 enabled<br>=C2=A0 =C2=A0 =C2=A0 VLAN mode: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disabled<br>=C2=
=A0 =C2=A0 =C2=A0 Auto speed detect: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 disabled<br>=C2=A0 =C2=A0 =C2=A0 Speed select: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000Mb/s<=
br>=C2=A0 =C2=A0 =C2=A0 Force speed: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no<br>=C2=A0 =C2=A0 =C2=A0 Force dup=
lex: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0no<br>0x00008: STATUS (Device status register) 0x00080783<br>=C2=A0 =
=C2=A0 =C2=A0 Duplex: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0full<br>=C2=A0 =C2=A0 =C2=A0 L=
ink up: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 link config<br>=C2=A0 =C2=A0 =C2=A0 TBI mode: =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0disabled<br>=C2=A0 =C2=A0 =C2=A0 Link speed: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000Mb/s<=
br>=C2=A0 =C2=A0 =C2=A0 Bus type: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI<br>=C2=A0 =C2=A0 =C2=
=A0 Bus speed: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 33MHz<br>=C2=A0 =C2=A0 =C2=A0 Bus width: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 32-bit<br>0x00100: RCTL (Receive control register) 0x0400801A<br>=C2=A0=
 =C2=A0 =C2=A0 Receiver: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enabled<br>=C2=A0 =C2=A0 =C2=A0 St=
ore bad packets: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 di=
sabled<br>=C2=A0 =C2=A0 =C2=A0 Unicast promiscuous: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enabled<br>=C2=A0 =C2=A0 =C2=A0 Multicast promi=
scuous: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enabled<br>=C2=A0 =C2=A0 =
=C2=A0 Long packet: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 disabled<br>=C2=A0 =C2=A0 =C2=A0 Descriptor minimum t=
hreshold size: 1/2<br>=C2=A0 =C2=A0 =C2=A0 Broadcast accept mode: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 accept<br>=C2=A0 =C2=A0 =C2=A0 VLAN filt=
er: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 disabled<br>=C2=A0 =C2=A0 =C2=A0 Canonical form indicator: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0disabled<br>=C2=A0 =C2=A0 =C2=A0 Discard pause f=
rames: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filtered<br>=C2=A0 =
=C2=A0 =C2=A0 Pass MAC control frames: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d=
on&#39;t pass<br>=C2=A0 =C2=A0 =C2=A0 Receive buffer size: =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2048<br>0x02808: RDLEN (Receive desc len=
gth) =C2=A0 =C2=A0 0x00001000<br>0x02810: RDH =C2=A0 (Receive desc head) =
=C2=A0 =C2=A0 =C2=A0 0x00000003<br>0x02818: RDT =C2=A0 (Receive desc tail) =
=C2=A0 =C2=A0 =C2=A0 0x00000000<br>0x02820: RDTR =C2=A0(Receive delay timer=
) =C2=A0 =C2=A0 0x00000020<br>0x00400: TCTL (Transmit ctrl register) =C2=A0=
 0x3103F0FA<br>=C2=A0 =C2=A0 =C2=A0 Transmitter: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enabled<br>=C2=A0 =C2=
=A0 =C2=A0 Pad short packets: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 enabled<br>=C2=A0 =C2=A0 =C2=A0 Software XOFF Transmission: =C2=
=A0 =C2=A0 =C2=A0 =C2=A0disabled<br>=C2=A0 =C2=A0 =C2=A0 Re-transmit on lat=
e collision: =C2=A0 =C2=A0 enabled<br>0x03808: TDLEN (Transmit desc length)=
 =C2=A0 =C2=A00x00001000<br>0x03810: TDH =C2=A0 (Transmit desc head) =C2=A0=
 =C2=A0 =C2=A00x00000003<br>0x03818: TDT =C2=A0 (Transmit desc tail) =C2=A0=
 =C2=A0 =C2=A00x00000003<br>0x03820: TIDV =C2=A0(Transmit delay timer) =C2=
=A0 =C2=A00x00000008<br>PHY type: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unkno=
wn<br><br># brctl show<br>bridge name bridge id STP enabled interfaces<br>m=
ytrunk0 8000.6805ca4124ff no enp1s0<br>vnet0<br># cat /etc/sysconfig/networ=
k-scripts/ifcfg-mytrunk0 <br>DEVICE=3Dmytrunk0<br>STP=3Dno<br>TYPE=3DBridge=
<br>BOOTPROTO=3Dnone<br>IPV4_FAILURE_FATAL=3Dno<br>IPV6INIT=3Dno<br>NAME=3D=
mytrunk0<br>ONBOOT=3Dyes<br>NM_CONTROLLED=3Dno<br><br># cat /etc/sysconfig/=
network-scripts/ifcfg-enp1s0<br>TYPE=3DEthernet<br>BOOTPROTO=3Dnone<br>DEFR=
OUTE=3Dyes<br>PEERDNS=3Dyes<br>PEERROUTES=3Dyes<br>IPV4_FAILURE_FATAL=3Dno<=
br>IPV6INIT=3Dno<br>IPV6_AUTOCONF=3Dno<br>IPV6_DEFROUTE=3Dno<br>IPV6_PEERDN=
S=3Dno<br>IPV6_PEERROUTES=3Dno<br>IPV6_FAILURE_FATAL=3Dno<br>NAME=3Denp1s0<=
br>DEVICE=3Denp1s0<br>ONBOOT=3Dyes<br>BRIDGE=3Dmytrunk0<br><br># virsh dump=
xml VM1<br>&lt;...&gt;<br>=C2=A0 =C2=A0 &lt;interface type=3D&#39;bridge&#3=
9;&gt;<br>=C2=A0 =C2=A0 =C2=A0 &lt;mac address=3D&#39;52:54:00:40:24:a5&#39=
;/&gt;<br>=C2=A0 =C2=A0 =C2=A0 &lt;source bridge=3D&#39;mytrunk0&#39;/&gt;<=
br>=C2=A0 =C2=A0 =C2=A0 &lt;target dev=3D&#39;vnet0&#39;/&gt;<br>=C2=A0 =C2=
=A0 =C2=A0 &lt;model type=3D&#39;virtio&#39;/&gt;<br>=C2=A0 =C2=A0 =C2=A0 &=
lt;alias name=3D&#39;net0&#39;/&gt;<br>=C2=A0 =C2=A0 =C2=A0 &lt;address typ=
e=3D&#39;pci&#39; domain=3D&#39;0x0000&#39; bus=3D&#39;0x00&#39; slot=3D&#3=
9;0x03&#39; function=3D&#39;0x0&#39;/&gt;<br>=C2=A0 =C2=A0 &lt;/interface&g=
t;<br></div>

--001a113ec9bca751bd0541bd220c--
