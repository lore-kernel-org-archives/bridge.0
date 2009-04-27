MIME-Version: 1.0
In-Reply-To: <db99f77d0904271413p1e807e52ue3d0ec41f62d7daf@mail.gmail.com>
References: <db99f77d0904271413p1e807e52ue3d0ec41f62d7daf@mail.gmail.com>
Date: Mon, 27 Apr 2009 16:36:00 -0500
Message-ID: <2e59e6970904271436nd66745cv1c64ba792cf76d2f@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: multipart/alternative; boundary=0015175cb886eb1fab0468902100
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
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Cc: bridge@lists.linux-foundation.org

--0015175cb886eb1fab0468902100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Don't run dhcp on interfaces (eth1) that are joined to the bridge, only on
the bridge interface itself.

On Mon, Apr 27, 2009 at 4:13 PM, Jochen Hebbrecht <jochenhebbrecht@gmail.com
> wrote:

> Hi everybody,
>
> First of all, let me say that I searched a lot on the internet. I
> spent several hours sitting after my notebook, but I can't configure
> my network bridge in Ubuntu. I'm really desperate, so I hope somebody
> can point me out what I'm doing
>
> Hardware:
> -----------------------------------------------------------
>  $ lspci | grep controller
> 06:05.0 Network controller: Intel Corporation PRO/Wireless 2200BG
> Network Connection (rev 05)
> 06:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169
> Gigabit Ethernet (rev 10)
> -----------------------------------------------------------
>
> Kernel:
> -----------------------------------------------------------
>  $ uname -a
> Linux Bacardi 2.6.24-23-generic #1 SMP Wed Apr 1 21:47:28 UTC 2009
> i686 GNU/Linux
> -----------------------------------------------------------
>
> I first tested the hardware in windows xp sp3. I selected the 2
> interfaces, right clicked on them and picked up: "Create network
> bridge". 30 seconds later, I was having a network bridge between my
> wired and wireless controller :-). Everything was working smoothly.
>
> Now, I want to do the same thing on my Ubuntu installation (same
> notebook, just dual booting to Ubuntu). I thought it would be easy,
> but apparantly, it isn't :-( ...
>
> This is my /etc/network/interfaces file:
>
> -----------------------------------------------------------
> $ cat /etc/network/interfaces
> auto lo
> iface lo inet loopback
>
> auto eth0
> iface eth0 inet manual
>
> auto eth1
> iface eth1 inet dhcp
> wpa-driver wext
> wpa-ssid ##SSID##
> wpa-ap-scan 1
> wpa-proto RSN
> wpa-pairwise CCMP
> wpa-group CCMP
> wpa-key-mgmt WPA-PSK
> wpa-psk ##PSK KEY##
>
> auto br0
> iface br0 inet dhcp
> bridge_ports eth0 eth1
> -----------------------------------------------------------
>
> So, eth1 is my wireless connection, eth0 is my wired connection.
> Without the bridge, I'm able to make a connection on my wireless side,
> as on my wired side.
>
> When I bring up the bridge, nothing works ... I'm not able to ping
> anything.
> This is my routing table:
>
> -----------------------------------------------------------
>  $ route -n
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags Metric Ref    Use
> Iface
> 169.254.0.0     0.0.0.0         255.255.0.0     U     0      0        0 br0
> 0.0.0.0         0.0.0.0         0.0.0.0         U     1000   0        0 b
> -----------------------------------------------------------
>
> And ifconfig -a information
> -----------------------------------------------------------
> $ ifconfig -a
> br0       Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c
>          inet6 addr: fe80::20a:e4ff:feae:7e4c/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:11 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:96 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:3927 (3.8 KB)  TX bytes:6970 (6.8 KB)
>
> br0:avahi Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c
>          inet addr:169.254.7.81  Bcast:169.254.255.255  Mask:255.255.0.0
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>
> eth0      Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c
>          inet6 addr: fe80::20a:e4ff:feae:7e4c/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:107 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:0 (0.0 B)  TX bytes:12221 (11.9 KB)
>          Interrupt:20 Base address:0xc000
>
> eth1      Link encap:Ethernet  HWaddr 00:15:00:1f:20:a6
>          inet6 addr: fe80::215:ff:fe1f:20a6/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:80 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:111 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:844783 (824.9 KB)  TX bytes:128864 (125.8 KB)
>          Interrupt:21 Base address:0xc000 Memory:c8006000-c8006fff
>
> lo        Link encap:Local Loopback
>          inet addr:127.0.0.1  Mask:255.0.0.0
>          inet6 addr: ::1/128 Scope:Host
>          UP LOOPBACK RUNNING  MTU:16436  Metric:1
>          RX packets:1734 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:1734 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:88276 (86.2 KB)  TX bytes:88276 (86.2 KB)
> -----------------------------------------------------------
>
> This is the output of syslog after restarting the networking daemon
>
> -----------------------------------------------------------
> Apr 27 23:01:32 Bacardi dhclient: There is already a pid file
> /var/run/dhclient.eth1.pid with pid 134519072
> Apr 27 23:01:32 Bacardi dhclient: Internet Systems Consortium DHCP Client
> V3.0.6
> Apr 27 23:01:32 Bacardi dhclient: Copyright 2004-2007 Internet Systems
> Consortium.
> Apr 27 23:01:32 Bacardi dhclient: All rights reserved.
> Apr 27 23:01:32 Bacardi dhclient: For info, please visit
> http://www.isc.org/sw/dhcp/
> Apr 27 23:01:32 Bacardi dhclient:
> Apr 27 23:01:32 Bacardi kernel: [  158.946623]
> ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
> Apr 27 23:01:33 Bacardi dhclient: Listening on LPF/eth1/00:15:00:1f:20:a6
> Apr 27 23:01:33 Bacardi dhclient: Sending on   LPF/eth1/00:15:00:1f:20:a6
> Apr 27 23:01:33 Bacardi dhclient: Sending on   Socket/fallback
> Apr 27 23:01:36 Bacardi dhclient: DHCPDISCOVER on eth1 to
> 255.255.255.255 port 67 interval 8
> Apr 27 23:01:36 Bacardi dhclient: DHCPOFFER of 192.168.1.111 from
> 192.168.1.1
> Apr 27 23:01:36 Bacardi dhclient: DHCPREQUEST of 192.168.1.111 on eth1
> to 255.255.255.255 port 67
> Apr 27 23:01:37 Bacardi dhclient: DHCPACK of 192.168.1.111 from 192.168.1.1
> Apr 27 23:01:37 Bacardi dhclient: bound to 192.168.1.111 -- renewal in
> 42920 seconds.
> Apr 27 23:01:42 Bacardi kernel: [  161.516967] eth1: no IPv6 routers
> present
> Apr 27 23:01:43 Bacardi kernel: [   74.578698] Bridge firewalling
> registered
> Apr 27 23:01:43 Bacardi kernel: [   74.578967] br0: Dropping
> NETIF_F_UFO since no NETIF_F_HW_CSUM feature.
> Apr 27 23:01:43 Bacardi kernel: [   74.581732] device eth0 entered
> promiscuous mode
> Apr 27 23:01:43 Bacardi kernel: [   74.581740]
> audit(1240866103.181:3): dev=eth0 prom=256 old_prom=0 auid=4294967295
> Apr 27 23:01:43 Bacardi kernel: [   74.583808] device eth1 entered
> promiscuous mode
> Apr 27 23:01:43 Bacardi kernel: [   74.583816]
> audit(1240866103.181:4): dev=eth1 prom=256 old_prom=0 auid=4294967295
> Apr 27 23:01:43 Bacardi kernel: [   74.586637] br0: port 2(eth1)
> entering learning state
> Apr 27 23:01:43 Bacardi kernel: [   74.586641] br0: port 1(eth0)
> entering learning state
> Apr 27 23:01:48 Bacardi ntpdate[7485]: can't find host ntp.univ-lyon1.fr
> Apr 27 23:01:48 Bacardi ntpdate[7485]: sendto(91.189.94.4): Network is
> unreachable
> Apr 27 23:01:51 Bacardi last message repeated 3 times
> Apr 27 23:01:52 Bacardi ntpdate[7485]: no server suitable for
> synchronization found
> Apr 27 23:01:53 Bacardi kernel: [  162.782421] br0: no IPv6 routers present
> Apr 27 23:01:58 Bacardi kernel: [  164.002241] br0: topology change
> detected, propagating
> Apr 27 23:01:58 Bacardi kernel: [  164.002252] br0: port 2(eth1)
> entering forwarding state
> Apr 27 23:01:58 Bacardi kernel: [  164.002257] br0: topology change
> detected, propagating
> Apr 27 23:01:58 Bacardi kernel: [  164.002262] br0: port 1(eth0)
> entering forwarding state
> Apr 27 23:01:58 Bacardi dhclient: Internet Systems Consortium DHCP Client
> V3.0.6
> Apr 27 23:01:58 Bacardi dhclient: Copyright 2004-2007 Internet Systems
> Consortium.
> Apr 27 23:01:58 Bacardi dhclient: All rights reserved.
> Apr 27 23:01:58 Bacardi dhclient: For info, please visit
> http://www.isc.org/sw/dhcp/
> Apr 27 23:01:58 Bacardi dhclient:
> Apr 27 23:01:59 Bacardi dhclient: Listening on LPF/br0/00:0a:e4:ae:7e:4c
> Apr 27 23:01:59 Bacardi dhclient: Sending on   LPF/br0/00:0a:e4:ae:7e:4c
> Apr 27 23:01:59 Bacardi dhclient: Sending on   Socket/fallback
> Apr 27 23:02:02 Bacardi dhclient: DHCPDISCOVER on br0 to
> 255.255.255.255 port 67 interval 8
> Apr 27 23:02:10 Bacardi dhclient: DHCPDISCOVER on br0 to
> 255.255.255.255 port 67 interval 12
> Apr 27 23:02:22 Bacardi dhclient: DHCPDISCOVER on br0 to
> 255.255.255.255 port 67 interval 11
> Apr 27 23:02:33 Bacardi dhclient: No DHCPOFFERS received.
> Apr 27 23:02:33 Bacardi dhclient: No working leases in persistent
> database - sleeping.
> Apr 27 23:02:33 Bacardi avahi-autoipd(br0)[7686]: Found user
> 'avahi-autoipd' (UID 105) and group 'avahi-autoipd' (GID 113).
> Apr 27 23:02:33 Bacardi avahi-autoipd(br0)[7686]: Successfully called
> chroot().
> Apr 27 23:02:33 Bacardi avahi-autoipd(br0)[7686]: Successfully dropped
> root privileges.
> Apr 27 23:02:33 Bacardi avahi-autoipd(br0)[7686]: Starting with
> address 169.254.7.81
> Apr 27 23:02:38 Bacardi avahi-autoipd(br0)[7686]: Callout BIND,
> address 169.254.7.81 on interface br0
> Apr 27 23:02:42 Bacardi avahi-autoipd(br0)[7686]: Successfully claimed
> IP address 169.254.7.81
> -----------------------------------------------------------
>
>
> So I'm sure the wireless network card is able to bridge (as it works
> in Windows). I'm not sure if it works in Ubuntu. But what can the
> problem be? Is there something wrong in my configuration file? When do
> you choose dhcp/static/manual Which log files should I check, just to
> understand what's going wrong?
>
>
> Thanks for you time to read this mail. I really hope somebody can help
> me out here :-( ...
>
> Jochen
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

--0015175cb886eb1fab0468902100
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Don&#39;t run dhcp on interfaces (eth1) that are joined to the bridge, only=
 on the bridge interface itself.<br><br><div class=3D"gmail_quote">On Mon, =
Apr 27, 2009 at 4:13 PM, Jochen Hebbrecht <span dir=3D"ltr">&lt;<a href=3D"=
mailto:jochenhebbrecht@gmail.com">jochenhebbrecht@gmail.com</a>&gt;</span> =
wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi everybody,<br>
<br>
First of all, let me say that I searched a lot on the internet. I<br>
spent several hours sitting after my notebook, but I can&#39;t configure<br=
>
my network bridge in Ubuntu. I&#39;m really desperate, so I hope somebody<b=
r>
can point me out what I&#39;m doing<br>
<br>
Hardware:<br>
-----------------------------------------------------------<br>
=A0$ lspci | grep controller<br>
06:05.0 Network controller: Intel Corporation PRO/Wireless 2200BG<br>
Network Connection (rev 05)<br>
06:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169<br>
Gigabit Ethernet (rev 10)<br>
-----------------------------------------------------------<br>
<br>
Kernel:<br>
-----------------------------------------------------------<br>
=A0$ uname -a<br>
Linux Bacardi 2.6.24-23-generic #1 SMP Wed Apr 1 21:47:28 UTC 2009<br>
i686 GNU/Linux<br>
-----------------------------------------------------------<br>
<br>
I first tested the hardware in windows xp sp3. I selected the 2<br>
interfaces, right clicked on them and picked up: &quot;Create network<br>
bridge&quot;. 30 seconds later, I was having a network bridge between my<br=
>
wired and wireless controller :-). Everything was working smoothly.<br>
<br>
Now, I want to do the same thing on my Ubuntu installation (same<br>
notebook, just dual booting to Ubuntu). I thought it would be easy,<br>
but apparantly, it isn&#39;t :-( ...<br>
<br>
This is my /etc/network/interfaces file:<br>
<br>
-----------------------------------------------------------<br>
$ cat /etc/network/interfaces<br>
auto lo<br>
iface lo inet loopback<br>
<br>
auto eth0<br>
iface eth0 inet manual<br>
<br>
auto eth1<br>
iface eth1 inet dhcp<br>
wpa-driver wext<br>
wpa-ssid ##SSID##<br>
wpa-ap-scan 1<br>
wpa-proto RSN<br>
wpa-pairwise CCMP<br>
wpa-group CCMP<br>
wpa-key-mgmt WPA-PSK<br>
wpa-psk ##PSK KEY##<br>
<br>
auto br0<br>
iface br0 inet dhcp<br>
bridge_ports eth0 eth1<br>
-----------------------------------------------------------<br>
<br>
So, eth1 is my wireless connection, eth0 is my wired connection.<br>
Without the bridge, I&#39;m able to make a connection on my wireless side,<=
br>
as on my wired side.<br>
<br>
When I bring up the bridge, nothing works ... I&#39;m not able to ping anyt=
hing.<br>
This is my routing table:<br>
<br>
-----------------------------------------------------------<br>
=A0$ route -n<br>
Kernel IP routing table<br>
Destination =A0 =A0 Gateway =A0 =A0 =A0 =A0 Genmask =A0 =A0 =A0 =A0 Flags M=
etric Ref =A0 =A0Use Iface<br>
169.254.0.0 =A0 =A0 0.0.0.0 =A0 =A0 =A0 =A0 255.255.0.0 =A0 =A0 U =A0 =A0 0=
 =A0 =A0 =A00 =A0 =A0 =A0 =A00 br0<br>
