MIME-Version: 1.0
Date: Tue, 27 Jul 2010 13:12:44 +0100
Message-ID: <AANLkTinFv+mi35FJ=q1AeKoGsmKt9mP60wb_7578eEMb@mail.gmail.com>
From: Jarrod Lowe <jarrod.lowe@gmail.com>
Content-Type: multipart/alternative; boundary=001636416bc72aec9e048c5d6b6a
Subject: [Bridge] Bridging and NAT: Confusion when linux sees the packet for
	a second time
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--001636416bc72aec9e048c5d6b6a
Content-Type: text/plain; charset=UTF-8

Hi,

I have a rather odd problem.

This is a bit of a complicated setup, if you want to know why, I have
included more detail at the bottom.



I have two bridges - lets call them "A" and "B". They have an IP address on
each, so we can route between them. There are also two virtual machines
attached to both "A" and "B" (call them "vs1" and "vs2"), and another
virtual machine attached only to "A" (call it "src")

src sends a packet to an address on the "B" network. It forwards this via
the Host's address on "A".

The Host applies an SNAT rule, to change the source address to another
address of the host (which is on a completely separate interface).

The Host forwards the packet via "B" to vs1.

vs1 forwards the packet via "A" to vs2.

At this point, the *host*, instead of copying the packet (as any good bridge
should do :)  does something... weird. It sends a RST packet, from a
*different* source port, instead of bridging!

/proc/sys/ip_conntrack, at this point, has *two* entries for the connection:
(A=10.17.192.*, B=192.168.148.*,  Host=172.16.64.76)
tcp      6 119 SYN_SENT src=10.17.192.254 dst=192.168.148.2 sport=41869
dport=80 packets=2 bytes=120 [UNREPLIED] src=192.168.148.2 dst=172.16.64.76
sport=80 dport=41869 packets=0 bytes=0 mark=0 secmark=0 use=2

tcp      6 9 CLOSE src=172.16.64.76 dst=192.168.148.2 sport=41869 dport=80
packets=2 bytes=100 src=192.168.148.2 dst=172.16.64.76 sport=80 dport=1088
packets=1 bytes=60 mark=0 secmark=0 use=2

Note that the CLOSE connections match says sport=41869, but its action
dport=1088.

I am utterly confused. Can anyone explain what is happening here, or how to
get around it?








In more detail:
I am using KVM to test what is, in live deployments, a bunch of independent
pieces of kit.

