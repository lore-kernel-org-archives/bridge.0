Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C631DA.25D779F0"
Date: Tue, 14 Feb 2006 18:47:22 -0800
Message-ID: <57F9959B46E0FA4D8BA88AEDFBE5829016734A@pxtbenexd01.pxt.primeexalia.com>
From: "Gary W. Smith" <gary@primeexalia.com>
Subject: [Bridge] Error while trying to setup bridge, appears to be a loop
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C631DA.25D779F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,=20

I've been trying to implement a bridge in place for a clustered firewall
at one of our office locations.  Currently we NAT two class C's
internally.  We decided, for performance reasons, that it would make
sense to put our servers into an official DMZ.  So we started this
bridging project.  Our goal is to have two redundant firewalls in place.
There is no need for active/active.  The current firewalls are running
Linux-HA happily.

We setup a single node and tried to setup a bridge and ran into problems
(please note, this isn't production but rather only testing at this
point).  Here is our general configuration.

eth0 public, 100mb
eth1 heartbeat for HA, private IP, 100mb
eth2 DMZ, 1GB
eth3 LAN, 1GB

We have setup a fake set of IP's for our internal environment
(58.100.1-31.0 split /24).  Interfaces eth0 and eth2 have no IP as they
will constitute the bridge, eth3 has 10.0.8.253.=20

After the machine has started, we login and start the bridge manually.
Sitting idle, the bridge will start to spew errors in the message log
(logged below) about received packet with own address as source address.
Looking around on the net it appears that there is a loop somewhere.
Interfaces eth0 and eth2 are on their own switches.  We tried using VLAN
but put eth2 on it's own switch to rule out the switch itself.=20=20

The errors show in the tcpdump spew as fast as the screen can write
15-30 seconds after I issue an ifconfig DMZ up.  On the LAN side we have
a single workstation, in the DMZ (or the eth2 side of the DMZ) there is
currently nothing.

Any help would be greatly appreciated.

brctl addbr DMZ
brctl addif DMZ eth0
brctl addif DMZ eth2
ifconfig DMZ up
ip addr add 58.100.13.253/24 dev DMZ
route add -net 0/0 gw 58.100.13.1 metric 0


ip addr
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue=20
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
    inet6 ::1/128 scope host=20
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:07:e9:82:67:2a brd ff:ff:ff:ff:ff:ff
    inet6 fe80::207:e9ff:fe82:672a/64 scope link=20
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:07:e9:82:67:2b brd ff:ff:ff:ff:ff:ff
    inet 10.254.254.253/29 brd 10.254.254.255 scope global eth1
    inet6 fe80::207:e9ff:fe82:672b/64 scope link=20
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:04:23:c1:fa:36 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::204:23ff:fec1:fa36/64 scope link tentative=20
       valid_lft forever preferred_lft forever
5: eth3: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:04:23:c1:fa:37 brd ff:ff:ff:ff:ff:ff
    inet 10.0.8.254/24 scope global secondary eth3
    inet6 fe80::204:23ff:fec1:fa37/64 scope link=20
       valid_lft forever preferred_lft forever
6: sit0: <NOARP> mtu 1480 qdisc noop=20
    link/sit 0.0.0.0 brd 0.0.0.0
7: DMZ: <BROADCAST,MULTICAST> mtu 1500 qdisc noqueue=20
    link/ether 00:04:23:c1:fa:36 brd ff:ff:ff:ff:ff:ff
    inet 58.100.13.253/24 scope global DMZ

brctl showstp DMZ
DMZ
 bridge id              8000.000423c1fa36
 designated root        8000.000423c1fa36
 root port                 0                    path cost
0
 max age                  19.99                 bridge max age
19.99
 hello time                1.99                 bridge hello time
1.99
 forward delay            14.99                 bridge forward delay
14.99
 ageing time             299.95
 hello timer               0.00                 tcn timer
0.00
 topology change timer     0.00                 gc timer
239.83
 flags


eth0 (2)
 port id                8002                    state
disabled
 designated root        8000.000423c1fa36       path cost
19
 designated bridge      8000.000423c1fa36       message age timer
0.00
 designated port        8002                    forward delay timer
0.00
 designated cost           0                    hold timer
0.00
 flags

eth2 (1)
 port id                8001                    state
disabled
 designated root        8000.000423c1fa36       path cost
19
 designated bridge      8000.000423c1fa36       message age timer
0.00
 designated port        8001                    forward delay timer
0.00
 designated cost           0                    hold timer
0.00
 flags


tcpdump -i eth2
18:23:28.964574 IP 58.100.13.253.24462 > 239.255.255.250.1900: UDP,
length 242
...
18:23:28.967746 IP 58.100.13.253.24470 > 239.255.255.250.1900: UDP,
length 322


