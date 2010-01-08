MIME-Version: 1.0
In-Reply-To: <c5b98f840912230829y56df31f9i7f03a8f1274f144e@mail.gmail.com>
References: <c5b98f840912230829y56df31f9i7f03a8f1274f144e@mail.gmail.com>
Date: Fri, 8 Jan 2010 10:47:04 -0700
Message-ID: <c5b98f841001080947h3ee03022yfaacfd632e956efb@mail.gmail.com>
From: Robert LeBlanc <robert@leblancnet.us>
Content-Type: multipart/alternative; boundary=0016e648c93a955722047caac6dc
Subject: Re: [Bridge] Mac Address bouncing between ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0016e648c93a955722047caac6dc
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Dec 23, 2009 at 9:29 AM, Robert LeBlanc <robert@leblancnet.us>wrote:

> I've been using Linux Bridge for years on physical hardware to create a
> transparent firewall. We are moving this set-up to virtual machines. I'm
> running into a problem with MAC addresses bouncing between switch ports and
> need help  diagnosing the problem. I've looked online all day yesterday and
> I can't find a similar symptom.
>
> The set-up:
> We have two networks that we want to firewall and a network that we want to
> NAT. We are using VMware ESX 4.0 server to host the virtual machine which is
> Debian Squeeze with Linux kernel 2.6.30 and brctl 1.2. I've created two
> bridges (br0 and br1) and I assign an IP address to br0 and none to br1 so
> that it is transparent. We are using VGT (Virtual Guest Tagging) for our
> VLANs for eth0 and eth1 is using VST (Virtual Switch Tagging) for it's VLAN.
> br0 holds eth0.1 and eth0.11 and br1 holds eth0.2 and eth0.12. eth1 has an
> IP address of 192.168.1.1 and does NAT though iptables. I've set the virtual
> portgroup in ESX that is connected to eth0 to accept promiscuous mode.
>
> For the most part things work fine, however, every once and a while the Mac
> address of a machine on the firewalled side of the switch will show up on
> the non-firewalled side and for about 1 minute all traffic to/from the
> machine ceases. This happend much more frequently when I was using purley
> VST for the bridges. I also get the error "eth0.1: received packet with own
> address as source" in the logs, again much less frequently with VGT than
> with VST.
>
> I would like help tracking down the cause of these two problems, but I
> don't know where to go from here. I've sniffed the traffic on the interface
> listed in the error message, but all I've seen is a broadcast packet that
> matches the description of the error.
>
> Thank you,
>
> Robert LeBlanc
> Life Sciences & Undergraduate Education Computer Support
> Brigham Young University
>

I'm still working on this problem and this is the new information that I
have regarding it. It seems that unicast traffic works just fine, but
broadcast traffic is causing the MAC to bounce between ports. Here is a snif
on eth1 while doing ping -b on a machine on the other side of the bridge:

test:/home/rleblanc# tcpdump -i eth1 ether host 00:50:56:8c:2e:6a
tcpdump: WARNING: eth1: no IPv4 address
assigned
tcpdump: verbose output suppressed, use -v or -vv for full protocol
decode
listening on eth1, link-type EN10MB (Ethernet), capture size 96
bytes
09:31:36.826198 vlan 1002, p 0, IP 10.0.1.1 > 10.0.1.255: ICMP echo request,
id 64780, seq 1, length 64
09:31:36.826226 vlan 769, p 0, IP 10.0.1.1 > 10.0.1.255: ICMP echo request,
id 64780, seq 1, length 64
09:31:36.826632 vlan 769, p 0, IP 10.0.1.1 > 10.0.1.255: ICMP echo request,
id 64780, seq 1, length 64
09:31:36.826647 vlan 1002, p 0, IP 10.0.1.1 > 10.0.1.255: ICMP echo request,
id 64780, seq 1, length 64
09:31:37.826022 vlan 1002, p 0, IP 10.0.1.1 > 10.0.1.255: ICMP echo request,
id 64780, seq 2, length 64
09:31:37.826044 vlan 769, p 0, IP 10.0.1.1 > 10.0.1.255: ICMP echo request,
id 64780, seq 2, length 64
09:31:37.826497 vlan 769, p 0, IP 10.0.1.1 > 10.0.1.255: ICMP echo request,
id 64780, seq 2, length 64
09:31:37.826517 vlan 1002, p 0, IP 10.0.1.1 > 10.0.1.255: ICMP echo request,
id 64780, seq 2, length 64
09:31:38.826016 vlan 1002, p 0, IP 10.0.1.1 > 10.0.1.255: ICMP echo request,
id 64780, seq 3, length 64
09:31:38.826036 vlan 769, p 0, IP 10.0.1.1 > 10.0.1.255: ICMP echo request,
id 64780, seq 3, length 64
09:31:38.826444 vlan 769, p 0, IP 10.0.1.1 > 10.0.1.255: ICMP echo request,
id 64780, seq 3, length 64
09:31:38.826462 vlan 1002, p 0, IP 10.0.1.1 > 10.0.1.255: ICMP echo request,
id 64780, seq 3, length 64
^C

