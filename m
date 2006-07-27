Message-ID: <44C8843A.4010200@seskion.de>
Date: Thu, 27 Jul 2006 11:15:38 +0200
From: Juergen Pfeiffer <j.pfeiffer@seskion.de>
MIME-Version: 1.0
References: <44C77FD2.2030208@seskion.de>	<20060726083455.08989fc6@localhost.localdomain>	<44C7979B.7040906@seskion.de>
	<20060726101335.67406ee8@localhost>
In-Reply-To: <20060726101335.67406ee8@localhost>
Content-Type: multipart/alternative;
	boundary="------------010209080403040407050606"
Subject: Re: [Bridge] Is bridgeing possible with kernel 2.6.10
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

--------------010209080403040407050606
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Stephen Hemminger schrieb:
>
> The bridge starts in the learning state doesn't forward until the
> forwarding delay (30 seconds) in expired. You need to be either patient
> or set the delay to a lower value.
>
>  =20

Hi
Here is the trace of my test:
After the output of "now do pings!", i started to ping on computer=20
192.168.1.1 (MAC=3D00:50:fc:93:e0:9c), connected to eth1 of my bridge to=20
computer 192.168.1.33 (MAC=3D00:14:22:f2:5d:70), connected to eth0 of my=20
bridge.
=3D> No Responses! May it be a problem of my ethernet driver=20
(drivers/net/fec.c for Freescale ColdFire 5485) ??

*$ /mnt/mtd/startbridge*
+ ifconfig eth0 0.0.0.0 down
+ ifconfig eth1 0.0.0.0 down
+ brctl addbr br0
+ brctl stp br0 on
+ brctl addif br0 eth0
device eth0 entered promiscuous mode
+ brctl addif br0 eth1
device eth1 entered promiscuous mode
+ ifconfig eth0 0.0.0.0 up
+ ifconfig eth1 0.0.0.0 up
+ ifconfig br0 0.0.0.0 up
br0: port 2(eth1) entering listening state
br0: port 1(eth0) entering listening state
+ sleep 35
br0: port 2(eth1) entering learning state
br0: port 1(eth0) entering learning state
br0: topology change detected, propagating
br0: port 2(eth1) entering forwarding state
br0: topology change detected, propagating
br0: port 1(eth0) entering forwarding state
+ echo 'now do pings!'
now do pings!
+ sleep 10
+ brctl show
bridge name     bridge id               STP enabled     interfaces
br0             8000.001122334450       yes             eth0
                                                        eth1
+ brctl showmacs br0
port no mac addr                is local?       ageing timer
  1     00:11:22:33:44:50       yes                0.00
  2     00:11:22:33:44:51       yes                0.00
*  1     00:14:22:f2:5d:70       no                10.13*
  2     00:40:05:41:12:8d       no                 4.52
*  2     00:50:fc:93:e0:9c       no                 0.38
*  2     00:c0:02:39:53:52       no                 7.88
+ brctl showstp br0
br0
 bridge id              8000.001122334450
 designated root        8000.001122334450
 root port                 0                    path cost                  0
 max age                  20.00                 bridge max=20
age            20.00
 hello time                2.00                 bridge hello=20
time          2.00
 forward delay            15.00 b               rbr0id:ge  fporowarrdt d=20