/var/log/messages
Feb 14 18:11:08 testfw01b kernel: printk: 3 messages suppressed.
Feb 14 18:11:08 testfw01b kernel: eth2: received packet with  own
address as source address
Feb 14 18:11:12 testfw01b kernel: printk: 5 messages suppressed.
Feb 14 18:11:12 testfw01b kernel: eth2: received packet with  own
address as source address

------_=_NextPart_001_01C631DA.25D779F0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7226.0">
<TITLE>Error while trying to setup bridge, appears to be a loop</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Hello,</=
FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> </SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">I</FONT>=
</SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=
=3D"Arial">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"e=
n-us"><FONT SIZE=3D2 FACE=3D"Arial">ve been trying to implement a bridge in=
 place for a clustered firewall at one of our office locations.&nbsp; Curre=
ntly we NAT two class C</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=
=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&#8217;</FONT></SPAN><SPAN LANG=3D=
"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">s interna=
lly.&nbsp; We decided, for performance reasons, that it would make sense to=
 put our servers into an official DMZ.&nbsp; So we started this bridging pr=
oject.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">&nbsp; Our goal is to have two redundant firewalls =
in place.&nbsp; There is no need for active/active.&nbsp; The current firew=
alls are running Linux-HA happily.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">We setup=
 a single node and tried to setup a bridge and ran into problems (please no=
te, this isn</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us">=
<FONT SIZE=3D2 FACE=3D"Arial">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"></S=
PAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">t production but rat=
her only testing at this point).</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><=
SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; Here is our genera=
l</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=
=3D2 FACE=3D"Arial">configuration</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN>=
<SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">eth0 pub=
lic</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZ=
E=3D2 FACE=3D"Arial">, 100mb</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN=
 LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">eth1 hea=
rtbeat for HA, private IP</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LA=
NG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">, 100mb</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">eth2 DMZ=
, 1GB</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">eth3 LAN=
, 1GB</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">We have =
setup a fake set of IP</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=
=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&#8217;</FONT></SPAN><SPAN LANG=3D=
"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">s for our=
 internal environment (58.100.1-31.0 split /24).</FONT></SPAN><SPAN LANG=3D=
"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; In=
terfaces eth0 and eth2 have no IP as they will constitute the bridge, eth3 =
has 10.0.8.253.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-u=
s"> </SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">After th=
e machine has started, we login and</FONT></SPAN><SPAN LANG=3D"en-us"></SPA=
N><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"> start the bridge manu=
ally.&nbsp; Sitting idle, the bridge will start to spew errors in the messa=
ge log (logged below) about</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">received packet with own addr=
ess as source address</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=
=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">.&nbsp; Looking around on the net =
it appears that there is a loop somewhere.&nbsp; Interfaces eth0 and eth2 a=
re on their own switches.&nbsp; We tried using VLAN but put eth2 on it</FON=
T></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FA=
CE=3D"Arial">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D=
"en-us"><FONT SIZE=3D2 FACE=3D"Arial">s own switch to rule out the switch i=
tself.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">&nbsp; </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">The erro=
rs show in the tcpdump spew as fast as the screen can write</FONT></SPAN><S=
PAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Aria=
l">15-30 seconds after I issue an ifconfig DMZ up.&nbsp; On the LAN side we=
 have a single workstation, in the DMZ (or the eth2 side of the DMZ) there =
is currently nothing</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D=
"en-us"><FONT SIZE=3D2 FACE=3D"Arial">.</FONT></SPAN><SPAN LANG=3D"en-us"><=
/SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Any help=
 would be greatly appreciated.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">brctl ad=
dbr DMZ</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">brctl ad=
dif DMZ eth0</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">brctl ad=
dif DMZ eth2</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">ifconfig=
 DMZ up</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">ip addr =
add 58.100.13.253/24 dev DMZ</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">route ad=
d -net 0/0 gw 58.100.13.1 metric 0</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN=
><SPAN LANG=3D"en-us"></SPAN></P>
<BR>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">ip addr<=
/FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">1: lo: &=
lt;LOOPBACK,UP&gt; mtu 16436 qdisc noqueue </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00</FONT></SP=
AN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; inet 127.0.0.1/8 brd 127.255.255.255 scope host lo</FONT></SPAN>=
</P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; inet6 ::1/128 scope host </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; valid_lft forever preferred_lft forever</FONT>=
</SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">2: eth0:=
 &lt;BROADCAST,MULTICAST,UP&gt; mtu 1500 qdisc pfifo_fast qlen 1000</FONT><=
/SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; link/ether 00:07:e9:82:67:2a brd ff:ff:ff:ff:ff:ff</FONT></SPAN>=
</P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; inet6 fe80::207:e9ff:fe82:672a/64 scope link </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; valid_lft forever preferred_lft forever</FONT>=
</SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">3: eth1:=
 &lt;BROADCAST,MULTICAST,UP&gt; mtu 1500 qdisc pfifo_fast qlen 1000</FONT><=
/SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; link/ether 00:07:e9:82:67:2b brd ff:ff:ff:ff:ff:ff</FONT></SPAN>=
</P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; inet 10.254.254.253/29 brd 10.254.254.255 scope global eth1</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; inet6 fe80::207:e9ff:fe82:672b/64 scope link </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; valid_lft forever preferred_lft forever</FONT>=
</SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">4: eth2:=
 &lt;BROADCAST,MULTICAST,UP&gt; mtu 1500 qdisc pfifo_fast qlen 1000</FONT><=
/SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; link/ether 00:04:23:c1:fa:36 brd ff:ff:ff:ff:ff:ff</FONT></SPAN>=
</P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; inet6 fe80::204:23ff:fec1:fa36/64 scope link tentative </FONT></=
SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; valid_lft forever preferred_lft forever</FONT>=
</SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">5: eth3:=
 &lt;BROADCAST,MULTICAST,UP&gt; mtu 1500 qdisc pfifo_fast qlen 1000</FONT><=
/SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; link/ether 00:04:23:c1:fa:37 brd ff:ff:ff:ff:ff:ff</FONT></SPAN>=
</P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; inet 10.0.8.254/24 scope global secondary eth3</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; inet6 fe80::204:23ff:fec1:fa37/64 scope link </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; valid_lft forever preferred_lft forever</FONT>=
</SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">6: sit0:=
 &lt;NOARP&gt; mtu 1480 qdisc noop </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; link/sit 0.0.0.0 brd 0.0.0.0</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">7: DMZ: =
&lt;BROADCAST,MULTICAST&gt; mtu 1500 qdisc noqueue </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; link/ether 00:04:23:c1:fa:36 brd ff:ff:ff:ff:ff:ff</FONT></SPAN>=
</P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&n=
bsp;&nbsp; inet 58.100.13.253/24 scope global DMZ</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">brctl sh=
owstp DMZ</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">DMZ</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;br=
idge id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 8000.000423c1fa36</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;de=
signated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.000423c1fa36</=
FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;ro=
ot port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path =
cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;ma=
x age&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19.99&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge max age&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19.99</FO=
NT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;he=
llo time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 1.99&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge hello time&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.99</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;fo=
rward delay&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 14.99&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge forward delay&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 14.99</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;ag=
eing time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 299.95</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;he=
llo timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcn timer&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 0.00</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;to=
pology change timer&nbsp;&nbsp;&nbsp;&nbsp; 0.00&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc ti=
mer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 239.83</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;fl=
ags</FONT></SPAN></P>
<BR>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">eth0 (2)=
</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;po=
rt id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 8002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; disabled</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;de=
signated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.000423c1fa36&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19</FONT>=
</SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;de=
signated bridge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.000423c1fa36&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; message age timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0.00</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;de=
signated port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8002&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; forward delay timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 0.00</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;de=
signated cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hold timer&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.0=
0</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;fl=
ags</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">eth2 (1)=
</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;po=
rt id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 8001&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; disabled</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;de=
signated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.000423c1fa36&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19</FONT>=
</SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;de=
signated bridge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.000423c1fa36&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; message age timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0.00</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;de=
signated port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8001&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; forward delay timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 0.00</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;de=
signated cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hold timer&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.0=
0</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;fl=
ags</FONT></SPAN></P>
<BR>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">tcpdump =
-i eth2</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">18:23:28=
.964574 IP 58.100.13.253.24462 &gt; 239.255.255.250.1900: UDP, length 242</=
FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">...</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">18:23:28=
.967746 IP 58.100.13.253.24470 &gt; 239.255.255.250.1900: UDP, length 322</=
FONT></SPAN></P>
<BR>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">/var/log=
/messages</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Feb 14 1=
8:11:08 testfw01b kernel: printk: 3 messages suppressed.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Feb 14 1=
8:11:08 testfw01b kernel: eth2: received packet with&nbsp; own address as s=
ource address</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Feb 14 1=
8:11:12 testfw01b kernel: printk: 5 messages suppressed.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Feb 14 1=
8:11:12 testfw01b kernel: eth2: received packet with&nbsp; own address as s=
ource address</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"=
></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C631DA.25D779F0--