The real machine - "H" is acting as the upstream router (on "A" and
"Internet", internal switch (for "B"), and the firewall (passing through
"H").

    "Internet"
        |
A       |        B
|       He       |
+--[Ha  H   Hb]--+
|                |
+--[V1a v1 V1b]--+
|                |
+--[V2a v2 V2b]--+
|                |
|  [   src  Sb]--+
|                |

v1 and v2 are running Linux IPVS (load balancing).

"A"=10.17.192.0/24, "B"=192.168.148.0/24,  "He"=172.16.64.76

For the particular connections I am having problems with, v1 is the master -
it additionally has the floating IP address Fa. It then chooses that v2
should handle this connection.

In this context, "B" is a private network, on RFC1918 addressing. If it
wants to access the "Internet" side ("A") is must be NATd - in this case
behind the address He. (Yes, "A" and "He" are also on RFC1918 addressing
here - but that is because it is in my lab. A real deployment would have
real IPs there - and "He" would be inside "B". Also, "A" and "B" would be on
physical switches, rather than bridges on a linux box)

I have only one iptables rule; on the nat table, in POSTROUTING; From "B" (
10.17.192.0/24) to anything not "B" (!10.17.192.0/24), SNAT behind "He"
(172.16.64.76)

So "src" wants to talk to "Fa".

I can see a packet "Sb->Fa", send from "src" to "Hb".

I can see a packet "He->Fa" (SNAT'd behind He), send from "H" to "v1" on
"A".

I can see a packet "He->Fa", send from "v1" to "v2" on "B" going up to the
bridge "B".

I can see an *incorrect* RST packet "He->Fa", send from "H" to "v2" on "A",
with the wrong destination port.

I suspect this is to do with ip_conntrack. I think it is getting confused,
and building two conntrack entries, but getting the packets against the
wrong one, possibly?

Is there any way I can force conntrack to not look at bridging packets?

Any Ideas?

Thanks,
-- 
Jarrod Lowe

--001636416bc72aec9e048c5d6b6a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I have a rather odd problem.<br><br>This is a bit of a complicat=
ed setup, if you want to know why, I have included more detail at the botto=
m.<br><br><br><br>I have two bridges - lets call them &quot;A&quot; and &qu=
ot;B&quot;. They have an IP address on each, so we can route between them. =
There are also two virtual machines attached to both &quot;A&quot; and &quo=
t;B&quot; (call them &quot;vs1&quot; and &quot;vs2&quot;), and another virt=
ual machine attached only to &quot;A&quot; (call it &quot;src&quot;)<br>
<br>src sends a packet to an address on the &quot;B&quot; network. It forwa=
rds this via the Host&#39;s address on &quot;A&quot;.<br><br>The Host appli=
es an SNAT rule, to change the source address to another address of the hos=
t (which is on a completely separate interface).<br>
<br>The Host forwards the packet via &quot;B&quot; to vs1.<br><br>vs1 forwa=
rds the packet via &quot;A&quot; to vs2.<br><br>At this point, the *host*, =
instead of copying the packet (as any good bridge should do :) =C2=A0does s=
omething... weird. It sends a RST packet, from a *different* source port, i=
nstead of bridging!<br>
<br>/proc/sys/ip_conntrack, at this point, has *two* entries for the connec=
tion: (A=3D10.17.192.*, B=3D192.168.148.*, =C2=A0Host=3D172.16.64.76)<br> t=
cp =C2=A0 =C2=A0 =C2=A06 119 SYN_SENT src=3D10.17.192.254 dst=3D192.168.148=
.2 sport=3D41869 dport=3D80 packets=3D2 bytes=3D120 [UNREPLIED] src=3D192.1=
68.148.2 dst=3D172.16.64.76 sport=3D80 dport=3D41869 packets=3D0 bytes=3D0 =
mark=3D0 secmark=3D0 use=3D2<br>
<br> tcp =C2=A0 =C2=A0 =C2=A06 9 CLOSE src=3D172.16.64.76 dst=3D192.168.148=
.2 sport=3D41869 dport=3D80 packets=3D2 bytes=3D100 src=3D192.168.148.2 dst=
=3D172.16.64.76 sport=3D80 dport=3D1088 packets=3D1 bytes=3D60 mark=3D0 sec=
mark=3D0 use=3D2<br><br>Note that the CLOSE connections match says sport=3D=
41869, but its action dport=3D1088.<br>
<br>I am utterly confused. Can anyone explain what is happening here, or ho=
w to get around it?<br><br><br><br><br><br><br><br><br>In more detail:<br>I=
 am using KVM to test what is, in live deployments, a bunch of independent =
pieces of kit.<br>
<br>The real machine - &quot;H&quot; is acting as the upstream router (on &=
quot;A&quot; and &quot;Internet&quot;, internal switch (for &quot;B&quot;),=
 and the firewall (passing through &quot;H&quot;).<br><br><font face=3D"cou=
rier new,monospace">=C2=A0=C2=A0=C2=A0 &quot;Internet&quot; <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |<br>A=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 B<br>|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 He =C2=A0=C2=A0 =C2=A0=C2=A0 |<br>+--[Ha=C2=A0 H =C2=A0 Hb]--+<br=
>|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |<br>+--[V1a v1 V1b]--+<br>|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |<br>+--[V2=
a v2 V2b]--+<br>|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |<br>|=C2=A0 [=C2=A0=C2=A0 src=C2=A0 Sb]-=
-+<br>|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |<br>
</font><br>v1 and v2 are running Linux IPVS (load balancing).<br><br>&quot;=
A&quot;=3D<a href=3D"http://10.17.192.0/24">10.17.192.0/24</a>, &quot;B&quo=
t;=3D<a href=3D"http://192.168.148.0/24">192.168.148.0/24</a>,=C2=A0 &quot;=
He&quot;=3D172.16.64.76<br>
<br>For the particular connections I am having problems with, v1 is the mas=
ter - it additionally has the floating IP address Fa. It then chooses that =
v2 should handle this connection.<br><br>In this context, &quot;B&quot; is =
a private network, on RFC1918 addressing. If it wants to access the &quot;I=
nternet&quot; side (&quot;A&quot;) is must be NATd - in this case behind th=
e address He. (Yes, &quot;A&quot; and &quot;He&quot; are also on RFC1918 ad=
dressing here - but that is because it is in my lab. A real deployment woul=
d have real IPs there - and &quot;He&quot; would be inside &quot;B&quot;. A=
lso, &quot;A&quot; and &quot;B&quot; would be on physical switches, rather =
than bridges on a linux box)<br>
<br>I have only one iptables rule; on the nat table, in POSTROUTING; From &=
quot;B&quot; (<a href=3D"http://10.17.192.0/24">10.17.192.0/24</a>) to anyt=
hing not &quot;B&quot; (!<a href=3D"http://10.17.192.0/24">10.17.192.0/24</=
a>), SNAT behind &quot;He&quot; (172.16.64.76)<br>
<br>So &quot;src&quot; wants to talk to &quot;Fa&quot;.<br><br>I can see a =
packet &quot;Sb-&gt;Fa&quot;, send from &quot;src&quot; to &quot;Hb&quot;.<=
br><br>I can see a packet &quot;He-&gt;Fa&quot; (SNAT&#39;d behind He), sen=
d from &quot;H&quot; to &quot;v1&quot; on &quot;A&quot;.<br>
<br>I can see a packet &quot;He-&gt;Fa&quot;, send from &quot;v1&quot; to &=
quot;v2&quot; on &quot;B&quot; going up to the bridge &quot;B&quot;.<br><br=
>I can see an *incorrect* RST packet &quot;He-&gt;Fa&quot;, send from &quot=
;H&quot; to &quot;v2&quot; on &quot;A&quot;, with the wrong destination por=
t. <br>
<br>I suspect this is to do with ip_conntrack. I think it is getting confus=
ed, and building two conntrack entries, but getting the packets against the=
 wrong one, possibly?<br><br>Is there any way I can force conntrack to not =
look at bridging packets?<br>
<br>Any Ideas?<br><br>Thanks,<br>-- <br>Jarrod Lowe

--001636416bc72aec9e048c5d6b6a--