12 packets
captured

12 packets received by
filter

0 packets dropped by kernel

Here is the bridge config:
test:/home/rleblanc# brctl show br1
bridge name     bridge id               STP enabled     interfaces
br0             8000.020000510001       no              eth1.1002
                                                        eth1.769
The interfaces:
lsgw2:/home/rleblanc# ifconfig
br0       Link encap:Ethernet  HWaddr 02:00:00:51:00:01
          inet addr:10.0.1.2  Bcast:10.0.1.255  Mask:255.255.255.0
          inet6 addr: fe80::250:56ff:fe8c:68a8/64
Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500
Metric:1
          RX packets:348834 errors:0 dropped:0 overruns:0
frame:0
          TX packets:305785 errors:0 dropped:0 overruns:0
carrier:0
          collisions:0
txqueuelen:0
          RX bytes:51104894 (48.7 MiB)  TX bytes:57145288 (54.4
MiB)

eth1      Link encap:Ethernet  HWaddr 00:50:56:8c:68:a8
          inet6 addr: fe80::250:56ff:fe8c:68a8/64 Scope:Link
          UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
          RX packets:2446112 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1160767 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:664454061 (633.6 MiB)  TX bytes:442231660 (421.7 MiB)

eth1.769  Link encap:Ethernet  HWaddr 02:00:00:51:00:01
          inet6 addr: fe80::250:56ff:fe8c:68a8/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:588579 errors:0 dropped:0 overruns:0 frame:0
          TX packets:580062 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:68490433 (65.3 MiB)  TX bytes:394788346 (376.4 MiB)

eth1.1002 Link encap:Ethernet  HWaddr 02:00:00:51:00:02
          inet6 addr: fe80::250:56ff:fe8c:68a8/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:275070 errors:0 dropped:0 overruns:0 frame:0
          TX packets:330181 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:333860364 (318.3 MiB)  TX bytes:26596772 (25.3 MiB)

I found a list thread that mentioned that bridging VLANs with the same MAC
address could cause problems, so I've set each of the VLAN interfaces to
have a unique locally administered MAC, this has not helped with this
problem. I also get a lot of messages like "eth1.769: received packet with
own address as source address" in syslog, but running a tcpdump does not
seem to show what packets they are and the ping -b does not make them show
up.

I'm running Debian Squeeze with stock kernel:
Linux lsgw2 2.6.30-2-amd64 #1 SMP Mon Dec 7 05:21:45 UTC 2009 x86_64
GNU/Linux

And Bridge utils:
test:/home/rleblanc# brctl -V
bridge-utils, 1.2

Any ideas would be helpful.

Thanks,

Robert LeBlanc
Life Sciences & Undergraduate Education Computer Support
Brigham Young University

--0016e648c93a955722047caac6dc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2009 at 9:29 AM, Robert LeBlanc <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:robert@leblancnet.us">robert@leblancnet.us</a>&gt;</span> wrot=
e:<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padd=
ing-left: 1ex;">
I&#39;ve been using Linux Bridge for years on physical hardware to create a=
 transparent firewall. We are moving this set-up to virtual machines. I&#39=
;m running into a problem with MAC addresses bouncing between switch ports =
and need help=A0 diagnosing the problem. I&#39;ve looked online all day yes=
terday and I can&#39;t find a similar symptom.<br>