el2ay(1
d a geeinng ttiemer             i 3n00g.0 0
 tihesllao btilmeer     d           s0.t61a             t       tecn
o imberr                0  : 0 .0p0
l rtotpo lo1gy( cehatnghe 0ti)me r      e  n19t.7e0     r              =20
igcn tg8
_Cefldag s      s               tTOaPOtLOeGY
  HANGE TOPOLOGY_CHANGE_DETECTED


eth0 (1)
 port id                8001                    state               =20
forwarding
pdesignated root        d80e00v.0i01c12e23 34e45t0      hpa1th  closet =20
f      0
34rdeosimgniatsedc buriodgue    s80 00m.0o01d12e23
h 45b0  rme0ss:ag e pagoe rtitme r      2  ( 0e.0t0
  1de)si gneatnedt peorrt       i80n01g                 fdoriwasrda=20
dbellaye tde
 d
  esignated cost           0                    hold=20
timer                 0.00
 flags

eth1 (2)
 port id                8002                    state               =20
forwardidne
v diescigena teed trohot0       8 00l0.e00f11t22 33p44r50o      pmatih=20
scocstu s
d dmesoigdnaete
  brbidrge0     8:00 0.p00o11r22t33 44150(      meestsahge0 a)ge =20
teimnert     n
ded esdiginastead bpolrte       8d00 2  s               tfoarwtared
  lay timer        0.00
 designated cost           0                    hold=20
timer                 0.00
 flags

+ ifconfig
br0       Link encap:Ethernet  HWaddr 00:11:22:33:44:50
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:24 errors:0 dropped:0 overruns:0 frame:0
          *TX packets:0* errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:1499 (1.4 KiB)  TX bytes:0 (0.0 B)

eth0      Link encap:Ethernet  HWaddr 00:11:22:33:44:50
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          *RX packets:85* errors:0 dropped:0 overruns:0 frame:0
          TX packets:229 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:7232 (7.0 KiB)  TX bytes:26956 (26.3 KiB)
          Interrupt:103 Base address:0x9000

eth1      Link encap:Ethernet  HWaddr 00:11:22:33:44:51
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:946 errors:0 dropped:0 overruns:0 frame:0
          TX packets:93 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:167451 (163.5 KiB)  TX bytes:62a3 (6.1 KiB)
          Interrupt:102 Base address:0x9800

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:268 (268.0 B)  TX bytes:268 (268.0 B)

+ ifconfig br0 down
+ brctl delif br0 eth1
+ brctl delif br0 eth0
+ brctl delbr br0
+ ifconfig eth1 0.0.0.0 down
+ ifconfig eth0 0.0.0.0 down
*$
*

--=20
------------------------------------------------------------------------
J=FCrgen Pfeiffer =09
=09
	* _mailto:j.pfeiffer@seskion.de_
SesKion Softwareentwicklung und System Konzeption GmbH =09
=09
	( : +49-711-9905814
Karlsruher Str. 11/1 =09
=09
	Fax: +49-711-9905827
D-70771 Leinfelden-Echterdingen =09
=09
	1 _http://www.seskion.de_

------------------------------------------------------------------------

--------------010209080403040407050606
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Stephen Hemminger schrieb:
<blockquote cite="mid20060726101335.67406ee8@localhost" type="cite"><br>
  <pre wrap="">
The bridge starts in the learning state doesn't forward until the
forwarding delay (30 seconds) in expired. You need to be either patient
or set the delay to a lower value.

  </pre>
</blockquote>
<br>
Hi<br>
Here is the trace of my test:<br>
After the output of "<tt><font color="#006600"><font color="#000000">now
do pings!",</font><font color="#000000"> i started to ping on computer
192.168.1.1 (MAC=</font></font></tt><tt><font color="#990000">00:50:fc:93:e0:9c</font></tt><tt><font
 color="#006600"><font color="#000000">), connected to eth1 of my
bridge to </font></font></tt><tt><font color="#006600"><font
 color="#000000">computer 192.168.1.33 (MAC=</font></font></tt><tt><font
 color="#990000">00:14:22:f2:5d:70</font></tt><tt><font color="#006600"><font
 color="#000000">), connected to eth0 of my bridge.<br>
=&gt; No Responses! May it be a problem of my ethernet driver
(drivers/net/fec.c for Freescale ColdFire 5485) ??</font></font></tt><br>
<br>
<tt><font color="#000000"><b>$ /mnt/mtd/startbridge</b></font><br>
+ ifconfig eth0 0.0.0.0 down<br>
+ ifconfig eth1 0.0.0.0 down<br>
+ brctl addbr br0<br>
+ brctl stp br0 on<br>
+ brctl addif br0 eth0<br>
<font color="#993399">device eth0 entered promiscuous mode<br>
</font>+ brctl addif br0 eth1<br>
<font color="#993399">device eth1 entered promiscuous mode<br>
</font>+ ifconfig eth0 0.0.0.0 up<br>
+ ifconfig eth1 0.0.0.0 up<br>
+ ifconfig br0 0.0.0.0 up<br>
<font color="#993399">br0: port 2(eth1) entering listening state<br>
br0: port 1(eth0) entering listening state<br>
</font>+ sleep 35<br>
<font color="#993399">br0: port 2(eth1) entering learning state<br>
br0: port 1(eth0) entering learning state<br>
br0: topology change detected, propagating<br>
br0: port 2(eth1) entering forwarding state<br>
br0: topology change detected, propagating<br>
br0: port 1(eth0) entering forwarding state<br>
</font><font color="#000000">+ echo 'now do pings!'<br>
now do pings!<br>
</font>+ sleep 10<br>
+ brctl show<br>
bridge name&nbsp;&nbsp;&nbsp;&nbsp; bridge id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STP enabled&nbsp;&nbsp;&nbsp;&nbsp; interfaces<br>
br0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001122334450&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth1<br>
+ brctl showmacs br0<br>
port no mac addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is local?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ageing timer<br>
&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp; 00:11:22:33:44:50&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>
&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp; 00:11:22:33:44:51&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>
<font color="#990000"><b><font color="#000099">&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;
00:14:22:f2:5d:70&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10.13</font></b><br>
</font>&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp; 00:40:05:41:12:8d&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.52<br>
<b><font color="#000099">&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp; 00:50:fc:93:e0:9c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.38<br>
</font></b>&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp; 00:c0:02:39:53:52&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7.88<br>
+ brctl showstp br0<br>
br0<br>
&nbsp;bridge id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001122334450<br>
&nbsp;designated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001122334450<br>
&nbsp;root port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path
cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;max age&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge max
age&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20.00<br>
&nbsp;hello time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge hello
time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.00<br>
&nbsp;forward delay&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15.00 b&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rbr0id:ge&nbsp; fporowarrdt
d el2ay(1<br>
d a geeinng ttiemer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i 3n00g.0 0<br>
&nbsp;tihesllao btilmeer&nbsp;&nbsp;&nbsp;&nbsp; d&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s0.t61a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tecn<br>
o imberr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; : 0 .0p0<br>
l rtotpo lo1gy( cehatnghe 0ti)me r&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e&nbsp; n19t.7e0&nbsp;&nbsp;&nbsp;&nbsp; r&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
igcn tg8<br>
_Cefldag s&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tTOaPOtLOeGY<br>
&nbsp; HANGE TOPOLOGY_CHANGE_DETECTED<br>
<br>
<br>
eth0 (1)<br>
&nbsp;port id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8001&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
forwarding<br>
pdesignated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d80e00v.0i01c12e23 34e45t0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hpa1th&nbsp; closet&nbsp;
f&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
34rdeosimgniatsedc buriodgue&nbsp;&nbsp;&nbsp; s80 00m.0o01d12e23<br>
h 45b0&nbsp; rme0ss:ag e pagoe rtitme r&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp; ( 0e.0t0<br>
&nbsp; 1de)si gneatnedt peorrt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i80n01g&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fdoriwasrda
dbellaye tde<br>
&nbsp;d<br>
&nbsp; esignated cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hold
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>
&nbsp;flags<br>
<br>
eth1 (2)<br>
&nbsp;port id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
forwardidne<br>
v diescigena teed trohot0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8 00l0.e00f11t22 33p44r50o&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pmatih
scocstu s<br>
d dmesoigdnaete<br>
&nbsp; brbidrge0&nbsp;&nbsp;&nbsp;&nbsp; 8:00 0.p00o11r22t33 44150(&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; meestsahge0 a)ge&nbsp;
teimnert&nbsp;&nbsp;&nbsp;&nbsp; n<br>
ded esdiginastead bpolrte&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8d00 2&nbsp; s&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tfoarwtared<br>
&nbsp; lay timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>
&nbsp;designated cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hold
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>
&nbsp;flags<br>
<br>
+ ifconfig<br>
br0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; HWaddr 00:11:22:33:44:50<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp; Metric:1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packets:24 errors:0 dropped:0 overruns:0 frame:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><font color="#cc0000">TX packets:0</font></b> errors:0
dropped:0 overruns:0 carrier:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 txqueuelen:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:1499 (1.4 KiB)&nbsp; TX bytes:0 (0.0 B)<br>
<br>
eth0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; HWaddr 00:11:22:33:44:50<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp; Metric:1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><font color="#cc0000">RX packets:85</font></b> errors:0
dropped:0 overruns:0 frame:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:229 errors:0 dropped:0 overruns:0 carrier:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 txqueuelen:1000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:7232 (7.0 KiB)&nbsp; TX bytes:26956 (26.3 KiB)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Interrupt:103 Base address:0x9000<br>
<br>
eth1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; HWaddr 00:11:22:33:44:51<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp; Metric:1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packets:946 errors:0 dropped:0 overruns:0 frame:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:93 errors:0 dropped:0 overruns:0 carrier:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 txqueuelen:1000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:167451 (163.5 KiB)&nbsp; TX bytes:62a3 (6.1 KiB)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Interrupt:102 Base address:0x9800<br>
<br>
lo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Local Loopback<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inet addr:127.0.0.1&nbsp; Mask:255.0.0.0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP LOOPBACK RUNNING&nbsp; MTU:16436&nbsp; Metric:1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packets:4 errors:0 dropped:0 overruns:0 frame:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:4 errors:0 dropped:0 overruns:0 carrier:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 txqueuelen:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:268 (268.0 B)&nbsp; TX bytes:268 (268.0 B)<br>
<br>
+ ifconfig br0 down<br>
+ brctl delif br0 eth1<br>
+ brctl delif br0 eth0<br>
+ brctl delbr br0<br>
+ ifconfig eth1 0.0.0.0 down<br>
+ ifconfig eth0 0.0.0.0 down<br>
<b>$ <br>
</b></tt><br>
<br>
<div class="moz-signature">-- <br>
<hr>
<table>
  <tbody>
    <tr>
      <td> <font face="Tahoma" size="2">J&uuml;rgen Pfeiffer</font> </td>
      <td><br>
      </td>
      <td><br>
      </td>
      <td> <font color="#000000" face="Wingdings" size="2">*</font> <u><font
 color="#00208c" face="Tahoma" size="2"><a
 href="mailto:j.pfeiffer@seskion.de">mailto:j.pfeiffer@seskion.de</a></font></u>
      <font face="Tahoma" size="2"> </font> </td>
    </tr>
    <tr>
      <td> <font color="#00208c" face="Arial Black" size="2">SesKion</font>
      <font face="Tahoma" size="2">Softwareentwicklung und System
Konzeption GmbH</font> </td>
      <td><br>
      </td>
      <td><br>
      </td>
      <td> <font face="Wingdings" size="2">(</font> <font
 face="Tahoma" size="2">: +49-711-9905814 </font> </td>
    </tr>
    <tr>
      <td> <font face="Tahoma" size="2">Karlsruher Str. 11/1</font> </td>
      <td><br>
      </td>
      <td><br>
      </td>
      <td> <font face="Tahoma" size="2">Fax: +49-711-9905827</font> </td>
    </tr>
    <tr>
      <td> <font face="Tahoma" size="2">D-70771 Leinfelden-Echterdingen</font>
      </td>
      <td><br>
      </td>
      <td><br>
      </td>
      <td> <font color="#000000" face="Wingdings" size="2">1</font> <u><font
 color="#00208c" face="Tahoma" size="2"><a href="http://www.seskion.de">http://www.seskion.de</a></font></u>
      <font face="Tahoma" size="2"> </font> </td>
    </tr>
  </tbody>
</table>
<hr>
</div>
</body>
</html>

--------------010209080403040407050606--
