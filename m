Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C677EC.EC8556E1"
Date: Mon, 15 May 2006 12:28:08 +0530
Message-ID: <93F0E3CFC1ABB646B8808894FC7CDD250454073D@azindbaex01.aztec.soft>
From: "Vinod L R" <vinodl@aztecsoft.com>
Subject: [Bridge] wds not working...help needed
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C677EC.EC8556E1
Content-Type: multipart/alternative;
	boundary="----------=_1147676036-19156-326"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1147676036-19156-326
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Hi,

=0D

I am really struck up in WDS !!!!!!!

=0D

I am using madwifi-ng-r1474-20060314 in one of my APs & the other AP has
madwifi-ng-r1531-20060427 .....

I am using Proxim 802.11 a/b/g card ..

I followed all the steps to setup & configure WDS
(http://madwifi.org/users-guide/) for both my APs ...

=0D

Both my APs are in mode 802.11a & my client is able to associate with
both my APs individually & hence can ping both separately ...

But there is no sign of WDS at all !!!

=0D

The APs can't ping each other, nor the client, after associating with
one AP, can ping the other AP ..

Ping says " Destination Unreachable " ....

=0D

Outputs from both my AP's iwconfig & ifconfig commands are :-

=0D

1st AP ::::::::::::::::::::::::

Iwconfig:::::

ath0      IEEE 802.11a  ESSID:"wds_testing" =0D

          Mode:Master  Frequency:5.2 GHz  Access Point:
00:20:A6:54:E0:61  =0D

          Bit Rate:0 kb/s   Tx-Power:13 dBm   Sensitivity=3D0/3 =0D

          Retry:off   RTS thr:off   Fragment thr:off

          Encryption key:off

          Power Management:off

          Link Quality=3D41/94  Signal level=3D-54 dBm  Noise level=3D-95 d=
Bm

          Rx invalid nwid:166  Rx invalid crypt:0  Rx invalid frag:0

          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

=0D

ath1      IEEE 802.11a  Mode:Repeater  Frequency:5.2 GHz =0D

          Access Point: 00:20:A6:54:E0:75   Bit Rate:0 kb/s
Tx-Power:13 dBm  =0D

          Sensitivity=3D0/3 =0D

          Retry:off   RTS thr:off   Fragment thr:off

          Encryption key:off

          Power Management:off

          Link Quality=3D41/94  Signal level=3D-54 dBm  Noise level=3D-95 d=
Bm

          Rx invalid nwid:112  Rx invalid crypt:0  Rx invalid frag:0

          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

=0D

=0D

Ifconfig :::::::

ath0      Link encap:Ethernet  HWaddr 00:20:A6:54:E0:61 =0D

          inet addr:192.168.1.12  Bcast:192.168.1.255
Mask:255.255.255.0

          inet6 addr: fe80::220:a6ff:fe54:e061/64 Scope:Link

          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

          RX packets:485 errors:0 dropped:0 overruns:0 frame:0

          TX packets:555 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:0=0D

          RX bytes:21098 (20.6 KiB)  TX bytes:24066 (23.5 KiB)

=0D

ath1      Link encap:Ethernet  HWaddr 00:20:A6:54:E0:61 =0D

          inet6 addr: fe80::220:a6ff:fe54:e061/64 Scope:Link

          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

          RX packets:47 errors:0 dropped:0 overruns:0 frame:0

          TX packets:5 errors:0 dropped:1 overruns:0 carrier:0

          collisions:0 txqueuelen:0=0D

          RX bytes:1930 (1.8 KiB)  TX bytes:378 (378.0 b)

=0D

br0       Link encap:Ethernet  HWaddr 00:20:A6:54:E0:61 =0D

          inet6 addr: fe80::220:a6ff:fe54:e061/64 Scope:Link

          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

          RX packets:38 errors:0 dropped:0 overruns:0 frame:0

          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:0=0D

          RX bytes:1020 (1020.0 b)  TX bytes:378 (378.0 b)

=0D

lo        Link encap:Local Loopback =0D

          inet addr:127.0.0.1  Mask:255.0.0.0

          inet6 addr: ::1/128 Scope:Host

          UP LOOPBACK RUNNING  MTU:16436  Metric:1

          RX packets:2712 errors:0 dropped:0 overruns:0 frame:0

          TX packets:2712 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:0=0D

          RX bytes:3161874 (3.0 MiB)  TX bytes:3161874 (3.0 MiB)

=0D

wifi0     Link encap:Ethernet  HWaddr 00:20:A6:54:E0:61 =0D

          inet6 addr: fe80::220:a6ff:fe54:e061/64 Scope:Link

          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

          RX packets:5600 errors:0 dropped:0 overruns:0 frame:622

          TX packets:1933 errors:420 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:199=0D

          RX bytes:652702 (637.4 KiB)  TX bytes:164100 (160.2 KiB)

          Interrupt:11 Memory:f8a40000-f8a50000=0D

=0D

=0D

2nd AP :::::::::::::

iwconfig :::

ath0      IEEE 802.11a  ESSID:"wds_testing1" =0D

          Mode:Master  Frequency:5.22 GHz  Access Point:
00:20:A6:54:E0:75  =0D

          Bit Rate:0 kb/s   Tx-Power:13 dBm   Sensitivity=3D0/3 =0D

          Retry:off   RTS thr:off   Fragment thr:off

          Encryption key:off

          Power Management:off

          Link Quality=3D17/94  Signal level=3D-78 dBm  Noise level=3D-95 d=
Bm

          Rx invalid nwid:23  Rx invalid crypt:0  Rx invalid frag:0

          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

=0D

ath1      IEEE 802.11a  Mode:Repeater  Frequency:5.22 GHz =0D

          Access Point: 00:20:A6:54:E0:61   Bit Rate:0 kb/s
Tx-Power:13 dBm  =0D

          Sensitivity=3D0/3 =0D

          Retry:off   RTS thr:off   Fragment thr:off

          Encryption key:off

          Power Management:off

          Link Quality=3D17/94  Signal level=3D-78 dBm  Noise level=3D-95 d=
Bm

          Rx invalid nwid:4  Rx invalid crypt:0  Rx invalid frag:0

          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

=0D

Ifconfig :::

ath0      Link encap:Ethernet  HWaddr 00:20:A6:54:E0:75 =0D

          inet addr:192.168.1.35  Bcast:192.168.1.255
Mask:255.255.255.0

          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

          RX packets:57 errors:0 dropped:0 overruns:0 frame:0

          TX packets:135 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:0=0D

          RX bytes:2142 (2.0 KiB)  TX bytes:7856 (7.6 KiB)

=0D

ath1      Link encap:Ethernet  HWaddr 00:20:A6:54:E0:75 =0D

          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

          RX packets:0 errors:0 dropped:0 overruns:0 frame:0

          TX packets:0 errors:0 dropped:1 overruns:0 carrier:0

          collisions:0 txqueuelen:0=0D

          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

=0D

br0       Link encap:Ethernet  HWaddr 00:20:A6:54:E0:75 =0D

          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

          RX packets:0 errors:0 dropped:0 overruns:0 frame:0

          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:0=0D

          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

=0D

lo        Link encap:Local Loopback =0D

          inet addr:127.0.0.1  Mask:255.0.0.0

          UP LOOPBACK RUNNING  MTU:16436  Metric:1

          RX packets:3118 errors:0 dropped:0 overruns:0 frame:0

          TX packets:3118 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:0=0D

          RX bytes:4203616 (4.0 MiB)  TX bytes:4203616 (4.0 MiB)

=0D

wifi0     Link encap:UNSPEC  HWaddr
00-20-A6-54-E0-75-58-0B-00-00-00-00-00-00-00-00 =0D

          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

          RX packets:7092 errors:0 dropped:0 overruns:0 frame:35

          TX packets:334 errors:4 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:199=0D

          RX bytes:1037700 (1013.3 KiB)  TX bytes:24075 (23.5 KiB)

          Interrupt:11 Memory:d4a80000-d4a90000=0D

=0D

=0D

Anybody could help me out please !!!

=0D

Thanks & regards,=0D

vinod=0D

=0D
=0D
=0D



The information contained in, or attached to, this e-mail, contains confide=
ntial information and is intended solely for the use of the individual or e=
ntity to whom they are addressed and is subject to legal privilege. If you =
have received this e-mail in error you should notify the sender immediately=
 by reply e-mail, delete the message from your system and notify your syste=
m manager. Please do not copy it for any purpose, or disclose its contents =
to any other person. The views or opinions presented in this e-mail are sol=
ely those of the author and do not necessarily represent those of the compa=
ny. The recipient should check this e-mail and any attachments for the pres=
ence of viruses. The company accepts no liability for any damage caused, di=
rectly or indirectly, by any virus transmitted in this email.

www.aztecsoft.com
------------=_1147676036-19156-326
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<TITLE id=3DridTitle>Message</TITLE>

<DEFANGED_STYLE BODY {
	MARGIN-TOP: 25px; FONT-SIZE: 10pt; MARGIN-LEFT: 10px; COLOR: #0033cc; FONT=
-FAMILY: Arial, Helvetica; BACKGROUND-COLOR: #ffffff
}
></DEFANGED_STYLE>

<META content=3D"MSHTML 6.00.2900.2873" name=3DGENERATOR></HEAD>
<BODY id=3D"ridBody" DEFANGED_style=3D"BACKGROUND-COLOR: #ffffff" bgColor=
=3D"#ffffff"=0D
DEFANGED_background=3D"cid:504135606@15052006-1057">
<DIV>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Hi,<?xml:namespace p=
refix =3D o ns =3D=0D
"urn:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></S=
PAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">I am really struck u=
p in WDS=0D
!!!!!!!<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></S=
PAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">I am using madwifi-n=
g-r1474-20060314=0D
in one of my APs &amp; the other AP has madwifi-ng-r1531-20060427=0D
&#8230;..<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">I am using Proxim 80=
2.11 a/b/g card=0D
..<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">I followed all the s=
teps to setup=0D
&amp; configure WDS (</SPAN></FONT><FONT face=3D"Courier New" size=3D2><SPA=
N=0D
DEFANGED_style=3D"FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><A=0D
href=3D"http://madwifi.org/users-guide/">http://madwifi.org/users-guide/</A=
>)</SPAN></FONT><FONT=0D
face=3DArial size=3D2><SPAN DEFANGED_style=3D"FONT-SIZE: 10pt; FONT-FAMILY:=
 Arial"> for both my=0D
APs &#8230;<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></S=
PAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Both my APs are in m=
ode 802.11a=0D
&amp; my client is able to associate with both my APs individually &amp; he=
nce=0D
</SPAN></FONT>can ping both separately &#8230;<o:p></o:p></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt">But there is no sign of WDS at all=0D
!!!<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt">The APs can&#8217;t ping each other, <B=
=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><U><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; mso-bidi-font-weight: normal">nor</SPA=
N></U></B> the=0D
client, after associating with one AP, can ping the other AP=0D
..<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><?xml:namespace prefix =3D st1 ns =3D=0D
"urn:schemas-microsoft-com:office:smarttags" /><DEFANGED_st1:place><FONT=0D
face=3D"Times New Roman" size=3D3><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt">Ping</SPAN></FONT></DEFANGED_st1:place> =
says &#8220; Destination=0D
Unreachable &#8221; &#8230;.<o:p></o:p></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt">Outputs from both my AP&#8217;s iwconfig=
 &amp; ifconfig=0D
commands are :-<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><B DEFANGED_style=3D"mso-bidi-font-weight: normal"><U>=
<FONT=0D
face=3D"Times New Roman" size=3D3><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 12pt; mso-bidi-font-weight:=
 normal">1<SUP>st</SUP>=0D
AP ::::::::::::::::::::::::<o:p></o:p></SPAN></FONT></U></B></P>
<P class=3DMsoNormal><B DEFANGED_style=3D"mso-bidi-font-weight: normal"><FO=
NT=0D
face=3D"Times New Roman" size=3D3><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 12pt; mso-bidi-font-weight:=
 normal">Iwconfig:::::<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">ath0<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;</SPAN>IEEE 802.11a<SPAN=
=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>ESSID:"wds_testing"<SPAN=
=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN><o:p></o:p></SPAN></FONT=
></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Mode:Master<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>=
Frequency:5.2=0D
GHz<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>Access Point:=
=0D
</SPAN></FONT></B><DEFANGED_st1:time Minute=3D"20" Hour=3D"0"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">00:20</SPAN></FONT></B></DEFANGED_st1:=
time><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">:A6:54:E0:61<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN><o:p></o:p></SPAN>=
</FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Bit Rate:0 kb/s<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbs=
p;=0D
</SPAN>Tx-Power:13 dBm<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbs=
p;=0D
</SPAN>Sensitivity=3D0/3<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=
=0D
</SPAN><o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Retry:off<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </S=
PAN>RTS=0D
thr:off<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Fragm=
ent=0D
thr:off<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Encryption key:off<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Power Management:off<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Link Quality=3D41/94<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp=
; </SPAN>Signal=0D
level=3D-54 dBm<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>Noi=
se level=3D-95=0D
dBm<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Rx invalid nwid:166<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=
 </SPAN>Rx=0D
invalid crypt:0<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>Rx =
invalid=0D
frag:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Tx excessive retries:0<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nb=
sp;=0D
</SPAN>Invalid misc:0<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp=
; </SPAN>Missed=0D
beacon:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">ath1<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>=
IEEE=0D
802.11a<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>Mode:Repeat=
er<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>Frequency:5.2 GHz<SPAN=
=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN><o:p></o:p></SPAN></FONT=
></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Access Point: </SPAN></FONT></B><DEFANGED_st1:time Minute=3D"20" Hou=
r=3D"0"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">00:20</SPAN></FONT></B></DEFANGED_st1:=
time><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">:A6:54:E0:75<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Bit Rate:0 kb/s<SP=
AN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Tx-Power:13 dBm<SP=
AN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN><o:p></o:p></SPAN>=
</FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Sensitivity=3D0/3<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=
=0D
</SPAN><o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Retry:off<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </S=
PAN>RTS=0D
thr:off<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Fragm=
ent=0D
thr:off<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Encryption key:off<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Power Management:off<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Link Quality=3D41/94<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp=
; </SPAN>Signal=0D
level=3D-54 dBm<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>Noi=
se level=3D-95=0D
dBm<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Rx invalid nwid:112<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=
 </SPAN>Rx=0D
invalid crypt:0<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>Rx =
invalid=0D
frag:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Tx excessive retries:0<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nb=
sp;=0D
</SPAN>Invalid misc:0<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp=
; </SPAN>Missed=0D
beacon:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><B DEFANGED_style=3D"mso-bidi-font-weight: normal"><FO=
NT=0D
face=3D"Times New Roman" size=3D3><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 12pt; mso-bidi-font-weight:=
 normal">Ifconfig=0D
:::::::<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">ath0<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>=
Link=0D
encap:Ethernet<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>HWad=
dr=0D
00:20:A6:54:E0:61<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN><o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>inet addr:192.168.1.12<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nb=
sp;=0D
</SPAN>Bcast:192.168.1.255<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=
=0D
</SPAN>Mask:255.255.255.0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>inet6 addr: fe80::220:a6ff:fe54:e061/64=0D
Scope:Link<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>UP BROADCAST RUNNING MULTICAST<SPAN DEFANGED_style=3D"mso-spacerun: =
yes">&nbsp;=0D
</SPAN>MTU:1500<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN>Metric:1<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX packets:485 errors:0 dropped:0 overruns:0=0D
frame:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>TX packets:555 errors:0 dropped:0 overruns:0=0D
carrier:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>collisions:0 txqueuelen:0 <o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX bytes:21098 (20.6 KiB)<SPAN DEFANGED_style=3D"mso-spacerun: yes">=
&nbsp; </SPAN>TX=0D
bytes:24066 (23.5 KiB)<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">ath1<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>=
Link=0D
encap:Ethernet<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>HWad=
dr=0D
00:20:A6:54:E0:61<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN><o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>inet6 addr: fe80::220:a6ff:fe54:e061/64=0D
Scope:Link<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>UP BROADCAST RUNNING MULTICAST<SPAN DEFANGED_style=3D"mso-spacerun: =
yes">&nbsp;=0D
</SPAN>MTU:1500<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN>Metric:1<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX packets:47 errors:0 dropped:0 overruns:0=0D
frame:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>TX packets:5 errors:0 dropped:1 overruns:0=0D
carrier:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>collisions:0 txqueuelen:0 <o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX bytes:1930 (1.8 KiB)<SPAN DEFANGED_style=3D"mso-spacerun: yes">&n=
bsp; </SPAN>TX=0D
bytes:378 (378.0 b)<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">br0<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <=
/SPAN>Link=0D
encap:Ethernet<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>HWad=
dr=0D
00:20:A6:54:E0:61<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN><o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>inet6 addr: fe80::220:a6ff:fe54:e061/64=0D
Scope:Link<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>UP BROADCAST RUNNING MULTICAST<SPAN DEFANGED_style=3D"mso-spacerun: =
yes">&nbsp;=0D
</SPAN>MTU:1500<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN>Metric:1<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX packets:38 errors:0 dropped:0 overruns:0=0D
frame:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>TX packets:5 errors:0 dropped:0 overruns:0=0D
carrier:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>collisions:0 txqueuelen:0 <o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX bytes:1020 (1020.0 b)<SPAN DEFANGED_style=3D"mso-spacerun: yes">&=
nbsp; </SPAN>TX=0D
bytes:378 (378.0 b)<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">lo<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; </SPAN>Link=0D
encap:Local Loopback<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN><o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>inet addr:127.0.0.1<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=
=0D
</SPAN>Mask:255.0.0.0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>inet6 addr: ::1/128 Scope:Host<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>UP LOOPBACK RUNNING<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=
=0D
</SPAN>MTU:16436<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN>Metric:1<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX packets:2712 errors:0 dropped:0 overruns:0=0D
frame:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>TX packets:2712 errors:0 dropped:0 overruns:0=0D
carrier:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>collisions:0 txqueuelen:0 <o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX bytes:3161874 (3.0 MiB)<SPAN DEFANGED_style=3D"mso-spacerun: yes"=
>&nbsp;=0D
</SPAN>TX bytes:3161874 (3.0 MiB)<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">wifi0<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>Link=
=0D
encap:Ethernet<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>HWad=
dr=0D
00:20:A6:54:E0:61<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN><o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>inet6 addr: fe80::220:a6ff:fe54:e061/64=0D
Scope:Link<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>UP BROADCAST RUNNING MULTICAST<SPAN DEFANGED_style=3D"mso-spacerun: =
yes">&nbsp;=0D
</SPAN>MTU:1500<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN>Metric:1<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX packets:5600 errors:0 dropped:0 overruns:0=0D
frame:622<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>TX packets:1933 errors:420 dropped:0 overruns:0=0D
carrier:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>collisions:0 txqueuelen:199 <o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX bytes:652702 (637.4 KiB)<SPAN DEFANGED_style=3D"mso-spacerun: yes=
">&nbsp;=0D
</SPAN>TX bytes:164100 (160.2 KiB)<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Interrupt:11 Memory:f8a40000-f8a50000 <o:p></o:p></SPAN></FONT></B><=
/P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><U><FONT face=3D"Courier Ne=
w" size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><o:p><SPAN=0D
DEFANGED_style=3D"TEXT-DECORATION: none">&nbsp;</SPAN></o:p></SPAN></FONT><=
/U></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><U><FONT face=3D"Courier Ne=
w" size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">2<SUP>nd</SUP>=0D
AP :::::::::::::<o:p></o:p></SPAN></FONT></U></B></P>
<P class=3DMsoNormal><B DEFANGED_style=3D"mso-bidi-font-weight: normal"><FO=
NT=0D
face=3D"Times New Roman" size=3D3><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 12pt; mso-bidi-font-weight:=
 normal">iwconfig=0D
:::<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">ath0<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>=
IEEE=0D
802.11a<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>ESSID:"wds_=
testing1"<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN><o:p></o:p></SPAN></FONT=
></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Mode:Master<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>=
Frequency:5.22=0D
GHz<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>Access Point:=
=0D
</SPAN></FONT></B><DEFANGED_st1:time Minute=3D"20" Hour=3D"0"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">00:20</SPAN></FONT></B></DEFANGED_st1:=
time><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">:A6:54:E0:75<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN><o:p></o:p></SPAN>=
</FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Bit Rate:0 kb/s<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbs=
p;=0D
</SPAN>Tx-Power:13 dBm<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbs=
p;=0D
</SPAN>Sensitivity=3D0/3<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=
=0D
</SPAN><o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Retry:off<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </S=
PAN>RTS=0D
thr:off<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Fragm=
ent=0D
thr:off<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Encryption key:off<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Power Management:off<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Link Quality=3D17/94<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp=
; </SPAN>Signal=0D
level=3D-78 dBm<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>Noi=
se level=3D-95=0D
dBm<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Rx invalid nwid:23<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>Rx=0D
invalid crypt:0<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>Rx =
invalid=0D
frag:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Tx excessive retries:0<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nb=
sp;=0D
</SPAN>Invalid misc:0<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp=
; </SPAN>Missed=0D
beacon:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">ath1<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>=
IEEE=0D
802.11a<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>Mode:Repeat=
er<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>Frequency:5.22 GHz<SPAN=
=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN><o:p></o:p></SPAN></FONT=
></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Access Point: </SPAN></FONT></B><DEFANGED_st1:time Minute=3D"20" Hou=
r=3D"0"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">00:20</SPAN></FONT></B></DEFANGED_st1:=
time><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">:A6:54:E0:61<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Bit Rate:0 kb/s<SP=
AN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Tx-Power:13 dBm<SP=
AN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN><o:p></o:p></SPAN>=
</FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Sensitivity=3D0/3<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=
=0D
</SPAN><o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Retry:off<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </S=
PAN>RTS=0D
thr:off<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Fragm=
ent=0D
thr:off<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Encryption key:off<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Power Management:off<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Link Quality=3D17/94<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp=
; </SPAN>Signal=0D
level=3D-78 dBm<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>Noi=
se level=3D-95=0D
dBm<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Rx invalid nwid:4<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; <=
/SPAN>Rx invalid=0D
crypt:0<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>Rx invalid=
=0D
frag:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Tx excessive retries:0<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nb=
sp;=0D
</SPAN>Invalid misc:0<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp=
; </SPAN>Missed=0D
beacon:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3DMsoNormal><B DEFANGED_style=3D"mso-bidi-font-weight: normal"><FO=
NT=0D
face=3D"Times New Roman" size=3D3><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 12pt; mso-bidi-font-weight:=
 normal"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3DMsoNormal><B DEFANGED_style=3D"mso-bidi-font-weight: normal"><FO=
NT=0D
face=3D"Times New Roman" size=3D3><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 12pt; mso-bidi-font-weight:=
 normal">Ifconfig=0D
:::<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">ath0<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>=
Link=0D
encap:Ethernet<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>HWad=
dr=0D
00:20:A6:54:E0:75<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN><o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>inet addr:192.168.1.35<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nb=
sp;=0D
</SPAN>Bcast:192.168.1.255<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=
=0D
</SPAN>Mask:255.255.255.0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>UP BROADCAST RUNNING MULTICAST<SPAN DEFANGED_style=3D"mso-spacerun: =
yes">&nbsp;=0D
</SPAN>MTU:1500<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN>Metric:1<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX packets:57 errors:0 dropped:0 overruns:0=0D
frame:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>TX packets:135 errors:0 dropped:0 overruns:0=0D
carrier:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>collisions:0 txqueuelen:0 <o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX bytes:2142 (2.0 KiB)<SPAN DEFANGED_style=3D"mso-spacerun: yes">&n=
bsp; </SPAN>TX=0D
bytes:7856 (7.6 KiB)<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">ath1<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>=
Link=0D
encap:Ethernet<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>HWad=
dr=0D
00:20:A6:54:E0:75<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN><o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>UP BROADCAST RUNNING MULTICAST<SPAN DEFANGED_style=3D"mso-spacerun: =
yes">&nbsp;=0D
</SPAN>MTU:1500<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN>Metric:1<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX packets:0 errors:0 dropped:0 overruns:0=0D
frame:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;=0D
</SPAN><SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;</SPAN>TX packets:0=
 errors:0=0D
dropped:1 overruns:0 carrier:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>collisions:0 txqueuelen:0 <o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX bytes:0 (0.0 b)<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>TX=0D
bytes:0 (0.0 b)<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">br0<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <=
/SPAN>Link=0D
encap:Ethernet<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>HWad=
dr=0D
00:20:A6:54:E0:75<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN><o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>UP BROADCAST RUNNING MULTICAST<SPAN DEFANGED_style=3D"mso-spacerun: =
yes">&nbsp;=0D
</SPAN>MTU:1500<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN>Metric:1<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX packets:0 errors:0 dropped:0 overruns:0=0D
frame:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>TX packets:0 errors:0 dropped:0 overruns:0=0D
carrier:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>collisions:0 txqueuelen:0 <o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX bytes:0 (0.0 b)<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>TX=0D
bytes:0 (0.0 b)<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">lo<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; </SPAN>Link=0D
encap:Local Loopback<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN><o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;</SPAN>inet=0D
addr:127.0.0.1<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN>Mask:255.0.0.0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>UP LOOPBACK RUNNING<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=
=0D
</SPAN>MTU:16436<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN>Metric:1<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX packets:3118 errors:0 dropped:0 overruns:0=0D
frame:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>TX packets:3118 errors:0 dropped:0 overruns:0=0D
carrier:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>collisions:0 txqueuelen:0 <o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX bytes:4203616 (4.0 MiB)<SPAN DEFANGED_style=3D"mso-spacerun: yes"=
>&nbsp;=0D
</SPAN>TX bytes:4203616 (4.0 MiB)<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal">wifi0<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>Link e=
ncap:UNSPEC<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN>HWaddr=0D
00-20-A6-54-E0-75-58-0B-00-00-00-00-00-00-00-00<SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp; </SPAN><o:p></o:p></SPAN></FONT=
></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>UP BROADCAST RUNNING MULTICAST<SPAN DEFANGED_style=3D"mso-spacerun: =
yes">&nbsp;=0D
</SPAN>MTU:1500<SPAN DEFANGED_style=3D"mso-spacerun: yes">&nbsp;=0D
</SPAN>Metric:1<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX packets:7092 errors:0 dropped:0 overruns:0=0D
frame:35<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>TX packets:334 errors:4 dropped:0 overruns:0=0D
carrier:0<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>collisions:0 txqueuelen:199 <o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>RX bytes:1037700 (1013.3 KiB)<SPAN DEFANGED_style=3D"mso-spacerun: y=
es">&nbsp;=0D
</SPAN>TX bytes:24075 (23.5 KiB)<o:p></o:p></SPAN></FONT></B></P>
<P class=3D"MsoNormal" DEFANGED_style=3D"mso-layout-grid-align: none"><B=0D
DEFANGED_style=3D"mso-bidi-font-weight: normal"><FONT face=3D"Courier New" =
size=3D2><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: 'Courier=
 New'; mso-bidi-font-weight: normal"><SPAN=0D
DEFANGED_style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=0D
</SPAN>Interrupt:11 Memory:d4a80000-d4a90000 <o:p></o:p></SPAN></FONT></B><=
/P>
<P class=3DMsoNormal><B DEFANGED_style=3D"mso-bidi-font-weight: normal"><FO=
NT=0D
face=3D"Times New Roman"><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 12pt; mso-bidi-font-weight:=
 normal"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3DMsoNormal><B DEFANGED_style=3D"mso-bidi-font-weight: normal"><U>=
<FONT=0D
face=3D"Times New Roman"><SPAN=0D
DEFANGED_style=3D"FONT-WEIGHT: bold; FONT-SIZE: 12pt; mso-bidi-font-weight:=
 normal"><o:p><SPAN=0D
DEFANGED_style=3D"TEXT-DECORATION: none">&nbsp;</SPAN></o:p></SPAN></FONT><=
/U></B></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman"><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt">Anybody could help me out please=0D
!!!<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman"><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman"><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt">Thanks &amp; regards,<FONT face=3DArial>=
<FONT=0D
color=3D#0000ff><SPAN=0D
class=3D235412612-10052006>&nbsp;</SPAN></FONT></FONT></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman"><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt"><FONT face=3DArial><FONT color=3D#0000ff=
><SPAN=0D
class=3D235412612-10052006>vinod&nbsp;</SPAN><o:p></o:p></FONT></FONT></SPA=
N></FONT></P></DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft>
<DIV align=3Dleft><FONT face=3DArial color=3D#0000ff><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt; COLOR: navy"><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt; COLOR: navy"></SPAN></SPAN></FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial color=3D#0000ff><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt; COLOR: navy"><SPAN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt; COLOR: navy"></SPAN></SPAN></FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial color=3D#0000ff></FONT>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial color=3D#0000ff></FONT>&nbsp;</DIV>
<DIV align=3Dleft><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; COLOR: navy"><SP=
AN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt; COLOR: navy"></SPAN></SPAN></DIV>
<DIV align=3Dleft><FONT face=3DArial color=3D#0000ff>
<DIV align=3Dleft><SPAN DEFANGED_style=3D"FONT-SIZE: 12pt; COLOR: navy"><SP=
AN=0D
DEFANGED_style=3D"FONT-SIZE: 12pt; COLOR: navy"></SPAN></SPAN></DIV></FONT>=
</DIV></DIV></BODY></HTML>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><br>
The information contained in, or attached to, this e-mail, contains confide=
ntial information and is intended solely for the use of the individual or e=
ntity to whom they are addressed and is subject to legal privilege. If you =
have received this e-mail in error you should notify the sender immediately=
 by reply e-mail, delete the message from your system and notify your syste=
m manager. Please do not copy it for any purpose, or disclose its contents =
to any other person. The views or opinions presented in this e-mail are sol=
ely those of the author and do not necessarily represent those of the compa=
ny. The recipient should check this e-mail and any attachments for the pres=
ence of viruses. The company accepts no liability for any damage caused, di=
rectly or indirectly, by any virus transmitted in this email.<br>
<br>
www.aztecsoft.com<br>
</font></td></tr></table>
------------=_1147676036-19156-326--

------_=_NextPart_001_01C677EC.EC8556E1
Content-Type: image/jpeg;
	name="Clear Day Bkgrd.jpg"
Content-Transfer-Encoding: base64
Content-ID: <504135606@15052006-1057>
Content-Description: Clear Day Bkgrd.jpg
Content-Location: Clear%20Day%20Bkgrd.jpg
Content-Disposition: inline

/9j/4AAQSkZJRgABAgEASABIAAD/7QVoUGhvdG9zaG9wIDMuMAA4QklNA+0A
AAAAABAASAAAAAEAAQBIAAAAAQABOEJJTQPzAAAAAAAIAAAAAAAAAAA4QklN
BAoAAAAAAAEAADhCSU0nEAAAAAAACgABAAAAAAAAAAI4QklNA/UAAAAAAEgA
L2ZmAAEAbGZmAAYAAAAAAAEAL2ZmAAEAoZmaAAYAAAAAAAEAMgAAAAEAWgAA
AAYAAAAAAAEANQAAAAEALQAAAAYAAAAAAAE4QklNA/gAAAAAAHAAAP//////
//////////////////////8D6AAAAAD/////////////////////////////
A+gAAAAA/////////////////////////////wPoAAAAAP//////////////
//////////////8D6AAAOEJJTQQIAAAAAAAQAAAAAQAAAkAAAAJAAAAAADhC
SU0ECQAAAAAD9wAAAAEAAACAAAAAgAAAAYAAAMAAAAAD2wAYAAH/2P/gABBK
RklGAAECAQBIAEgAAP/+ACdGaWxlIHdyaXR0ZW4gYnkgQWRvYmUgUGhvdG9z
aG9wqCA0LjAA/+4ADkFkb2JlAGSAAAAAAf/bAIQADAgICAkIDAkJDBELCgsR
FQ8MDA8VGBMTFRMTGBEMDAwMDAwRDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM
DAwMDAENCwsNDg0QDg4QFA4ODhQUDg4ODhQRDAwMDAwREQwMDAwMDBEMDAwM
DAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAgACAAwEiAAIRAQMRAf/d
AAQACP/EAT8AAAEFAQEBAQEBAAAAAAAAAAMAAQIEBQYHCAkKCwEAAQUBAQEB
AQEAAAAAAAAAAQACAwQFBgcICQoLEAABBAEDAgQCBQcGCAUDDDMBAAIRAwQh
EjEFQVFhEyJxgTIGFJGhsUIjJBVSwWIzNHKC0UMHJZJT8OHxY3M1FqKygyZE
k1RkRcKjdDYX0lXiZfKzhMPTdePzRieUpIW0lcTU5PSltcXV5fVWZnaGlqa2
xtbm9jdHV2d3h5ent8fX5/cRAAICAQIEBAMEBQYHBwYFNQEAAhEDITESBEFR
YXEiEwUygZEUobFCI8FS0fAzJGLhcoKSQ1MVY3M08SUGFqKygwcmNcLSRJNU
oxdkRVU2dGXi8rOEw9N14/NGlKSFtJXE1OT0pbXF1eX1VmZ2hpamtsbW5vYn
N0dXZ3eHl6e3x//aAAwDAQACEQMRAD8A9LSS7JlWLMolMkkmpXSTpIqUnCin
CQQySTSknWilJkpSQtKxSlJJBKk6ZOkFP//Q9LlJMnVZmVCYqRUUCpSRKUpk
ErSpBRhOkClkCkmCcJ1rVQmUk0JKUm7p0kEqSTSkUrU//9H0kKQUU8qoCzlc
lRTyopEqC6SSSSVwlokkihScJAJwEgEKCRTpiE6lLJJJkFLJJJJq5//S9JTJ
0ypthcJJkpSUukklqipSkmhSARAQVBJOE6ctWCdJIooYlRKkSok6ppXBSRSC
codEv//T9JSSThVGwxITKZTQhSrUE6QCdOCCuEkySKF5Ugop0QgrpikSokok
qCxTKSaEwrlBP8Eyfskh/9T0lSUSkCVUZ2SSYKSKFkkkgipSSdMUlLpFMmJS
tVLykmlOhaVJJAJ4RQslKSZBL//V9JTwkkqjOunUU4KchSQTpJKWJSTEppQt
NLkpkk8IbqUAnSTIqZJSmSRQsmUlEoFIf//W9KCSSdVWdZIJQkkplKZNKSNo
pc6qMKSZBKycFOkB4pUq1JJ4CUI0i1kydMUClUpkkkEv/9kAOEJJTQQGAAAA
AAAHAAMAAAABAQD//gAnRmlsZSB3cml0dGVuIGJ5IEFkb2JlIFBob3Rvc2hv
cKggNC4wAP/uAA5BZG9iZQBkAAAAAAH/2wCEAAoHBwcIBwoICAoPCggKDxIN
CgoNEhQQEBIQEBQRDAwMDAwMEQwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM
DAwBCwwMFRMVIhgYIhQODg4UFA4ODg4UEQwMDAwMEREMDAwMDAwRDAwMDAwM
DAwMDAwMDAwMDAwMDAwMDAwMDAwMDP/AABEIASwBLAMBEQACEQEDEQH/3QAE
ACb/xAGiAAAABwEBAQEBAAAAAAAAAAAEBQMCBgEABwgJCgsBAAICAwEBAQEB
AAAAAAAAAAEAAgMEBQYHCAkKCxAAAgEDAwIEAgYHAwQCBgJzAQIDEQQABSES
MUFRBhNhInGBFDKRoQcVsUIjwVLR4TMWYvAkcoLxJUM0U5KismNzwjVEJ5Oj
szYXVGR0w9LiCCaDCQoYGYSURUaktFbTVSga8uPzxNTk9GV1hZWltcXV5fVm
doaWprbG1ub2N0dXZ3eHl6e3x9fn9zhIWGh4iJiouMjY6PgpOUlZaXmJmam5
ydnp+So6SlpqeoqaqrrK2ur6EQACAgECAwUFBAUGBAgDA20BAAIRAwQhEjFB
BVETYSIGcYGRMqGx8BTB0eEjQhVSYnLxMyQ0Q4IWklMlomOywgdz0jXiRIMX
VJMICQoYGSY2RRonZHRVN/Kjs8MoKdPj84SUpLTE1OT0ZXWFlaW1xdXl9UZW
ZnaGlqa2xtbm9kdXZ3eHl6e3x9fn9zhIWGh4iJiouMjY6Pg5SVlpeYmZqbnJ
2en5KjpKWmp6ipqqusra6vr/2gAMAwEAAhEDEQA/AOoZluG1hQ3TArqYpaxQ
7fCrROKGtsVcadsVdthVvamBXYpcBgQ3TFk7FW8Vdtirgu+BV6rQ1xSuGRZN
0GKtU3+WFFOpirVBiq04UNYUOxVo4q49cVawoaritt1xVo4q7FDqHFLqHFW+
ONpbpgtaf//Q6jmU4bRGFXVxQ1XFXVxVquFDVcVawq7FXYq3gVvFXDFK4YEu
OKrcKG8VXLgKQvGRZN4EurirVcNIdXFXVxVrFDRwq7FWsULcKGjhQ1irWFXD
FVwwJbxV2KXDArfbFX//0eo5lOI44ULcKHYqtOKHYVaxV2KHYpbwK3irhilv
FXYEuOKGsKt4quGBK4HAluuBLWFXYENYVdXFWq4obrilrFDROFWsKGiMVawo
dTArsKuwKuGBLeKXYq3ir//S6kMynEaOKFuSQ7FVpxQ1hV2KHYpbwKuAxS7F
XYq7FXYq1ireKuxVsYEt1wJbrirsVarih2KtHCrVcUN1xS6uKtE4UNVxV1cV
bxVrFXYq7FDhilcMCW8Vdir/AP/T6l2zKcRo4oaOFWsKHUwKtIwodhV1MCt0
xS2MCuwq7FXYq0cUNVxVuuKXVxVsHFW8CXDFW8CXYodirRwq1hQ7FXYq1ihr
FWxilvFWsVdih2KtjAlvFLsVXYEv/9TqNcynDaJwq1hVvArqYq7FDVMVdhVr
FXYq3irsVccCrckhrFWq4otuuK2uU4GTeBLYxVdgS1ih2KuphVxGKVuFi7FW
qYq6mKt4q7FVuKGxilumBXYVdgS4nCh1dq4rb//V6hXMtw2sKuxVsYFbwK6m
KXEYoaOFVuFDWKG8Ut4q0Tiq3ChaThYtYVbGBV4OBkurkUtg4pdXFXVxVcMC
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
t4q//9k=

------_=_NextPart_001_01C677EC.EC8556E1--