<br>The set-up:<br>We have two networks that we want to firewall and a netw=
ork that we want to NAT. We are using VMware ESX 4.0 server to host the vir=
tual machine which is Debian Squeeze with Linux kernel 2.6.30 and brctl 1.2=
. I&#39;ve created two bridges (br0 and br1) and I assign an IP address to =
br0 and none to br1 so that it is transparent. We are using VGT (Virtual Gu=
est Tagging) for our VLANs for eth0 and eth1 is using VST (Virtual Switch T=
agging) for it&#39;s VLAN. br0 holds eth0.1 and eth0.11 and br1 holds eth0.=
2 and eth0.12. eth1 has an IP address of 192.168.1.1 and does NAT though ip=
tables. I&#39;ve set the virtual portgroup in ESX that is connected to eth0=
 to accept promiscuous mode.<br>

<br>For the most part things work fine, however, every once and a while the=
 Mac address of a machine on the firewalled side of the switch will show up=
 on the non-firewalled side and for about 1 minute all traffic to/from the =
machine ceases. This happend much more frequently when I was using purley V=
ST for the bridges. I also get the error &quot;eth0.1: received packet with=
 own address as source&quot; in the logs, again much less frequently with V=
GT than with VST.<br>

<br>I would like help tracking down the cause of these two problems, but I =
don&#39;t know where to go from here. I&#39;ve sniffed the traffic on the i=
nterface listed in the error message, but all I&#39;ve seen is a broadcast =
packet that matches the description of the error.<br>

<br>Thank you,<br clear=3D"all"><font color=3D"#888888"><br>Robert LeBlanc<=
br>Life Sciences &amp; Undergraduate Education Computer Support<br>Brigham =
Young University<br>
</font></blockquote></div><br>I&#39;m still working on this problem and thi=
s is the new information that I have regarding it. It seems that unicast tr=
affic works just fine, but broadcast traffic is causing the MAC to bounce b=
etween ports. Here is a snif on eth1 while doing ping -b on a machine on th=
e other side of the bridge:<br>
<br><span style=3D"font-family: courier new,monospace;">test:/home/rleblanc=
# tcpdump -i eth1 ether host 00:50:56:8c:2e:6a</span><br style=3D"font-fami=
ly: courier new,monospace;"><span style=3D"font-family: courier new,monospa=
ce;">tcpdump: WARNING: eth1: no IPv4 address assigned=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 </span><br style=3D"font-family: courier new,monos=
pace;">
<span style=3D"font-family: courier new,monospace;">tcpdump: verbose output=
 suppressed, use -v or -vv for full protocol decode=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 </span><br style=3D"font-family: courier new,monospace;"=
><span style=3D"font-family: courier new,monospace;">listening on eth1, lin=
k-type EN10MB (Ethernet), capture size 96 bytes=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><br style=3D"font-family: courier new=
,monospace;">
<span style=3D"font-family: courier new,monospace;">09:31:36.826198 vlan 10=
02, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255">10.0.1.255</a>: ICM=
P echo request, id 64780, seq 1, length 64 </span><br style=3D"font-family:=
 courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">09:31:36.826226 vlan 76=
9, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255">10.0.1.255</a>: ICMP=
 echo request, id 64780, seq 1, length 64=A0 </span><br style=3D"font-famil=
y: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">09:31:36.826632 vlan 76=
9, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255">10.0.1.255</a>: ICMP=
 echo request, id 64780, seq 1, length 64=A0 </span><br style=3D"font-famil=
y: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">09:31:36.826647 vlan 10=
02, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255">10.0.1.255</a>: ICM=
P echo request, id 64780, seq 1, length 64 </span><br style=3D"font-family:=
 courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">09:31:37.826022 vlan 10=
02, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255">10.0.1.255</a>: ICM=
P echo request, id 64780, seq 2, length 64 </span><br style=3D"font-family:=
 courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">09:31:37.826044 vlan 76=
9, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255">10.0.1.255</a>: ICMP=
 echo request, id 64780, seq 2, length 64=A0 </span><br style=3D"font-famil=
y: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">09:31:37.826497 vlan 76=
9, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255">10.0.1.255</a>: ICMP=
 echo request, id 64780, seq 2, length 64=A0 </span><br style=3D"font-famil=