0.0.0.0 =A0 =A0 =A0 =A0 0.0.0.0 =A0 =A0 =A0 =A0 0.0.0.0 =A0 =A0 =A0 =A0 U =
=A0 =A0 1000 =A0 0 =A0 =A0 =A0 =A00 b<br>
-----------------------------------------------------------<br>
<br>
And ifconfig -a information<br>
-----------------------------------------------------------<br>
$ ifconfig -a<br>
br0 =A0 =A0 =A0 Link encap:Ethernet =A0HWaddr 00:0a:e4:ae:7e:4c<br>
 =A0 =A0 =A0 =A0 =A0inet6 addr: fe80::20a:e4ff:feae:7e4c/64 Scope:Link<br>
 =A0 =A0 =A0 =A0 =A0UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric:1<=
br>
 =A0 =A0 =A0 =A0 =A0RX packets:11 errors:0 dropped:0 overruns:0 frame:0<br>
 =A0 =A0 =A0 =A0 =A0TX packets:96 errors:0 dropped:0 overruns:0 carrier:0<b=
r>
 =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:0<br>
 =A0 =A0 =A0 =A0 =A0RX bytes:3927 (3.8 KB) =A0TX bytes:6970 (6.8 KB)<br>
<br>
br0:avahi Link encap:Ethernet =A0HWaddr 00:0a:e4:ae:7e:4c<br>
 =A0 =A0 =A0 =A0 =A0inet addr:169.254.7.81 =A0Bcast:169.254.255.255 =A0Mask=
