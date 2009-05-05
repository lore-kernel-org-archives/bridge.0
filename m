Message-ID: <4A00705B.8020508@gmail.com>
Date: Tue, 05 May 2009 18:59:07 +0200
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us> <49F8C4C3.9020504@gmail.com>	
	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>	
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>	
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>	
	<49FDD890.1090302@free.fr> <49FF41C4.4090404@gmail.com>	
	<49FF4AF8.1050801@free.fr> <49FF58EC.2090902@gmail.com>
	<2e59e6970905041633u57678f2dn4e433ec417475927@mail.gmail.com>
	<49FFD355.70301@free.fr>
In-Reply-To: <49FFD355.70301@free.fr>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
 connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: bridge@lists.linux-foundation.org

Nicolas de Peslo=FCan schreef:
> I agree with Richard.
>
> Jochen, can you please try the following configuration (step #5 in my=20
> previous e-mail) ?
>
> #auto eth0
> iface eth0 inet manual
>
> #auto eth1
> iface eth1 inet manual
>
> auto br0
> iface br0 inet dhcp
> bridge_ports eth0 eth1
> # the wpa-iface option is expected to instruct wpa_supplicant
> # to setup the wifi link using eth1 instead of br0.
> wpa-iface eth1
> wpa-driver wext
> wpa-ssid ##SSID##
> wpa-ap-scan 1
> wpa-proto RSN
> wpa-pairwise CCMP
> wpa-group CCMP
> wpa-key-mgmt WPA-PSK
> wpa-psk ##PSK KEY##
> # The wpa-bridge option is expected to instruct wpa_supplicant
> # to listen on br0 instead of eth1.
> wpa-bridge br0
>
Nicoloas,

First of all, thanks for your effort and time. I'm really appreciating=20
this and I'm really willing to let this bridge works.
So I tried what you suggested here:

$ cat /etc/network/interfaces
#auto eth0
iface eth0 inet manual

#auto eth1
iface eth1 inet manual

auto br0
iface br0 inet dhcp
bridge_ports eth0 eth1
# the wpa-iface option is expected to instruct wpa_supplicant
# to setup the wifi link using eth1 instead of br0.
wpa-iface eth1
wpa-driver wext
wpa-ssid ##SSID##
wpa-ap-scan 1
wpa-proto RSN
wpa-pairwise CCMP
wpa-group CCMP
wpa-key-mgmt WPA-PSK
wpa-psk ##PSK##
# The wpa-bridge option is expected to instruct wpa_supplicant
# to listen on br0 instead of eth1.
wpa-bridge br0

$ sudo /etc/init.d/networking restart
 * Reconfiguring network=20
interfaces...                                        =20
Waiting for br0 to get ready (MAXWAIT is 32 seconds).
Internet Systems Consortium DHCP Client V3.0.6
Copyright 2004-2007 Internet Systems Consortium.
All rights reserved.
For info, please visit http://www.isc.org/sw/dhcp/

Listening on LPF/br0/00:0a:e4:ae:7e:4c
Sending on   LPF/br0/00:0a:e4:ae:7e:4c
Sending on   Socket/fallback
DHCPDISCOVER on br0 to 255.255.255.255 port 67 interval 3
DHCPDISCOVER on br0 to 255.255.255.255 port 67 interval 4
DHCPDISCOVER on br0 to 255.255.255.255 port 67 interval 11
DHCPDISCOVER on br0 to 255.255.255.255 port 67 interval 7
DHCPDISCOVER on br0 to 255.255.255.255 port 67 interval 6
No DHCPOFFERS received.
No working leases in persistent database - sleeping.
                                                                        =20
[ OK ]

jochus@Bacardi ~ $ ifconfig
br0       Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c=20
          inet6 addr: fe80::20a:e4ff:feae:7e4c/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
          TX packets:58 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:387 (387.0 B)  TX bytes:5743 (5.6 KB)

br0:avahi Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c=20
          inet addr:169.254.7.81  Bcast:169.254.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

