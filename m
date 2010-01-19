MIME-Version: 1.0
Date: Tue, 19 Jan 2010 15:30:21 -0700
Message-ID: <c5b98f841001191430k3cf1ec2bs569b09e6b5bfcce7@mail.gmail.com>
From: Robert LeBlanc <robert@leblancnet.us>
Content-Type: multipart/alternative; boundary=0016e644dc60eed537047d8c03b7
Subject: [Bridge] Need help writing ebtables rules
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0016e644dc60eed537047d8c03b7
Content-Type: text/plain; charset=ISO-8859-1

So, I've found the problem with my VMware bridge and need help 'fixing' it.
Short story is, since the virtual switch in ESX is not a true Layer 2
switch, VMware uses some short cuts to improve performance. They allow
physical adapters to be connected to one virtual switch and a VM will be
assigned a physical adapter and only send traffic out that one adapter, but
can receive traffic on any adapter. This works great for the common case as
the VMs are load balanced between NICs. In my case with a bridge it causes
problems.

When broadcast traffic is sent, the traffic is reflected by switches farther
up and seen as duplicates in the VM. Here is the layout: ESX server in HP
chassis with 4 NICs, each NIC is connected to one of 4 switches in the HP
chassis. The 4 HP chassis switches are connected to a set of HP Procurve
switches. When a VM behind the bridge VM sends a broadcast messages, it goes
out one NIC, to one of the HP chassis switches, to the Procurve switch,
which sends the broadcast on all ports, back to another HP chassis switch
connected to another NIC on the ESX server and gets sent to the VM causing
the duplicate. With real switches, you would create trunk groups and would
not have this problem.

So, I need some clever ebtables rules to drop this duplicate traffic. I used
ebtables years ago and then found that I could do what I needed with
iptables so I abandoned it. Needless to say, my ebtables foo is not very
good. Here is some of the duplicate traffic as seen by the bridge:

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

Thank you,

Robert LeBlanc
Life Sciences & Undergraduate Education Computer Support
Brigham Young University

--0016e644dc60eed537047d8c03b7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

So, I&#39;ve found the problem with my VMware bridge and need help &#39;fix=
ing&#39; it. Short story is, since the virtual switch in ESX is not a true =
Layer 2 switch, VMware uses some short cuts to improve performance. They al=
low physical adapters to be connected to one virtual switch and a VM will b=
e assigned a physical adapter and only send traffic out that one adapter, b=
ut can receive traffic on any adapter. This works great for the common case=
 as the VMs are load balanced between NICs. In my case with a bridge it cau=
ses problems.<br>
<br>When broadcast traffic is sent, the traffic is reflected by switches fa=
rther up and seen as duplicates in the VM. Here is the layout: ESX server i=
n HP chassis with 4 NICs, each NIC is connected to one of 4 switches in the=
 HP chassis. The 4 HP chassis switches are connected to a set of HP Procurv=
e switches. When a VM behind the bridge VM sends a broadcast messages, it g=
oes out one NIC, to one of the HP chassis switches, to the Procurve switch,=
 which sends the broadcast on all ports, back to another HP chassis switch =
connected to another NIC on the ESX server and gets sent to the VM causing =
the duplicate. With real switches, you would create trunk groups and would =
not have this problem.<br>
<br>So, I need some clever ebtables rules to drop this duplicate traffic. I=
 used ebtables years ago and then found that I could do what I needed with =
iptables so I abandoned it. Needless to say, my ebtables foo is not very go=
od. Here is some of the duplicate traffic as seen by the bridge:<br>
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
02, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255/" target=3D"_blank">=
10.0.1.255</a>: ICMP echo request, id 64780, seq 1, length 64 </span><br st=
yle=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">09:31:36.826226 vlan 76=
9, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255/" target=3D"_blank">1=
0.0.1.255</a>: ICMP echo request, id 64780, seq 1, length 64=A0 </span><br =
style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">09:31:36.826632 vlan 76=
9, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255/" target=3D"_blank">1=
0.0.1.255</a>: ICMP echo request, id 64780, seq 1, length 64=A0 </span><br =
style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">09:31:36.826647 vlan 10=
02, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255/" target=3D"_blank">=
10.0.1.255</a>: ICMP echo request, id 64780, seq 1, length 64 </span><br st=
yle=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">09:31:37.826022 vlan 10=
02, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255/" target=3D"_blank">=
10.0.1.255</a>: ICMP echo request, id 64780, seq 2, length 64 </span><br st=
yle=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">09:31:37.826044 vlan 76=
9, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255/" target=3D"_blank">1=
0.0.1.255</a>: ICMP echo request, id 64780, seq 2, length 64=A0 </span><br =
style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">09:31:37.826497 vlan 76=
9, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255/" target=3D"_blank">1=
0.0.1.255</a>: ICMP echo request, id 64780, seq 2, length 64=A0 </span><br =
style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">09:31:37.826517 vlan 10=
02, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255/" target=3D"_blank">=
10.0.1.255</a>: ICMP echo request, id 64780, seq 2, length 64 </span><br st=
yle=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">09:31:38.826016 vlan 10=
02, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255/" target=3D"_blank">=
10.0.1.255</a>: ICMP echo request, id 64780, seq 3, length 64 </span><br st=
yle=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">09:31:38.826036 vlan 76=
9, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255/" target=3D"_blank">1=
0.0.1.255</a>: ICMP echo request, id 64780, seq 3, length 64=A0 </span><br =
style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">09:31:38.826444 vlan 76=
9, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255/" target=3D"_blank">1=
0.0.1.255</a>: ICMP echo request, id 64780, seq 3, length 64=A0 </span><br =
style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">09:31:38.826462 vlan 10=
02, p 0, IP 10.0.1.1 &gt; <a href=3D"http://10.0.1.255/" target=3D"_blank">=
10.0.1.255</a>: ICMP echo request, id 64780, seq 3, length 64 </span><br st=
yle=3D"font-family: courier new,monospace;">

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
ts dropped by kernel=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><br clea=
r=3D"all">
<br>Thank you,<br><br>Robert LeBlanc<br>Life Sciences &amp; Undergraduate E=
ducation Computer Support<br>Brigham Young University<br>

--0016e644dc60eed537047d8c03b7--