:255.255.0.0<br>
 =A0 =A0 =A0 =A0 =A0UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric:1<=
br>
<br>
eth0 =A0 =A0 =A0Link encap:Ethernet =A0HWaddr 00:0a:e4:ae:7e:4c<br>
 =A0 =A0 =A0 =A0 =A0inet6 addr: fe80::20a:e4ff:feae:7e4c/64 Scope:Link<br>
 =A0 =A0 =A0 =A0 =A0UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric:1<=
br>
 =A0 =A0 =A0 =A0 =A0RX packets:0 errors:0 dropped:0 overruns:0 frame:0<br>
 =A0 =A0 =A0 =A0 =A0TX packets:107 errors:0 dropped:0 overruns:0 carrier:0<=
br>
 =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:1000<br>
 =A0 =A0 =A0 =A0 =A0RX bytes:0 (0.0 B) =A0TX bytes:12221 (11.9 KB)<br>
 =A0 =A0 =A0 =A0 =A0Interrupt:20 Base address:0xc000<br>
<br>
eth1 =A0 =A0 =A0Link encap:Ethernet =A0HWaddr 00:15:00:1f:20:a6<br>
 =A0 =A0 =A0 =A0 =A0inet6 addr: fe80::215:ff:fe1f:20a6/64 Scope:Link<br>
 =A0 =A0 =A0 =A0 =A0UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric:1<=
