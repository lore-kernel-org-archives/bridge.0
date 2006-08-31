Message-ID: <131411580608310945p1dd9bbe4jcb7468adc43196dc@mail.gmail.com>
Date: Thu, 31 Aug 2006 12:45:44 -0400
From: "Raffaele Carla" <raffaele.carla@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_66412_18582767.1157042744376"
Subject: [Bridge] Trouble with ARP traffic
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_66412_18582767.1157042744376
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I've setup a Linux (SUSE v. 2.6.16.13-4-smp) in bridging mode. The br0
interface has two physical: eth0 and  eth1.

The eth0 interface is connected to  our LAN, the eth1 is connected to a
SONICWALL firewall. STP is turned off, since  it's the only bridge
connecting the two areas. The bridge is also filtering  some traffic via
iptables.

All is working fine, but when I use  tcpdump on the eth1 interface, I see
all the ARP requests of the LAN. In other  words, the entirely ARP
broadcasts (that will be resolved internally) are  passing the bridge and
reaching the firewall.

As a bridge, the Linux box should be  aware where every machine is located
and separate logically the two segments,  shouldn't it?

Also, the command "arp =96a" shows  only one address, wether the "brctl
showmacs br0"  shows all the addresses  correctly. Is this a normal
behaviour?

Thank you for any advice,

Raffaele


Output of brctl showstp  br0
---------------------------------------

br0
 bridge id                8000.001560a34be7
 designated root         8000.001560a34be7
 root port                  0                    path cost
0
 max age                   20.00                 bridge max age
50.00
 hello time                 2.00                 bridge hello
time           5.00
 forward delay             37.50                 bridge forward delay
15.00
 ageing time              300.01
 hello timer               1.39                  tcn timer
0.00
 topology change timer      0.00                 gc
timer                    0.05
 flags

eth0  (1)
 port id                 8001
state                 forwarding
 designated root         8000.001560a34be7       path
cost                  19
 designated bridge       8000.001560a34be7        message age
timer           0.00
 designated port         8001                    forward delay
timer         0.00
 designated cost            0                    hold
timer                  0.39
 flags

eth1  (2)
 port id                 8002
state                 forwarding
 designated root         8000.001560a34be7       path
cost                 100
 designated bridge       8000.001560a34be7       message age
timer           0.00
 designated port         8002                    forward delay
timer         0.00
 designated cost            0                    hold
timer                   0.39
 flags

Output of brctl showmacs  br0
------------------------------------------
1     00:04:23:0a:a6:13        no                86.16
  1     00:04:75:4c:d7:03        no                 5.06
  1     00:04:75:87:bd:a9        no               138.51
  1     00:04:76:a3:c9:b8        no               100.12
  2     00:06:b1:11:8d:a4        no                 0.07
  1     00:0f:20:3b:8e:4e        no                41.11
  1      00:0f:20:3b:fe:57       no                60.78
  1     00:14:69:b4:49:84        no                 0.14
  1     00:15:60:a3:4b:e7        yes                0.00
  1     00:30:c1:5f:24:56        no                28.16
  1     00:30:c1:8c:e7:61        no                39.05
  2     00:c0:f0:56:51:c6        yes                0.00

------=_Part_66412_18582767.1157042744376
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<span>Hi, <br> <br>I've setup a Linux (SUSE v. 2.6.16.13-4-smp) in bridging=
 mode. The br0 interface has two physical: eth0 and&nbsp;&nbsp;eth1.<br><br=
