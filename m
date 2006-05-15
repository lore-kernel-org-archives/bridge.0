Message-ID: <4468FBFC.8090809@fortresstech.com>
Date: Mon, 15 May 2006 18:09:00 -0400
From: Steve Lazaridis <slaz@fortresstech.com>
MIME-Version: 1.0
Subject: Re: [Bridge] wds not working...help needed
References: <93F0E3CFC1ABB646B8808894FC7CDD250454073D@azindbaex01.aztec.soft>
In-Reply-To: <93F0E3CFC1ABB646B8808894FC7CDD250454073D@azindbaex01.aztec.soft>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Vinod L R <vinodl@aztecsoft.com>
Cc: bridge@osdl.org

You probably want to refer to the madwifi list for this.

Recommendations:
Post your script you used to configure the interfaces.
Try not running in repeater mode and create a Vap on one AP
and on the other create a  Vap and a STA.
Bring the STA interface up before brining the Vap up interface.


Steve


Vinod L R wrote:
> Hi,
>=20
> =20
>=20
> I am really struck up in WDS !!!!!!!
>=20
> =20
>=20
> I am using madwifi-ng-r1474-20060314 in one of my APs & the other AP has =

> madwifi-ng-r1531-20060427 =85..
>=20
> I am using Proxim 802.11 a/b/g card ..
>=20
> I followed all the steps to setup & configure WDS=20
> (http://madwifi.org/users-guide/) for both my APs =85
>=20
> =20
>=20
> Both my APs are in mode 802.11a & my client is able to associate with=20
> both my APs individually & hence can ping both separately =85
>=20
> But there is no sign of WDS at all !!!
>=20
> =20
>=20
> The APs can=92t ping each other, *_nor_* the client, after associating=20
> with one AP, can ping the other AP ..
>=20
> Ping says =93 Destination Unreachable =94 =85.
>=20
> =20
>=20
> Outputs from both my AP=92s iwconfig & ifconfig commands are :-
>=20
> =20
>=20
> *_1^st AP ::::::::::::::::::::::::_*
>=20
> *Iwconfig:::::*
>=20
> *ath0      IEEE 802.11a  ESSID:"wds_testing"  *
>=20
> *          Mode:Master  Frequency:5.2 GHz  Access Point:=20
> **00:20**:A6:54:E0:61   *
>=20
> *          Bit Rate:0 kb/s   Tx-Power:13 dBm   Sensitivity=3D0/3  *
>=20
> *          Retry:off   RTS thr:off   Fragment thr:off*
>=20
> *          Encryption key:off*
>=20
> *          Power Management:off*
>=20
> *          Link Quality=3D41/94  Signal level=3D-54 dBm  Noise level=3D-9=
5 dBm*
>=20
> *          Rx invalid nwid:166  Rx invalid crypt:0  Rx invalid frag:0*
>=20
> *          Tx excessive retries:0  Invalid misc:0   Missed beacon:0*
>=20
> * *
>=20
> *ath1      IEEE 802.11a  Mode:Repeater  Frequency:5.2 GHz  *
>=20
> *          Access Point: **00:20**:A6:54:E0:75   Bit Rate:0 kb/s  =20
> Tx-Power:13 dBm   *
>=20
> *          Sensitivity=3D0/3  *
>=20
> *          Retry:off   RTS thr:off   Fragment thr:off*
>=20
> *          Encryption key:off*
>=20
> *          Power Management:off*
>=20
> *          Link Quality=3D41/94  Signal level=3D-54 dBm  Noise level=3D-9=
5 dBm*
>=20
> *          Rx invalid nwid:112  Rx invalid crypt:0  Rx invalid frag:0*
>=20
> *          Tx excessive retries:0  Invalid misc:0   Missed beacon:0*
>=20
> * *
>=20
> =20
>=20
> *Ifconfig :::::::*
>=20
> *ath0      Link encap:Ethernet  HWaddr 00:20:A6:54:E0:61  *
>=20
> *          inet addr:192.168.1.12  Bcast:192.168.1.255  Mask:255.255.255.=
0*
>=20
> *          inet6 addr: fe80::220:a6ff:fe54:e061/64 Scope:Link*
>=20
> *          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1*
>=20
> *          RX packets:485 errors:0 dropped:0 overruns:0 frame:0*
>=20
> *          TX packets:555 errors:0 dropped:0 overruns:0 carrier:0*
>=20
> *          collisions:0 txqueuelen:0 *
>=20
> *          RX bytes:21098 (20.6 KiB)  TX bytes:24066 (23.5 KiB)*
>=20
> * *
>=20
> *ath1      Link encap:Ethernet  HWaddr 00:20:A6:54:E0:61  *
>=20
> *          inet6 addr: fe80::220:a6ff:fe54:e061/64 Scope:Link*
>=20
> *          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1*
>=20
> *          RX packets:47 errors:0 dropped:0 overruns:0 frame:0*
>=20
> *          TX packets:5 errors:0 dropped:1 overruns:0 carrier:0*
>=20
> *          collisions:0 txqueuelen:0 *
>=20
> *          RX bytes:1930 (1.8 KiB)  TX bytes:378 (378.0 b)*
>=20
> * *
>=20
> *br0       Link encap:Ethernet  HWaddr 00:20:A6:54:E0:61  *
>=20
> *          inet6 addr: fe80::220:a6ff:fe54:e061/64 Scope:Link*
>=20
> *          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1*
>=20
> *          RX packets:38 errors:0 dropped:0 overruns:0 frame:0*
>=20
> *          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0*
>=20
> *          collisions:0 txqueuelen:0 *
>=20
> *          RX bytes:1020 (1020.0 b)  TX bytes:378 (378.0 b)*
>=20
> * *
>=20
> *lo        Link encap:Local Loopback  *
>=20
> *          inet addr:127.0.0.1  Mask:255.0.0.0*
>=20
> *          inet6 addr: ::1/128 Scope:Host*
>=20
> *          UP LOOPBACK RUNNING  MTU:16436  Metric:1*
>=20
> *          RX packets:2712 errors:0 dropped:0 overruns:0 frame:0*
>=20
> *          TX packets:2712 errors:0 dropped:0 overruns:0 carrier:0*
>=20
> *          collisions:0 txqueuelen:0 *
>=20
> *          RX bytes:3161874 (3.0 MiB)  TX bytes:3161874 (3.0 MiB)*
>=20
> * *
>=20
> *wifi0     Link encap:Ethernet  HWaddr 00:20:A6:54:E0:61  *
>=20
> *          inet6 addr: fe80::220:a6ff:fe54:e061/64 Scope:Link*
>=20
> *          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1*
>=20
> *          RX packets:5600 errors:0 dropped:0 overruns:0 frame:622*
>=20
> *          TX packets:1933 errors:420 dropped:0 overruns:0 carrier:0*
>=20
> *          collisions:0 txqueuelen:199 *
>=20
> *          RX bytes:652702 (637.4 KiB)  TX bytes:164100 (160.2 KiB)*
>=20
> *          Interrupt:11 Memory:f8a40000-f8a50000 *
>=20
> * *
>=20
> *_ _*
>=20
> *_2^nd AP :::::::::::::_*
>=20
> *iwconfig :::*
>=20
> *ath0      IEEE 802.11a  ESSID:"wds_testing1"  *
>=20
> *          Mode:Master  Frequency:5.22 GHz  Access Point:=20
> **00:20**:A6:54:E0:75   *
>=20
> *          Bit Rate:0 kb/s   Tx-Power:13 dBm   Sensitivity=3D0/3  *
>=20
> *          Retry:off   RTS thr:off   Fragment thr:off*
>=20
> *          Encryption key:off*
>=20
> *          Power Management:off*
>=20
> *          Link Quality=3D17/94  Signal level=3D-78 dBm  Noise level=3D-9=
5 dBm*
>=20
> *          Rx invalid nwid:23  Rx invalid crypt:0  Rx invalid frag:0*
>=20
> *          Tx excessive retries:0  Invalid misc:0   Missed beacon:0*
>=20
> * *
>=20
> *ath1      IEEE 802.11a  Mode:Repeater  Frequency:5.22 GHz  *
>=20
> *          Access Point: **00:20**:A6:54:E0:61   Bit Rate:0 kb/s  =20
> Tx-Power:13 dBm   *
>=20
> *          Sensitivity=3D0/3  *
>=20
> *          Retry:off   RTS thr:off   Fragment thr:off*
>=20
> *          Encryption key:off*
>=20
> *          Power Management:off*
>=20
> *          Link Quality=3D17/94  Signal level=3D-78 dBm  Noise level=3D-9=
5 dBm*
>=20
> *          Rx invalid nwid:4  Rx invalid crypt:0  Rx invalid frag:0*
>=20
> *          Tx excessive retries:0  Invalid misc:0   Missed beacon:0*
>=20
> * *
>=20
> *Ifconfig :::*
>=20
> *ath0      Link encap:Ethernet  HWaddr 00:20:A6:54:E0:75  *
>=20
> *          inet addr:192.168.1.35  Bcast:192.168.1.255  Mask:255.255.255.=
0*
>=20
> *          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1*
>=20
> *          RX packets:57 errors:0 dropped:0 overruns:0 frame:0*
>=20
> *          TX packets:135 errors:0 dropped:0 overruns:0 carrier:0*
>=20
> *          collisions:0 txqueuelen:0 *
>=20
> *          RX bytes:2142 (2.0 KiB)  TX bytes:7856 (7.6 KiB)*
>=20
> * *
>=20
> *ath1      Link encap:Ethernet  HWaddr 00:20:A6:54:E0:75  *
>=20
> *          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1*
>=20
> *          RX packets:0 errors:0 dropped:0 overruns:0 frame:0*
>=20
> *          TX packets:0 errors:0 dropped:1 overruns:0 carrier:0*
>=20
> *          collisions:0 txqueuelen:0 *
>=20
> *          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)*
>=20
> * *
>=20
> *br0       Link encap:Ethernet  HWaddr 00:20:A6:54:E0:75  *
>=20
> *          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1*
>=20
> *          RX packets:0 errors:0 dropped:0 overruns:0 frame:0*
>=20
> *          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0*
>=20
> *          collisions:0 txqueuelen:0 *
>=20
> *          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)*
>=20
> * *
>=20
> *lo        Link encap:Local Loopback  *
>=20
> *          inet addr:127.0.0.1  Mask:255.0.0.0*
>=20
> *          UP LOOPBACK RUNNING  MTU:16436  Metric:1*
>=20
> *          RX packets:3118 errors:0 dropped:0 overruns:0 frame:0*
>=20
> *          TX packets:3118 errors:0 dropped:0 overruns:0 carrier:0*
>=20
> *          collisions:0 txqueuelen:0 *
>=20
> *          RX bytes:4203616 (4.0 MiB)  TX bytes:4203616 (4.0 MiB)*
>=20
> * *
>=20
> *wifi0     Link encap:UNSPEC  HWaddr=20
> 00-20-A6-54-E0-75-58-0B-00-00-00-00-00-00-00-00  *
>=20
> *          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1*
>=20
> *          RX packets:7092 errors:0 dropped:0 overruns:0 frame:35*
>=20
> *          TX packets:334 errors:4 dropped:0 overruns:0 carrier:0*
>=20
> *          collisions:0 txqueuelen:199 *
>=20
> *          RX bytes:1037700 (1013.3 KiB)  TX bytes:24075 (23.5 KiB)*
>=20
> *          Interrupt:11 Memory:d4a80000-d4a90000 *
>=20
> * *
>=20
> *_ _*
>=20
> Anybody could help me out please !!!
>=20
> =20
>=20
> Thanks & regards,=20
>=20
> vinod=20
>=20
> =20
> =20
> =20
>=20
> The information contained in, or attached to, this e-mail, contains=20
> confidential information and is intended solely for the use of the=20
> individual or entity to whom they are addressed and is subject to legal=20
> privilege. If you have received this e-mail in error you should notify=20
> the sender immediately by reply e-mail, delete the message from your=20
> system and notify your system manager. Please do not copy it for any=20
> purpose, or disclose its contents to any other person. The views or=20
> opinions presented in this e-mail are solely those of the author and do=20
> not necessarily represent those of the company. The recipient should=20
> check this e-mail and any attachments for the presence of viruses. The=20
> company accepts no liability for any damage caused, directly or=20
> indirectly, by any virus transmitted in this email.
>=20
> www.aztecsoft.com
>=20
>=20
> ------------------------------------------------------------------------
>=20
>=20
> ------------------------------------------------------------------------
>=20
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