eth0      Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c=20
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:20 Base address:0xc000

eth1      Link encap:Ethernet  HWaddr 00:15:00:1f:20:a6=20
          inet6 addr: fe80::215:ff:fe1f:20a6/64 Scope:Link
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:42 dropped:42 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:277199 (270.7 KB)  TX bytes:95538 (93.2 KB)
          Interrupt:21 Base address:0xc000 Memory:c8006000-c8006fff

lo        Link encap:Local Loopback=20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:1942 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1942 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:97578 (95.2 KB)  TX bytes:97578 (95.2 KB)


jochus@Bacardi ~ $ iwconfig
lo        no wireless extensions.

eth0      no wireless extensions.

eth1      IEEE 802.11g  ESSID:"Jochus"=20
          Mode:Managed  Frequency:2.462 GHz  Access Point:=20
00:16:B6:3B:1E:3C =20
          Bit Rate:54 Mb/s   Tx-Power=3D20 dBm   Sensitivity=3D8/0=20
          Retry limit:7   RTS thr:off   Fragment thr:off
          Power Management:off
          Link Quality=3D67/100  Signal level=3D-52 dBm  Noise level=3D-85 =
dBm
          Rx invalid nwid:0  Rx invalid crypt:48  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

br0       no wireless extensions.

jochus@Bacardi ~ $ arp -an
? (195.130.130.165) at <incomplete> on br0
? (195.130.129.165) at <incomplete> on br0


