Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 23 Sep 2004 09:09:33 -0400
Message-ID: <C6D44AA99ECEB540A5498F15F92DA07DDD38FD@amperion01>
From: "Jeff David" <jdavid@amperion.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] RE: Problem COnnecting AP from Mobile Node
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: =?iso-8859-1?B?WW9uZyBDaHUgRXUgKNHu19PT0yk=?= <ceyong@yahoo.com>, hostap@shmoo.com, bridge@osdl.org
Cc: jasonb@edseek.com, jt@hpl.hp.com, linux-help@houseofcraig.net

Your client's IP Address is wrong.  The client should be on the same subnet=
 as the Access Point.  Any routing must occur on the Access Point node, not=
 on the client.  So if you want to connect the MN to 192.168.3.4, it must h=
ave a 192.168.3.x ip address.

Jeff


> -----Original Message-----
> From: Yong Chu Eu (=D1=EE=D7=D3=D3=D3) [mailto:ceyong@yahoo.com]=20
> Sent: Thursday, September 23, 2004 8:55 AM
> To: hostap@shmoo.com; bridge@osdl.org
> Cc: jasonb@edseek.com; jt@hpl.hp.com; linux-help@houseofcraig.net
> Subject: Problem COnnecting AP from Mobile Node
>=20
>=20
>=20
> I am having problem in ping or connect AP from Mobile=20
> Node(essid & channel is the same,maybe routing did=20
> not set properly but i fail to configure with route add=20
> default gw 192.168.3.4,its alway said=20
> network is unreachable ),My Mobile Node is using acx100 as=20
> driver while AP(redhat 9.0) is using HOSTAP 0.1.3.Any one can=20
> help? I heard How-To said we not need to set address on eth0=20
> & wlan0 if we have bridge(with address)but will MN connect=20
> straight with bridge that i set?=20
>=20
> My mobile node setting:
> [root@localhost scripts]# iwconfig
> lo        no wireless extensions.
>=20
> sit0      no wireless extensions.
>=20
> eth0      no wireless extensions.
>=20
> ip6tnl0   no wireless extensions.
>=20
> mip6mnha  no wireless extensions.
>=20
> wlan0     IEEE 802.11b+  ESSID:"mipv6b"  Nickname:"acx100 v0.2.0pre8"
>           Mode:Managed  Channel:1  Access Point: 00:01:03:88:62:96
>           Bit Rate=3D11Mb/s   Tx-Power:18 dBm   Sensitivity=3D176/255
>           Retry min limit:7   RTS thr:off
>           Encryption key:off
>           Power Management:off
>           Link Quality:69/100  Signal level:57/100  Noise level:0/100
>           Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
>           Tx excessive retries:0  Invalid misc:0   Missed beacon:0
>=20
> root@localhost scripts]# ifconfig
> eth0      Link encap:Ethernet  HWaddr 00:D0:59:80:0C:2E
>           inet addr:172.16.76.56  Bcast:172.16.76.255 =20
> Mask:255.255.255.0
>           inet6 addr: fe80::2d0:59ff:fe80:c2e/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:3832 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:36 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100
>           RX bytes:252364 (246.4 Kb)  TX bytes:3140 (3.0 Kb)
>           Interrupt:11 Base address:0x1400 Memory:f4020000-f4020038
>=20
> lo        Link encap:Local Loopback
>           inet6 addr: ::1/128 Scope:Host
>           UP LOOPBACK RUNNING  MTU:16436  Metric:1
>           RX packets:19 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:19 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:5256 (5.1 Kb)  TX bytes:5256 (5.1 Kb)
>=20
> mip6mnha1 Link encap:UNSPEC  HWaddr=20
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>           inet6 addr: 3ffe:80d0:ff03:4::1/64 Scope:Global
>           UP RUNNING NOARP  MTU:1460  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:8 dropped:8 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>=20
> wlan0     Link encap:Ethernet  HWaddr 00:0F:3D:46:A6:25
>           inet addr:192.168.4.1  Bcast:192.168.4.255 =20
> Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:576  Metric:1
>           RX packets:6 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:6 errors:1 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100
>           RX bytes:1968 (1.9 Kb)  TX bytes:2052 (2.0 Kb)
>           Interrupt:11 Base address:0x4000
>=20
>=20
>=20
> My Redhat AP Setting
>=20
> [root@localhost root]# iwconfig
> lo        no wireless extensions.
>=20
> sit0      no wireless extensions.
>=20
> eth0      no wireless extensions.
>=20
> wlan0     IEEE 802.11b  ESSID:"mipv6b" =20
> Nickname:"localhost.localdomain"
>           Mode:Master  Frequency:2.412GHz  Access Point:=20
> 00:01:03:88:62:96
>           Bit Rate=3D11Mb/s   Tx-Power:150 dBm   Sensitivity=3D1/3
>           Retry limit:8   RTS thr:off   Fragment thr:off
>           Encryption key:off
>           Power Management:off
>           Link Quality:0  Signal level:0  Noise level:0
>           Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
>           Tx excessive retries:0  Invalid misc:46   Missed beacon:0
>=20
> br0       no wireless extensions.
>=20
> [root@localhost root]# ifconfig
> br0       Link encap:Ethernet  HWaddr 00:01:03:88:62:96
>           inet addr:192.168.3.3  Bcast:192.168.3.255 =20
> Mask:255.255.255.0
>           inet6 addr: fe80::201:3ff:fe88:6296/64 Scope:Link
>           inet6 addr: 3ffe:80d0:ff03:3::3/0 Scope:Global
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:15 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:0 (0.0 b)  TX bytes:1050 (1.0 Kb)
>=20
> eth0      Link encap:Ethernet  HWaddr 00:50:BA:5F:61:56
>           inet addr:192.168.3.2  Bcast:192.168.3.255 =20
> Mask:255.255.255.0
>           inet6 addr: 3ffe:80d0:ff03:3::2/64 Scope:Global
>           inet6 addr: fe80::250:baff:fe5f:6156/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:19 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100
>           RX bytes:0 (0.0 b)  TX bytes:1458 (1.4 Kb)
>           Interrupt:9 Base address:0xd000
>=20
> lo        Link encap:Local Loopback
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           inet6 addr: ::1/128 Scope:Host
>           UP LOOPBACK RUNNING  MTU:16436  Metric:1
>           RX packets:232 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:232 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:12792 (12.4 Kb)  TX bytes:12792 (12.4 Kb)
>=20
> wlan0     Link encap:Ethernet  HWaddr 00:01:03:88:62:96
>           inet addr:192.168.3.4  Bcast:192.168.3.255 =20
> Mask:255.255.255.0
>           inet6 addr: fe80::201:3ff:fe88:6296/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:11 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100
>           RX bytes:0 (0.0 b)  TX bytes:1212 (1.1 Kb)
>           Interrupt:9 Base address:0xd400
>=20
>=20
> Wireless testBed is almost like below:
> =20
>=20
>                                          |
>                                      192.168.1.1
>                                  3ffe:80f0:ff03:1::1
>                                         fxp0
>                             FreeBSD 4.10 Router(Vls Server 0.5.6)
>                             vr0                   rl0
>                        192.168.2.1            192.168.3.1
>                      3ffe:80f0:ff03:2::1      3ffe:80f0:ff03:3::1
>                              |                     |
>                              |                     |
>                              |                     |
>                            eth0                  eth0
>                    3ffe:80f0:ff03:2::2      3ffe:80f0:ff03:3::2
>                        192.168.2.2            192.168.3.2
>                    Linux PC Access Point      Linux PC Access Point
>                       (HOSTAP 0.13)          (HOSTAP 0.13)
>                              |                     |
>                              |                     |
>                             br0                   br0
>                         192.168.2.3            192.168.3.3
>                    3ffe:80f0:ff03:2::3      3ffe:80f0:ff03:3::3 =20
>                              |                     |         =20
>            =20
>    =20
>                              |                     |
>                           wlan0                 wlan0
>                         192.168.2.4            192.168.3.4
>                        essid:mipv6a           essid:mipv6b
>=20
>=20
>                           ----
>                          | MN |
>                           ----  =20
>                 Roaming notebook (VLC player 0.7.2)
>               Linux Kernel 2.4.22 with MIPL 1.0
>             (Dlink Wireless  Card with acx100 driver)
>            192.168.4.1(Home address 3ffe:80d0:ff03:4::1)
>=20
>=20
>=20
> =3D=3D=3D=3D=3D
> =D4=B8=C4=FA=D3=C0=D4=B6=D0=D2=B8=A3=A3=AC=BF=EC=C0=D6=BA=CD=B0=B2=CF=EA =
Happy & Healthy Always ! ^_^ !=20
> =B8=F6=C8=CB=CD=F8=D2=B3 Homepage:http://planet.time.net.my/sunwaycity/ce=
yong
> =B8=F6=C8=CB=B7=F0=D1=A7=CD=F8=D2=B3 Buddhist Page:=20
> http://planet.time.net.my/SunwayCity/ceyong/ar> tikel.htm
>=20
> ICQ:16994867/ Yahoo Messenger ID:ceyong /MSN=20
> Messenger:ceyong at hotmail.com
>=20
>=20
> 	=09
> __________________________________
> Do you Yahoo!?
> Yahoo! Mail is new and improved - Check it out!=20
http://promotions.yahoo.com/new_mail
_______________________________________________
HostAP mailing list
HostAP@shmoo.com
http://lists.shmoo.com/mailman/listinfo/hostap