>The eth0 interface is connected to&nbsp;&nbsp;our LAN, the eth1 is connect=
ed to a SONICWALL firewall. STP is turned off, since&nbsp;&nbsp;it's the on=
ly bridge connecting the two areas.=20
The bridge is also filtering&nbsp;&nbsp;some traffic via iptables. <br> <br=
>All is working fine, but when I use&nbsp;&nbsp;tcpdump on the eth1 interfa=
ce, I see all the ARP requests of the LAN. In other&nbsp;&nbsp;words, the e=
ntirely ARP broadcasts (that will be resolved internally) are&nbsp;&nbsp;pa=
ssing the bridge and reaching the firewall.=20
<br> <br>As a bridge, the Linux box should be&nbsp;&nbsp;aware where every =
machine is located and separate logically the two segments,&nbsp;&nbsp;shou=
ldn't it? <br> <br>Also, the command &quot;arp =96a&quot; shows&nbsp;&nbsp;=
only one address, wether the &quot;brctl showmacs br0&quot;&nbsp; shows all=
 the addresses&nbsp;&nbsp;correctly. Is this a normal behaviour?=20
<br> <br>Thank you for any advice, <br><br>Raffaele <br> &nbsp; <br><br>Out=
put of brctl showstp&nbsp;&nbsp;br0 <br>-----------------------------------=
---- <br> <br>br0 <br>&nbsp;bridge id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
8000.001560a34be7 <br>&nbsp;designated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;8000.001560a34be7 <br>&nbsp;root port&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path cost&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0 <br>&nbsp;max age&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;20.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge max age&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
50.00 <br>&nbsp;hello time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.00&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bridge hello time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;5.00 <br>&nbsp;forward delay&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;37.50&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridg=
e forward delay&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;15.00 <br>&nbsp;ag=
eing time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;300.01
 <br>&nbsp;hello timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.39&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tcn ti=
mer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00 <br>&nbsp;topology change timer&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;0.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc timer&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.05 <br>&nbsp;flags <br>  <br>
eth0&nbsp;&nbsp;(1) <br>&nbsp;port id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8001&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;forwarding=
 <br>&nbsp;designated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;8000.001560a34be7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path cost&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;19 <br>&nbsp;designated bridge&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;8000.001560a34be7

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message age timer&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.00 <br>&nbsp;designated port=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8001&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; forward delay timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;0.00 <br>&nbsp;designated cost&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; hold timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.39 <br>&nbsp;fla=
gs=20
<br><br>eth1&nbsp;&nbsp;(2) <br>&nbsp;port id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;800=
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fo=
rwarding <br>&nbsp;designated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;8000.001560a34be7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path cos=
t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;100 <br>&nbsp;designated bridge&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;8000.001560a34be7
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message age timer&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.00 <br>&nbsp;designated port=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8002&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; forward delay timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;0.00 <br>&nbsp;designated cost&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; hold timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0.39 <br>&nbsp;flags <br>&nbsp; <br>Output of brctl showmacs&nbsp;&nbsp;br0=
 <br>------------------------------------------ <br> 1&nbsp;&nbsp;&nbsp;&nb=
sp; 00:04:23:0a:a6:13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;no&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 86.16 <br>&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp; 00:04:75:4c:d7:03&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;no&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
5.06 <br>&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp; 00:04:75:87:bd:a9&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 138.51 <br>&nbsp; 1&nbsp;&nbsp;=
&nbsp;&nbsp; 00:04:76:a3:c9:b8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 100.12 <br>&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp; 00:06:b1:11:8d:a=
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;no&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.=
07 <br>&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp; 00:0f:20:3b:8e:4e&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
41.11 <br>&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;00:0f:20:3b:fe:57&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 60.78 <br>&nbsp; 1&nbsp;=
&nbsp;&nbsp;&nbsp; 00:14:69:b4:49:84&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.14 <br>&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp; =
00:15:60:a3:4b:e7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;yes&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0.00 <br>&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp; 00:30:c1:5f:24:56&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
28.16 <br>&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp; 00:30:c1:8c:e7:61&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39.05 <br>&nbsp; 2&nbsp;=
&nbsp;&nbsp;&nbsp; 00:c0:f0:56:51:c6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>&nbsp;</span>


------=_Part_66412_18582767.1157042744376--