So, no luck :-(

> And if this fail, please try the same configuration, without the=20
> wpa-bridge option.
Ok, so this is what I tried:

$ cat /etc/network/interfaces
#auto eth0
iface eth0 inet manual

#auto eth1
iface eth1 inet manual

auto br0
iface br0 inet dhcp
bridge_ports eth0 eth1
# the wpa-iface option is expected to instruct wpa_supplicant
# to setup the wifi link using eth1 instead of br0.
wpa-iface eth1
wpa-driver wext
wpa-ssid ##SSID##
wpa-ap-scan 1
wpa-proto RSN
wpa-pairwise CCMP
wpa-group CCMP
wpa-key-mgmt WPA-PSK
wpa-psk ##PSK##

$ sudo /etc/init.d/networking restart
 * Reconfiguring network=20
interfaces...                                                              =
                                                                           =
                                    =20
There is already a pid file /var/run/dhclient.br0.pid with pid 7828
killed old client process, removed PID file
Internet Systems Consortium DHCP Client V3.0.6
Copyright 2004-2007 Internet Systems Consortium.
All rights reserved.
For info, please visit http://www.isc.org/sw/dhcp/

Listening on LPF/br0/00:0a:e4:ae:7e:4c
Sending on   LPF/br0/00:0a:e4:ae:7e:4c
Sending on   Socket/fallback
DHCPRELEASE on br0 to 192.168.1.1 port 67

Waiting for br0 to get ready (MAXWAIT is 32 seconds).
There is already a pid file /var/run/dhclient.br0.pid with pid 134519072
Internet Systems Consortium DHCP Client V3.0.6
Copyright 2004-2007 Internet Systems Consortium.
All rights reserved.
For info, please visit http://www.isc.org/sw/dhcp/

Listening on LPF/br0/00:0a:e4:ae:7e:4c
Sending on   LPF/br0/00:0a:e4:ae:7e:4c
Sending on   Socket/fallback
DHCPDISCOVER on br0 to 255.255.255.255 port 67 interval 3
DHCPDISCOVER on br0 to 255.255.255.255 port 67 interval 8
DHCPDISCOVER on br0 to 255.255.255.255 port 67 interval 13
DHCPDISCOVER on br0 to 255.255.255.255 port 67 interval 7
No DHCPOFFERS received.
No working leases in persistent database - sleeping.

$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use=20
Iface
169.254.0.0     0.0.0.0         255.255.0.0     U     0      0        0 br0
0.0.0.0         0.0.0.0         0.0.0.0         U     1000   0        0 br0




jochus@Bacardi ~ $ ifconfig
br0       Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c=20
          inet6 addr: fe80::20a:e4ff:feae:7e4c/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:53 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:5233 (5.1 KB)

br0:avahi Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c=20
          inet addr:169.254.7.81  Bcast:169.254.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

eth0      Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c=20
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:20 Base address:0xc000

eth1      Link encap:Ethernet  HWaddr 00:15:00:1f:20:a6=20
          inet6 addr: fe80::215:ff:fe1f:20a6/64 Scope:Link
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:3 errors:79 dropped:79 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:292724 (285.8 KB)  TX bytes:95750 (93.5 KB)
          Interrupt:21 Base address:0xc000 Memory:c8006000-c8006fff

lo        Link encap:Local Loopback=20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:1957 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1957 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0         =20
          RX bytes:98999 (96.6 KB)  TX bytes:98999 (96.6 KB)


jochus@Bacardi ~ $ iwconfig
lo        no wireless extensions.

eth0      no wireless extensions.

eth1      IEEE 802.11g  ESSID:"Jochus"=20
          Mode:Managed  Frequency:2.462 GHz  Access Point:=20
00:16:B6:3B:1E:3C =20
          Bit Rate:54 Mb/s   Tx-Power=3D20 dBm   Sensitivity=3D8/0=20
          Retry limit:7   RTS thr:off   Fragment thr:off
          Power Management:off
          Link Quality=3D76/100  Signal level=3D-49 dBm  Noise level=3D-85 =
dBm
          Rx invalid nwid:0  Rx invalid crypt:79  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

br0       no wireless extensions.


jochus@Bacardi ~ $ arp -an
? (195.130.130.165) at <incomplete> on br0
? (195.130.129.165) at <incomplete> on br0
>
> If both fail, please provide the list of files in /etc/network/if*/*.

jochus@Bacardi ~ $ ls /etc/network/if*/* -al
-rwxr-xr-x 1 root root  979 2007-10-04 17:04=20
/etc/network/if-down.d/avahi-autoipd
lrwxrwxrwx 1 root root   32 2009-04-26 11:27=20
/etc/network/if-down.d/wpasupplicant -> ../../wpa_supplicant/ifupdown.sh
lrwxrwxrwx 1 root root   23 2009-04-26 11:36=20
/etc/network/if-post-down.d/avahi-daemon -> ../if-up.d/avahi-daemon
-rwxr-xr-x 1 root root 1903 2007-10-23 21:45=20
/etc/network/if-post-down.d/bridge
-rwxr-xr-x 1 root root  997 2007-04-27 23:37=20
/etc/network/if-post-down.d/wireless-tools
lrwxrwxrwx 1 root root   32 2009-04-26 11:27=20
/etc/network/if-post-down.d/wpasupplicant ->=20
../../wpa_supplicant/ifupdown.sh
-rwxr-xr-x 1 root root 3593 2007-10-23 21:45 /etc/network/if-pre-up.d/bridge
-rwxr-xr-x 1 root root 2358 2007-04-27 23:37=20
/etc/network/if-pre-up.d/wireless-tools
lrwxrwxrwx 1 root root   32 2009-04-26 11:27=20
/etc/network/if-pre-up.d/wpasupplicant -> ../../wpa_supplicant/ifupdown.sh
-rwxr-xr-x 1 root root  886 2007-10-04 17:04=20
/etc/network/if-up.d/avahi-autoipd
-rwxr-xr-x 1 root root  504 2008-12-18 19:35=20
/etc/network/if-up.d/avahi-daemon
-rwxr-xr-x 1 root root   90 2009-01-23 16:01 /etc/network/if-up.d/mountnfs
-rwxr-xr-x 1 root root  664 2009-01-06 16:51 /etc/network/if-up.d/ntpdate
lrwxrwxrwx 1 root root   32 2009-04-26 11:27=20
/etc/network/if-up.d/wpasupplicant -> ../../wpa_supplicant/ifupdown.sh
