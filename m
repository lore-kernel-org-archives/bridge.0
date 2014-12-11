Return-Path: <chirag.patwari@matrixcomsec.com>
MIME-Version: 1.0
Date: Thu, 11 Dec 2014 11:48:42 +0530
Message-ID: <CAKx303j6JbfjzG4T7WTHfSy3LD+r=Cm4NDbw12yQAgL=2-oztQ@mail.gmail.com>
From: Chirag Patwari <chirag.patwari@matrixcomsec.com>
Content-Type: multipart/alternative; boundary=001a11c2d69e7454c30509eabf9c
Subject: [Bridge] Packet Forward to same interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--001a11c2d69e7454c30509eabf9c
Content-Type: text/plain; charset=UTF-8

Hello All,
  I have issue with packet forward from same interface.
  In my project There is two interface eth0 and br0
  br0 is created between eth1 (Lan switch) and wlan0 (wifi)
  eth0 has ip address 192.168.1.100 and br0 has ip 192.168.2.56
  In my setup I have one web server running on 8080 port and it is in my
lan network and it's ip address is 192.168.2.60, So if any user from wan
side want to access this server then it send packet to my Wan interface
192.168.1.100:8080 and I have apply port forwarding to this interface using
iptables and this packet route to internal server 192.168.2.60:8080.
  Now if I want to access this server from my lan network, I have another
PC with IP 192.168.2.57 with gateway address 192.168.2.56 and it want to
use this server then there is tow way
  1. Directly connect to 192.168.2.60:8080
  2. using address 192.168.1.100:8080
   In Second case I have to route this packet to 192.168.2.60:8080 using
same iptables rule.
   But it is works only if *0 is written in
/proc/sys/net/bridge/bridge-nf-call-iptables* file if I write 1 in this
file then it stop working.
   Packet drop some where in bridge interface.
   Please do the needful for this.

Best Regards,
Chirag Patwari

--001a11c2d69e7454c30509eabf9c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello All,<div>=C2=A0 I have issue with packet forward fro=
m same interface.</div><div>=C2=A0 In my project There is two interface eth=
0 and br0</div><div>=C2=A0 br0 is created between eth1 (Lan switch) and wla=
n0 (wifi)</div><div>=C2=A0 eth0 has ip address 192.168.1.100 and br0 has ip=
 192.168.2.56</div><div>=C2=A0 In my setup I have one web server running on=
 8080 port and it is in my lan network and it&#39;s ip address is 192.168.2=
.60, So if any user from wan side want to access this server then it send p=
acket to my Wan interface <a href=3D"http://192.168.1.100:8080">192.168.1.1=
00:8080</a> and I have apply port forwarding to this interface using iptabl=
es and this packet route to internal server <a href=3D"http://192.168.2.60:=
8080">192.168.2.60:8080</a>.</div><div>=C2=A0 Now if I want to access this =
server from my lan network, I have another PC with IP 192.168.2.57 with gat=
eway address 192.168.2.56 and it want to use this server then there is tow =
way</div><div>=C2=A0 1. Directly connect to <a href=3D"http://192.168.2.60:=
8080">192.168.2.60:8080</a></div><div>=C2=A0 2. using address <a href=3D"ht=
tp://192.168.1.100:8080">192.168.1.100:8080</a></div><div>=C2=A0 =C2=A0In S=
econd case I have to route this packet to <a href=3D"http://192.168.2.60:80=
80">192.168.2.60:8080</a> using same iptables rule.</div><div>=C2=A0 =C2=A0=
But it is works only if<span style=3D"background-color:rgb(255,255,255)"> <=
b><u><font color=3D"#ff0000">0 is written in /proc/sys/net/bridge/bridge-nf=
-call-iptables</font></u></b></span> file if I write 1 in this file then it=
 stop working.</div><div>=C2=A0 =C2=A0Packet drop some where in bridge inte=
rface.</div><div>=C2=A0 =C2=A0Please do the needful for this.</div><div><br=
></div><div>Best Regards,</div><div>Chirag Patwari</div><div>=C2=A0</div></=
div>

--001a11c2d69e7454c30509eabf9c--
