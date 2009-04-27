MIME-Version: 1.0
Date: Mon, 27 Apr 2009 23:13:03 +0200
Message-ID: <db99f77d0904271413p1e807e52ue3d0ec41f62d7daf@mail.gmail.com>
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Ubuntu: network bridging between wireless and wired
	connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi everybody,

First of all, let me say that I searched a lot on the internet. I
spent several hours sitting after my notebook, but I can't configure
my network bridge in Ubuntu. I'm really desperate, so I hope somebody
can point me out what I'm doing

Hardware:
-----------------------------------------------------------
 $ lspci | grep controller
06:05.0 Network controller: Intel Corporation PRO/Wireless 2200BG
Network Connection (rev 05)
06:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169
Gigabit Ethernet (rev 10)
-----------------------------------------------------------

Kernel:
-----------------------------------------------------------
 $ uname -a
Linux Bacardi 2.6.24-23-generic #1 SMP Wed Apr 1 21:47:28 UTC 2009
i686 GNU/Linux
-----------------------------------------------------------

I first tested the hardware in windows xp sp3. I selected the 2
interfaces, right clicked on them and picked up: "Create network
bridge". 30 seconds later, I was having a network bridge between my
wired and wireless controller :-). Everything was working smoothly.

Now, I want to do the same thing on my Ubuntu installation (same
notebook, just dual booting to Ubuntu). I thought it would be easy,
but apparantly, it isn't :-( ...

This is my /etc/network/interfaces file:

-----------------------------------------------------------
$ cat /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet manual

auto eth1
iface eth1 inet dhcp
wpa-driver wext
wpa-ssid ##SSID##
wpa-ap-scan 1
wpa-proto RSN
wpa-pairwise CCMP
wpa-group CCMP
wpa-key-mgmt WPA-PSK
wpa-psk ##PSK KEY##

auto br0
iface br0 inet dhcp
bridge_ports eth0 eth1
-----------------------------------------------------------

So, eth1 is my wireless connection, eth0 is my wired connection.
Without the bridge, I'm able to make a connection on my wireless side,
as on my wired side.

When I bring up the bridge, nothing works ... I'm not able to ping anything.
This is my routing table:

-----------------------------------------------------------
 $ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
169.254.0.0     0.0.0.0         255.255.0.0     U     0      0        0 br0
0.0.0.0         0.0.0.0         0.0.0.0         U     1000   0        0 b
-----------------------------------------------------------

And ifconfig -a information
-----------------------------------------------------------
$ ifconfig -a
br0       Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c
          inet6 addr: fe80::20a:e4ff:feae:7e4c/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:11 errors:0 dropped:0 overruns:0 frame:0
          TX packets:96 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:3927 (3.8 KB)  TX bytes:6970 (6.8 KB)

br0:avahi Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c
          inet addr:169.254.7.81  Bcast:169.254.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

eth0      Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c
          inet6 addr: fe80::20a:e4ff:feae:7e4c/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:107 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:12221 (11.9 KB)
          Interrupt:20 Base address:0xc000

eth1      Link encap:Ethernet  HWaddr 00:15:00:1f:20:a6
          inet6 addr: fe80::215:ff:fe1f:20a6/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:80 errors:0 dropped:0 overruns:0 frame:0
          TX packets:111 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:844783 (824.9 KB)  TX bytes:128864 (125.8 KB)
          Interrupt:21 Base address:0xc000 Memory:c8006000-c8006fff

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:1734 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1734 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:88276 (86.2 KB)  TX bytes:88276 (86.2 KB)
-----------------------------------------------------------

This is the output of syslog after restarting the networking daemon