br>
 =A0 =A0 =A0 =A0 =A0RX packets:80 errors:0 dropped:0 overruns:0 frame:0<br>
 =A0 =A0 =A0 =A0 =A0TX packets:111 errors:0 dropped:0 overruns:0 carrier:0<=
br>
 =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:1000<br>
 =A0 =A0 =A0 =A0 =A0RX bytes:844783 (824.9 KB) =A0TX bytes:128864 (125.8 KB=
)<br>
 =A0 =A0 =A0 =A0 =A0Interrupt:21 Base address:0xc000 Memory:c8006000-c8006f=
ff<br>
<br>
lo =A0 =A0 =A0 =A0Link encap:Local Loopback<br>
 =A0 =A0 =A0 =A0 =A0inet addr:127.0.0.1 =A0Mask:255.0.0.0<br>
 =A0 =A0 =A0 =A0 =A0inet6 addr: ::1/128 Scope:Host<br>
 =A0 =A0 =A0 =A0 =A0UP LOOPBACK RUNNING =A0MTU:16436 =A0Metric:1<br>
 =A0 =A0 =A0 =A0 =A0RX packets:1734 errors:0 dropped:0 overruns:0 frame:0<b=
r>
 =A0 =A0 =A0 =A0 =A0TX packets:1734 errors:0 dropped:0 overruns:0 carrier:0=
