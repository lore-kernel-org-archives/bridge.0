Message-ID: <49FF58EC.2090902@gmail.com>
Date: Mon, 04 May 2009 23:06:52 +0200
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>
	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>
	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>
	<49FDD890.1090302@free.fr> <49FF41C4.4090404@gmail.com>
	<49FF4AF8.1050801@free.fr>
In-Reply-To: <49FF4AF8.1050801@free.fr>
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
>
> I think that the "Destination Host Unreachable" is caused by some sort=20
> of "down link", because wpa_supplicant failed to establish the wifi=20
> link. When eth1 is part of the br0, packets received on eth1 is=20
> "forwarded" to br0 and not available on eth1. So wpa_supplicant must=20
> be instructed to listen for incoming packets on br0, not on eth1.
>
> Can you try the exact same configuration, adding wpa-bridge br0 in the=20
> eth1 stanza, to inform wpa_supplicant where to listen from ?
>
> auto lo
> iface lo inet loopback
>
> auto eth1
> iface eth1 inet manual
> wpa-driver wext
> wpa-ssid ##SSID##
> wpa-ap-scan 1
> wpa-proto RSN
> wpa-pairwise CCMP
> wpa-group CCMP
> wpa-key-mgmt WPA-PSK
> wpa-psk ##PSK KEY##
> wpa-bridge br0          <--- HERE.
>
> auto br0
> iface br0 inet static
> bridge_ports eth1
> address 192.168.1.111
> netmask 255.255.255.0
> gateway 192.168.1.1
I changed the configuration and restarted the networking daemon. I'm=20
getting this output

jochus@Bacardi ~ $ sudo /etc/init.d/networking restart
 * Reconfiguring network=20
interfaces...                                                              =
                                                                           =
                                    =20
ioctl[SIOCGIFINDEX]: No such device
Failed to open l2_packet connection for the bridge interface 'br0'
wpa_supplicant: /sbin/wpa_supplicant daemon failed to start
run-parts: /etc/network/if-pre-up.d/wpasupplicant exited with return code 1

Waiting for br0 to get ready (MAXWAIT is 32 seconds).
                                                                           =
                                                                           =
                       =20

I'm worried about the wpa_supplicant error. The file is present:

jochus@Bacardi ~ $ ls -al /sbin/wpa_supplicant
-rwxr-xr-x 1 root root 319812 2008-03-12 22:28 /sbin/wpa_supplicant

The output of ifconfig:

jochus@Bacardi ~ $ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use=20
Iface
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 br0
169.254.0.0     0.0.0.0         255.255.0.0     U     1000   0        0 br0
0.0.0.0         192.168.1.1     0.0.0.0         UG    100    0        0 br0

jochus@Bacardi ~ $ ifconfig
br0       Link encap:Ethernet  HWaddr 00:15:00:1f:20:a6=20
          inet addr:192.168.1.111  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::215:ff:fe1f:20a6/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:12 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:720 (720.0 B)

eth0      Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c=20
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:20 Base address:0xc000

eth1      Link encap:Ethernet  HWaddr 00:15:00:1f:20:a6=20
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:5255 errors:12 dropped:12 overruns:0 frame:0
          TX packets:466 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:912108 (890.7 KB)  TX bytes:113643 (110.9 KB)
          Interrupt:21 Memory:c8006000-c8006fff

lo        Link encap:Local Loopback=20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:1974 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1974 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:101385 (99.0 KB)  TX bytes:101385 (99.0 KB)

The output of iwconfig of eth1

jochus@Bacardi ~ $ iwconfig eth1
eth1      unassociated  ESSID:"Jochus"=20
          Mode:Managed  Frequency=3D2.462 GHz  Access Point: Not-Associated=
 =20
          Bit Rate:0 kb/s   Tx-Power=3D20 dBm   Sensitivity=3D8/0=20
          Retry limit:7   RTS thr:off   Fragment thr:off
          Power Management:off
          Link Quality:0  Signal level:0  Noise level:0
          Rx invalid nwid:0  Rx invalid crypt:146  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

The output of arp -an:

jochus@Bacardi ~ $ arp -an
? (192.168.1.1) at <incomplete> on br0