y: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">09:31:37.826517 vlan 10=
02, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255">10.0.1.255</a>: ICM=
P echo request, id 64780, seq 2, length 64 </span><br style=3D"font-family:=
 courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">09:31:38.826016 vlan 10=
02, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255">10.0.1.255</a>: ICM=
P echo request, id 64780, seq 3, length 64 </span><br style=3D"font-family:=
 courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">09:31:38.826036 vlan 76=
9, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255">10.0.1.255</a>: ICMP=
 echo request, id 64780, seq 3, length 64=A0 </span><br style=3D"font-famil=
y: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">09:31:38.826444 vlan 76=
9, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255">10.0.1.255</a>: ICMP=
 echo request, id 64780, seq 3, length 64=A0 </span><br style=3D"font-famil=
y: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">09:31:38.826462 vlan 10=
02, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255">10.0.1.255</a>: ICM=
P echo request, id 64780, seq 3, length 64 </span><br style=3D"font-family:=
 courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">^C=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 </span><br style=3D"font-family: courier new,monospace;"><span=
 style=3D"font-family: courier new,monospace;">12 packets captured=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><br style=3D"font-f=
amily: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">12 packets received by =
filter=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><br style=3D"font-family: courier =
new,monospace;"><span style=3D"font-family: courier new,monospace;">0 packe=
ts dropped by kernel=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><br styl=
e=3D"font-family: courier new,monospace;">
<br>Here is the bridge config:<br><span style=3D"font-family: courier new,m=
onospace;">test:/home/rleblanc# brctl show br1</span><br style=3D"font-fami=
ly: courier new,monospace;"><span style=3D"font-family: courier new,monospa=
ce;">bridge name=A0=A0=A0=A0 bridge id=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 STP enabled=A0=A0=A0=A0 interfaces</span><br style=3D"font-family: c=
ourier new,monospace;">
<span style=3D"font-family: courier new,monospace;">br0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 8000.020000510001=A0=A0=A0=A0=A0=A0 no=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 eth1.1002</span><br style=3D"font-family: courier new=
,monospace;"><span style=3D"font-family: courier new,monospace;">=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 eth1.769</span><br style=3D"font-family: courier new,monospace;">
The interfaces:<br><span style=3D"font-family: courier new,monospace;">lsgw=
2:/home/rleblanc# ifconfig</span><br style=3D"font-family: courier new,mono=
space;"><span style=3D"font-family: courier new,monospace;">br0=A0=A0=A0=A0=
=A0=A0 Link encap:Ethernet=A0 HWaddr 02:00:00:51:00:01=A0 </span><br style=
=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 inet addr:10.0.1.2=A0 Bcast:10.0.1.255=A0 Mask:255.255.255.0</span><=
br style=3D"font-family: courier new,monospace;"><span style=3D"font-family=
: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0 inet6 addr: fe80::250=
:56ff:fe8c:68a8/64 Scope:Link=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 </span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 UP BROADCAST RUNNING MULTICAST=A0 MTU:1500=A0 Metric:1=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><br style=3D"font-family: co=
urier new,monospace;"><span style=3D"font-family: courier new,monospace;">=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 RX packets:348834 errors:0 dropped:0 overruns:0=
 frame:0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><br style=3D"font-famil=
y: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 TX packets:305785 errors:0 dropped:0 overruns:0 carrier:0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 </span><br style=3D"font-family: courier new,monospac=
e;"><span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 collisions:0 txqueuelen:0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 </span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 RX bytes:51104894 (48.7 MiB)=A0 TX bytes:57145288 (54.4 MiB)=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 </span><br style=3D"font-family: courier new,monospac=
e;"><span style=3D"font-family: courier new,monospace;"><br>
eth1=A0=A0=A0=A0=A0 Link encap:Ethernet=A0 HWaddr 00:50:56:8c:68:a8=A0 </sp=
an><br style=3D"font-family: courier new,monospace;"><span style=3D"font-fa=
mily: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0 inet6 addr: fe80:=
:250:56ff:fe8c:68a8/64 Scope:Link</span><br style=3D"font-family: courier n=
ew,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 UP BROADCAST RUNNING PROMISC MULTICAST=A0 MTU:1500=A0 Metric:1</span=
><br style=3D"font-family: courier new,monospace;"><span style=3D"font-fami=
ly: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0 RX packets:2446112 =
errors:0 dropped:0 overruns:0 frame:0=A0 </span><br style=3D"font-family: c=
ourier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 TX packets:1160767 errors:0 dropped:0 overruns:0 carrier:0</span><br=
 style=3D"font-family: courier new,monospace;"><span style=3D"font-family: =
courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0 collisions:0 txqueuelen=
:1000=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 </span><br style=3D"font-family: courier new,monospace;"=
>
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 RX bytes:664454061 (633.6 MiB)=A0 TX bytes:442231660 (421.7 MiB)</sp=
an><br style=3D"font-family: courier new,monospace;"><br style=3D"font-fami=
ly: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;"></span><span style=3D"f=
ont-family: courier new,monospace;">eth1.769=A0 Link encap:Ethernet=A0 HWad=
dr 02:00:00:51:00:01</span><br style=3D"font-family: courier new,monospace;=
"><span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 inet6 addr: fe80::250:56ff:fe8c:68a8/64 Scope:Link</span><br style=
=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 UP BROADCAST RUNNING MULTICAST=A0 MTU:1500=A0 Metric:1</span><br sty=
le=3D"font-family: courier new,monospace;"><span style=3D"font-family: cour=
ier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0 RX packets:588579 errors:0 =
dropped:0 overruns:0 frame:0</span><br style=3D"font-family: courier new,mo=
nospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 TX packets:580062 errors:0 dropped:0 overruns:0 carrier:0</span><br =
style=3D"font-family: courier new,monospace;"><span style=3D"font-family: c=
ourier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0 collisions:0 txqueuelen:=
0</span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 RX bytes:68490433 (65.3 MiB)=A0 TX bytes:394788346 (376.4 MiB)</span=
><br style=3D"font-family: courier new,monospace;"><br style=3D"font-family=
: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;"></span><span style=3D"f=
ont-family: courier new,monospace;">eth1.1002 Link encap:Ethernet=A0 HWaddr=
 02:00:00:51:00:02</span><br style=3D"font-family: courier new,monospace;">=
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 inet6 addr: fe80::250:56ff:fe8c:68a8/64 Scope:Link</span><br style=
=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 UP BROADCAST RUNNING MULTICAST=A0 MTU:1500=A0 Metric:1</span><br sty=
le=3D"font-family: courier new,monospace;"><span style=3D"font-family: cour=
ier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0 RX packets:275070 errors:0 =
dropped:0 overruns:0 frame:0</span><br style=3D"font-family: courier new,mo=
nospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 TX packets:330181 errors:0 dropped:0 overruns:0 carrier:0</span><br =
style=3D"font-family: courier new,monospace;"><span style=3D"font-family: c=
ourier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=A0=A0 collisions:0 txqueuelen:=
0</span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 RX bytes:333860364 (318.3 MiB)=A0 TX bytes:26596772 (25.3 MiB)</span=
><br style=3D"font-family: courier new,monospace;"><br style=3D"font-family=
: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;"></span>I found a list t=
hread that mentioned that bridging VLANs with the same MAC address could ca=
use problems, so I&#39;ve set each of the VLAN interfaces to have a unique =
locally administered MAC, this has not helped with this problem. I also get=
 a lot of messages like &quot;eth1.769: received packet with=A0 own address=
 as source address&quot; in syslog, but running a tcpdump does not seem to =
show what packets they are and the ping -b does not make them show up.<br>
<br>I&#39;m running Debian Squeeze with stock kernel:<br><span style=3D"fon=
t-family: courier new,monospace;">Linux lsgw2 2.6.30-2-amd64 #1 SMP Mon Dec=
 7 05:21:45 UTC 2009 x86_64 GNU/Linux</span><br><br>And Bridge utils:<br>
<span style=3D"font-family: courier new,monospace;">test:/home/rleblanc# br=
ctl -V</span><br style=3D"font-family: courier new,monospace;"><span style=
=3D"font-family: courier new,monospace;">bridge-utils, 1.2</span><br><br>An=
y ideas would be helpful.<br>
<br>Thanks,<br><br>Robert LeBlanc<br>Life Sciences &amp; Undergraduate Educ=
ation Computer Support<br>Brigham Young University<br>

--0016e648c93a955722047caac6dc--
