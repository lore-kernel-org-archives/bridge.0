Message-ID: <83475D0A79834C4C964DFE7F73FABFFD@lzheng>
From: "Lv Zheng" <lv.zheng@soliton.com.cn>
References: <0598BD8415F140D9BE986E3AB9FFF35F@lzheng>
	<49639295.9060309@candelatech.com>
In-Reply-To: <49639295.9060309@candelatech.com>
Date: Wed, 7 Jan 2009 09:53:39 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0107_01C970AD.D14939E0"
Subject: Re: [Bridge] vlan and bond integration in bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ben Greear <greearb@candelatech.com>
Cc: Bridge Linux <bridge@lists.linux-foundation.org>

This is a multi-part message in MIME format.

------=_NextPart_000_0107_01C970AD.D14939E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>> vconfig set_name_type DEV_PLUS_VID_NO_PAD

I made a mistake here. As we want single
management interface per VLAN (single L3
management address per VLAN, we will run
single L3 authentication service instance
-- such as DHCP -- per VLAN), we tried
VLAN_PLUS_VID_NO_PAD.

Using name_type as DEV_PLUS_VID or
DEV_PLUS_VID_NO_PAD will end up without
failures, but we will get tow management
interface for single VLAN: eth0.1/eth1.1

Failure screen shot is as follows:

root@zlv:/root# vconfig set_name_type VLAN_PLUS_VID_NO_PAD
Set name-type for VLAN subsystem. Should be visible
in /proc/net/vlan/config
root@zlv:/root# vconfig add eth0 1
Added VLAN with VID =3D=3D 1 to IF -:eth0:-
WARNING:  VLAN 1 does not work with many switches,
consider another number if you have problems.
root@zlv:/root# vconfig add eth1 1
ERROR: trying to add VLAN #1 to IF -:eth1:-  error: Invalid argument
root@zlv:/root# ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:E0:4C:17:05:4F
          inet addr:192.168.100.100  Bcast:192.168.100.255
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:495 errors:0 dropped:0 overruns:0 frame:0
          TX packets:48 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:51480 (50.2 KiB)  TX bytes:4333 (4.2 KiB)
          Interrupt:169 Base address:0xd800

eth1      Link encap:Ethernet  HWaddr 00:14:2A:DE:A9:FC
          inet addr:10.241.110.78  Bcast:10.241.110.255
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:8204 errors:0 dropped:0 overruns:0 frame:0
          TX packets:501 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1244653 (1.1 MiB)  TX bytes:40928 (39.9 KiB)
          Interrupt:177 Base address:0xd400

vlan1     Link encap:Ethernet  HWaddr 00:E0:4C:17:05:4F
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

Best regards/Zetalog

------=_NextPart_000_0107_01C970AD.D14939E0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6001.18183" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY>
<DIV><FONT face=3D"Courier New" size=3D2>&gt;&gt; vconfig set_name_type=20
DEV_PLUS_VID_NO_PAD</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>I made a mistake here. As we =
want=20
single</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>management interface per VLAN =
(single=20
L3</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>management address per VLAN, we =
will=20
run</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>single L3 authentication =
</FONT><FONT=20
face=3D"Courier New" size=3D2>service instance</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>-- such as DHCP -- per VLAN), =
we=20
tried</FONT></DIV>
<DIV><FONT face=3D"Courier New" =
size=3D2>VLAN_PLUS_VID_NO_PAD.</FONT></DIV>
<DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>Using name_type as DEV_PLUS_VID =

or</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>DEV_PLUS_VID_NO_PAD will end up =

without</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>failures, but we will get tow=20
management</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>interface for single VLAN:=20
eth0.1/eth1.1</FONT></DIV></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT><FONT face=3D"Courier =
New"=20
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>Failure screen shot is as=20
follows:</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><A href=3D"mailto:root@zlv:/root"><FONT face=3D"Courier New"=20
size=3D2>root@zlv:/root</FONT></A><FONT face=3D"Courier New" size=3D2># =
vconfig=20
set_name_type VLAN_PLUS_VID_NO_PAD<BR>Set name-type for VLAN subsystem. =
Should=20
be visible<BR>in /proc/net/vlan/config<BR></FONT><A=20
href=3D"mailto:root@zlv:/root"><FONT face=3D"Courier New"=20
size=3D2>root@zlv:/root</FONT></A><FONT face=3D"Courier New" size=3D2># =
vconfig add=20
eth0 1<BR>Added VLAN with VID =3D=3D 1 to IF -:eth0:-<BR>WARNING:&nbsp; =
VLAN 1 does=20
not work with many switches,<BR>consider another number if you have=20
problems.<BR></FONT><A href=3D"mailto:root@zlv:/root"><FONT =
face=3D"Courier New"=20
size=3D2>root@zlv:/root</FONT></A><FONT face=3D"Courier New" size=3D2># =
vconfig add=20
eth1 1<BR>ERROR: trying to add VLAN #1 to IF -:eth1:-&nbsp; error: =
Invalid=20
argument</FONT></DIV>
<DIV><A href=3D"mailto:root@zlv:/root"><FONT face=3D"Courier New"=20
size=3D2>root@zlv:/root</FONT></A><FONT face=3D"Courier New" size=3D2># =
ifconfig=20
-a<BR>eth0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; =
HWaddr=20
00:E0:4C:17:05:4F<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; inet=20
addr:192.168.100.100&nbsp;=20
Bcast:192.168.100.255<BR>Mask:255.255.255.0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
UP BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=20
packets:495 errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX =
packets:48=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
collisions:0=20
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 RX=20
bytes:51480 (50.2 KiB)&nbsp; TX bytes:4333 (4.2=20
KiB)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Interrupt:169=20
Base address:0xd800</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" =
size=3D2>eth1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link=20
encap:Ethernet&nbsp; HWaddr=20
00:14:2A:DE:A9:FC<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; inet=20
addr:10.241.110.78&nbsp;=20
Bcast:10.241.110.255<BR>Mask:255.255.255.0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;=20
UP BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=20
packets:8204 errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX =
packets:501=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
collisions:0=20
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 RX=20
bytes:1244653 (1.1 MiB)&nbsp; TX bytes:40928 (39.9=20
KiB)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Interrupt:177=20
Base address:0xd400</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>vlan1&nbsp;&nbsp;&nbsp;&nbsp; =
Link=20
encap:Ethernet&nbsp; HWaddr=20
00:E0:4C:17:05:4F<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
BROADCAST MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX =
packets:0=20
errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX =
packets:0=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
collisions:0=20
txqueuelen:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
RX=20
bytes:0 (0.0 b)&nbsp; TX bytes:0 (0.0 b)</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>Best =
regards/Zetalog</FONT></DIV>
<DIV><FONT face=3D"Courier New" =
size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0107_01C970AD.D14939E0--