-----------------------------------------------------------
Apr 27 23:01:32 Bacardi dhclient: There is already a pid file
/var/run/dhclient.eth1.pid with pid 134519072
Apr 27 23:01:32 Bacardi dhclient: Internet Systems Consortium DHCP Client V3.0.6
Apr 27 23:01:32 Bacardi dhclient: Copyright 2004-2007 Internet Systems
Consortium.
Apr 27 23:01:32 Bacardi dhclient: All rights reserved.
Apr 27 23:01:32 Bacardi dhclient: For info, please visit
http://www.isc.org/sw/dhcp/
Apr 27 23:01:32 Bacardi dhclient:
Apr 27 23:01:32 Bacardi kernel: [  158.946623]
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
Apr 27 23:01:33 Bacardi dhclient: Listening on LPF/eth1/00:15:00:1f:20:a6
Apr 27 23:01:33 Bacardi dhclient: Sending on   LPF/eth1/00:15:00:1f:20:a6
Apr 27 23:01:33 Bacardi dhclient: Sending on   Socket/fallback
Apr 27 23:01:36 Bacardi dhclient: DHCPDISCOVER on eth1 to
255.255.255.255 port 67 interval 8
Apr 27 23:01:36 Bacardi dhclient: DHCPOFFER of 192.168.1.111 from 192.168.1.1
Apr 27 23:01:36 Bacardi dhclient: DHCPREQUEST of 192.168.1.111 on eth1
to 255.255.255.255 port 67
Apr 27 23:01:37 Bacardi dhclient: DHCPACK of 192.168.1.111 from 192.168.1.1
Apr 27 23:01:37 Bacardi dhclient: bound to 192.168.1.111 -- renewal in
42920 seconds.
Apr 27 23:01:42 Bacardi kernel: [  161.516967] eth1: no IPv6 routers present
Apr 27 23:01:43 Bacardi kernel: [   74.578698] Bridge firewalling registered
Apr 27 23:01:43 Bacardi kernel: [   74.578967] br0: Dropping
NETIF_F_UFO since no NETIF_F_HW_CSUM feature.
Apr 27 23:01:43 Bacardi kernel: [   74.581732] device eth0 entered
promiscuous mode
Apr 27 23:01:43 Bacardi kernel: [   74.581740]
audit(1240866103.181:3): dev=eth0 prom=256 old_prom=0 auid=4294967295
Apr 27 23:01:43 Bacardi kernel: [   74.583808] device eth1 entered
promiscuous mode
Apr 27 23:01:43 Bacardi kernel: [   74.583816]
audit(1240866103.181:4): dev=eth1 prom=256 old_prom=0 auid=4294967295
Apr 27 23:01:43 Bacardi kernel: [   74.586637] br0: port 2(eth1)
entering learning state
Apr 27 23:01:43 Bacardi kernel: [   74.586641] br0: port 1(eth0)
entering learning state
Apr 27 23:01:48 Bacardi ntpdate[7485]: can't find host ntp.univ-lyon1.fr
Apr 27 23:01:48 Bacardi ntpdate[7485]: sendto(91.189.94.4): Network is
unreachable
Apr 27 23:01:51 Bacardi last message repeated 3 times
Apr 27 23:01:52 Bacardi ntpdate[7485]: no server suitable for
synchronization found
Apr 27 23:01:53 Bacardi kernel: [  162.782421] br0: no IPv6 routers present
Apr 27 23:01:58 Bacardi kernel: [  164.002241] br0: topology change
detected, propagating
Apr 27 23:01:58 Bacardi kernel: [  164.002252] br0: port 2(eth1)
entering forwarding state
Apr 27 23:01:58 Bacardi kernel: [  164.002257] br0: topology change
detected, propagating
Apr 27 23:01:58 Bacardi kernel: [  164.002262] br0: port 1(eth0)
entering forwarding state
Apr 27 23:01:58 Bacardi dhclient: Internet Systems Consortium DHCP Client V3.0.6
Apr 27 23:01:58 Bacardi dhclient: Copyright 2004-2007 Internet Systems
Consortium.
Apr 27 23:01:58 Bacardi dhclient: All rights reserved.
Apr 27 23:01:58 Bacardi dhclient: For info, please visit
http://www.isc.org/sw/dhcp/
Apr 27 23:01:58 Bacardi dhclient:
Apr 27 23:01:59 Bacardi dhclient: Listening on LPF/br0/00:0a:e4:ae:7e:4c
Apr 27 23:01:59 Bacardi dhclient: Sending on   LPF/br0/00:0a:e4:ae:7e:4c
Apr 27 23:01:59 Bacardi dhclient: Sending on   Socket/fallback
Apr 27 23:02:02 Bacardi dhclient: DHCPDISCOVER on br0 to
255.255.255.255 port 67 interval 8
Apr 27 23:02:10 Bacardi dhclient: DHCPDISCOVER on br0 to
255.255.255.255 port 67 interval 12
Apr 27 23:02:22 Bacardi dhclient: DHCPDISCOVER on br0 to
255.255.255.255 port 67 interval 11
Apr 27 23:02:33 Bacardi dhclient: No DHCPOFFERS received.
Apr 27 23:02:33 Bacardi dhclient: No working leases in persistent
database - sleeping.
Apr 27 23:02:33 Bacardi avahi-autoipd(br0)[7686]: Found user
'avahi-autoipd' (UID 105) and group 'avahi-autoipd' (GID 113).
Apr 27 23:02:33 Bacardi avahi-autoipd(br0)[7686]: Successfully called chroot().
Apr 27 23:02:33 Bacardi avahi-autoipd(br0)[7686]: Successfully dropped
root privileges.
Apr 27 23:02:33 Bacardi avahi-autoipd(br0)[7686]: Starting with
address 169.254.7.81
Apr 27 23:02:38 Bacardi avahi-autoipd(br0)[7686]: Callout BIND,
address 169.254.7.81 on interface br0
Apr 27 23:02:42 Bacardi avahi-autoipd(br0)[7686]: Successfully claimed
IP address 169.254.7.81
-----------------------------------------------------------


So I'm sure the wireless network card is able to bridge (as it works
in Windows). I'm not sure if it works in Ubuntu. But what can the
problem be? Is there something wrong in my configuration file? When do
you choose dhcp/static/manual Which log files should I check, just to
understand what's going wrong?


Thanks for you time to read this mail. I really hope somebody can help
me out here :-( ...

Jochen
