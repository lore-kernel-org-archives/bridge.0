Message-ID: <43F29AA6.3050407@osdl.org>
Date: Tue, 14 Feb 2006 19:06:14 -0800
From: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
Subject: Re: [Bridge] Error while trying to setup bridge, appears to be a loop
References: <57F9959B46E0FA4D8BA88AEDFBE5829016734A@pxtbenexd01.pxt.primeexalia.com>
In-Reply-To: <57F9959B46E0FA4D8BA88AEDFBE5829016734A@pxtbenexd01.pxt.primeexalia.com>
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
To: "Gary W. Smith" <gary@primeexalia.com>
Cc: bridge@lists.osdl.org

Gary W. Smith wrote:
>
> Hello,
>
> I=92ve been trying to implement a bridge in place for a clustered=20
> firewall at one of our office locations. Currently we NAT two class=20
> C=92s internally. We decided, for performance reasons, that it would=20
> make sense to put our servers into an official DMZ. So we started this=20
> bridging project. Our goal is to have two redundant firewalls in=20
> place. There is no need for active/active. The current firewalls are=20
> running Linux-HA happily.
>
> We setup a single node and tried to setup a bridge and ran into=20
> problems (please note, this isn=92t production but rather only testing=20
> at this point). Here is our general configuration.
>
> eth0 public, 100mb
>
> eth1 heartbeat for HA, private IP, 100mb
>
> eth2 DMZ, 1GB
>
> eth3 LAN, 1GB
>
> We have setup a fake set of IP=92s for our internal environment=20
> (58.100.1-31.0 split /24). Interfaces eth0 and eth2 have no IP as they=20
> will constitute the bridge, eth3 has 10.0.8.253.
>
> After the machine has started, we login and start the bridge manually.=20
> Sitting idle, the bridge will start to spew errors in the message log=20
> (logged below) about received packet with own address as source=20
> address. Looking around on the net it appears that there is a loop=20
> somewhere. Interfaces eth0 and eth2 are on their own switches. We=20
> tried using VLAN but put eth2 on it=92s own switch to rule out the=20
> switch itself.
>
> The errors show in the tcpdump spew as fast as the screen can write=20
> 15-30 seconds after I issue an ifconfig DMZ up. On the LAN side we=20
> have a single workstation, in the DMZ (or the eth2 side of the DMZ)=20
> there is currently nothing.
>
> Any help would be greatly appreciated.
>
> brctl addbr DMZ
>
> brctl addif DMZ eth0
>
> brctl addif DMZ eth2
>
> ifconfig DMZ up
>
> ip addr add 58.100.13.253/24 dev DMZ
>
> route add -net 0/0 gw 58.100.13.1 metric 0
>
>
> ip addr
>
> 1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
>
> link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>
> inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
>
> inet6 ::1/128 scope host
>
> valid_lft forever preferred_lft forever
>
> 2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
>
> link/ether 00:07:e9:82:67:2a brd ff:ff:ff:ff:ff:ff
>
> inet6 fe80::207:e9ff:fe82:672a/64 scope link
>
> valid_lft forever preferred_lft forever
>
> 3: eth1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
>
> link/ether 00:07:e9:82:67:2b brd ff:ff:ff:ff:ff:ff
>
> inet 10.254.254.253/29 brd 10.254.254.255 scope global eth1
>
> inet6 fe80::207:e9ff:fe82:672b/64 scope link
>
> valid_lft forever preferred_lft forever
>
> 4: eth2: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
>
> link/ether 00:04:23:c1:fa:36 brd ff:ff:ff:ff:ff:ff
>
> inet6 fe80::204:23ff:fec1:fa36/64 scope link tentative
>
> valid_lft forever preferred_lft forever
>
> 5: eth3: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
>
> link/ether 00:04:23:c1:fa:37 brd ff:ff:ff:ff:ff:ff
>
> inet 10.0.8.254/24 scope global secondary eth3
>
> inet6 fe80::204:23ff:fec1:fa37/64 scope link
>
> valid_lft forever preferred_lft forever
>
> 6: sit0: <NOARP> mtu 1480 qdisc noop
>
> link/sit 0.0.0.0 brd 0.0.0.0
>
> 7: DMZ: <BROADCAST,MULTICAST> mtu 1500 qdisc noqueue
>
> link/ether 00:04:23:c1:fa:36 brd ff:ff:ff:ff:ff:ff
>
> inet 58.100.13.253/24 scope global DMZ
>
> brctl showstp DMZ
>
> DMZ
>
> bridge id 8000.000423c1fa36
>
> designated root 8000.000423c1fa36
>
> root port 0 path cost 0
>
> max age 19.99 bridge max age 19.99
>
> hello time 1.99 bridge hello time 1.99
>
> forward delay 14.99 bridge forward delay 14.99
>
> ageing time 299.95
>
> hello timer 0.00 tcn timer 0.00
>
> topology change timer 0.00 gc timer 239.83
>
> flags
>
>
> eth0 (2)
>
> port id 8002 state disabled
>
> designated root 8000.000423c1fa36 path cost 19
>
> designated bridge 8000.000423c1fa36 message age timer 0.00
>
> designated port 8002 forward delay timer 0.00
>
> designated cost 0 hold timer 0.00
>
> flags
>
> eth2 (1)
>
> port id 8001 state disabled
>
> designated root 8000.000423c1fa36 path cost 19
>
> designated bridge 8000.000423c1fa36 message age timer 0.00
>
> designated port 8001 forward delay timer 0.00
>
> designated cost 0 hold timer 0.00
>
> flags
>
>
> tcpdump -i eth2
>
> 18:23:28.964574 IP 58.100.13.253.24462 > 239.255.255.250.1900: UDP,=20
> length 242
>
> ...
>
> 18:23:28.967746 IP 58.100.13.253.24470 > 239.255.255.250.1900: UDP,=20
> length 322
>
>
> /var/log/messages
>
> Feb 14 18:11:08 testfw01b kernel: printk: 3 messages suppressed.
>
> Feb 14 18:11:08 testfw01b kernel: eth2: received packet with own=20
> address as source address
>
> Feb 14 18:11:12 testfw01b kernel: printk: 5 messages suppressed.
>
> Feb 14 18:11:12 testfw01b kernel: eth2: received packet with own=20
> address as source address
>
Looks like you have multiple ethers all connected on the same wire (and=20
spanning tree is off).
In that case packets would end up looping for ever and you would see=20
that message.