<br>
 =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:0<br>
 =A0 =A0 =A0 =A0 =A0RX bytes:88276 (86.2 KB) =A0TX bytes:88276 (86.2 KB)<br=
>
-----------------------------------------------------------<br>
<br>
This is the output of syslog after restarting the networking daemon<br>
<br>
-----------------------------------------------------------<br>
Apr 27 23:01:32 Bacardi dhclient: There is already a pid file<br>
/var/run/dhclient.eth1.pid with pid 134519072<br>
Apr 27 23:01:32 Bacardi dhclient: Internet Systems Consortium DHCP Client V=
3.0.6<br>
Apr 27 23:01:32 Bacardi dhclient: Copyright 2004-2007 Internet Systems<br>
Consortium.<br>
Apr 27 23:01:32 Bacardi dhclient: All rights reserved.<br>
Apr 27 23:01:32 Bacardi dhclient: For info, please visit<br>
<a href=3D"http://www.isc.org/sw/dhcp/" target=3D"_blank">http://www.isc.or=
g/sw/dhcp/</a><br>
Apr 27 23:01:32 Bacardi dhclient:<br>
Apr 27 23:01:32 Bacardi kernel: [ =A0158.946623]<br>
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready<br>
Apr 27 23:01:33 Bacardi dhclient: Listening on LPF/eth1/00:15:00:1f:20:a6<b=
r>
Apr 27 23:01:33 Bacardi dhclient: Sending on =A0 LPF/eth1/00:15:00:1f:20:a6=
<br>
Apr 27 23:01:33 Bacardi dhclient: Sending on =A0 Socket/fallback<br>
Apr 27 23:01:36 Bacardi dhclient: DHCPDISCOVER on eth1 to<br>
255.255.255.255 port 67 interval 8<br>
Apr 27 23:01:36 Bacardi dhclient: DHCPOFFER of 192.168.1.111 from 192.168.1=
.1<br>
Apr 27 23:01:36 Bacardi dhclient: DHCPREQUEST of 192.168.1.111 on eth1<br>
to 255.255.255.255 port 67<br>
Apr 27 23:01:37 Bacardi dhclient: DHCPACK of 192.168.1.111 from 192.168.1.1=
<br>
Apr 27 23:01:37 Bacardi dhclient: bound to 192.168.1.111 -- renewal in<br>
42920 seconds.<br>
Apr 27 23:01:42 Bacardi kernel: [ =A0161.516967] eth1: no IPv6 routers pres=
ent<br>
Apr 27 23:01:43 Bacardi kernel: [ =A0 74.578698] Bridge firewalling registe=
red<br>
Apr 27 23:01:43 Bacardi kernel: [ =A0 74.578967] br0: Dropping<br>
NETIF_F_UFO since no NETIF_F_HW_CSUM feature.<br>
Apr 27 23:01:43 Bacardi kernel: [ =A0 74.581732] device eth0 entered<br>
promiscuous mode<br>
Apr 27 23:01:43 Bacardi kernel: [ =A0 74.581740]<br>
audit(1240866103.181:3): dev=3Deth0 prom=3D256 old_prom=3D0 auid=3D42949672=
95<br>
Apr 27 23:01:43 Bacardi kernel: [ =A0 74.583808] device eth1 entered<br>
promiscuous mode<br>
Apr 27 23:01:43 Bacardi kernel: [ =A0 74.583816]<br>
audit(1240866103.181:4): dev=3Deth1 prom=3D256 old_prom=3D0 auid=3D42949672=
95<br>
Apr 27 23:01:43 Bacardi kernel: [ =A0 74.586637] br0: port 2(eth1)<br>
entering learning state<br>
Apr 27 23:01:43 Bacardi kernel: [ =A0 74.586641] br0: port 1(eth0)<br>
entering learning state<br>
Apr 27 23:01:48 Bacardi ntpdate[7485]: can&#39;t find host <a href=3D"http:=
//ntp.univ-lyon1.fr" target=3D"_blank">ntp.univ-lyon1.fr</a><br>
Apr 27 23:01:48 Bacardi ntpdate[7485]: sendto(91.189.94.4): Network is<br>
unreachable<br>
Apr 27 23:01:51 Bacardi last message repeated 3 times<br>
Apr 27 23:01:52 Bacardi ntpdate[7485]: no server suitable for<br>
synchronization found<br>
Apr 27 23:01:53 Bacardi kernel: [ =A0162.782421] br0: no IPv6 routers prese=
nt<br>
Apr 27 23:01:58 Bacardi kernel: [ =A0164.002241] br0: topology change<br>
detected, propagating<br>
Apr 27 23:01:58 Bacardi kernel: [ =A0164.002252] br0: port 2(eth1)<br>
entering forwarding state<br>
Apr 27 23:01:58 Bacardi kernel: [ =A0164.002257] br0: topology change<br>
detected, propagating<br>
Apr 27 23:01:58 Bacardi kernel: [ =A0164.002262] br0: port 1(eth0)<br>
entering forwarding state<br>
Apr 27 23:01:58 Bacardi dhclient: Internet Systems Consortium DHCP Client V=
3.0.6<br>
Apr 27 23:01:58 Bacardi dhclient: Copyright 2004-2007 Internet Systems<br>
Consortium.<br>
Apr 27 23:01:58 Bacardi dhclient: All rights reserved.<br>
Apr 27 23:01:58 Bacardi dhclient: For info, please visit<br>
<a href=3D"http://www.isc.org/sw/dhcp/" target=3D"_blank">http://www.isc.or=
g/sw/dhcp/</a><br>
Apr 27 23:01:58 Bacardi dhclient:<br>
Apr 27 23:01:59 Bacardi dhclient: Listening on LPF/br0/00:0a:e4:ae:7e:4c<br=
>
Apr 27 23:01:59 Bacardi dhclient: Sending on =A0 LPF/br0/00:0a:e4:ae:7e:4c<=
br>
Apr 27 23:01:59 Bacardi dhclient: Sending on =A0 Socket/fallback<br>
Apr 27 23:02:02 Bacardi dhclient: DHCPDISCOVER on br0 to<br>
255.255.255.255 port 67 interval 8<br>
Apr 27 23:02:10 Bacardi dhclient: DHCPDISCOVER on br0 to<br>
255.255.255.255 port 67 interval 12<br>
Apr 27 23:02:22 Bacardi dhclient: DHCPDISCOVER on br0 to<br>
255.255.255.255 port 67 interval 11<br>
Apr 27 23:02:33 Bacardi dhclient: No DHCPOFFERS received.<br>
Apr 27 23:02:33 Bacardi dhclient: No working leases in persistent<br>
database - sleeping.<br>
Apr 27 23:02:33 Bacardi avahi-autoipd(br0)[7686]: Found user<br>
&#39;avahi-autoipd&#39; (UID 105) and group &#39;avahi-autoipd&#39; (GID 11=
3).<br>
Apr 27 23:02:33 Bacardi avahi-autoipd(br0)[7686]: Successfully called chroo=
t().<br>
Apr 27 23:02:33 Bacardi avahi-autoipd(br0)[7686]: Successfully dropped<br>
root privileges.<br>
Apr 27 23:02:33 Bacardi avahi-autoipd(br0)[7686]: Starting with<br>
address 169.254.7.81<br>
Apr 27 23:02:38 Bacardi avahi-autoipd(br0)[7686]: Callout BIND,<br>
address 169.254.7.81 on interface br0<br>
Apr 27 23:02:42 Bacardi avahi-autoipd(br0)[7686]: Successfully claimed<br>
IP address 169.254.7.81<br>
-----------------------------------------------------------<br>
<br>
<br>
So I&#39;m sure the wireless network card is able to bridge (as it works<br=
>
in Windows). I&#39;m not sure if it works in Ubuntu. But what can the<br>
problem be? Is there something wrong in my configuration file? When do<br>
you choose dhcp/static/manual Which log files should I check, just to<br>
understand what&#39;s going wrong?<br>
<br>
<br>
Thanks for you time to read this mail. I really hope somebody can help<br>
me out here :-( ...<br>
<br>
Jochen<br>
_______________________________________________<br>
Bridge mailing list<br>
<a href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-fou=
ndation.org</a><br>
<a href=3D"https://lists.linux-foundation.org/mailman/listinfo/bridge" targ=
et=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a=
><br>
</blockquote></div><br>

--0015175cb886eb1fab0468902100--
